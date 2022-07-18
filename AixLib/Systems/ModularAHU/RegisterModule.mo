within AixLib.Systems.ModularAHU;
model RegisterModule "AHU register module for heaters and coolers"
    extends AixLib.Fluid.Interfaces.PartialFourPortParallel;


  parameter String hydraulicModuleIcon = "Admix" "Icon selection corresponding to module" annotation(choices(
              choice="Admix",
              choice="Injection",
              choice="Injection2WayValve",
              choice="Pump",
              choice="Throttle",
              choice="ThrottlePump"),Dialog(enable=true, group="Hydraulics"));

  parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal(min=0)
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal(min=0)
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature T_start=293.15
    "Initialization temperature" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Time tau=15
    "Time constant for PT1 behavior of temperature sensors in air canal"
    annotation (Dialog(group="Heat exchanger"));
  parameter Modelica.Units.SI.Temperature T_amb "Ambient temperature";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state" annotation (Dialog(tab = "Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of mass balance: dynamic (3 initialization options) or steady state" annotation (Dialog(tab = "Dynamics"));
  parameter Modelica.Units.SI.Time tauHeaTra=1200
    "Time constant for heat transfer of temperature sensors in air chanal"
    annotation (Dialog(tab="Advanced"));
  replaceable AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule hydraulicModule(
    final energyDynamics=energyDynamics,
    final T_amb=T_amb,
    redeclare final package Medium = Medium2,
    final m_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal2,
    massDynamics=massDynamics) "Hydraulic module selection" annotation (
    Dialog(enable=true, group="Hydraulics"),
    Placement(transformation(
        extent={{-38,-38},{38,38}},
        rotation=90,
        origin={2,-40})),
    __Dymola_choicesAllMatching=true);
  AixLib.Fluid.HeatExchangers.DynamicHX dynamicHX(final m1_flow_nominal=
        m1_flow_nominal, final m2_flow_nominal=m2_flow_nominal,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    redeclare final package Medium1 = Medium1,
    redeclare final package Medium2 = Medium2,
    tau1=2,
    tau2=8,
    energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    T1_start=T_start,
    T2_start=T_start,
    tau_C=10)
    annotation (Dialog(enable=true, group="Heat exchanger"), Placement(transformation(extent={{-20,28},
            {20,68}})));
  AixLib.Systems.ModularAHU.BaseClasses.RegisterBus registerBus
    annotation (Placement(transformation(extent={{-108,-20},{-70,18}}),
        iconTransformation(extent={{-112,-14},{-86,12}})));


protected
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_airIn(
    final tau=0.1,
    final T_start=T_start,
    final transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m1_flow_nominal,
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final tauHeaTra=tauHeaTra)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Continuous.FirstOrder PT1_airIn(
    final initType=Modelica.Blocks.Types.Init.SteadyState,
    final y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-70,90})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_airOut(
    tau=0.1,
    T_start=T_start,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m1_flow_nominal,
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final tauHeaTra=tauHeaTra)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Continuous.FirstOrder PT1_airOut(
    final initType=Modelica.Blocks.Types.Init.SteadyState,
    final y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={70,90})));

  AixLib.Fluid.Sensors.VolumeFlowRate VFSen_out(
    T_start=T_start,
    final m_flow_nominal=m1_flow_nominal,
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1)
    "Inflow into admix module in forward line" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-38,60})));
equation
  connect(hydraulicModule.port_b1, dynamicHX.port_a2) annotation (Line(points={{-20.8,
          -2},{-22,-2},{-22,20},{20,20},{20,36}},       color={0,127,255}));
  connect(hydraulicModule.port_a2, dynamicHX.port_b2) annotation (Line(points={{24.8,-2},
          {18,-2},{18,6},{-20,6},{-20,36}},          color={0,127,255}));
  connect(senT_airIn.T, PT1_airIn.u)
    annotation (Line(points={{-70,71},{-70,78}}, color={0,0,127}));
  connect(senT_airOut.T, PT1_airOut.u)
    annotation (Line(points={{70,71},{70,78}}, color={0,0,127}));
  connect(dynamicHX.port_b1, senT_airOut.port_a) annotation (Line(points={{20,60},
          {60,60}},                   color={0,127,255}));
  connect(hydraulicModule.hydraulicBus, registerBus.hydraulicBus) annotation (
      Line(
      points={{-36,-40},{-88.905,-40},{-88.905,-0.905}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_airIn.port_b, VFSen_out.port_a)
    annotation (Line(points={{-60,60},{-48,60}}, color={0,127,255}));
  connect(VFSen_out.port_b, dynamicHX.port_a1) annotation (Line(points={{-28,60},
          {-20,60}},                       color={0,127,255}));
  connect(PT1_airIn.y, registerBus.TAirInMea) annotation (Line(points={{-70,101},
          {-70,110},{-88.905,110},{-88.905,-0.905}},        color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PT1_airOut.y, registerBus.TAirOutMea) annotation (Line(points={{70,101},
          {70,110},{-88.905,110},{-88.905,-0.905}},
                                                  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_airIn.port_a, port_a1)
    annotation (Line(points={{-80,60},{-100,60}}, color={0,127,255}));
  connect(senT_airOut.port_b, port_b1)
    annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
  connect(hydraulicModule.port_a1, port_a2) annotation (Line(points={{-20.8,-78},
          {-100,-78},{-100,-60}}, color={0,127,255}));
  connect(hydraulicModule.port_b2, port_b2) annotation (Line(points={{24.8,-78},
          {100,-78},{100,-60}}, color={0,127,255}));
  connect(VFSen_out.V_flow, registerBus.VFlowAirMea) annotation (Line(points={{-38,49},
          {-38,34},{-88.905,34},{-88.905,-0.905}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -140},{100,120}}),
                         graphics={
        Rectangle(
          extent={{-100,114},{100,-140}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Line(
          points={{100,60},{68,60},{68,106},{34,106},{34,-140},{100,-140},{100,
              -62}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-100,60},{-68,60},{-68,106},{-34,106},{-34,-140},{-100,-140},
              {-100,-62}},
          color={28,108,200},
          thickness=1),
        Line(
          visible=hydraulicModuleIcon == "Admix" or hydraulicModuleIcon == "Injection",
          points={{-34,-84},{34,-84}},
          color={28,108,200},
          thickness=1),
        Polygon(
          points={{0,0},{0,0}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-34,24},
          rotation=360),
        Ellipse(
          visible=hydraulicModuleIcon <> "Throttle",
          extent={{-20,20},{20,-20}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-34,-18},
          rotation=360),
        Line(visible=hydraulicModuleIcon <> "Throttle",
          points={{-10,20},{10,0},{-10,-20}},
          color={135,135,135},
          thickness=0.5,
          origin={-34,-8},
          rotation=90),
        Polygon(
          visible=hydraulicModuleIcon == "Admix" or hydraulicModuleIcon == "Injection",
          points={{-10,-10},{-10,10},{10,0},{-10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-24,-84},
          rotation=180),
        Polygon(
          points={{10,-10},{10,10},{-10,0},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-34,-74},
          rotation=90,
          visible=hydraulicModuleIcon <> "Pump"),
        Polygon(
          points={{10,-10},{-10,-10},{0,10},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-34,-94},
          rotation=360,
          visible=hydraulicModuleIcon <> "Pump"),
        Ellipse(
          extent={{-6,6},{6,-6}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-48,-84},
          rotation=360,
          visible=hydraulicModuleIcon <> "Pump"),
        Line(
          points={{0,4},{0,-4}},
          color={95,95,95},
          thickness=0.5,
          origin={-38,-84},
          rotation=90,
          visible=hydraulicModuleIcon <> "Pump"),
        Ellipse(
          extent={{-42,-112},{-26,-128}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-42,-112},{-26,-128}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Ellipse(
          extent={{-58,-112},{-42,-128}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,-112},{-42,-128}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Polygon(
          points={{0,0},{0,0}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-34,24},
          rotation=360),
        Ellipse(
          extent={{-42,28},{-26,12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-42,28},{-26,12}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Ellipse(
          extent={{-58,28},{-42,12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,28},{-42,12}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{74,94},{90,78}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{74,94},{90,78}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{68,86},{74,86}},     color={28,108,200}),
        Ellipse(
          extent={{40,28},{56,12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{40,28},{56,12}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{34,20},{40,20}},   color={28,108,200}),
        Polygon(
          points={{-40,38},{40,98},{-40,98},{-40,38}},
          lineThickness=0.5,
          fillColor={215,215,238},
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135}),
        Polygon(
          points={{-40,38},{40,98},{40,38},{-40,38}},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={135,135,135}),
        Ellipse(
          extent={{40,-112},{56,-128}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{40,-112},{56,-128}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{34,-120},{40,-120}},
                                         color={28,108,200}),
        Ellipse(
          extent={{-92,94},{-76,78}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-92,94},{-76,78}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{-76,94},{-60,78}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-76,94},{-60,78}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Line(
          visible=hydraulicModuleIcon == "Injection" or hydraulicModuleIcon == "Injection2WayValve",
          points={{-34,-50},{34,-50}},
          color={28,108,200},
          thickness=1)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{100,
            120}})),
    Documentation(info="<html><p>
  The RegisterModule is a model for heating and cooling registers in
  air-handling units. It includes a simple heat exchanger and a
  replaceable hydraulic system (HydraulicModules) for the heat/cold
  supply with e.g. water. The Icon of the hydraulic circuit can be
  selected as well.
</p>
<p>
  In order to communicate sensor measurements and actuator signals, the
  registerBus is used. The air temperature sensor signal is multiplied
  with a first order element to simulate the dynamic behavior of the
  sensors.
</p>
<ul>
  <li>Januar 09, 2019, by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>"));
end RegisterModule;
