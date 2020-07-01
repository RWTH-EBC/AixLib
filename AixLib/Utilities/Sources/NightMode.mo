within AixLib.Utilities.Sources;
model NightMode
  "Module to establish if an element should opperate in night mode or not."
  import BaseLib = AixLib.Utilities;
  //Parameters
  parameter Real dayStart "hour when day operation starts";
  parameter Real dayEnd "hour when night operation starts";
  parameter Real startTime = 0
    "The start time of the simulation in reference to 1st of Jan. 0:00 o'clock";
  BaseLib.Sources.HourOfDay hourOfDay annotation(Placement(transformation(extent = {{-72, 10}, {-52, 30}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterThreshold(threshold = dayStart) annotation(Placement(transformation(extent = {{-11.5, 7.5}, {3, 22.5}})));
  Modelica.Blocks.Logical.LessThreshold lessEqualThreshold(threshold = dayEnd) annotation(Placement(transformation(extent = {{-12, -19.5}, {3, -4.5}})));
  Modelica.Blocks.Logical.Nand IsNight annotation(Placement(transformation(extent = {{18, -4.5}, {33, 10.5}})));
  Modelica.Blocks.Interfaces.BooleanOutput SwitchToNightMode
    "Connector of Boolean output signal"                                                          annotation(Placement(transformation(extent = {{78.5, -7}, {98.5, 13}}), iconTransformation(extent = {{78.5, -7}, {98.5, 13}})));
equation
  connect(hourOfDay.HOD, lessEqualThreshold.u) annotation(Line(points = {{-64, 10}, {-64, 1.5}, {-21, 1.5}, {-21, -12}, {-13.5, -12}}, color = {0, 0, 127}));
  connect(hourOfDay.HOD, greaterThreshold.u) annotation(Line(points = {{-64, 10}, {-64, 1.5}, {-21, 1.5}, {-21, 15}, {-12.95, 15}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, IsNight.u2) annotation(Line(points = {{3.75, -12}, {9, -12}, {9, -3}, {16.5, -3}}, color = {255, 0, 255}));
  connect(greaterThreshold.y, IsNight.u1) annotation(Line(points = {{3.725, 15}, {9, 15}, {9, 3}, {16.5, 3}}, color = {255, 0, 255}));
  connect(IsNight.y, SwitchToNightMode) annotation(Line(points = {{33.75, 3}, {88.5, 3}}, color = {255, 0, 255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {1.5, 1.5}), graphics={  Ellipse(extent = {{-70.5, 73.5}, {78, -76.5}}, lineColor = {0, 0, 255}), Line(points = {{3, 73.5}, {3, 57}, {3, 58.5}}, color = {0, 0, 255}), Line(points = {{3, -60}, {3, -76.5}, {3, -75}}, color = {0, 0, 255}), Line(points = {{-54, 0}, {-70.5, 0}, {-70.5, 1.5}}, color = {0, 0, 255}), Line(points = {{78, 0}, {61.5, 0}, {61.5, 1.5}}, color = {0, 0, 255}), Line(points = {{-51, 49.5}, {-42, 37.5}, {-51, 49.5}}, color = {0, 0, 255}), Line(points = {{46.5, -42}, {55.5, -54}, {46.5, -42}}, color = {0, 0, 255}), Line(points = {{-39, -40.5}, {-51, -52.5}, {-39, -40.5}}, color = {0, 0, 255}), Line(points = {{60, 48}, {48, 36}, {60, 48}}, color = {0, 0, 255}), Ellipse(extent = {{-70.5, 73.5}, {78, -76.5}}, lineColor = {0, 255, 255},
            lineThickness =                                                                                                   1, fillColor = {0, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Ellipse(extent = {{-40.5, 18}, {-15, -9}}, lineColor = {255, 255, 0}, fillColor = {255, 255, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-27, 18}, {-27, 30}, {-28.5, -18}, {-27, 4.5}, {-49.5, 4.5}, {-4.5, 4.5}, {-30, 4.5}, {-12, 21}, {-45, -12}, {-27, 6}, {-43.5, 21}, {-12, -10.5}, {-28.5, 6}}, color = {255, 255, 0}, thickness = 0.5), Polygon(points = {{4.5, 73.5}, {4.5, -78}, {19.5, -75}, {31.5, -72}, {43.5, -66}, {54, -58.5}, {63, -49.5}, {72, -34.5}, {78, -21}, {79.5, -4.5}, {79.5, 13.5}, {72, 31.5}, {64.5, 45}, {49.5, 60}, {24, 72}, {22.5, 72}, {4.5, 73.5}}, lineColor = {0, 0, 255},
            lineThickness =                                                                                                   0.5, fillColor = {0, 0, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Ellipse(extent = {{16.5, 22.5}, {49.5, -12}}, lineColor = {255, 255, 0}, fillColor = {255, 255, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Ellipse(extent = {{28.5, 22.5}, {63, -10.5}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255},
            fillPattern =                                                                                                   FillPattern.Solid,
            lineThickness =                                                                                                   1)}), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the switching between night and day operation modes based
  on the simulation time.
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
  <li>
    <i>Mai 20, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"));
end NightMode;
