within AixLib.Fluid.DistrictHeatingCooling.Pipes.Examples;
model TwoPipe "Simple example of PlugFlowPipe"
  extends Modelica.Icons.Example;
  replaceable package Medium = AixLib.Media.Water "Medium in the pipe" annotation (
      choicesAllMatching=true);
  Modelica.Blocks.Sources.Ramp Tin(
    height=20,
    duration=0,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-92,24},{-72,44}})));
  Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{82,20},{62,40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou(T=283.15)
    "Boundary temperature"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  AixLib.Fluid.Sources.MassFlowSource_T sou(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTemOut(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{30,20},{50,40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemIn(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Blocks.Sources.Ramp Tin1(
    height=20,
    duration=0,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{100,-30},{80,-50}})));
  Sources.Boundary_pT sin1(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    p(displayUnit="Pa") = 101325,
    nPorts=1)                     "Pressure boundary condition"
    annotation (Placement(transformation(extent={{-80,-20},{-60,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou1(T=283.15)
    "Boundary temperature"
    annotation (Placement(transformation(extent={{20,-62},{0,-82}})));
  Sources.MassFlowSource_T              sou1(
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3,
    nPorts=1) "Flow source"
    annotation (Placement(transformation(extent={{60,-20},{40,-40}})));
  Sensors.TemperatureTwoPort              senTemOut1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{28,-20},{8,-40}})));
  Sensors.TemperatureTwoPort              senTemIn1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-32,-20},{-52,-40}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.TwoPipe twoPipe(
    redeclare package Medium = Medium,
    dh=0.1,
    length=100,
    m_flow_nominal=1,
    dIns=0.004,
    kIns=0.38,
    redeclare AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipeEmbedded
      staticPipe,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(Tin.y, sou.T_in)
    annotation (Line(points={{-71,34},{-62,34}},
                                               color={0,0,127}));
  connect(senTemOut.port_b, sin.ports[1])
    annotation (Line(points={{50,30},{62,30}},
                                             color={0,127,255}));
  connect(sou.ports[1], senTemIn.port_a)
    annotation (Line(points={{-40,30},{-30,30}},
                                               color={0,127,255}));
  connect(senTemIn1.port_b, sin1.ports[1])
    annotation (Line(points={{-52,-30},{-60,-30}}, color={0,127,255}));
  connect(sou1.ports[1], senTemOut1.port_a)
    annotation (Line(points={{40,-30},{28,-30}}, color={0,127,255}));
  connect(Tin1.y, sou1.T_in) annotation (Line(points={{79,-40},{72,-40},{72,-34},
          {62,-34}}, color={0,0,127}));
  connect(senTemIn.port_b, twoPipe.port_a1)
    annotation (Line(points={{-10,30},{-10,6}}, color={0,127,255}));
  connect(twoPipe.ports_b1[1], senTemOut.port_a) annotation (Line(points={{10,6},
          {20,6},{20,30},{30,30}}, color={0,127,255}));
  connect(bou.port, twoPipe.heatPort1)
    annotation (Line(points={{-20,70},{0,70},{0,9.4}}, color={191,0,0}));
  connect(twoPipe.heatPort2, bou1.port) annotation (Line(points={{0,-9.4},{0,
          -24},{-8,-24},{-8,-72},{0,-72}}, color={191,0,0}));
  connect(twoPipe.ports_b2[1], senTemIn1.port_a) annotation (Line(points={{-10,
          -6},{-22,-6},{-22,-30},{-32,-30}}, color={0,127,255}));
  connect(twoPipe.port_a2, senTemOut1.port_b)
    annotation (Line(points={{10,-6},{10,-30},{8,-30}}, color={0,127,255}));
  annotation (
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/DistrictHeatingCooling/Pipes/Examples/PlugFlowPipeZeta.mos"
                      "Simulate and plot"),
    experiment(StopTime=1000, Tolerance=1e-006),
    Documentation(info="<html><p>
  Basic test of model <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipeZeta\">
  AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipeZeta</a>. This
  test includes an inlet temperature step under a constant mass flow
  rate.
</p>
<ul>
  <li>September 25, 2019 by Nils Neuland:<br/>
    First implementation
  </li>
</ul>
</html>"));
end TwoPipe;
