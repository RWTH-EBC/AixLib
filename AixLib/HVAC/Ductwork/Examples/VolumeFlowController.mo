within AixLib.HVAC.Ductwork.Examples;
model VolumeFlowController "Example for Volume Flow Controller"
  import Anlagensimulation_WS1314 = AixLib.HVAC;
  extends Modelica.Icons.Example;
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(use_p_in = false, p = 100000) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {64, 11})));
  inner Anlagensimulation_WS1314.BaseParameters baseParameters annotation(Placement(transformation(extent = {{60, 66}, {80, 86}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 100, startTime = 50, offset = 1.005e5, height = 40000) annotation(Placement(transformation(extent = {{-52, -58}, {-32, -38}})));
  Modelica.Blocks.Sources.Ramp ramp1(offset = 0, startTime = 150, height = -5000, duration = 2) annotation(Placement(transformation(extent = {{-52, -88}, {-32, -68}})));
  Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-4, -72}, {16, -52}})));
  Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(use_p_in = true, p = 99900) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-62, 11})));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 1) annotation(Placement(transformation(extent = {{-88, 34}, {-68, 54}})));
  Anlagensimulation_WS1314.Ductwork.VolumeFlowController volumeFlowControler(D = 0.3) annotation(Placement(transformation(extent = {{-24, 6}, {-4, 16}})));
equation
  connect(ramp.y, add.u1) annotation(Line(points = {{-31, -48}, {-24, -48}, {-24, -56}, {-6, -56}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(ramp1.y, add.u2) annotation(Line(points = {{-31, -78}, {-23.5, -78}, {-23.5, -68}, {-6, -68}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(boundaryMoistAir_phX2.p_in, add.y) annotation(Line(points = {{-74, 19}, {-92, 19}, {-92, -32}, {60, -32}, {60, -62}, {17, -62}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(boundaryMoistAir_phX2.portMoistAir_a, volumeFlowControler.portMoistAir_a) annotation(Line(points = {{-52, 11}, {-24, 11}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volumeFlowControler.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a) annotation(Line(points = {{-4, 11}, {54, 11}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volumeFlowControler.VolumeFlowSet, realExpression.y) annotation(Line(points = {{-24.8, 13.1}, {-24.8, 43.2}, {-67, 43.2}, {-67, 44}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A small example which shows how the volume flow controller works</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end VolumeFlowController;

