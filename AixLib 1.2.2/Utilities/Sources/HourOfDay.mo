within AixLib.Utilities.Sources;
model HourOfDay "Computes the hour of day taking the second of year as input"
  Modelica.Blocks.Sources.ContinuousClock clock(offset=-startTime)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Interfaces.RealOutput SOY "second of the year" annotation(Placement(transformation(extent = {{90, 70}, {110, 90}})));
  Modelica.Blocks.Interfaces.RealOutput H "passed hours" annotation(Placement(transformation(extent = {{90, 10}, {110, 30}})));
  Modelica.Blocks.Interfaces.RealOutput D "passed days" annotation(Placement(transformation(extent = {{90, -50}, {110, -30}})));
  Modelica.Blocks.Interfaces.RealOutput SOD "second of the day" annotation(Placement(transformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput HOD "hour of the day" annotation(Placement(transformation(origin = {-20, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  parameter Real startTime = 0
    "The start time of the simulation in reference to 1st of Jan. 0:00 o'clock";
equation
  // Modulo(SOY,SecondsInDay) gives the passed seconds of the current day.
  SOD = mod(SOY, 86400) "passed seconds of the current day";
  H = SOY / 3600 "passed hours";
  D = SOY / 86400 "passed days";
  // computes the hour of day from second of day.
  HOD = SOD / 3600;
  connect(clock.y, SOY) annotation(Line(points = {{1, 30}, {20, 30}, {20, 80}, {100, 80}}, color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Text(extent = {{34, 96}, {88, 62}}, lineColor = {0, 0, 255}, textString = "SoY"), Text(extent = {{-6, -62}, {100, -90}}, lineColor = {0, 0, 255}, textString = "SoD"), Text(extent = {{-92, -62}, {28, -92}}, lineColor = {0, 0, 255}, textString = "HoD"), Line(points = {{-38, 70}, {-28, 51}}, color = {160, 160, 164}), Line(points = {{-71, 37}, {-54, 28}}, color = {160, 160, 164}), Line(points = {{-80, 0}, {-60, 0}}, color = {160, 160, 164}), Line(points = {{-71, -37}, {-50, -26}}, color = {160, 160, 164}), Line(points = {{-39, -70}, {-29, -52}}, color = {160, 160, 164}), Line(points = {{0, -80}, {0, -60}}, color = {160, 160, 164}), Line(points = {{39, -70}, {29, -51}}, color = {160, 160, 164}), Line(points = {{71, -37}, {52, -27}}, color = {160, 160, 164}), Line(points = {{80, 0}, {60, 0}}, color = {160, 160, 164}), Line(points = {{70, 38}, {49, 26}}, color = {160, 160, 164}), Line(points = {{37, 70}, {26, 50}}, color = {160, 160, 164}), Line(points = {{0, 80}, {0, 60}}, color = {160, 160, 164}), Ellipse(extent = {{-80, 80}, {80, -80}}, lineColor = {160, 160, 164}), Line(points = {{0, 0}, {-50, 50}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{0, 0}, {40, 0}}, color = {0, 0, 0}, thickness = 0.5)}), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Additional to passed simulation seconds (SOY), hours (HOY) and days
  (DOY) this model provides the passed seconds of a day and the passed
  hours of a day. That can be used for a controller that will act
  depending on the time of the day for example.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Utilities.Examples.TimeUtilities_test\">AixLib.Utilities.Examples.TimeUtilities_test</a>
</p>
<ul>
  <li>
    <i>April 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>by Peter Matthes:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HourOfDay;
