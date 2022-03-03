within AixLib.Utilities.Logical;
block SmoothSwitch "Smooth switch between two Real signals"
  extends Modelica.Blocks.Icons.PartialBooleanBlock;
  Modelica.Blocks.Interfaces.RealInput u1
    "Connector of first Real input signal"                                       annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
  Modelica.Blocks.Interfaces.BooleanInput u2
    "Connector of Boolean input signal"                                          annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.RealInput u3
    "Connector of second Real input signal"                                       annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
equation
  y = smooth(1, if u2 then u1 else u3);
  annotation(defaultComponentName = "switch1", Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Adapted from <a href=
  \"modelica://Modelica.Blocks.Logical.Switch\">Modelica.Blocks.Logical.Switch</a>.
</p>
<p>
  The SmoothSwitch switches, depending on the logical connector u2 (the
  middle connector) between the two possible input signals u1 (upper
  connector) and u3 (lower connector).
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The switch is smooth.
</p>
<p>
  If u2 is <b>true</b>, the output signal y is set equal to u1, else it
  is set equal to u3.
</p>
<ul>
  <li>
    <i>April 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>16 Mai, 2012&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Line(points = {{12, 0}, {100, 0}}, pattern = LinePattern.Solid, thickness = 0.25, arrow = {Arrow.None, Arrow.None}, color = {0, 0, 255}), Line(points = {{-100, 0}, {-40, 0}}, color = {255, 0, 127}, pattern = LinePattern.Solid, thickness = 0.25, arrow = {Arrow.None, Arrow.None}), Line(points = {{-100, -80}, {-40, -80}, {-40, -80}}, pattern = LinePattern.Solid, thickness = 0.25, arrow = {Arrow.None, Arrow.None}, color = {0, 0, 255}), Line(points = {{-40, 12}, {-40, -12}}, color = {255, 0, 127}), Line(points = {{-100, 80}, {-38, 80}}, color = {0, 0, 255}), Line(points = {{-38, 80}, {6, 2}}, thickness = 1, color = {0, 0, 255}), Ellipse(extent={{
              -2,10},{18,-10}},                                                                                                                                                                                                        fillColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, lineColor = {0, 0, 255})}));
end SmoothSwitch;
