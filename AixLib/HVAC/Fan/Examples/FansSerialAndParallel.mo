within AixLib.HVAC.Fan.Examples;

model FansSerialAndParallel "Serial and Parallel Fan Example"
  extends Modelica.Icons.Example;
  inner BaseParameters baseParameters(T0 = 298.15) annotation(Placement(transformation(extent = {{80, 80}, {100, 100}})));
  FanSimple fanSimple_parallel1(UseRotationalSpeedInput = false) annotation(Placement(transformation(extent = {{-54, 52}, {-34, 72}})));
  FanSimple fanSimple_parallel2(UseRotationalSpeedInput = false) annotation(Placement(transformation(extent = {{-54, 24}, {-34, 44}})));
  FanSimple fanSimple_serial1(UseRotationalSpeedInput = false) annotation(Placement(transformation(extent = {{-54, -10}, {-34, 10}})));
  FanSimple fanSimple_serial2(UseRotationalSpeedInput = false) annotation(Placement(transformation(extent = {{-16, -10}, {4, 10}})));
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1_in(use_p_in = false, h = 1e3) annotation(Placement(transformation(extent = {{-102, 10}, {-82, 30}})));
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2_out(use_p_in = false, p = 120000) annotation(Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {82, 20})));
  Ductwork.PressureLoss pressureLoss_parallel(D = 0.1, zeta = 5) annotation(Placement(transformation(extent = {{24, 38}, {44, 58}})));
  Ductwork.PressureLoss pressureLoss_serial(D = 0.1, zeta = 5) annotation(Placement(transformation(extent = {{24, -10}, {44, 10}})));
  Ductwork.PressureLoss pressureLoss_single(D = 0.1, zeta = 5) annotation(Placement(transformation(extent = {{24, -56}, {44, -36}})));
  FanSimple fanSimple_single(UseRotationalSpeedInput = false) annotation(Placement(transformation(extent = {{-54, -56}, {-34, -36}})));
equation
  connect(fanSimple_parallel1.portMoistAir_b, pressureLoss_parallel.portMoistAir_a) annotation(Line(points = {{-34, 62}, {-12, 62}, {-12, 48}, {24, 48}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(fanSimple_parallel2.portMoistAir_b, pressureLoss_parallel.portMoistAir_a) annotation(Line(points = {{-34, 34}, {-12, 34}, {-12, 48}, {24, 48}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(fanSimple_serial1.portMoistAir_b, fanSimple_serial2.portMoistAir_a) annotation(Line(points = {{-34, 0}, {-16, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(fanSimple_serial2.portMoistAir_b, pressureLoss_serial.portMoistAir_a) annotation(Line(points = {{4, 0}, {24, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pressureLoss_serial.portMoistAir_b, boundaryMoistAir_phX2_out.portMoistAir_a) annotation(Line(points = {{44, 0}, {58, 0}, {58, 20}, {72, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pressureLoss_parallel.portMoistAir_b, boundaryMoistAir_phX2_out.portMoistAir_a) annotation(Line(points = {{44, 48}, {58, 48}, {58, 20}, {72, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_parallel1.portMoistAir_a) annotation(Line(points = {{-82, 20}, {-68, 20}, {-68, 62}, {-54, 62}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_parallel2.portMoistAir_a) annotation(Line(points = {{-82, 20}, {-68, 20}, {-68, 34}, {-54, 34}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_serial1.portMoistAir_a) annotation(Line(points = {{-82, 20}, {-68, 20}, {-68, 0}, {-54, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(fanSimple_single.portMoistAir_b, pressureLoss_single.portMoistAir_a) annotation(Line(points = {{-34, -46}, {24, -46}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(boundaryMoistAir_phX1_in.portMoistAir_a, fanSimple_single.portMoistAir_a) annotation(Line(points = {{-82, 20}, {-68, 20}, {-68, -46}, {-54, -46}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(pressureLoss_single.portMoistAir_b, boundaryMoistAir_phX2_out.portMoistAir_a) annotation(Line(points = {{44, -46}, {58, -46}, {58, 20}, {72, 20}}, color = {0, 127, 255}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A simple Simulation Model which compares a single fan to two fans in serial and parallel</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end FansSerialAndParallel;