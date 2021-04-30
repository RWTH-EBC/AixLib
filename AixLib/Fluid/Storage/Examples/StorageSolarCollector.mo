within AixLib.Fluid.Storage.Examples;
model StorageSolarCollector
  extends Modelica.Icons.Example;
  import AixLib;

  replaceable package Medium = AixLib.Media.Water;

  AixLib.Fluid.Storage.Storage storage(
    n=10,
    V_HE=0.05,
    kappa=0.4,
    beta=350e-6,
    A_HE=20,
    lambda_ins=0.04,
    s_ins=0.1,
    hConIn=1500,
    hConOut=15,
    k_HE=1500,
    d=1.5,
    h=2.5,
    redeclare package Medium = Medium,
    m_flow_nominal_layer=solarThermal.m_flow_nominal,
    m_flow_nominal_HE=solarThermal.m_flow_nominal)
                                       annotation (Placement(transformation(extent={{-30,14},{-10,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 283.15) annotation(Placement(transformation(extent={{-60,14},
            {-40,34}})));
  AixLib.Obsolete.Year2021.Fluid.Movers.Pump pump(
    ControlStrategy=1,
    redeclare package Medium = Medium,
    m_flow_small=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-8,70})));
  AixLib.Fluid.Sources.Boundary_pT
                     boundary_p(nPorts=1, redeclare package Medium = Medium)
                                annotation(Placement(transformation(extent = {{-86, 70}, {-66, 90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin={36,70})));
  Modelica.Fluid.Pipes.DynamicPipe
                   pipe(
    redeclare package Medium = Medium,
    length=10,
    diameter=0.05)                       annotation(Placement(transformation(extent={{-6,-10},
            {14,10}})));
  AixLib.Fluid.Sources.Boundary_ph
                      boundary_ph1(use_p_in = true, h = 42e3,
    nPorts=1,
    redeclare package Medium = Medium)                        annotation(Placement(transformation(extent={{-66,-26},
            {-46,-6}})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph2(nPorts=1, redeclare package Medium = Medium)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin={-76,52})));
  Modelica.Fluid.Pipes.DynamicPipe
                   pipe1(
    redeclare package Medium = Medium,
    length=10,
    diameter=0.05)                        annotation(Placement(transformation(extent={{-40,-26},
            {-20,-6}})));
  AixLib.Fluid.Solar.Thermal.SolarThermal solarThermal(
    Collector=AixLib.DataBase.SolarThermal.FlatCollector(),
    A=20,
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    volPip=1)
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  Modelica.Blocks.Sources.Pulse pulse(period = 3600,               width = 1, amplitude = 60,
    offset=101325)                                                                            annotation(Placement(transformation(extent={{-96,-18},
            {-76,2}})));
  AixLib.Obsolete.Year2021.Fluid.Actuators.Valves.SimpleValve simpleValve(
    Kvs=2,
    redeclare package Medium = Medium,
    m_flow_small=1e-4) annotation (Placement(transformation(
        extent={{-10,9},{10,-9}},
        rotation=90,
        origin={69,42})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            temperatureSensor(redeclare package Medium = Medium,
      m_flow_nominal=0.01)                    annotation(Placement(transformation(extent={{48,-10},
            {68,10}})));
  Modelica.Blocks.Continuous.LimPID PI(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.05, Ti = 60, yMax = 0.999, yMin = 0) annotation(Placement(transformation(extent = {{-6, 6}, {6, -6}}, rotation = 90, origin={90,14})));
  Modelica.Blocks.Sources.Constant const(k = 273.15 + 70) annotation(Placement(transformation(extent={{74,-10},
            {80,-4}})));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 90, origin={88,30})));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation(Placement(transformation(extent={{70,20},
            {78,28}})));
  Modelica.Blocks.Sources.CombiTimeTable hotSummerDay(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,21,0; 3600,20.6,0; 7200,20.5,0; 10800,20.4,0; 14400,20,6; 18000,20.5,
        106; 21600,22.4,251; 25200,24.1,402; 28800,26.3,540; 32400,28.4,657; 36000,
        30,739; 39600,31.5,777; 43200,31.5,778; 46800,32.5,737; 50400,32.5,657;
        54000,32.5,544; 57600,32.5,407; 61200,32.5,257; 64800,31.6,60; 68400,30.8,
        5; 72000,22.9,0; 75600,21.2,0; 79200,20.6,0; 82800,20.3,0],
    offset={273.15,0.01})
    annotation (Placement(transformation(extent={{10,32},{30,52}})));
equation
  connect(fixedTemperature.port, storage.heatPort) annotation(Line(points={{-40,24},
          {-28,24}},                                                                                color = {191, 0, 0}));
  connect(booleanExpression.y, pump.IsNight) annotation(Line(points={{25,70},{
          2.2,70}},                                                                             color = {255, 0, 255}));
  connect(pump.port_b, storage.port_a_heatGenerator) annotation(Line(points={{-8,60},
          {-8,32.8},{-11.6,32.8}},                                                                                     color = {0, 127, 255}));
  connect(pipe.port_a, storage.port_b_heatGenerator) annotation(Line(points={{-6,0},{
          -8,0},{-8,16},{-11.6,16}},                                                                                        color = {0, 127, 255}));
  connect(pipe1.port_b, storage.port_a_consumer) annotation(Line(points={{-20,-16},
          {-20,14}},                                                                                           color = {0, 127, 255}));
  connect(hotSummerDay.y[2], solarThermal.Irradiation) annotation(Line(points={{31,42},
          {31,10},{34,10}},                                                                                           color = {0, 0, 127}));
  connect(hotSummerDay.y[1], solarThermal.T_air) annotation(Line(points={{31,42},
          {31,22},{28,22},{28,10}},                                                                 color = {0, 0, 127}));
  connect(pulse.y, boundary_ph1.p_in) annotation(Line(points={{-75,-8},{-68,-8}},        color = {0, 0, 127}));
  connect(simpleValve.port_b, pump.port_a) annotation(Line(points={{69,52},{68,
          52},{68,80},{-8,80}},                                                                                color = {0, 127, 255}));
  connect(solarThermal.port_b, temperatureSensor.port_a) annotation(Line(points={{44,0},{
          48,0}},                                                                                     color = {0, 127, 255}));
  connect(solarThermal.port_a, pipe.port_b) annotation(Line(points={{24,0},{14,
          0}},                                                                            color = {0, 127, 255}));
  connect(temperatureSensor.port_b, simpleValve.port_a) annotation(Line(points={{68,0},{
          68,32},{69,32}},                                                                                      color = {0, 127, 255}));
  connect(const.y, PI.u_s) annotation(Line(points={{80.3,-7},{90,-7},{90,6.8}},          color = {0, 0, 127}));
  connect(PI.y, add.u2) annotation(Line(points={{90,20.6},{90,25.2},{90.4,25.2}},           color = {0, 0, 127}));
  connect(add.y, simpleValve.opening) annotation(Line(points={{88,34.4},{88,42},
          {76.2,42}},                                                                              color = {0, 0, 127}));
  connect(boundary_ph1.ports[1], pipe1.port_a) annotation (Line(
      points={{-46,-16},{-40,-16}},
      color={0,127,255}));
  connect(boundary_ph2.ports[1], storage.port_b_consumer) annotation (Line(
      points={{-66,52},{-20,52},{-20,34}},
      color={0,127,255}));
  connect(boundary_p.ports[1], pump.port_a) annotation (Line(
      points={{-66,80},{-36,80},{-8,80}},
      color={0,127,255}));
  connect(temperatureSensor.T, PI.u_m) annotation (Line(
      points={{58,11},{58,14},{82.8,14}},
      color={0,0,127}));
  connect(const1.y, add.u1) annotation (Line(points={{78.4,24},{85.6,24},{85.6,
          25.2}}, color={0,0,127}));
  annotation (experiment(StopTime = 172800, Interval = 60),Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is a simple example of a storage and a solar collector.
</p>
<ul>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe
  </li>
  <li>
    <i>April 2016&#160;</i> by Peter Remmen:<br/>
    Replace TempAndRad model
  </li>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>13.12.2013</i> by Sebastian Stinner:<br/>
    implemented
  </li>
</ul>
</html>"));
end StorageSolarCollector;
