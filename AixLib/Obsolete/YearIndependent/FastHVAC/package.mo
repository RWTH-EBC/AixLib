within AixLib.Obsolete.YearIndependent;
package FastHVAC "Package contains models for components and components for HVAC components with a high simplification of fluid behaviour."
  extends Modelica.Icons.Package;

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;







  annotation (
  obsolete = "Obsolete model - FastHVAC is not maintained anymore but can still be used.",
preferredView="info", Documentation(info="<html>This package contains models for HVAC components with a high
simplification of fluid behavior. For more information see <a href=
\"http://www.ep.liu.se/ecp/article.asp?issue=118&amp;volume=&amp;article=100\">
FastHVAC</a> - A library for fast composition and simulation of
building energy systems.
</html>"),
    Icon(graphics={
        Ellipse(origin={-1,-85},
          fillColor={255,255,255},
          extent={{-69,-69},{69,69}},
          startAngle=20.0,
          endAngle=160.0),
        Ellipse(origin={-1,-85},
          fillColor={128,128,128},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-13,-13},{13,13}}),
        Line(origin={0,-112},
          points={{0.0,60.0},{0.0,90.0}}),
        Ellipse(origin={-1,-85},
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-7,-7},{7,7}}),
        Polygon(
          origin={62,-22},
          rotation=-35.0,
          fillColor={64,64,64},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-21.2878,-88.1523},{-22.6066,-30.4786},{-16.7093,-21.4662},{
            -10.9736,-29.6577},{-9.65477,-87.3315},{-21.2878,-88.1523}}),
        Ellipse(
          extent={{-74,52},{-60,38}},
          lineColor={217,67,180},
          pattern=LinePattern.None,
          lineThickness=0.5),
        Ellipse(
          extent={{-40,90},{42,8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Ellipse(
          extent={{6,21},{-6,-21}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={-14,35},
          rotation=135),
        Ellipse(
          extent={{6,21},{-6,-21}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={14,35},
          rotation=225),
        Ellipse(
          extent={{6,21},{-6,-21}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          origin={0,69},
          rotation=180)}));
end FastHVAC;
