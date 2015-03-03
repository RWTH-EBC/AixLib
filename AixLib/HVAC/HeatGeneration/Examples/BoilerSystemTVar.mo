within AixLib.HVAC.HeatGeneration.Examples;


model BoilerSystemTVar "Test case for boiler model with heating curve"
  import AixLib;
  extends Modelica.Icons.Example;
  Pumps.Pump pumpSimple(Head_max = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-50, 10})));
  Sources.Boundary_p staticPressure annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, -10})));
  Pipes.StaticPipe pipe(l = 25, D = 0.01) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {70, 10})));
  Pipes.StaticPipe pipe1(l = 25, D = 0.01) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {10, -50})));
  inner BaseParameters baseParameters annotation(Placement(transformation(extent = {{80, 80}, {100, 100}})));
  Sensors.MassFlowSensor massFlowSensor annotation(Placement(transformation(extent = {{-40, 60}, {-20, 80}})));
  Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(extent = {{0, 60}, {20, 80}})));
  Boiler boiler(boilerEfficiencyB = AixLib.DataBase.Boiler.BoilerCondensing()) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-50, 50})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{12, -90}, {32, -70}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 1000, startTime = 60, freqHz = 0.0002, offset = -1000) annotation(Placement(transformation(extent = {{-28, -90}, {-8, -70}})));
  Volume.Volume volume annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {50, -50})));
  Modelica.Blocks.Sources.BooleanExpression Source_IsNight annotation(Placement(transformation(extent = {{-96, 0}, {-76, 20}})));
  Utilities.HeatCurve heatCurve annotation(Placement(transformation(extent = {{-90, 26}, {-70, 46}})));
  Sources.OutdoorTemp outdoorTemp annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-80, 82})));
equation
  connect(staticPressure.port_a, pumpSimple.port_a) annotation(Line(points = {{-90, -20}, {-90, -24}, {-50, -24}, {-50, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pipe1.port_b, pumpSimple.port_a) annotation(Line(points = {{0, -50}, {-50, -50}, {-50, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation(Line(points = {{-20, 70}, {0, 70}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(temperatureSensor.port_b, pipe.port_a) annotation(Line(points = {{20, 70}, {70, 70}, {70, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pumpSimple.port_b, boiler.port_a) annotation(Line(points = {{-50, 20}, {-50, 40}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boiler.port_b, massFlowSensor.port_a) annotation(Line(points = {{-50, 60}, {-50, 70}, {-40, 70}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(sine.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-7, -80}, {12, -80}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(pipe.port_b, volume.port_a) annotation(Line(points = {{70, 0}, {70, -50}, {60, -50}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volume.port_b, pipe1.port_a) annotation(Line(points = {{40, -50}, {20, -50}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(prescribedHeatFlow.port, volume.heatPort) annotation(Line(points = {{32, -80}, {50, -80}, {50, -60}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(Source_IsNight.y, pumpSimple.IsNight) annotation(Line(points = {{-75, 10}, {-60.2, 10}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(heatCurve.T_set, boiler.T_set) annotation(Line(points = {{-69.2, 36}, {-64, 36}, {-64, 39.2}, {-57, 39.2}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(outdoorTemp.T_out, heatCurve.T_ref) annotation(Line(points = {{-80, 71.4}, {-80, 60}, {-96, 60}, {-96, 36}, {-90, 36}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 82800, Interval = 60), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p><br/>This example models a simple fluid circuit in order to test the boiler model for plausibility</p>
 </html>", revisions = "<html>
 <p>07.10.2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end BoilerSystemTVar;
