within AixLib.Airflow.AirHandlingUnit.Examples;
model TestRecuperatorIDEAS "Example model to test the MenergaModular model"

    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT supplyAir(
    redeclare package Medium = MediumAir,
    X={0.02,0.98},
    nPorts=1,
    p=100000,
    T=294.15) "Sink for supply air"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-16})));
  Fluid.Sources.Boundary_pT outsideAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    p=100000,
    T=283.15,
    nPorts=1) "Source for outside air"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={70,-16})));
  Fluid.Sources.Boundary_pT exhaustAir(
    redeclare package Medium = MediumAir,
    X={0.03,0.97},
    nPorts=1,
    p=100000,
    T=296.15) "Source for exhaust air"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,16})));
  Fluid.Sources.Boundary_pT exitAir(
    redeclare package Medium = MediumAir,
    X={0.01,0.99},
    nPorts=1,
    p=100000,
    T=283.15) "Sink für exit air" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,16})));
  IDEAS.Fluid.HeatExchangers.IndirectEvaporativeHex recuperator(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=5.1,
    m2_flow_nominal=5.1,
    eps_adia_on=0.9,
    eps_adia_off=0.79,
    use_eNTU=true,
    UA_adia_on=13000,
    UA_adia_off=24000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,70})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,70})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));
  Fluid.Movers.FlowControlled_m_flow outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{50,4},{30,-16}})));
  Fluid.Movers.FlowControlled_m_flow outsideAirFan1(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{-48,-4},{-28,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=5.1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-38,40})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=5.1) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={40,-50})));
equation
  connect(recuperator.port_b1, exitAir.ports[1])
    annotation (Line(points={{10,6},{70,6}}, color={0,127,255}));
  connect(recuperator.port_b2, supplyAir.ports[1])
    annotation (Line(points={{-10,-6},{-70,-6}}, color={0,127,255}));
  connect(exhaustAir.ports[1], outsideAirFan1.port_a)
    annotation (Line(points={{-70,6},{-48,6}}, color={0,127,255}));
  connect(outsideAirFan1.port_b, recuperator.port_a1)
    annotation (Line(points={{-28,6},{-10,6}}, color={0,127,255}));
  connect(outsideAir.ports[1], outsideAirFan.port_a)
    annotation (Line(points={{70,-6},{50,-6}}, color={0,127,255}));
  connect(outsideAirFan.port_b, recuperator.port_a2)
    annotation (Line(points={{30,-6},{10,-6}}, color={0,127,255}));
  connect(realExpression3.y, outsideAirFan1.m_flow_in)
    annotation (Line(points={{-38,29},{-38,18}}, color={0,0,127}));
  connect(realExpression4.y, outsideAirFan.m_flow_in)
    annotation (Line(points={{40,-39},{40,-18}}, color={0,0,127}));
  connect(recuperator.adiabaticOn, booleanExpression.y) annotation (Line(points
        ={{10.4,0},{16,0},{16,-40},{11,-40}}, color={255,0,255}));
  annotation (experiment(StopTime=1800, Interval=10));
end TestRecuperatorIDEAS;
