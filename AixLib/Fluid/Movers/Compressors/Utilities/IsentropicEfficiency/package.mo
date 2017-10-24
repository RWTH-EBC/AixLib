within AixLib.Fluid.Movers.Compressors.Utilities;
package IsentropicEfficiency "Package that contains models describing different isentropic efficiencies"
  extends Modelica.Icons.Library;




annotation (Icon(coordinateSystem(preserveAspectRatio=false),
              graphics={
                Ellipse(
                  extent={{-90,-90},{90,90}},
                  lineThickness=0.25,
                  pattern=LinePattern.None,
                  lineColor={215,215,215},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-40,60},{-30,70},{-20,60},{-20,60}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{-20,60},{-20,-30},{-20,38},{-16,50},
                          {-6,58},{0,60},{6,58}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{6,58},{16,50},{20,40},{20,-70},
                          {20,-70},{20,-70},{20,-70}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5)}),
Documentation(revisions="<html>
<ul>
  <li>
  October 19, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end IsentropicEfficiency;
