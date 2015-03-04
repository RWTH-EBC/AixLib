within AixLib.HVAC.Volume.Examples;


model MoistAirWithHeatTransfer
  extends Modelica.Icons.Example;
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(X = 0.001, p = 100000) annotation(Placement(transformation(extent = {{-100, -97}, {-70, -67}})));
  Sources.MassflowsourceMoistAir_mhX massflowsourceMoistAir_mhX_1(h = 7e3, X = 2e-3, m = 0.1) annotation(Placement(transformation(extent = {{-100, 40}, {-70, 71}})));
  AixLib.HVAC.Volume.VolumeMoistAir volumeMoistAir_1(V = 1) annotation(Placement(transformation(extent = {{44, 36}, {84, 76}})));
  inner BaseParameters baseParameters(T0 = 298.15) annotation(Placement(transformation(extent = {{78, 74}, {98, 94}})));
  AixLib.HVAC.Volume.VolumeMoistAir volumeMoistAir_M(V = 1) annotation(Placement(transformation(extent = {{-20, 20}, {20, -20}}, rotation = 180, origin = {66, -82})));
  AixLib.HVAC.Volume.VolumeMoistAir volumeMoistAir_2(V = 2) annotation(Placement(transformation(extent = {{40, -20}, {80, 20}})));
  Sensors.RelativeHumiditySensor humiditySensor_1 annotation(Placement(transformation(extent = {{-56, 46}, {-36, 66}})));
  Sensors.RelativeHumiditySensor humiditySensor_2 annotation(Placement(transformation(extent = {{-52, -10}, {-32, 10}})));
  Sensors.RelativeHumiditySensor humiditySensor_M annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {26, -82})));
  Sources.MassflowsourceMoistAir_mhX massflowsourceMoistAir_mhX_2(h = 39e3, X = 7.5e-3, m = 0.2) annotation(Placement(transformation(extent = {{-103, -15}, {-73, 16}})));
  Sensors.RelativeHumiditySensor humiditySensor_C annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-50, -82})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{-40, -52}, {-20, -32}})));
  AixLib.HVAC.Volume.VolumeMoistAir volumeMoistAir_M1(V = 1) annotation(Placement(transformation(extent = {{-20, 20}, {20, -20}}, rotation = 180, origin = {-12, -82})));
  Modelica.Blocks.Sources.Ramp ramp(startTime = 100, duration = 100, height = -2000) annotation(Placement(transformation(extent = {{-80, -52}, {-60, -32}})));
equation
  connect(massflowsourceMoistAir_mhX_1.portMoistAir_a, humiditySensor_1.portMoistAir_a) annotation(Line(points = {{-70, 55.5}, {-63, 55.5}, {-63, 56}, {-56, 56}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(humiditySensor_1.portMoistAir_b, volumeMoistAir_1.portMoistAir_a) annotation(Line(points = {{-36, 56}, {44, 56}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(humiditySensor_2.portMoistAir_b, volumeMoistAir_2.portMoistAir_a) annotation(Line(points = {{-32, 0}, {40, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(humiditySensor_2.portMoistAir_a, massflowsourceMoistAir_mhX_2.portMoistAir_a) annotation(Line(points = {{-52, 0}, {-66, 0}, {-66, 0.5}, {-73, 0.5}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(humiditySensor_C.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a) annotation(Line(points = {{-60, -82}, {-70, -82}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volumeMoistAir_2.portMoistAir_b, volumeMoistAir_M.portMoistAir_a) annotation(Line(points = {{80, 0}, {98, 0}, {98, -82}, {86, -82}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volumeMoistAir_1.portMoistAir_b, volumeMoistAir_M.portMoistAir_a) annotation(Line(points = {{84, 56}, {98, 56}, {98, -82}, {86, -82}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(humiditySensor_M.portMoistAir_b, volumeMoistAir_M1.portMoistAir_a) annotation(Line(points = {{16, -82}, {8, -82}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volumeMoistAir_M1.portMoistAir_b, humiditySensor_C.portMoistAir_a) annotation(Line(points = {{-32, -82}, {-40, -82}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volumeMoistAir_M.portMoistAir_b, humiditySensor_M.portMoistAir_a) annotation(Line(points = {{46, -82}, {36, -82}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(prescribedHeatFlow.port, volumeMoistAir_M1.heatPort) annotation(Line(points = {{-20, -42}, {-12, -42}, {-12, -62}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(ramp.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-59, -42}, {-40, -42}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 1000, Interval = 1), __Dymola_experimentSetupOutput, Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example to show mixing of fluid flows and heat transfer for moist air model</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end MoistAirWithHeatTransfer;
