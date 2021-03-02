within AixLib.Fluid.DistrictHeatingCooling.Pipes.Examples;
model DHCPipe "Simple example of DHCPipe and its four different modes"
  extends Modelica.Icons.Example;
  replaceable package Medium = AixLib.Media.Water "Medium in the pipe" annotation (
      choicesAllMatching=true);
  Modelica.Blocks.Sources.Pulse Tin(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{72,40},{52,60}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCPipe          pip(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare BaseClassesStatic.StaticCore pipCor "Static core",
    nPorts=1,
    dh=0.1,
    length=100,
    dIns=0.05,
    kIns=0.028,
    m_flow_nominal=1,
    cPip=500,
    thickness=0.0032,
    initDelay=true,
    m_flow_start=1,
    rhoPip=8000,
    use_zeta=false,
    T_start_in=323.15,
    T_start_out=323.15) "Pipe"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou(T=283.15)
    "Boundary temperature"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Fluid.Sources.MassFlowSource_T sou(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=1) "Flow source"
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTemOut(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemIn(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Pulse Tin1(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
  Sources.Boundary_pT sin1(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{72,0},{52,20}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCPipe          pip1(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor "PlugFlow core",
    nPorts=1,
    dh=0.1,
    length=100,
    dIns=0.05,
    kIns=0.028,
    m_flow_nominal=1,
    cPip=500,
    thickness=0.0032,
    initDelay=true,
    m_flow_start=1,
    rhoPip=8000,
    use_zeta=false,
    T_start_in=323.15,
    T_start_out=323.15) "Pipe"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Sources.MassFlowSource_T              sou1(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=1) "Flow source"
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Sensors.TemperatureTwoPort              senTemOut1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Sensors.TemperatureTwoPort              senTemIn1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Pulse Tin2(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-100,-38},{-80,-18}})));
  Sources.Boundary_pT sin2(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{72,-42},{52,-22}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCPipe          pip2(
    redeclare package Medium = Medium,
    use_soil=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor "PlugFlow core",
    nPorts=1,
    dh=0.1,
    length=100,
    dIns=0.05,
    kIns=0.028,
    m_flow_nominal=1,
    cPip=500,
    thickness=0.0032,
    initDelay=true,
    m_flow_start=1,
    rhoPip=8000,
    use_zeta=false,
    T_start_in=323.15,
    T_start_out=323.15) "Pipe"
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
  Sources.MassFlowSource_T              sou2(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=1) "Flow source"
    annotation (Placement(transformation(extent={{-70,-42},{-50,-22}})));
  Sensors.TemperatureTwoPort              senTemOut2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,-42},{40,-22}})));
  Sensors.TemperatureTwoPort              senTemIn2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,-42},{-20,-22}})));
  Modelica.Blocks.Sources.Pulse Tin3(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-100,-76},{-80,-56}})));
  Sources.Boundary_pT sin3(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{72,-80},{52,-60}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCPipe          pip3(
    redeclare package Medium = Medium,
    sum_zetas=2.5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor "PlugFlow core",
    nPorts=1,
    dh=0.1,
    length=100,
    dIns=0.05,
    kIns=0.028,
    m_flow_nominal=1,
    cPip=500,
    thickness=0.0032,
    initDelay=true,
    m_flow_start=1,
    rhoPip=8000,
    use_zeta=true,
    T_start_in=323.15,
    T_start_out=323.15) "Pipe"
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Sources.MassFlowSource_T              sou3(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=1) "Flow source"
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Sensors.TemperatureTwoPort              senTemOut3(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Sensors.TemperatureTwoPort              senTemIn3(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
equation
  connect(bou.port, pip.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,60}},   color={191,0,0}));
  connect(Tin.y, sou.T_in)
    annotation (Line(points={{-79,54},{-72,54}},
                                               color={0,0,127}));
  connect(pip.ports_b[1], senTemOut.port_a)
    annotation (Line(points={{10,50},{20,50}},
                                             color={0,127,255}));
  connect(senTemOut.port_b, sin.ports[1])
    annotation (Line(points={{40,50},{52,50}},
                                             color={0,127,255}));
  connect(sou.ports[1], senTemIn.port_a)
    annotation (Line(points={{-50,50},{-40,50}},
                                               color={0,127,255}));
  connect(senTemIn.port_b, pip.port_a)
    annotation (Line(points={{-20,50},{-10,50}},
                                             color={0,127,255}));
  connect(bou.port, pip1.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,20}}, color={191,0,0}));
  connect(Tin1.y, sou1.T_in)
    annotation (Line(points={{-79,14},{-72,14}}, color={0,0,127}));
  connect(pip1.ports_b[1], senTemOut1.port_a)
    annotation (Line(points={{10,10},{20,10}}, color={0,127,255}));
  connect(senTemOut1.port_b, sin1.ports[1])
    annotation (Line(points={{40,10},{52,10}}, color={0,127,255}));
  connect(sou1.ports[1], senTemIn1.port_a)
    annotation (Line(points={{-50,10},{-40,10}}, color={0,127,255}));
  connect(senTemIn1.port_b, pip1.port_a)
    annotation (Line(points={{-20,10},{-10,10}}, color={0,127,255}));
  connect(bou.port, pip2.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-22}}, color={191,0,0}));
  connect(Tin2.y, sou2.T_in)
    annotation (Line(points={{-79,-28},{-72,-28}}, color={0,0,127}));
  connect(pip2.ports_b[1], senTemOut2.port_a)
    annotation (Line(points={{10,-32},{20,-32}}, color={0,127,255}));
  connect(senTemOut2.port_b, sin2.ports[1])
    annotation (Line(points={{40,-32},{52,-32}}, color={0,127,255}));
  connect(sou2.ports[1], senTemIn2.port_a)
    annotation (Line(points={{-50,-32},{-40,-32}}, color={0,127,255}));
  connect(senTemIn2.port_b, pip2.port_a)
    annotation (Line(points={{-20,-32},{-10,-32}}, color={0,127,255}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-60}}, color={191,0,0}));
  connect(Tin3.y, sou3.T_in)
    annotation (Line(points={{-79,-66},{-72,-66}}, color={0,0,127}));
  connect(pip3.ports_b[1], senTemOut3.port_a)
    annotation (Line(points={{10,-70},{20,-70}}, color={0,127,255}));
  connect(senTemOut3.port_b, sin3.ports[1])
    annotation (Line(points={{40,-70},{52,-70}}, color={0,127,255}));
  connect(sou3.ports[1], senTemIn3.port_a)
    annotation (Line(points={{-50,-70},{-40,-70}}, color={0,127,255}));
  connect(senTemIn3.port_b, pip3.port_a)
    annotation (Line(points={{-20,-70},{-10,-70}}, color={0,127,255}));
  annotation (
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/DistrictHeatingCooling/Pipes/Examples/DHCPipe.mos"
                      "Simulate and plot"),
    experiment(StopTime=3600, Tolerance=1e-006),
    Documentation(info="<html><p>
  Basic test of model <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCPipe\">AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCPipe</a>.
  This test includes an inlet temperature step under a constant mass
  flow rate. All four possible applications of the DHC pipe model are
  shown as examples.
</p>
<ul>
  <li>November 12, 2020, by Michael Mans:<br/>
    First implementation
  </li>
</ul>
</html>"));
end DHCPipe;
