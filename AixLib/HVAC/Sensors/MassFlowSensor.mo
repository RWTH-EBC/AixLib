within AixLib.HVAC.Sensors;
model MassFlowSensor "Sensor which outputs the fluid mass flow rate"
  extends BaseClasses.PartialSensor;
  extends Modelica.Icons.RotationalSensor;
equation
  signal = port_a.m_flow;
  annotation(Icon(graphics = {Line(points=  {{-70, 0}, {-94, 0}, {-96, 0}}, color=  {0, 127, 255}, smooth=  Smooth.None), Line(points=  {{0, 38}, {0, 90}}, color=  {135, 135, 135}, smooth=  Smooth.None), Line(points=  {{70, 0}, {100, 0}}, color=  {0, 127, 255}, smooth=  Smooth.None)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br/>This component monitors the mass flow rate from port_a to port_b. The sensor is ideal, i.e., it does not influence the fluid. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst</a></p>
 </html>", revisions = "<html>
 <p>07.10.2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end MassFlowSensor;

