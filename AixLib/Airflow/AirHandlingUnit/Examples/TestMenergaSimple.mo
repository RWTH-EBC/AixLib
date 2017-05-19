within AixLib.Airflow.AirHandlingUnit.Examples;
model TestMenergaSimple
  "Example model to test the MenergaSimple model"


    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  extends Modelica.Icons.Example;
  Fluid.Sources.Boundary_pT exhaustAir(
     redeclare package Medium = MediumAir,
    X={0.03,0.97},
    nPorts=1,
    p=100000,
    T=296.15)                                        "Source for Exhaust Air"
    annotation (Placement(transformation(extent={{-94,12},{-74,32}})));
  Fluid.Sources.Boundary_pT supplyAir(
     redeclare package Medium = MediumAir,
    X={0.01,0.99},
    p=101000,
    T=293.15,
    nPorts=1)                                        "Sink for Supply Air"
    annotation (Placement(transformation(extent={{122,12},{142,32}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{-28,12},{-8,32}})));
  Fluid.Movers.FlowControlled_m_flow exhaustAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "provides pressure difference to transport the exhaust air"
    annotation (Placement(transformation(extent={{28,14},{44,30}})));
  Modelica.Blocks.Sources.Constant exhaust_mflow(k=5.1)
    "nominal mass flow for exhaust air fan"
    annotation (Placement(transformation(extent={{-24,50},{-4,70}})));
equation
  connect(exhaustAir.ports[1], res.port_a)
    annotation (Line(points={{-74,22},{-52,22},{-28,22}}, color={0,127,255}));
  connect(res.port_b, exhaustAirFan.port_a)
    annotation (Line(points={{-8,22},{6,22},{28,22}}, color={0,127,255}));
  connect(exhaustAirFan.port_b, supplyAir.ports[1])
    annotation (Line(points={{44,22},{58,22},{142,22}}, color={0,127,255}));
  connect(exhaust_mflow.y, exhaustAirFan.m_flow_in) annotation (Line(points={{
          -3,60},{18,60},{18,56},{35.84,56},{35.84,31.6}}, color={0,0,127}));
end TestMenergaSimple;
