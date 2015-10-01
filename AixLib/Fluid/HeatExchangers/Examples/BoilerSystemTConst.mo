within AixLib.Fluid.HeatExchangers.Examples;
model BoilerSystemTConst
  "Test case for boiler model with constant supply temperature"
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;
  Movers.Pump pumpSimple(
    Head_max=1,
    redeclare package Medium = Medium,
    m_flow_small=0.001) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,10})));
  Fluid.Sources.FixedBoundary
                     staticPressure(nPorts=1, redeclare package Medium = Medium)
                                    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, -10})));
  FixedResistances.StaticPipe
                   pipe(l = 25, D = 0.01,
    redeclare package Medium = Medium,
    m_flow_small=0.001)                   annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {70, 10})));
  FixedResistances.StaticPipe
                   pipe1(l = 25, D = 0.01,
    redeclare package Medium = Medium,
    m_flow_small=0.001)                    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {10, -50})));
  Fluid.Sensors.MassFlowRate
                         massFlowSensor(redeclare package Medium = Medium)
                                        annotation(Placement(transformation(extent = {{-40, 60}, {-20, 80}})));
  Fluid.Sensors.TemperatureTwoPort
                            temperatureSensor(redeclare package Medium = Medium,
      m_flow_nominal=0.01)                    annotation(Placement(transformation(extent = {{0, 60}, {20, 80}})));
  Boiler boiler(redeclare package Medium = Medium, m_flow_nominal=0.01)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,50})));
  Modelica.Blocks.Sources.Constant const(k = 80 + 273.15) annotation(Placement(transformation(extent = {{-100, 26}, {-80, 46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{12, -90}, {32, -70}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 1000, startTime = 60, freqHz = 0.0002, offset = -1000) annotation(Placement(transformation(extent = {{-28, -90}, {-8, -70}})));
  Fluid.MixingVolumes.MixingVolume
                volume(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    V=0.1)             annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin={50,-66})));
  Modelica.Blocks.Sources.BooleanExpression Source_IsNight annotation(Placement(transformation(extent = {{-96, 0}, {-76, 20}})));
equation
  connect(pipe1.port_b, pumpSimple.port_a) annotation(Line(points = {{0, -50}, {-50, -50}, {-50, 0}}, color = {0, 127, 255}));
  connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation(Line(points = {{-20, 70}, {0, 70}}, color = {0, 127, 255}));
  connect(temperatureSensor.port_b, pipe.port_a) annotation(Line(points = {{20, 70}, {70, 70}, {70, 20}}, color = {0, 127, 255}));
  connect(pumpSimple.port_b, boiler.port_a) annotation(Line(points = {{-50, 20}, {-50, 40}}, color = {0, 127, 255}));
  connect(boiler.port_b, massFlowSensor.port_a) annotation(Line(points = {{-50, 60}, {-50, 70}, {-40, 70}}, color = {0, 127, 255}));
  connect(const.y, boiler.T_set) annotation(Line(points = {{-79, 36}, {-57, 36}, {-57, 39.2}}, color = {0, 0, 127}));
  connect(sine.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-7, -80}, {12, -80}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow.port, volume.heatPort) annotation(Line(points={{32,-80},
          {72,-80},{72,-66},{60,-66}},                                                                          color = {191, 0, 0}));
  connect(Source_IsNight.y, pumpSimple.IsNight) annotation(Line(points = {{-75, 10}, {-60.2, 10}}, color = {255, 0, 255}));
  connect(pipe.port_b, volume.ports[1]) annotation (Line(
      points={{70,0},{70,-50},{52,-50},{52,-56}},
      color={0,127,255}));
  connect(pipe1.port_a, volume.ports[2]) annotation (Line(
      points={{20,-50},{44,-50},{48,-56}},
      color={0,127,255}));
  connect(staticPressure.ports[1], pumpSimple.port_a) annotation (Line(
      points={{-90,-20},{-90,-28},{-50,-28},{-50,0}},
      color={0,127,255}));
  annotation( experiment(StopTime = 82800, Interval = 60), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p><br/>This example models a simple fluid circuit in order to test the boiler model for plausibility</p>
 </html>", revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>07.10.2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end BoilerSystemTConst;
