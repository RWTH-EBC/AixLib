within AixLib.Building.LowOrder.BaseClasses;
model SolarRadWeightedSum
  "weights vec input and sums it up to one scalar output"
  parameter Integer n = 1 "number of inputs and weightfactors";
  parameter Real weightfactors[n] = {1}
    "weightfactors with which the inputs are to be weighted";
  Utilities.Interfaces.SolarRad_in solarRad_in[n] annotation(Placement(transformation(extent = {{-100, 0}, {-80, 20}}), iconTransformation(extent = {{-100, -10}, {-80, 10}})));
  Utilities.Interfaces.SolarRad_out solarRad_out annotation(Placement(transformation(extent = {{80, 0}, {100, 20}}), iconTransformation(extent = {{80, -10}, {100, 10}})));
protected
  parameter Real sumWeightfactors = if sum(weightfactors) <0.0001 then 0.0001 else sum(weightfactors);
initial equation
  assert(noEvent(n == size(weightfactors, 1)), "weightfactors (likely Aw) has to have n elements");
  assert(noEvent(sum(weightfactors)>0.0001),"The sum of the weightfactors (likely the window areas) in SolarRadWeightedSum is 0. In case of no radiation (e.g. no windows) this might be correct.");
equation
  solarRad_out.I = solarRad_in.I * weightfactors / sumWeightfactors;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Icon(graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0}), Text(extent = {{-40, 70}, {-22, 60}}, lineColor = {0, 0, 0}, textString = "*Gn"), Line(points = {{-80, 0}, {-60, -20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-80, 0}, {-60, 20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-80, 0}, {-60, 60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{72, 0}, {82, 0}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, -20}, {0, -20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, 20}, {0, 20}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, 60}, {0, 60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-60, -60}, {0, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{-80, 0}, {-60, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 20}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, 60}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{20, 0}, {0, -60}}, color = {0, 0, 0}, smooth = Smooth.None), Line(points = {{0, -20}, {20, 0}}, color = {0, 0, 0}, smooth = Smooth.None), Text(extent = {{10, -2}, {72, -14}}, lineColor = {0, 0, 0}, textString = "/sum(Gn)"), Text(extent = {{-42, 30}, {-20, 20}}, lineColor = {0, 0, 0}, textString = "*Gn"), Text(extent = {{-42, -10}, {-20, -20}}, lineColor = {0, 0, 0}, textString = "*Gn"), Text(extent = {{-42, -50}, {-20, -60}}, lineColor = {0, 0, 0}, textString = "*Gn")}), Documentation(info="<html>
<p>This component weights the n-vectorial radiant input with n weightfactors and has a scalar output.</p>
<p><br>The partial class contains following components:</p>
<ul>
<li>2 solar radiation ports</li>
</ul>
<h4>Main equations</h4>
<p><br>There is one fundamental equation: input(n)*weightfactors(n)/sum(weightfactors). </p>
<h4>Assumption and limitations</h4>
<p>If the weightfactors are all zero, Dymola tries to divide through zero. You will get a warning and the output is set to zero. </p>
<h4>Typical use and important parameters</h4>
<p>You can use this component to weight a radiant input and sum it up to one scalar output, e.g. weight the radiance of the sun of n directions with the areas of windows in n directions and sum it up to one scalar radiance on a non-directional window </p>
</html>",  revisions="<html>
<ul>
<li><i>December 2014,&nbsp;</i> by Steffen Riebling:<br>Revised documentation. </li>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br>Implemented. </li>
</ul>
</html>"));
end SolarRadWeightedSum;

