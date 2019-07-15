within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions;
function getOuterDiameters
  "Returns a vector with the outer diameters of the radial elements of an radially discretized volume"
  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;

  input SI.Length d_out "Outer diameter of whole volume";
  input SI.Length d_in "Inner diameter of whole volume";
  input Integer nRad "Number of radial discretizations";

  output SI.Length[nRad] outputVector;

protected
  SI.Length stepWidth;

algorithm
  stepWidth:=(d_out - d_in)/nRad;

  for i in 1:nRad loop
    outputVector[i] := d_in + (i*stepWidth);
  end for;

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Function returns a vector with the outer diameters of the radial elements of an radially discretized volume.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>Model developed as part of DA025 &QUOT;Modellierung und Simulation eines LowEx-Geb&auml;udes in der objektorientierten Programmiersprache Modelica&QUOT; by Tim Comanns</li>
</ul>
</html>",
    revisions="<html>
<p><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:</p><p>Implemented.</p>
</html>"));
end getOuterDiameters;
