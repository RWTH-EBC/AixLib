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
  BaseClasses.TabsBus tabsBus1
    annotation (Placement(transformation(extent={{-48,46},{-28,66}})));
  HydraulicModules.Controller.CtrMix ctrMix(TflowSet=298.15)
    annotation (Placement(transformation(extent={{-84,50},{-64,70}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
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
equation
  connect(boundary2.ports[1], tabs.port_a2) annotation (Line(points={{-40,10},{
          -24,10},{-24,32},{-10,32},{-10,38},{-8,38}}, color={0,127,255}));
  connect(boundary1.ports[1], tabs.port_a1) annotation (Line(points={{-70,10},{
          -68,10},{-68,26},{-58,26},{-58,34},{-16,34},{-16,38}}, color={0,127,
          255}));
  connect(tabs.tabsBus, tabsBus1) annotation (Line(
      points={{-20.2,56.3636},{-29.1,56.3636},{-29.1,56},{-38,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMix.hydraulicBus, tabsBus1.admixBus) annotation (Line(
      points={{-64.7,58.9},{-50.35,58.9},{-50.35,56.05},{-37.95,56.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, tabsBus1.valSet) annotation (Line(points={{-79,30},{-74,30},
          {-74,42},{-37.95,42},{-37.95,56.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fixedTemperature.port, tabs.heatPort) annotation (Line(points={{-20,
          90},{-12,90},{-12,92},{0,92},{0,79.8182}}, color={191,0,0}));
  connect(tabs.port_b1, res.port_a) annotation (Line(points={{8,38},{12,38},{12,
          20},{20,20}}, color={0,127,255}));
  connect(res.port_b, boundary3.ports[1])
    annotation (Line(points={{40,20},{42,20},{42,8}}, color={0,127,255}));
  connect(tabs.port_b2, res1.port_a) annotation (Line(points={{16,38.3636},{26,
          38.3636},{26,38},{54,38},{54,36},{60,36}}, color={0,127,255}));
  connect(res1.port_b, boundary6.ports[1])
    annotation (Line(points={{80,36},{80,10}}, color={0,127,255}));
  annotation (experiment(StopTime=7200));
end Tabs;
