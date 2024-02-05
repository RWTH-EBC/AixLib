within AixLib.Fluid.DistrictHeatingCooling.Pipes.Examples;
model PlugFlowPipeEmbedded "Simple example of PlugFlowPipeEmbedded"
  import AixLib;
  extends Modelica.Icons.Example;
  replaceable package Medium = AixLib.Media.Water "Medium in the pipe" annotation (
      choicesAllMatching=true);
  Modelica.Blocks.Sources.Ramp Tin(
    height=20,
    offset=273.15 + 10,
    duration=1000,
    startTime=10000)
                   "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-92,-6},{-72,14}})));
  Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipeEmbedded
                                             pip(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    nPorts=1,
    dh=0.1,
    length=100,
    kIns=0.028,
    m_flow_nominal=1,
    cPip=500,
    thickness=0.0032,
    initDelay=true,
    m_flow_start=1,
    rhoPip=8000,
    dIns=0.00001,
    T_start_in=323.15,
    T_start_out=323.15,
    thickness_ground=0.05)
                        "Pipe"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou(T=288.15)
    "Boundary temperature"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  AixLib.Fluid.Sources.MassFlowSource_T sou(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTemOut(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemIn(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  connect(bou.port, pip.heatPort)
    annotation (Line(points={{-20,70},{10,70},{10,10.4}},
                                                        color={191,0,0}));
  connect(Tin.y, sou.T_in)
    annotation (Line(points={{-71,4},{-62,4}}, color={0,0,127}));
  connect(pip.port_b, senTemOut.port_a)
    annotation (Line(points={{20,0},{30,0}}, color={0,127,255}));
  connect(senTemOut.port_b, sin.ports[1])
    annotation (Line(points={{50,0},{62,0}}, color={0,127,255}));
  connect(sou.ports[1], senTemIn.port_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,127,255}));
  connect(senTemIn.port_b, pip.port_a)
    annotation (Line(points={{-10,0},{0,0}}, color={0,127,255}));
  annotation (
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/DistrictHeatingCooling/Pipes/Examples/PlugFlowPipeEmbedded.mos"
                      "Simulate and plot"),
    experiment(
      StopTime=100000,
      Interval=60,
      Tolerance=1e-06),
    Documentation(info="<html><p>
  Basic test of model <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipeEmbedded\">
  AixLib.Fluid.DistrictHeatingCooling.Pipes.PlugFlowPipeEmbedded</a>.
  This test includes an inlet temperature step under a constant mass
  flow rate.
</p>
<ul>
  <li>September 25, 2019 by Nils Neuland:<br/>
    First implementation
  </li>
</ul>
</html>"));
end PlugFlowPipeEmbedded;
