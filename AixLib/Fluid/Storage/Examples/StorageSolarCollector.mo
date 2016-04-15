within AixLib.Fluid.Storage.Examples;
model StorageSolarCollector
  extends Modelica.Icons.Example;
  import AixLib;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  AixLib.HVAC.Storage.Storage storage(
    n=10,
    V_HE=0.05,
    kappa=0.4,
    beta=350e-6,
    A_HE=20,
    lambda_ins=0.04,
    s_ins=0.1,
    alpha_in=1500,
    alpha_out=15,
    k_HE=1500,
    d=1.5,
    h=2.5,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-56,14},{-36,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 283.15) annotation(Placement(transformation(extent = {{-94, 14}, {-74, 34}})));
  Pumps.Pump pump(ControlStrategy = 1,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                 annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-38, 64})));
  AixLib.Fluid.Sources.FixedBoundary
                     boundary_p(nPorts=1, redeclare package Medium = Medium)
                                annotation(Placement(transformation(extent = {{-86, 70}, {-66, 90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-10, 64})));
  Pipes.StaticPipe pipe(D = 0.05, l = 5,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                   annotation(Placement(transformation(extent = {{-34, -10}, {-14, 10}})));
  AixLib.Fluid.Sources.Boundary_ph
                      boundary_ph1(use_p_in = true, h = 42e3,
    nPorts=1,
    redeclare package Medium = Medium)                        annotation(Placement(transformation(extent = {{-112, -20}, {-92, 0}})));
  AixLib.Fluid.Sources.FixedBoundary
                      boundary_ph2(nPorts=1, redeclare package Medium = Medium)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin = {-72, 46})));
  Pipes.StaticPipe pipe1(D = 0.05, l = 5,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                    annotation(Placement(transformation(extent = {{-68, -20}, {-48, 0}})));
  HeatGeneration.SolarThermal solarThermal(Collector = AixLib.DataBase.SolarThermal.FlatCollector(), A = 20,
    redeclare package Medium = Medium,
    m_flow_nominal=0.01)                                                                                     annotation(Placement(transformation(extent = {{24, -10}, {44, 10}})));
  Modelica.Blocks.Sources.Pulse pulse(period = 3600,               width = 1, amplitude = 60,
    offset=101325)                                                                            annotation(Placement(transformation(extent = {{-142, -14}, {-122, 6}})));
  AixLib.HVAC.Valves.SimpleValve simpleValve(
    Kvs=2,
    redeclare package Medium = Medium,
    m_flow_small=1e-4) annotation (Placement(transformation(
        extent={{-10,9},{10,-9}},
        rotation=90,
        origin={79,42})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            temperatureSensor(redeclare package Medium = Medium,
      m_flow_nominal=0.01)                    annotation(Placement(transformation(extent = {{58, -10}, {78, 10}})));
  Modelica.Blocks.Continuous.LimPID PI(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.05, Ti = 60, yMax = 0.999, yMin = 0) annotation(Placement(transformation(extent = {{-6, 6}, {6, -6}}, rotation = 90, origin = {100, 12})));
  Modelica.Blocks.Sources.Constant const(k = 273.15 + 70) annotation(Placement(transformation(extent = {{84, -10}, {90, -4}})));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 90, origin = {98, 30})));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation(Placement(transformation(extent = {{82, 22}, {88, 28}})));
  Modelica.SIunits.Conversions.NonSIunits.Energy_kWh Q_ges;
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
  der(Q_ges) = (solarThermal.volume.heatPort.Q_flow - fixedTemperature.port.Q_flow) / 3.6e6;
  connect(fixedTemperature.port, storage.heatPort) annotation(Line(points = {{-74, 24}, {-54, 24}}, color = {191, 0, 0}));
  connect(booleanExpression.y, pump.IsNight) annotation(Line(points = {{-21, 64}, {-27.8, 64}}, color = {255, 0, 255}));
  connect(pump.port_b, storage.port_a_heatGenerator) annotation(Line(points = {{-38, 54}, {-38, 32.8}, {-37.6, 32.8}}, color = {0, 127, 255}));
  connect(pipe.port_a, storage.port_b_heatGenerator) annotation(Line(points = {{-34, 0}, {-38, 0}, {-38, 16}, {-37.6, 16}}, color = {0, 127, 255}));
  connect(pipe1.port_b, storage.port_a_consumer) annotation(Line(points = {{-48, -10}, {-46, -10}, {-46, 14}}, color = {0, 127, 255}));
  connect(hotSummerDay.y[2], solarThermal.Irradiation) annotation(Line(points={{31,42},
          {31,10.8},{35,10.8}},                                                                                       color = {0, 0, 127}));
  connect(hotSummerDay.y[1], solarThermal.T_air) annotation(Line(points={{31,42},
          {31,22},{28,22},{28,10.8}},                                                               color = {0, 0, 127}));
  connect(pulse.y, boundary_ph1.p_in) annotation(Line(points={{-121,-4},{-114,-2}},      color = {0, 0, 127}));
  connect(simpleValve.port_b, pump.port_a) annotation(Line(points = {{79, 52}, {78, 52}, {78, 74}, {-38, 74}}, color = {0, 127, 255}));
  connect(solarThermal.port_b, temperatureSensor.port_a) annotation(Line(points = {{44, 0}, {58, 0}}, color = {0, 127, 255}));
  connect(solarThermal.port_a, pipe.port_b) annotation(Line(points = {{24, 0}, {-14, 0}}, color = {0, 127, 255}));
  connect(temperatureSensor.port_b, simpleValve.port_a) annotation(Line(points = {{78, 0}, {78, 32}, {79, 32}}, color = {0, 127, 255}));
  connect(const.y, PI.u_s) annotation(Line(points = {{90.3, -7}, {100, -7}, {100, 4.8}}, color = {0, 0, 127}));
  connect(PI.y, add.u2) annotation(Line(points = {{100, 18.6}, {100, 25.2}, {100.4, 25.2}}, color = {0, 0, 127}));
  connect(add.y, simpleValve.opening) annotation(Line(points = {{98, 34.4}, {98, 42}, {86.2, 42}}, color = {0, 0, 127}));
  connect(const1.y, add.u1) annotation(Line(points = {{88.3, 25}, {92.15, 25}, {92.15, 25.2}, {95.6, 25.2}}, color = {0, 0, 127}));
  connect(boundary_ph1.ports[1], pipe1.port_a) annotation (Line(
      points={{-92,-10},{-68,-10}},
      color={0,127,255}));
  connect(boundary_ph2.ports[1], storage.port_b_consumer) annotation (Line(
      points={{-62,46},{-48,46},{-46,34}},
      color={0,127,255}));
  connect(boundary_p.ports[1], pump.port_a) annotation (Line(
      points={{-66,80},{-38,80},{-38,74}},
      color={0,127,255}));
  connect(temperatureSensor.T, PI.u_m) annotation (Line(
      points={{68,11},{68,18},{92.8,12}},
      color={0,0,127}));
  annotation (experiment(StopTime = 172800, Interval = 60),Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>This is a simple example of a storage and a solar collector.</p>
 </html>", revisions="<html>
 <ul>
 <li><i>April 2016&nbsp;</i>
    by Peter Remmen:<br/>
    Replace TempAndRad model</li>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 <li><i>13.12.2013</i>
       by Sebastian Stinner:<br/>
      implemented</li>
 </ul>
 </html>"));
end StorageSolarCollector;
