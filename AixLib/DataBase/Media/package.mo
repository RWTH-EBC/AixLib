within AixLib.DataBase;
package Media "Package that provides records describing media properties"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
        Line(
          points={{-40,20},{-44,88},{-44,88}},
          color={175,175,175}),
        Line(
          points={{-60,-28},{-74,84},{-74,84}},
          color={175,175,175}),
        Line(
          points={{-76,-80},{-94,-16},{-94,-16}},
          color={175,175,175}),
        Line(
          points = {{-76,-80},{-62,-30},{-32,40},{4,66},{48,66},{73,45},
                    {62,-8},{48,-50},{38,-80}},
          color={64,64,64},
          smooth=Smooth.Bezier),
        Line(
          points={{-40,20},{68,20}},
          color={175,175,175}),
        Line(
          points={{-60,-28},{56,-28}},
          color={175,175,175}),
        Line(
          points={{-76,-80},{38,-80}},
          color={175,175,175}),
        Line(
          points={{56,-28},{70,-80}},
          color={175,175,175}),
        Line(
          points={{68,20},{86,-58}},
          color={175,175,175})}),
              Documentation(info="<html><p>
  This package provides records describing properties of different
  media. Properties means, for example, base properties (e.g. critical
  temperature or triple temperature) or fitting coefficients (e.g.
  coefficients of the Helmholtz equation of state or coefficients of
  the saturation pressure's formula). However, properties are
  implemented just for refrigerant media by now.
</p>
<ul>
  <li>June 9, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end Media;
