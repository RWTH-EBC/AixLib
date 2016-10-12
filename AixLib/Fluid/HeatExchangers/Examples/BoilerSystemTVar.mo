within AixLib.Fluid.HeatExchangers.Examples;
model BoilerSystemTVar
  "Test case for boiler model with varying supply temperature"
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;
  Fluid.Movers.Pump pumpSimple(
    Head_max=1,
    redeclare package Medium = Medium,
    m_flow_small=0.001) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,10})));
  Fluid.Sources.FixedBoundary
                     staticPressure(nPorts=1, redeclare package Medium = Medium)
                                    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, -10})));
  FixedResistances.FixedResistanceDpM
                                    pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal=200)                       annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {70, 10})));
  FixedResistances.FixedResistanceDpM
                                    pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal=200)                        annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {10, -50})));
  Fluid.Sensors.MassFlowRate
                         massFlowSensor(redeclare package Medium = Medium)
                                        annotation(Placement(transformation(extent = {{-40, 60}, {-20, 80}})));
  Fluid.Sensors.TemperatureTwoPort
                            temperatureSensor(redeclare package Medium = Medium,
      m_flow_nominal=0.01)                    annotation(Placement(transformation(extent = {{0, 60}, {20, 80}})));
  Fluid.HeatExchangers.Boiler boiler(redeclare package Medium = Medium,
      m_flow_nominal=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,50})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{12, -90}, {32, -70}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 1000, startTime = 60, freqHz = 0.0002, offset = -1000) annotation(Placement(transformation(extent = {{-28, -90}, {-8, -70}})));
  Fluid.MixingVolumes.MixingVolume
                volume(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    V=0.1)             annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin={50,-66})));
  Modelica.Blocks.Sources.BooleanExpression Source_IsNight annotation(Placement(transformation(extent = {{-96, 0}, {-76, 20}})));
  Fluid.HeatExchangers.Utilities.HeatCurve heatCurve
    annotation (Placement(transformation(extent={{-90,26},{-70,46}})));
  Modelica.Blocks.Sources.CombiTimeTable coldWinterDay(
    table=[0,-5.1,0; 3600,-5,0; 7200,-4.9,0; 10800,-4.9,0; 14400,-4.8,0; 18000,
        -4.8,0; 21600,-4.9,0; 25200,-4.9,0; 28800,-4.8,0; 32400,-4.6,19; 36000,
        -4.4,39; 39600,-4.3,51; 43200,-4,51; 46800,-4.1,40; 50400,-4.1,21;
        54000,-4.1,1; 57600,-4.2,0; 61200,-4.7,0; 64800,-4.6,0; 68400,-4.7,0;
        72000,-5.2,0; 75600,-6.1,0; 79200,-5.8,0; 82800,-5.5,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    offset={273.15})
    annotation (Placement(transformation(extent={{-98,68},{-78,88}})));
equation
  connect(pipe1.port_b, pumpSimple.port_a) annotation(Line(points = {{0, -50}, {-50, -50}, {-50, 0}}, color = {0, 127, 255}));
  connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation(Line(points = {{-20, 70}, {0, 70}}, color = {0, 127, 255}));
  connect(temperatureSensor.port_b, pipe.port_a) annotation(Line(points = {{20, 70}, {70, 70}, {70, 20}}, color = {0, 127, 255}));
  connect(pumpSimple.port_b, boiler.port_a) annotation(Line(points = {{-50, 20}, {-50, 40}}, color = {0, 127, 255}));
  connect(boiler.port_b, massFlowSensor.port_a) annotation(Line(points = {{-50, 60}, {-50, 70}, {-40, 70}}, color = {0, 127, 255}));
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
  connect(heatCurve.T_set, boiler.T_set) annotation (Line(
      points={{-69.2,36},{-58,36},{-57,39.2}},
      color={0,0,127}));
  connect(coldWinterDay.y[1], heatCurve.T_ref) annotation (Line(points={{-77,78},
          {-72,78},{-72,52},{-96,52},{-96,36},{-90,36}}, color={0,0,127}));
  annotation (experiment(StopTime = 82800, Interval = 60), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>This example models a simple fluid circuit in order to test the boiler model
 for plausibility</p>
 </html>", revisions="<html>
 <ul>
 <li><i>October 11, 2016</i> by Marcus Fuchs:<br/>Replace pipe</li>
 <li><i>April 2016&nbsp;</i>
    by Peter Remmen:<br/>
    Replace OutdoorTemp model</li>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 <li><i>October 7, 2013&nbsp;</i>
    by Marcus Fuchs:<br/>
    Implemented</li>
 </ul>
 </html>"));
end BoilerSystemTVar;
