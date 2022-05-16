within AixLib.Systems.HydraulicModules.Example;
model SimpleConsumer_Feedback
  extends Modelica.Icons.Example;
  package MediumWater = AixLib.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Volume V_Water = 0.1;

  Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  AixLib.Systems.HydraulicModules.SimpleConsumer simpleConsumer(
    kA=10,
    T_fixed=283.15,
    T_return=313.15,
    T_flow=323.15,
    Q_flow_fixed=1000,
    functionality="T_fixed",
    demandType=1,
    hasPump=true,
    dp_nominalPumpConsumer=200000,
    k_ControlConsumerPump=0.5,
    Ti_ControlConsumerPump=10,
    hasFeedback=true,
    k_ControlConsumerValve=0.5,
    Ti_ControlConsumerValve=10,
    dp_Valve(displayUnit="Pa") = 100,
    dpFixed_nominal(displayUnit="Pa") = {100,100},
    redeclare package Medium = MediumWater,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sources.Boundary_pT
                      bou1(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,0})));
equation
  connect(simpleConsumer.port_b, bou1.ports[1])
    annotation (Line(points={{10,0},{50,0}}, color={0,127,255}));
  connect(bou.ports[1], simpleConsumer.port_a)
    annotation (Line(points={{-90,0},{-10,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer_Feedback;
