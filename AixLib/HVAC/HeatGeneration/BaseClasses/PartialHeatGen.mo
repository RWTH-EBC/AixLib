within AixLib.HVAC.HeatGeneration.BaseClasses;

partial model PartialHeatGen "Base Class for modelling heat generation equipment of different types"
  outer BaseParameters baseParameters "System properties";
  parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref;
  Volume.Volume volume annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Interfaces.Port_a port_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Interfaces.Port_b port_b annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Sensors.TemperatureSensor T_in(T_ref = T_ref) annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  Sensors.MassFlowSensor massFlowSensor annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
equation
  connect(volume.port_b, port_b) annotation(Line(points = {{10, 0}, {100, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(port_a, T_in.port_a) annotation(Line(points = {{-100, 0}, {-80, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(T_in.port_b, massFlowSensor.port_a) annotation(Line(points = {{-60, 0}, {-50, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(massFlowSensor.port_b, volume.port_a) annotation(Line(points = {{-30, 0}, {-10, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  annotation(Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p><br/>This partial model is a base class for modelling all heat generation equipment. It includes the necessary fluid port and a fluid volume with a thermal connector for heating the fluid.</p>
 <p>This model is just a start and is likely to change in order to be suitable for all heat generation equipment within the lecture.</p>
 </html>", revisions = "<html>
 <p>27.11.2013, Marcus Fuchs</p>
 <p><ul>
 <li>removed input for T_set as this is not applicable with solar thermal collectors</li>
 </ul></p>
 <p>02.10.2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end PartialHeatGen;