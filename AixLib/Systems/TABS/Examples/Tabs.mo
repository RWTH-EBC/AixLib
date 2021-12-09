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
        origin={-40,-60})));
  AixLib.Systems.TABS.Tabs                tabs2_1(
    redeclare package Medium = Medium,
    area=3000,
    thickness=0.03)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-70,-60})));
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
    annotation (Placement(transformation(extent={{-38,40},{-18,60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-10,
    duration(displayUnit="h") = 32400,
    offset=273.15 + 30,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Controller.CtrTabs ctrTabs
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(boundary1.ports[1], tabs2_1.port_a1) annotation (Line(points={{-70,-50},
          {-68,-50},{-68,-26},{-16,-26},{-16,-20}},               color={0,127,
          255}));
  connect(prescribedTemperature.port, tabs2_1.heatPort)
    annotation (Line(points={{-18,50},{0,50},{0,22}},      color={191,0,0}));
  connect(ramp.y, prescribedTemperature.T)
    annotation (Line(points={{-59,50},{-40,50}}, color={0,0,127}));
  connect(ctrTabs.tabsBus, tabs2_1.tabsBus) annotation (Line(
      points={{-60,0},{-40,0},{-40,0.2},{-20.2,0.2}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary2.ports[1], tabs2_1.port_a2)
    annotation (Line(points={{8,-50},{8,-20}},     color={0,127,255}));
  connect(boundary6.ports[1], tabs2_1.port_b1) annotation (Line(points={{-40,
          -50},{-40,-40},{-8,-40},{-8,-20}}, color={0,127,255}));
  connect(boundary3.ports[1], tabs2_1.port_b2) annotation (Line(points={{42,-50},
          {42,-40},{16,-40},{16,-19.6}}, color={0,127,255}));
  annotation (experiment(StopTime=36000), Documentation(revisions="<html>
<ul>
<li>December 09, 2021, by Alexander K&uuml;mpel:<br>First implementation.</li>
</ul>
</html>", info="<html>
<p>Example of the Tabs system.</p>
</html>"));
end Tabs;
