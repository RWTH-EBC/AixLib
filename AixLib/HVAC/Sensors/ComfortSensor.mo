within AixLib.HVAC.Sensors;
model ComfortSensor "calculates the operative temperature"
  Interfaces.RadPort radPort annotation(Placement(transformation(extent = {{-90, -54}, {-70, -34}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPort annotation(Placement(transformation(extent = {{-90, 50}, {-70, 70}})));
  Modelica.Blocks.Interfaces.RealOutput OperativeTemperature annotation(Placement(transformation(extent = {{80, 0}, {100, 20}}), iconTransformation(extent = {{80, 0}, {100, 20}})));
equation
  // No influence on system
  convPort.Q_flow = 0;
  radPort.Q_flow = 0;
  // Calculate the output
  OperativeTemperature = (convPort.T + radPort.T) * 0.5;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-60, 66}, {66, -58}},
            lineThickness =                                                                                                   1, fillColor = {170, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0})}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple model for a comfort sensor, by computing the operative temperature. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The operative temperature is the mean value between the air temperature and the radiative (walls) temperature. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 </html>", revisions = "<html>
 <p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
 </html>"));
end ComfortSensor;
