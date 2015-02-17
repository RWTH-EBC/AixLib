within AixLib;
package Media "Package with medium models"
  extends Modelica.Icons.Package;

  annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains different implementations for
various media.
The media models in this package are
compatible with
<a href=\"modelica://Modelica.Media\">
Modelica.Media</a>
but the implementation is in general simpler, which often
leads to easier numerical problems and better convergence of the
models.
Due to the simplifications, the media model of this package
are generally accurate for a smaller temperature range than the
models in <a href=\"modelica://Modelica.Media\">
Modelica.Media</a>, but the smaller temperature range may often be
sufficient for building HVAC applications.
</p>
</html>"),
    Icon(graphics={
        Line(
          points={{-74,-80},{-60,-30},{-30,40},{6,66},{50,66},{75,45},{64,-8},{50,
              -50},{40,-80}},
          color={64,64,64},
          smooth=Smooth.Bezier),
        Line(
          points={{-38,20},{-42,88},{-42,88}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-58,-28},{-72,84},{-72,84}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-74,-80},{-92,-16},{-92,-16}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-74,-80},{40,-80}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-58,-28},{58,-28}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{-38,20},{70,20}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{70,20},{88,-58}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{58,-28},{72,-80}},
          color={175,175,175},
          smooth=Smooth.None)}));
end Media;
