within AixLib.Media;
package Water "Package with medium models for water"
  extends Modelica.Icons.Package;

  annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains different implementations for
water.
For typical building energy simulations, we recommend to use
<a href=\"modelica://AixLib.Media.Water.Simple\">AixLib.Media.Water.Simple</a>
in which the density is a constant. This leads to faster and more robust simulation.
The media model
<a href=\"modelica://AixLib.Media.Water.Simple\">AixLib.Media.Water.Detailed</a>
models density as a function of temperature. This leads to coupled nonlinear system of
equations that cause slower computing time and may cause convergence problems for models
with large hydraulic networks.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Polygon(
          points={{16,-28},{32,-42},{26,-48},{10,-36},{16,-28}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Sphere,
          smooth=Smooth.None,
          fillColor={95,95,95}),
        Polygon(
          points={{10,34},{26,44},{30,36},{14,26},{10,34}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Sphere,
          smooth=Smooth.None,
          fillColor={95,95,95}),
        Ellipse(
          extent={{-82,52},{24,-54}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,0}),
        Ellipse(
          extent={{22,82},{80,24}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={95,95,95}),
        Ellipse(
          extent={{20,-30},{78,-88}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={95,95,95})}));
end Water;
