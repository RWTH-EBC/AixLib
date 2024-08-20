within AixLib.Systems.TABS.Examples;
model Tabs "Test of Tabs"
  extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  Fluid.Sources.Boundary_pT          boundary6(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-20,-60})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-60,-60})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=288.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={8,-60})));
  Fluid.Sources.Boundary_pT          boundary3(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={42,-60})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
                                                         prescribedTemperature
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-10,
    duration(displayUnit="h") = 32400,
    offset=273.15 + 30,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Controller.CtrTabs ctrTabs
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  AixLib.Systems.TABS.Tabs tabs(
    redeclare package Medium = Medium,
    area=3000,
    thickness=0.03,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    pumpSys(PumpInterface(speed_rpm_nominal=3580)),
    throttlePumpHot(PumpInterface(speed_rpm_nominal=2900)),
    throttlePumpCold(PumpInterface(speed_rpm_nominal=2900)))
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation
  connect(ramp.y, prescribedTemperature.T)
    annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
  connect(tabs.tabsBus, ctrTabs.tabsBus) annotation (Line(
      points={{-20.2,0.2},{-60,0}},
      color={255,204,51},
      thickness=0.5));
  connect(tabs.heatPort, prescribedTemperature.port)
    annotation (Line(points={{0,22},{0,50},{-20,50}}, color={191,0,0}));
  connect(tabs.port_a1, boundary1.ports[1]) annotation (Line(points={{-16,-20},
          {-16,-26},{-62,-26},{-62,-50},{-60,-50}}, color={0,127,255}));
  connect(tabs.port_b1, boundary6.ports[1]) annotation (Line(points={{-8,-20},{
          -8,-40},{-18,-40},{-18,-50},{-20,-50}}, color={0,127,255}));
  connect(tabs.port_a2, boundary2.ports[1])
    annotation (Line(points={{8,-20},{8,-50}}, color={0,127,255}));
  connect(tabs.port_b2, boundary3.ports[1]) annotation (Line(points={{16,-19.6},
          {16,-32},{42,-32},{42,-50}}, color={0,127,255}));
  annotation (experiment(StopTime=36000), Documentation(revisions="<html><ul>
  <li>December 09, 2021, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Example for testing the Tabs system <a href=
  \"modelica://AixLib.Systems.TABS.Tabs\">AixLib.Systems.TABS.Tabs</a>.
</p>
</html>"));
end Tabs;
