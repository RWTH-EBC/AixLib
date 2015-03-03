within AixLib.HVAC.Sensors;
model RelativeHumiditySensor
  "Sensor which outputs the relative Humidity of Moist Air"
  extends Interfaces.TwoPortMoistAirTransportFluidprops;
  outer BaseParameters baseParameters "System properties";
  Modelica.Blocks.Interfaces.RealOutput Humidity "Output signal from sensor" annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {0, 100})));
equation
  dp = 0;
  Humidity = p_Steam / p_Saturation;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points=  {{0, 100}, {0, 50}}, color=  {0, 0, 127}), Line(points=  {{-92, 0}, {100, 0}}, color=  {0, 128, 255}), Ellipse(extent=  {{-54, 4}, {46, -96}}, lineColor=  {0, 128, 255}, fillColor=  {0, 0, 255}, fillPattern=  FillPattern.Solid), Polygon(points=  {{-51, -28}, {0, 84}, {42, -28}, {-51, -28}}, lineColor=  {0, 0, 255}, smooth=  Smooth.None, fillColor=  {0, 0, 255}, fillPattern=  FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This component monitors the relative Humidity of the mass flow flowing from port_a to port_b. The sensor is ideal, i.e., it does not influence the fluid. </p>
 <p><br/>If there is liquid water in the air, the relative humidity is limited to 1.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer\">AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer</a></p>
 </html>", revisions = "<html>
 <p>10.12.2013, Mark Wesseling</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end RelativeHumiditySensor;

