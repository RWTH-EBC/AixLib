within AixLib.Utilities.Multiplier;
class Q_flowMultiplier "Basic partial class"

Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1 annotation (
    Placement(transformation(extent={{-100,-10},{-80,10}}, rotation=0)));
Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm2 annotation (
    Placement(transformation(extent={{80,-10},{100,10}}, rotation=0)));
  parameter Real f "multiplier: Therm1.Q_flow*f=Therm2.Q_flow";
equation
Therm1.T=Therm2.T;
Therm1.Q_flow*f=-Therm2.Q_flow;
  annotation (
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}},
      grid={2,2}), graphics={
      Text(
        extent={{-100,80},{100,40}},
        lineColor={0,0,255},
        fillColor={255,170,170},
        fillPattern=FillPattern.Solid,
        textString="%name"),
      Polygon(
        points={{-60,0},{60,40},{60,-40},{-60,0}},
        lineColor={0,0,255},
        fillColor={255,85,85},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-100,-48},{-20,-68}},
        lineColor={0,0,255},
        textString="low"),
      Text(
        extent={{20,-48},{100,-68}},
        lineColor={0,0,255},
        textString="high")}),
    Diagram(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}},
      grid={2,2}), graphics),
    Window(
      x=0.3,
      y=0.41,
      width=0.6,
      height=0.6),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The model multiplies the heat flow rate at constant temperature.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"BaseLib.Examples.Multiplier_test\">BaseLib.Examples.Multiplier_test</a>
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>April 01, 2014</i> by Moritz Lauster:<br/>
    Renamed
  </li>
  <li>
    <i>April 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>by Alexander Hoh:<br/>
    Implemented.
  </li>
</ul>
</html>"),
    DymolaStoredErrors);
end Q_flowMultiplier;
