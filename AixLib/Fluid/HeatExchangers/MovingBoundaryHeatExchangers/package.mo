within AixLib.Fluid.HeatExchangers;
package MovingBoundaryHeatExchangers "This package contains models of moving boundary heat exchangers"
extends Modelica.Icons.Package;

annotation (Icon(graphics={
        Rectangle(
          extent={{-90,70},{90,94}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-90,70},{90,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,-94},{90,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Polygon(
          points={{-90,70},{-90,-70},{-12,-70},{34,-70},{8,-68},{-12,-34},{-20,
            10},{-8,50},{28,68},{40,70},{-90,70}},
          lineColor={28,108,200},
          smooth=Smooth.Bezier,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,70},{-20,-70}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-26,70},{-44,52},{-20,28},{-38,4},{-14,-26},{-36,-52},{-28,
            -70}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{36,70},{18,52},{42,28},{24,4},{48,-26},{26,-52},{34,-70}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Text(
          extent={{-30,-26},{38,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="TP"),
        Text(
          extent={{-90,-26},{-30,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="SC"),
        Text(
          extent={{36,-26},{92,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="SH")}), Documentation(revisions="<html>
<ul>
  <li>
  December 07, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>"));
end MovingBoundaryHeatExchangers;
