within AixLib.Fluid.DistrictHeatingCooling.Pipes.Examples;
model DHCDoublePipe "Simple example of PlugFlowPipe"
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
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCDoublePipe    pip(
    redeclare package Medium = Medium,
    redeclare BaseClassesStatic.StaticCore pipCor "Static core",
    redeclare BaseClassesStatic.StaticCore pipCor1 "Static core",
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
    m_flow=3) "Flow source"
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
    annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Sources.Boundary_pT sin1(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{72,-40},{52,-20}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCDoublePipe    pip1(
    redeclare package Medium = Medium,
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor "PlugFlow core",
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor1 "PlugFlow core",
    nPorts=1,
    dh=0.1,
    length=100,
    dIns=0.001,
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
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Sources.MassFlowSource_T              sou1(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Sensors.TemperatureTwoPort              senTemOut1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Sensors.TemperatureTwoPort              senTemIn1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.Pulse Tin2(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-100,-116},{-80,-96}})));
  Sources.Boundary_pT sin2(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{72,-120},{52,-100}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCDoublePipe    pip2(
    redeclare package Medium = Medium,
    use_soil=true,
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor "PlugFlow core",
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor1 "PlugFlow core",
    nPorts=1,
    dh=0.1,
    length=100,
    dIns=0.001,
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
    annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  Sources.MassFlowSource_T              sou2(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{-70,-120},{-50,-100}})));
  Sensors.TemperatureTwoPort              senTemOut2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  Sensors.TemperatureTwoPort              senTemIn2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,-120},{-20,-100}})));
  Modelica.Blocks.Sources.Pulse Tin3(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-100,-196},{-80,-176}})));
  Sources.Boundary_pT sin3(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{72,-200},{52,-180}})));
  AixLib.Fluid.DistrictHeatingCooling.Pipes.DHCDoublePipe    pip3(
    redeclare package Medium = Medium,
    sum_zetas=2.5,
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor "PlugFlow core",
    redeclare FixedResistances.BaseClasses.PlugFlowCore pipCor1 "PlugFlow core",
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
    annotation (Placement(transformation(extent={{-10,-200},{10,-180}})));
  Sources.MassFlowSource_T              sou3(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{-70,-200},{-50,-180}})));
  Sensors.TemperatureTwoPort              senTemOut3(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{20,-200},{40,-180}})));
  Sensors.TemperatureTwoPort              senTemIn3(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));
  Modelica.Blocks.Sources.Pulse Tin4(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{100,30},{80,50}})));
  Sources.MassFlowSource_T              sou4(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{76,10},{56,30}})));
  Sensors.TemperatureTwoPort              senTemIn4(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,10},{20,30}})));
  Sources.Boundary_pT sin4(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
  Sensors.TemperatureTwoPort              senTemOut4(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
  Modelica.Blocks.Sources.Pulse Tin5(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Sources.MassFlowSource_T              sou5(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{76,-70},{56,-50}})));
  Sensors.TemperatureTwoPort              senTemIn5(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
  Sources.Boundary_pT sin5(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{-68,-70},{-48,-50}})));
  Sensors.TemperatureTwoPort              senTemOut5(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Pulse Tin6(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{100,-132},{80,-112}})));
  Sources.MassFlowSource_T              sou6(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{76,-150},{56,-130}})));
  Sensors.TemperatureTwoPort              senTemIn6(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,-150},{20,-130}})));
  Sources.Boundary_pT sin6(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{-68,-150},{-48,-130}})));
  Sensors.TemperatureTwoPort              senTemOut6(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-20,-150},{-40,-130}})));
  Modelica.Blocks.Sources.Pulse Tin7(
    amplitude=20,
    period=20,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{100,-212},{80,-192}})));
  Sources.MassFlowSource_T              sou7(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3) "Flow source"
    annotation (Placement(transformation(extent={{76,-230},{56,-210}})));
  Sensors.TemperatureTwoPort              senTemIn7(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{40,-230},{20,-210}})));
  Sources.Boundary_pT sin7(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{-68,-230},{-48,-210}})));
  Sensors.TemperatureTwoPort              senTemOut7(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15) "Temperature sensor"
    annotation (Placement(transformation(extent={{-20,-230},{-40,-210}})));
equation
  connect(bou.port, pip.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,60}},   color={191,0,0}));
  connect(Tin.y, sou.T_in)
    annotation (Line(points={{-79,54},{-72,54}},
                                               color={0,0,127}));
  connect(pip.ports_b[1], senTemOut.port_a)
    annotation (Line(points={{9.8,55},{14,55},{14,50},{20,50}},
                                             color={0,127,255}));
  connect(senTemOut.port_b, sin.ports[1])
    annotation (Line(points={{40,50},{52,50}},
                                             color={0,127,255}));
  connect(sou.ports[1], senTemIn.port_a)
    annotation (Line(points={{-50,50},{-40,50}},
                                               color={0,127,255}));
  connect(senTemIn.port_b, pip.port_a)
    annotation (Line(points={{-20,50},{-16,50},{-16,55},{-10.2,55}},
                                             color={0,127,255}));
  connect(bou.port, pip1.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-20}},color={191,0,0}));
  connect(Tin1.y, sou1.T_in)
    annotation (Line(points={{-79,-26},{-72,-26}},
                                                 color={0,0,127}));
  connect(pip1.ports_b[1], senTemOut1.port_a)
    annotation (Line(points={{9.8,-25},{14,-25},{14,-30},{20,-30}},
                                               color={0,127,255}));
  connect(senTemOut1.port_b, sin1.ports[1])
    annotation (Line(points={{40,-30},{52,-30}},
                                               color={0,127,255}));
  connect(sou1.ports[1], senTemIn1.port_a)
    annotation (Line(points={{-50,-30},{-40,-30}},
                                                 color={0,127,255}));
  connect(senTemIn1.port_b, pip1.port_a)
    annotation (Line(points={{-20,-30},{-16,-30},{-16,-25},{-10.2,-25}},
                                                 color={0,127,255}));
  connect(bou.port, pip2.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-100}},color={191,0,0}));
  connect(Tin2.y, sou2.T_in)
    annotation (Line(points={{-79,-106},{-72,-106}},
                                                   color={0,0,127}));
  connect(pip2.ports_b[1], senTemOut2.port_a)
    annotation (Line(points={{9.8,-105},{14,-105},{14,-110},{20,-110}},
                                                 color={0,127,255}));
  connect(senTemOut2.port_b, sin2.ports[1])
    annotation (Line(points={{40,-110},{52,-110}},
                                                 color={0,127,255}));
  connect(sou2.ports[1], senTemIn2.port_a)
    annotation (Line(points={{-50,-110},{-40,-110}},
                                                   color={0,127,255}));
  connect(senTemIn2.port_b, pip2.port_a)
    annotation (Line(points={{-20,-110},{-16,-110},{-16,-105},{-10.2,-105}},
                                                   color={0,127,255}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(Tin3.y, sou3.T_in)
    annotation (Line(points={{-79,-186},{-72,-186}},
                                                   color={0,0,127}));
  connect(pip3.ports_b[1], senTemOut3.port_a)
    annotation (Line(points={{9.8,-185},{14,-185},{14,-190},{20,-190}},
                                                 color={0,127,255}));
  connect(senTemOut3.port_b, sin3.ports[1])
    annotation (Line(points={{40,-190},{52,-190}},
                                                 color={0,127,255}));
  connect(sou3.ports[1], senTemIn3.port_a)
    annotation (Line(points={{-50,-190},{-40,-190}},
                                                   color={0,127,255}));
  connect(senTemIn3.port_b, pip3.port_a)
    annotation (Line(points={{-20,-190},{-16,-190},{-16,-185},{-10.2,-185}},
                                                   color={0,127,255}));
  connect(Tin4.y, sou4.T_in)
    annotation (Line(points={{79,40},{78,40},{78,24}}, color={0,0,127}));
  connect(sou4.ports[1], senTemIn4.port_a)
    annotation (Line(points={{56,20},{40,20}}, color={0,127,255}));
  connect(senTemOut4.port_b, sin4.ports[1])
    annotation (Line(points={{-40,20},{-48,20}}, color={0,127,255}));
  connect(senTemOut4.port_a, pip.ports_b1[1]) annotation (Line(points={{-20,20},
          {-16,20},{-16,45},{-10,45}}, color={0,127,255}));
  connect(senTemIn4.port_b, pip.port_a1) annotation (Line(points={{20,20},{16,
          20},{16,45},{10,45}}, color={0,127,255}));
  connect(bou.port, pip.heatPort1)
    annotation (Line(points={{-80,90},{0,90},{0,34.8}}, color={191,0,0}));
  connect(bou.port, pip1.heatPort1)
    annotation (Line(points={{-80,90},{0,90},{0,-45.2}}, color={191,0,0}));
  connect(bou.port, pip1.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-20}},color={191,0,0}));
  connect(bou.port, pip2.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-100}},color={191,0,0}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(Tin5.y, sou5.T_in)
    annotation (Line(points={{79,-40},{78,-40},{78,-56}}, color={0,0,127}));
  connect(sou5.ports[1], senTemIn5.port_a)
    annotation (Line(points={{56,-60},{40,-60}}, color={0,127,255}));
  connect(senTemOut5.port_b, sin5.ports[1])
    annotation (Line(points={{-40,-60},{-48,-60}}, color={0,127,255}));
  connect(bou.port, pip1.heatPort1)
    annotation (Line(points={{-80,90},{0,90},{0,-45.2}}, color={191,0,0}));
  connect(senTemIn5.port_b, pip1.port_a1) annotation (Line(points={{20,-60},{16,
          -60},{16,-35},{10,-35}}, color={0,127,255}));
  connect(senTemOut5.port_a, pip1.ports_b1[1]) annotation (Line(points={{-20,
          -60},{-16,-60},{-16,-35},{-10,-35}}, color={0,127,255}));
  connect(bou.port, pip2.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-100}},color={191,0,0}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(bou.port, pip2.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-100}},color={191,0,0}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(Tin6.y, sou6.T_in)
    annotation (Line(points={{79,-122},{78,-122},{78,-136}}, color={0,0,127}));
  connect(sou6.ports[1], senTemIn6.port_a)
    annotation (Line(points={{56,-140},{40,-140}}, color={0,127,255}));
  connect(senTemOut6.port_b, sin6.ports[1])
    annotation (Line(points={{-40,-140},{-48,-140}}, color={0,127,255}));
  connect(bou.port, pip2.heatPort1)
    annotation (Line(points={{-80,90},{0,90},{0,-125.2}}, color={191,0,0}));
  connect(senTemIn6.port_b, pip2.port_a1) annotation (Line(points={{20,-140},{
          16,-140},{16,-115},{10,-115}}, color={0,127,255}));
  connect(senTemOut6.port_a, pip2.ports_b1[1]) annotation (Line(points={{-20,
          -140},{-16,-140},{-16,-115},{-10,-115}}, color={0,127,255}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(bou.port, pip3.heatPort)
    annotation (Line(points={{-80,90},{0,90},{0,-180}},color={191,0,0}));
  connect(Tin7.y, sou7.T_in)
    annotation (Line(points={{79,-202},{78,-202},{78,-216}}, color={0,0,127}));
  connect(sou7.ports[1], senTemIn7.port_a)
    annotation (Line(points={{56,-220},{40,-220}}, color={0,127,255}));
  connect(senTemOut7.port_b, sin7.ports[1])
    annotation (Line(points={{-40,-220},{-48,-220}}, color={0,127,255}));
  connect(senTemIn7.port_b, pip3.port_a1) annotation (Line(points={{20,-220},{
          16,-220},{16,-195},{10,-195}}, color={0,127,255}));
  connect(senTemOut7.port_a, pip3.ports_b1[1]) annotation (Line(points={{-20,
          -220},{-16,-220},{-16,-195},{-10,-195}}, color={0,127,255}));
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
</html>"),
    Diagram(coordinateSystem(extent={{-100,-240},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-240},{100,100}})));
end DHCDoublePipe;
