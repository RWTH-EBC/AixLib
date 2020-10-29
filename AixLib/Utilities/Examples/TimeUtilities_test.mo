within AixLib.Utilities.Examples;
model TimeUtilities_test "Simulation to test the utilities concerning the time"
  import Utilities;
  extends Modelica.Icons.Example;
  Sources.NightMode nightMode(dayStart = 8, dayEnd = 20) annotation(Placement(transformation(extent = {{-12, -32}, {8, -12}})));
  Sources.HourOfDay hourOfDay annotation(Placement(transformation(extent = {{-12, 10}, {8, 30}})));
  Modelica.Blocks.Interfaces.BooleanOutput boolNightMode annotation(Placement(transformation(extent = {{56, -30}, {76, -10}})));
  Modelica.Blocks.Interfaces.RealOutput realSamples[1] annotation(Placement(transformation(extent = {{56, 30}, {76, 50}})));
equation
  //Connections for real outputs
  realSamples[1] = hourOfDay.HOD;
  //Connection for night mode output
  boolNightMode = nightMode.IsNight.y;
  connect(boolNightMode, boolNightMode) annotation(Line(points = {{66, -20}, {66, -20}}, color = {255, 0, 255}));
  annotation(experiment(StopTime = 604800, Interval = 600), Documentation(revisions = "<html><ul>
  <li>
    <i>April 25, 2013&#160;</i> by Ole Odendahl:<br/>
    Implemented model, added documentation and formatted appropriately
  </li>
</ul>
</html>
 ", info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simulation to test the functionality of time concerning models.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  To check the calculations of models which are using the simulation
  time. There are no inputs required.
</p>
<p>
  Output values can be easily displayed via the provided output ports,
  one for each data type (real and boolean).
</p>
</html>"));
end TimeUtilities_test;
