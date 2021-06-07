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
        origin={-20,-26})));
  EONERC_MainBuilding.Tabs2     tabs2_1(
    redeclare package Medium = Medium,
    area=3000,
    thickness=0.3)                     annotation (Placement(transformation(extent={{-20,38},{20,78}})));
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
        origin={8,-4})));
  Fluid.Sources.Boundary_pT          boundary3(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={42,-2})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
                                                         prescribedTemperature
    annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  Fluid.FixedResistances.HydraulicDiameter res(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Fluid.FixedResistances.HydraulicDiameter res1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-22,10})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-10,
    duration(displayUnit="h") = 32400,
    offset=273.15 + 30,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  EONERC_MainBuilding.Controller.CtrTabs2 ctrTabs2_1
    annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
equation
  connect(boundary1.ports[1], tabs2_1.port_a1) annotation (Line(points={{-70,10},
          {-68,10},{-68,26},{-58,26},{-58,34},{-16,34},{-16,38}}, color={0,127,
          255}));
  connect(prescribedTemperature.port, tabs2_1.heatPort)
    annotation (Line(points={{-30,90},{0,90},{0,79.8182}}, color={191,0,0}));
  connect(res.port_b, boundary3.ports[1])
    annotation (Line(points={{40,20},{42,20},{42,8}}, color={0,127,255}));
  connect(res1.port_b, boundary6.ports[1])
    annotation (Line(points={{-22,-3.55271e-15},{-22,2},{-20,2},{-20,-16}},
                                               color={0,127,255}));
  connect(res.port_a, tabs2_1.port_b2) annotation (Line(points={{20,20},{16,20},
          {16,38.3636}}, color={0,127,255}));
  connect(ramp.y, prescribedTemperature.T)
    annotation (Line(points={{-59,90},{-52,90}}, color={0,0,127}));
  connect(ctrTabs2_1.tabsBus, tabs2_1.tabsBus) annotation (Line(
      points={{-60,56},{-40,56},{-40,56.3636},{-20.2,56.3636}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary2.ports[1], tabs2_1.port_a2)
    annotation (Line(points={{8,6},{8,38},{8,38}}, color={0,127,255}));
  connect(res1.port_a, tabs2_1.port_b1)
    annotation (Line(points={{-22,20},{-8,20},{-8,38}}, color={0,127,255}));
  annotation (experiment(StopTime=36000));
end Tabs;
