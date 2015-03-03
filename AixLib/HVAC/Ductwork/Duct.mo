within AixLib.HVAC.Ductwork;
model Duct "Duct with pressure loss and storage of mass and energy"
  extends Interfaces.TwoPortMoistAir;
  outer BaseParameters baseParameters "System properties";
  parameter Modelica.SIunits.Length D = 0.05 "Diameter";
  parameter Modelica.SIunits.Length l = 1 "Length";
  parameter Modelica.SIunits.Length e = 2.5e-5 "Roughness";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport annotation(Placement(transformation(extent = {{-12, 32}, {8, 52}}), iconTransformation(extent = {{-10, 27}, {10, 47}})));
  Volume.VolumeMoistAir volumeMoistAir(V = D * D / 4 * Modelica.Constants.pi * l, X(start = 0.005), X_Steam(start = 0.005)) annotation(Placement(transformation(extent = {{18, -31}, {80, 31}})));
  BaseClasses.DuctPressureLoss ductPressureLoss(D = D, l = l, e = e, X(start = 0.005), X_Steam(start = 0.005)) annotation(Placement(transformation(extent = {{-70, -28}, {-8, 28}})));
equation
  connect(volumeMoistAir.portMoistAir_b, portMoistAir_b) annotation(Line(points = {{80, 0}, {100, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volumeMoistAir.heatPort, heatport) annotation(Line(points = {{49, 31}, {44, 31}, {44, 34}, {-2, 34}, {-2, 42}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(ductPressureLoss.portMoistAir_b, volumeMoistAir.portMoistAir_a) annotation(Line(points = {{-8, -3.55271e-015}, {-2, -3.55271e-015}, {-2, 0}, {18, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(ductPressureLoss.portMoistAir_a, portMoistAir_a) annotation(Line(points = {{-70, -3.55271e-015}, {-86, -3.55271e-015}, {-86, 0}, {-100, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}}), graphics = {Rectangle(extent=  {{-100, 33}, {100, -35}}, lineColor=  {0, 0, 0}, fillColor=  {95, 95, 95}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-100, 29}, {100, -31}}, lineColor=  {0, 0, 0}, fillColor=  {170, 255, 255}, fillPattern=  FillPattern.HorizontalCylinder)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple Duct Model with pressure loss and storage of mass and energy</p>
 <p>It consists of one pressure loss model and one Volume model.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Ductwork.Examples.DuctNetwork\">AixLib.HVAC.Ductwork.Examples.DuctNetwork</a> </p>
 </html>", revisions = "<html>
 <p>30.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -40}, {100, 40}}), graphics));
end Duct;
