within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.Functions;
function getInnerDiametersLg
  "Returns a vector with the outer diameters of the radial elements of an radially discretized volume"
  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;

  input SI.Length d_out "Outer diameter of whole volume";
  input SI.Length d_in "Inner diameter of whole volume";
  input Integer nRad "Number of radial discretizations";

  output SI.Length[nRad] outputVector;

  //SI.Length stepWidth "length of one normal discretisation element";
protected
  SI.Length lengthLgDiscr "length of all log. discretisation elements";
  //SI.Length lengthNormDiscr "length of all normal discretisation elements";
  Integer nb;
algorithm

  nb:=nRad + 1;
   lengthLgDiscr:=(d_out - d_in);
outputVector[1] := d_in;
outputVector[2] := d_in + (log10(nb)-log10(nb-1))/log10(nb)*lengthLgDiscr;

  for i in 2:nRad-1 loop
      outputVector[i+1] := outputVector[i]+(log10(nb+1-i)-log10(nb-i))/log10(nb)*lengthLgDiscr;
  end for;

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Function gives inner diameters for a logarithmically discretized ground.</p>
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
end getInnerDiametersLg;
