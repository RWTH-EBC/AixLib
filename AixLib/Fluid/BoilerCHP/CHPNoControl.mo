within AixLib.Fluid.BoilerCHP;
model CHPNoControl
  "Table based CHP model without an internal controller"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(pressureDrop(
        a=1e10), vol(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
                     V=param.vol[1]));

  parameter AixLib.DataBase.CHP.CHPDataSimple.CHPBaseDataDefinition param
    "CHP data set"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Real minCapacity = 0
    "Minimum allowable working capacity (unit [-])"
    annotation(Dialog(group="Unit properties"));
  parameter Modelica.SIunits.ThermalConductance G=0.003*param.data_CHP[end,3]/50
    "Constant thermal conductance to environment(G=Q_loss/dT)";
  parameter Modelica.SIunits.HeatCapacity C=1.5*param.data_CHP[end,3]
    "Heat capacity of metal (J/K)";

  Modelica.Blocks.Interfaces.RealInput u_rel(
    final unit="1") "Relative" annotation (Placement(
        transformation(extent={{-126,66},{-100,94}},  rotation=0),
        iconTransformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Interfaces.RealOutput electricalPower(
    final quantity="Power", final unit="W")
    "Electrical power"
    annotation (Placement(
        transformation(
        origin={20,110},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealOutput thermalPower(final unit="W")
    "Thermal power"
    annotation (Placement(
        transformation(
        origin={36,110},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,90})));
  Modelica.Blocks.Interfaces.RealOutput fuelInput(final unit="W")
    "Fuel input"
    annotation (Placement(transformation(
      origin={51,110},
      extent={{-10,-11},{10,11}},
      rotation=90), iconTransformation(
        extent={{-10,-11},{10,11}},
        rotation=90,
        origin={20,90})));
  Modelica.Blocks.Interfaces.RealOutput fuelConsumption
    "Fuel consumption"
    annotation (Placement(transformation(
      origin={66,110},
      extent={{-10,-10},{10,10}},
      rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,90})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    tableName="NoName",
    fileName="NoName",
    final table=param.data_CHP)
    "Time table to read CHP performance data"
    annotation (Placement(transformation(extent={{40,40},{60,60}}, rotation=0)));
  Modelica.Blocks.Math.Gain gain(final k=1000) "Conversion factor"
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-60,-4})));

  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=1, final uMin=
        minCapacity)
    "Limits the rel power between 0 and 1"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Math.Gain gain4(final k=1000)
    "Conversion factor"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={66,90})));
  Modelica.Blocks.Math.Gain gain1(final k=1000)
    "Conversion factor"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={20,90})));
  Modelica.Blocks.Math.Gain gain2(final k=1000)
    "Conversion factor"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={36,90})));
  Modelica.Blocks.Math.Gain gain3(final k=1000)
    "Conversion factor"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={50,90})));
  Modelica.Blocks.Interfaces.RealOutput T_out
    "Outflow temperature of the passing fluid" annotation (Placement(transformation(
          extent={{100,50},{120,70}}), iconTransformation(extent={{62,22},{82,42}})));
  Modelica.Blocks.Interfaces.RealOutput T_in "Inflow temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{62,48},{82,68}})));
  Modelica.Blocks.Math.Gain toPercent(final k=100) "Conversion factor"
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={12,50})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=C,
      T(start=T_start))            "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={2,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=G)
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,-20})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b T_amb "Heat port for heat losses to ambient" annotation (
      Placement(transformation(extent={{30,-30},{50,-10}}), iconTransformation(
          extent={{58,-60},{78,-40}})));
equation


  connect(combiTable1Ds.y[2], gain.u) annotation (Line(points={{61,50},{76,50},{
          76,3.2},{-60,3.2}},   color={0,0,127}));
  connect(gain.y, heater.Q_flow) annotation (Line(points={{-60,-10.6},{-60,-40}},
                                        color={0,0,127}));
  connect(combiTable1Ds.y[4], gain4.u)
    annotation (Line(points={{61,50},{66,50},{66,85.2}}, color={0,0,127}));
  connect(gain4.y, fuelConsumption)
    annotation (Line(points={{66,94.4},{66,110}}, color={0,0,127}));
  connect(gain1.u, combiTable1Ds.y[1]) annotation (Line(points={{20,85.2},{20,76},
          {66,76},{66,50},{61,50}}, color={0,0,127}));
  connect(gain2.u, combiTable1Ds.y[2]) annotation (Line(points={{36,85.2},{36,76},
          {66,76},{66,50},{61,50}}, color={0,0,127}));
  connect(gain3.u, combiTable1Ds.y[3]) annotation (Line(points={{50,85.2},{50,76},
          {66,76},{66,50},{61,50}}, color={0,0,127}));
  connect(senTHot.T,T_out)  annotation (Line(points={{40,-69},{40,-60},{84,-60},
          {84,60},{110,60}},          color={0,0,127}));
  connect(senTCold.T,T_in)  annotation (Line(points={{-70,-69},{-70,-100},{110,-100},
          {110,40}}, color={0,0,127}));
  connect(limiter.u, u_rel) annotation (Line(points={{-62,50},{-80,50},{-80,80},
          {-113,80}}, color={0,0,127}));
  connect(limiter.y, toPercent.u)
    annotation (Line(points={{-39,50},{4.8,50}},  color={0,0,127}));
  connect(toPercent.y, combiTable1Ds.u)
    annotation (Line(points={{18.6,50},{38,50}}, color={0,0,127}));
  connect(vol.heatPort,internalCapacity. port)
    annotation (Line(points={{-50,-70},{-50,-40},{-8,-40}}, color={191,0,0}));
  connect(ConductanceToEnv.port_b,T_amb)
    annotation (Line(points={{-20,-20},{40,-20}}, color={191,0,0}));
  connect(ConductanceToEnv.port_a, vol.heatPort)
    annotation (Line(points={{-40,-20},{-50,-20},{-50,-70}}, color={191,0,0}));
  connect(gain1.y, electricalPower)
    annotation (Line(points={{20,94.4},{20,110}}, color={0,0,127}));
  connect(gain2.y, thermalPower)
    annotation (Line(points={{36,94.4},{36,110}}, color={0,0,127}));
  connect(gain3.y, fuelInput) annotation (Line(points={{50,94.4},{50,102},{50,
          110},{51,110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-50,58},{50,18}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString="CHP",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{-12,6},{12,-36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-16},{-10,-36},{-8,-30},{8,-30},{10,-36},{10,-16},{-10,-16}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-26},{4,-32}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,-54},{-8,-64}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-30},{-14,-54},{-10,-56},{0,-32},{-2,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4.5,-15.5},{-8,-10},{0,4},{6,-4},{10,-4},{8,-8},{8,-12},{5.5,
              -15.5},{-4.5,-15.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-4.5,-13.5},{0,-4},{6,-10},{2,-14},{-4.5,-13.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>A table based combined heat and power (CHP) model. The input is the relative part load rate [0...1]. </p>
<p><b><span style=\"color: #008000;\">Concept</span> </b></p>
<p>The dimension of thermal and electrical power outputs and fuel input as well as the electricity profile should be in kW. The dimension of fuel consumption depends on the user&apos;s data. </p>
</html>",
revisions="<html><ul>
  <li>August 31, 2020, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end CHPNoControl;
