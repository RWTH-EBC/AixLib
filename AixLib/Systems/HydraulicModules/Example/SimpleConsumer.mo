within AixLib.Systems.HydraulicModules.Example;
model SimpleConsumer
  extends Modelica.Icons.Example;
  package MediumWater = AixLib.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0) = 0.5
    "Nominal mass flow rate";
  BaseClasses.PumpCircuit pumpCircuit(
    redeclare package Medium = MediumWater,
    m_flow_total=m_flow_nominal,
    dp_nom=100000,
    V_Water=0.1)   annotation (Placement(transformation(
        extent={{-22,-10},{22,10}},
        rotation=180,
        origin={0,-60})));
  Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.RealExpression y_pump(y=1)    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Sources.RealExpression T_pump(y=273.15 + 50)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,-80})));
  Fluid.Sensors.TemperatureTwoPort senTFlow(
    redeclare package Medium = MediumWater,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=293.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-34})));
  Fluid.Sensors.TemperatureTwoPort senTReturn(
    redeclare package Medium = MediumWater,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=293.15)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,-30})));
  AixLib.Systems.HydraulicModules.SimpleConsumer simpleConsumer(
    kA=10,
    T_return=313.15,
    T_flow=323.15,
    Q_flow_fixed=10000,
    functionality="Q_flow_fixed",
    demandType=1,
      redeclare package Medium = MediumWater,
      m_flow_nominal = m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(bou.ports[1], simpleConsumer.port_a)
    annotation (Line(points={{-90,0},{-10,0}}, color={0,127,255}));
  connect(y_pump.y, pumpCircuit.y) annotation (Line(points={{-19,-80},{-6.66134e-16,
          -80},{-6.66134e-16,-69.5}}, color={0,0,127}));
  connect(T_pump.y, pumpCircuit.T) annotation (Line(points={{19,-80},{4.4,-80},{
          4.4,-69.5}}, color={0,0,127}));
  connect(pumpCircuit.port_b, senTFlow.port_a) annotation (Line(points={{-22,-60},
          {-60,-60},{-60,-44}}, color={0,127,255}));
  connect(senTFlow.port_b, simpleConsumer.port_a)
    annotation (Line(points={{-60,-24},{-60,0},{-10,0}}, color={0,127,255}));
  connect(simpleConsumer.port_b, senTReturn.port_a)
    annotation (Line(points={{10,0},{44,0},{44,-20}}, color={0,127,255}));
  connect(senTReturn.port_b, pumpCircuit.port_a)
    annotation (Line(points={{44,-40},{44,-60},{22,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer;
