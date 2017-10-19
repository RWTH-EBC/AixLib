within AixLib.Utilities.Math.Functions;
function smoothMax
  "Once continuously differentiable approximation to the maximum function"
  extends Modelica.Icons.Function;
  input Real x1 "First argument";
  input Real x2 "Second argument";
  input Real deltaX "Width of transition interval";
  output Real y "Result";
algorithm
  y := AixLib.Utilities.Math.Functions.regStep(
         y1=x1, y2=x2, x=x1-x2, x_small=deltaX);
  annotation (
  Inline=true,
  smoothOrder=1,
Documentation(info="<html>
<p>
Once continuously differentiable approximation to the <code>max(.,.)</code> function.
</p>
<p>
Note that the maximum need not be respected, such as illustrated in
<a href=\"modelica://AixLib.Utilities.Math.Examples.SmoothMin\">
AixLib.Utilities.Math.Examples.SmoothMin</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
March 15, 2016, by Michael Wetter:<br/>
Replaced <code>spliceFunction</code> with <code>regStep</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/300\">issue 300</a>.
</li>
<li>
March 12, 2015, by Filip Jorissen:<br/>
Added documentation reference demonstrating overshoot.
</li>
<li>
February 5, 2015, by Filip Jorissen:<br/>
Added <code>smoothOrder = 1</code>.
</li>
<li>
August 15, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end smoothMax;
