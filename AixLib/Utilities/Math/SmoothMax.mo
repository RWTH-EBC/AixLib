within AixLib.Utilities.Math;
block SmoothMax
  "Once continuously differentiable approximation to the maximum function"
  extends Modelica.Blocks.Interfaces.SI2SO;
 parameter Real deltaX "Width of transition interval";
equation
  y =  AixLib.Utilities.Math.Functions.smoothMax(x1=u1, x2=u2, deltaX=deltaX);
  annotation (Icon(graphics={Text(
          extent={{-88,40},{92,-32}},
          textColor={160,160,164},
          textString="smoothMax()"), Text(
          extent={{-74,-44},{68,-114}},
          textColor={0,0,255},
          textString="dX=%deltaX%")}),
Documentation(info="<html>
<p>
Once continuously differentiable approximation to the <i>max(.,.)</i> function.
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
March 12, 2015, by Filip Jorissen:<br/>
Added documentation reference demonstrating overshoot.
</li>
<li>
August 15, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end SmoothMax;
