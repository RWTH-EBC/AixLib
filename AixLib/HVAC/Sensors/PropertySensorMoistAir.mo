within AixLib.HVAC.Sensors;
model PropertySensorMoistAir
  "Sensor which outputs some properties of Moist Air"
  extends Interfaces.TwoPortMoistAirTransportFluidprops;
  outer BaseParameters baseParameters "System properties";
  Modelica.Blocks.Interfaces.RealOutput X_S annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, -90})));
  Modelica.Blocks.Interfaces.RealOutput X_W annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-58, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-60, -90})));
  Modelica.Blocks.Interfaces.RealOutput Temperature annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-20, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-30, -90})));
  Modelica.Blocks.Interfaces.RealOutput rho annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {14, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, -90})));
  Modelica.Blocks.Interfaces.RealOutput DynamicViscosity annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {40, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {30, -90})));
  Modelica.Blocks.Interfaces.RealOutput VolumeFlow annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {94, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {60, -90})));
  Modelica.Blocks.Interfaces.RealOutput MassFlow annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {94, -100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {90, -90})));
equation
  dp = 0;
  rho = rho_MoistAir;
  Temperature = T;
  X_S = X_Steam;
  X_W = X_Water;
  DynamicViscosity = dynamicViscosity;
  VolumeFlow = abs(portMoistAir_a.m_flow / rho_Air);
  MassFlow = abs(portMoistAir_a.m_flow);
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points=  {{0, 68}, {0, 50}}, color=  {0, 0, 127}), Line(points=  {{-92, 0}, {100, 0}}, color=  {0, 128, 255}), Ellipse(extent=  {{-70, 68}, {70, -72}}, lineColor=  {0, 0, 0}, fillColor=  {255, 255, 255}, fillPattern=  FillPattern.Solid), Line(points=  {{0, 68}, {0, 38}}, color=  {0, 0, 0}), Line(points=  {{22.9, 30.8}, {40.2, 55.3}}, color=  {0, 0, 0}), Line(points=  {{-22.9, 30.8}, {-40.2, 55.3}}, color=  {0, 0, 0}), Line(points=  {{37.6, 11.7}, {65.8, 21.9}}, color=  {0, 0, 0}), Line(points=  {{-37.6, 11.7}, {-65.8, 21.9}}, color=  {0, 0, 0}), Line(points=  {{0, -2}, {9.02, 26.6}}, color=  {0, 0, 0}), Polygon(points=  {{-0.48, 29.6}, {18, 24}, {18, 55.2}, {-0.48, 29.6}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid), Ellipse(extent=  {{-5, 3}, {5, -7}}, lineColor=  {0, 0, 0}, fillColor=  {0, 0, 0}, fillPattern=  FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This component monitors some properties of the mass flow flowing from port_a to port_b. The sensor is ideal, i.e., it does not influence the fluid.</p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end PropertySensorMoistAir;

