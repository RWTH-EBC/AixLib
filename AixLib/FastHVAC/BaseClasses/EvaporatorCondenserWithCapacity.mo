within AixLib.FastHVAC.BaseClasses;
model EvaporatorCondenserWithCapacity
  extends AixLib.FastHVAC.Interfaces.TwoPortHeatMassExchanger( workingFluid(m_fluid=m_fluid,
    medium=medium));
  parameter Boolean is_con "Type of heat exchanger"
  annotation (Dialog( descriptionLabel = true),choices(choice=true "Condenser",
      choice=false "Evaporator",
      radioButtons=true));
  parameter Modelica.SIunits.Volume V "Volume in condenser";
  parameter Boolean use_cap=true "False if capacity and heat losses are neglected"
  annotation (Dialog(group="Heat losses"),choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity C "Capacity of heat exchanger"
  annotation (Dialog(group="Heat losses", enable=use_cap));
  parameter Modelica.SIunits.Mass m_fluid "Mass of working fluid";
  parameter Modelica.SIunits.ThermalConductance kAOut_nominal
    "Nominal value for thermal conductance to the ambient"
  annotation (Dialog(group="Heat losses", enable=
          use_cap));
  Modelica.Blocks.Interfaces.RealOutput kAInn
    "Formular for calculation of heat transfer coefficient on the inside"
  annotation (Dialog(group="Heat losses", enable=
          use_cap));
  Modelica.Thermal.HeatTransfer.Components.Convection conIns if use_cap
    "Convection between fluid and solid" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-12,28})));
  Modelica.Thermal.HeatTransfer.Components.Convection conOut if use_cap
    "Convection and conduction between solid and ambient air" annotation (
      Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=270,
        origin={-12,78})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCap(
    final C=C,
    final T(start=T_start),
    final der_T(start=0)) if use_cap
    "Heat Capacity"
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=270,
        origin={12,52})));

  Modelica.Blocks.Sources.RealExpression heatLossIns(final y=kAInn) if
                                               use_cap
    "Nominal heat loss coefficient to the inside" annotation (Placement(
        transformation(
        extent={{-15,-10},{15,10}},
        rotation=0,
        origin={-61,28})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_out if use_cap
    "Temperature and heat flow to the ambient"
    annotation (Placement(transformation(extent={{-5,105},{5,95}}),
        iconTransformation(extent={{-5,105},{5,95}})));
  Modelica.Blocks.Sources.RealExpression heatLossOut(final y=kAOut_nominal) if use_cap
    "Nominal heat loss coefficient to the inside" annotation (Placement(
        transformation(
        extent={{-15,-10},{15,10}},
        rotation=0,
        origin={-61,78})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea(final alpha=0,
      final T_ref=293.15) "Heat flow rate of the condenser" annotation (
      Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=270,
        origin={0,-68})));
  Modelica.Blocks.Interfaces.RealInput QFlow_in "Heat flow rate to the medium"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-118}), iconTransformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-8.88178e-16,-106})));
equation
  connect(conIns.fluid, heatCap.port)
    annotation (Line(points={{-12,36},{-12,52},{1.77636e-15,52}},
                                                          color={191,0,0},
      pattern=LinePattern.Dash));
  connect(heatCap.port, conOut.solid)
    annotation (Line(points={{1.77636e-15,52},{-12,52},{-12,70}},
                                                          color={191,0,0},
      pattern=LinePattern.Dash));
  connect(conIns.Gc, heatLossIns.y)
    annotation (Line(points={{-20,28},{-44.5,28}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conOut.fluid, port_out)
    annotation (Line(points={{-12,86},{-12,100},{0,100}},
                                                  color={191,0,0},
      pattern=LinePattern.Dash));
  connect(conOut.Gc, heatLossOut.y)
    annotation (Line(points={{-20,78},{-44.5,78}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(preHea.Q_flow, QFlow_in) annotation (Line(points={{-2.22045e-15,-80},{
          -2.22045e-15,-99},{0,-99},{0,-118}}, color={0,0,127}));
  connect(conIns.solid, preHea.port) annotation (Line(points={{-12,20},{-14,20},
          {-14,-56},{2.22045e-15,-56}}, color={191,0,0}));
  connect(workingFluid.heatPort, preHea.port) annotation (Line(points={{0,9.4},{
          -14,9.4},{-14,-56},{2.22045e-15,-56}},
                             color={191,0,0}));
  annotation (Icon(graphics={ Ellipse(
          extent={{-48,46},{46,-42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={170,213,255}),
        Rectangle(
          extent={{-18,100},{18,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,68},
          rotation=90,
          visible=use_cap),
        Text(
          extent={{-36,52},{36,82}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          textString="C",
          visible=use_cap),
        Text(
          extent={{-36,-18},{36,12}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          textString="V"),
        Rectangle(
          extent={{-4,-42},{4,-50}},
          pattern=LinePattern.None,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-107,5},{-44,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          visible=is_con),
        Rectangle(
          extent={{44,-4},{100,5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          visible=is_con),
        Line(
          points={{0,-96},{0,-50},{0,-46}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-12,-76},{-12,-122},{50,-80},{82,-64},{4,-100}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-18,-70},{42,-44}},
          color={0,0,0},
          pattern=LinePattern.None),
        Rectangle(
          extent={{0,-98},{0,-48}},
          lineColor={238,46,47},
          pattern=LinePattern.None,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-102,34},{-96,56},{-140,52},{-100,88},{-84,84},{-106,36}},
          color={238,46,47},
          pattern=LinePattern.None),
        Line(
          points={{-80,88},{-80,110},{-76,104},{-80,110},{-84,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{-80,34},{-80,56},{-76,50},{-80,56},{-84,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{-50,34},{-50,56},{-46,50},{-50,56},{-54,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{-50,88},{-50,110},{-46,104},{-50,110},{-54,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{80,34},{80,56},{84,50},{80,56},{76,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{80,88},{80,110},{84,104},{80,110},{76,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{50,88},{50,110},{54,104},{50,110},{46,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{50,34},{50,56},{54,50},{50,56},{46,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{20,34},{20,56},{24,50},{20,56},{16,50}},
          color={238,46,47},
          visible=use_cap),
        Line(
          points={{20,88},{20,110},{24,104},{20,110},{16,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{-20,88},{-20,110},{-16,104},{-20,110},{-24,104}},
          color={28,108,200},
          visible=use_cap),
        Line(
          points={{-20,34},{-20,56},{-16,50},{-20,56},{-24,50}},
          color={238,46,47},
          visible=use_cap),
        Rectangle(
          extent={{-100,-4},{-44,5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          visible=not is_con),
        Rectangle(
          extent={{43,5},{106,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          visible=not is_con)}),
  Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Evaporator/Condenser model adapted to FastHAVC library.<br/>
  This model is based on the Fluid model <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.EvaporatorCondenserWithCapacity\">
  AixLib.Fluid.HeatPumps.BaseClasses.EvaporatorCondenserWithCapacity</a>.
  It includes heat losses to the environment.
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>January 22, 2019&#160;</i> Niklas Hülsenbeck:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end EvaporatorCondenserWithCapacity;
