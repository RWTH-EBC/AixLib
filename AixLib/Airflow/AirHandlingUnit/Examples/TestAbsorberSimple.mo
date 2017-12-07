within AixLib.Airflow.AirHandlingUnit.Examples;
model TestAbsorberSimple "testing model for absorber"
  extends Modelica.Icons.Example;

      //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  ComponentsAHU.AbsorberSimpleTank
                               absorberSimple(
    redeclare package Medium1 = MediumAir,
    m1_flow_nominal=5,
    m2_flow_nominal=1,
    m3_flow_nominal=11.5*1000/3600,
    redeclare package Medium2 = MediumWater,
    dp_abs=0,
    dp_wat=0)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Fluid.Sources.MassFlowSource_T
                            bou(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    nPorts=1,
    m_flow=5,
    T=305.15)                             annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={30,16})));
  Fluid.Sources.Boundary_pT bou1(nPorts=1,
    redeclare package Medium = MediumAir,
    T=301.75)                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,10})));
  Fluid.Sources.Boundary_pT bou3(nPorts=1,
    redeclare package Medium = MediumAir,
    T=327.95)                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,70})));
  Fluid.Sources.Boundary_pT bou5(nPorts=1,
    redeclare package Medium = MediumWater,
    T=299.15)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Fluid.Sources.MassFlowSource_T
                            bou2(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    nPorts=1,
    m_flow=1,
    T=305.15)                             annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,70})));
  Fluid.Sources.MassFlowSource_T
                            bou6(
    nPorts=1,
    m_flow=15,
    redeclare package Medium = MediumWater,
    T=305.15)                             annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,60})));
equation
  connect(absorberSimple.port_b1, bou1.ports[1])
    annotation (Line(points={{-10,34},{-30,34},{-30,20}}, color={0,127,255}));
  connect(bou.ports[1], absorberSimple.port_a1)
    annotation (Line(points={{30,26},{30,34},{10,34}}, color={0,127,255}));
  connect(bou2.ports[1], absorberSimple.port_a2)
    annotation (Line(points={{30,60},{30,46},{10,46}}, color={0,127,255}));
  connect(bou3.ports[1], absorberSimple.port_b2) annotation (Line(points={{
          -30,60},{-30,46},{-10,46}}, color={0,127,255}));
  connect(bou5.ports[1], absorberSimple.port_b3) annotation (Line(points={{
          -60,20},{-40,20},{-40,39},{-10,39}}, color={0,127,255}));
  connect(bou6.ports[1], absorberSimple.port_a3) annotation (Line(points={{
          -60,60},{-40,60},{-40,41},{-10,41}}, color={0,127,255}));
end TestAbsorberSimple;
