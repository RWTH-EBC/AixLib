within AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface;
model RadOnTiltedSurf_Liu
  "Calculates solar radiation on tilted surfaces according to Liu"
  extends BaseClasses.PartialRadOnTiltedSurf;

import Modelica.Units.Conversions.from_deg;

  Real InBeamRadHor "beam irradiance on the horizontal surface";
  Real InDiffRadHor "diffuse irradiance on the horizontal surface";

  Real cos_theta;
  Real cos_theta_help;
  Real cos_theta_z;
  Real cos_theta_z_help;
  Real R;
  Real R_help;
  Real term;

equation
  // calculation of cos_theta_z [Duffie/Beckman, p.15], cos_theta_z is manually cut at 0 (no neg. values)
  cos_theta_z_help = sin(from_deg(InDeclinationSun))*sin(from_deg(
    Latitude)) + cos(from_deg(InDeclinationSun))*cos(from_deg(Latitude))*
    cos(from_deg(InHourAngleSun));
  cos_theta_z = (cos_theta_z_help + abs(cos_theta_z_help))/2;

  // calculation of cos_theta [Duffie/Beckman, p.15], cos_theta is manually cut at 0 (no neg. values)
  term = cos(from_deg(InDeclinationSun))*sin(from_deg(Tilt))*sin(from_deg(
    Azimut))*sin(from_deg(InHourAngleSun));
  cos_theta_help = sin(from_deg(InDeclinationSun))*sin(from_deg(Latitude))
    *cos(from_deg(Tilt)) - sin(from_deg(InDeclinationSun))*cos(from_deg(
    Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut)) + cos(from_deg(
    InDeclinationSun))*cos(from_deg(Latitude))*cos(from_deg(Tilt))*cos(
    from_deg(InHourAngleSun)) + cos(from_deg(InDeclinationSun))*sin(
    from_deg(Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut))*cos(
    from_deg(InHourAngleSun)) + term;
  cos_theta = (cos_theta_help + abs(cos_theta_help))/2;

  // calculation of R factor [Duffie/Beckman, p.25], due to numerical problems (cos_theta_z in denominator)
  // R is manually set to 0 for theta_z >= 80 deg (-> 90 deg means sunset)
  if noEvent(cos_theta_z <= 0.17365) then
    R_help = cos_theta_z*cos_theta;

  else
    R_help = cos_theta/cos_theta_z;

  end if;

  R = R_help;

  // conversion of direct and diffuse horizontal radiation
  if WeatherFormat == 1 then // TRY
    InBeamRadHor = solarInput1;
    InDiffRadHor = solarInput2;
  else  // WeatherFormat == 2 , TMY then
    InBeamRadHor = solarInput1 * cos_theta_z;
    InDiffRadHor = max(solarInput2-InBeamRadHor, 0);
  end if;

  // calculation of total radiation on tilted surface according to model of Liu and Jordan
  // according to [Dissertation Nytsch-Geusen, p.98]
  OutTotalRadTilted.I = max(0, R*InBeamRadHor + 0.5*(1 + cos(from_deg(
    Tilt)))*InDiffRadHor + GroundReflection*(InBeamRadHor + InDiffRadHor)
    *((1 - cos(from_deg(Tilt)))/2));

  // Setting the outputs of direct. diffuse and ground reflection radiation on tilted surface and the angle of incidence
  OutTotalRadTilted.I_dir = R*InBeamRadHor;
  OutTotalRadTilted.I_diff = 0.5*(1 + cos(from_deg(Tilt)))*InDiffRadHor;
  OutTotalRadTilted.I_gr = GroundReflection*(InBeamRadHor + InDiffRadHor)*((1 - cos(from_deg(Tilt)))/2);

  OutTotalRadTilted.AOI = Modelica.Math.acos(cos_theta); // in rad

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
          {100,100}}), graphics={
      Rectangle(
        extent={{-80,60},{80,-100}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-80,60},{80,-100}},
        lineColor={0,0,0},
         pattern=LinePattern.None,
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={170,213,255}),
      Ellipse(
        extent={{14,36},{66,-16}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={255,225,0},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-80,-40},{80,-100}},
        lineColor={0,0,0},
         pattern=LinePattern.None,
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={0,127,0}),
      Rectangle(
        extent={{-80,-72},{80,-100}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={0,127,0},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{-60,-64},{-22,-76},{-22,-32},{-60,-24},{-60,-64}},
        lineColor={0,0,0},
        fillPattern=FillPattern.VerticalCylinder,
        fillColor={226,226,226}),
      Polygon(
        points={{-60,-64},{-80,-72},{-80,-100},{-60,-100},{-22,-76},{-60,
            -64}},
        lineColor={0,0,0},
         pattern=LinePattern.None,
        fillPattern=FillPattern.VerticalCylinder,
        fillColor={0,77,0}),
      Text(
        extent={{-100,100},{100,60}},
        lineColor={0,0,255},
        textString="%name")}),
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),        graphics={
        Rectangle(
          extent={{-80,60},{80,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,60},{80,-100}},
          lineColor={0,0,0},
           pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={170,213,255}),
        Ellipse(
          extent={{14,36},{66,-16}},
          lineColor={0,0,255},
           pattern=LinePattern.None,
          fillColor={255,225,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-40},{80,-100}},
          lineColor={0,0,0},
           pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,0}),
        Rectangle(
          extent={{-80,-72},{80,-100}},
          lineColor={0,0,255},
           pattern=LinePattern.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-64},{-22,-76},{-22,-32},{-60,-24},{-60,-64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={226,226,226}),
        Polygon(
          points={{-60,-64},{-80,-72},{-80,-100},{-60,-100},{-22,-76},{-60,
              -64}},
          lineColor={0,0,0},
           pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,77,0})}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>RadOnTiltedSurf</b> model calculates the total radiance on a
  tilted surface.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The <b>RadOnTiltedSurf</b> model uses output data of the <b><a href=
  \"AixLib.Building.Components.Weather.BaseClasses.Sun\">Sun</a></b>
  model and weather data (beam and diffuse radiance on a horizontal
  surface for TRY format, or beam normal and global horizontal for TMY
  format) to compute total radiance on a tilted surface. It needs
  information on the tilt angle and the azimut angle of the surface,
  the latitude of the location and the ground reflection coefficient.
</p>
<p>
  The input InDayAngleSun is not explicitly used in the model, but it
  is part of the partial model and it doesn't interfere with the
  calculations.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  The model is checked within the <a href=
  \"AixLib.Building.Examples.Weather.WeatherModels\">weather</a> example
  as part of the <a href=
  \"AixLib.Building.Components.Weather.Weather\">weather</a> model.
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>March 23, 2015&#160;</i> by Ana Constantin:<br/>
    Adapted solar inputs so it cand work with both TRY and TMY weather
    format
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>March 14, 2005&#160;</i> by Timo Haase:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end RadOnTiltedSurf_Liu;
