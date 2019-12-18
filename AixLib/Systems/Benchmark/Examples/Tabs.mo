within AixLib.Systems.Benchmark.Examples;
model Tabs "Test of Tabs"
  extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  Fluid.Sources.Boundary_pT          boundary6(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={80,0})));
  AixLib.Systems.Benchmark.Tabs tabs(
    redeclare package Medium = Medium,
    C=1000*4*2000,
    Gc=10*20) annotation (Placement(transformation(extent={{-20,38},{20,78}})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-70,0})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=288.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-40,0})));
  Fluid.Sources.Boundary_pT          boundary3(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={42,-2})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=300.15)
    annotation (Placement(transformation(extent={{-50,78},{-30,98}})));
  Fluid.FixedResistances.HydraulicDiameter res(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Fluid.FixedResistances.HydraulicDiameter res1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{60,26},{80,46}})));
  Controller.CtrTabs ctrTabs(
    TflowSet=293.15,
    k=0.02,
    Ti=120,
    rpm_pump=1000)
    annotation (Placement(transformation(extent={{-78,46},{-58,66}})));
equation
  connect(boundary2.ports[1], tabs.port_a2) annotation (Line(points={{-40,10},{
          -24,10},{-24,32},{-10,32},{-10,38},{-8,38}}, color={0,127,255}));
  connect(boundary1.ports[1], tabs.port_a1) annotation (Line(points={{-70,10},{
          -68,10},{-68,26},{-58,26},{-58,34},{-16,34},{-16,38}}, color={0,127,
          255}));
  connect(fixedTemperature.port, tabs.heatPort) annotation (Line(points={{-30,88},
          {-12,88},{-12,92},{0,92},{0,79.8182}},     color={191,0,0}));
  connect(res.port_b, boundary3.ports[1])
    annotation (Line(points={{40,20},{42,20},{42,8}}, color={0,127,255}));
  connect(res1.port_b, boundary6.ports[1])
    annotation (Line(points={{80,36},{80,10}}, color={0,127,255}));
  connect(ctrTabs.tabsBus, tabs.tabsBus) annotation (Line(
      points={{-57.8,56.2},{-40.9,56.2},{-40.9,56.3636},{-20.2,56.3636}},
      color={255,204,51},
      thickness=0.5));
  connect(res.port_a, tabs.port_b2)
    annotation (Line(points={{20,20},{8,20},{8,38.3636}}, color={0,127,255}));
  connect(tabs.port_b1, res1.port_a) annotation (Line(points={{16,38.3636},{16,
          36},{60,36}}, color={0,127,255}));
  annotation (experiment(StopTime=36000));
end Tabs;
