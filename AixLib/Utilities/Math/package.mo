within AixLib.Utilities;
package Math "Library with functions such as for smoothing"
  extends Modelica.Icons.Package;

  model Round
    "round real input to the specified number of digits after decimal point"
    parameter Integer digits(min=0,max=5)=1;
protected
    Real tmp "helper variable";
    parameter Real factor = 10^digits;
public
    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-120,-10},{-80,30}})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{80,-2},{100,18}})));
  algorithm
    tmp:=integer(u*factor);
    y:=if noEvent(u*factor >= tmp+0.5) then (tmp+1)/factor else (tmp)/factor;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics), Icon(graphics={Ellipse(extent={{-80,
                86},{80,-82}}, lineColor={0,0,255}), Text(
            extent={{-56,24},{52,-14}},
            lineColor={0,0,255},
            textString="round")}),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Round real input to the specified number of digits after decimal point</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/> </p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"BaseLib.Examples.UtilitiesMisc_test\">BaseLib.Examples.UtilitiesMisc_test</a> </p>
</html>", revisions="<html>
<p><ul>
<li><i>April 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
"));
  end Round;

annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains blocks and functions for commonly used
mathematical operations.
The classes in this package augment the classes
<a href=\"modelica://Modelica.Blocks\">
Modelica.Blocks</a>.
</p>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
          {100,100}}), graphics={Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},
            {-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{
            -26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,
            -50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},
            {51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={
            0,0,0}, smooth=Smooth.Bezier)}));
end Math;
