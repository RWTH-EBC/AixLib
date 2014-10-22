within AixLib.Building.Components.Weather.BaseClasses;

model RadOnTiltedSurf "Compute radiation on tilted surface"
  import Modelica.SIunits.Conversions.from_deg;
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude = 52.517 "latitude of location";
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Azimut = 13.400 "azimut of tilted surface, e.g. 0=south, 90=west, 180=north, -90=east";
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Tilt = 90 "tilt of surface, e.g. 0=horizontal surface, 90=vertical surface";
  parameter Real GroundReflection = 0.2 "ground reflection coefficient";
  Real cos_theta;
  Real cos_theta_help;
  Real cos_theta_z;
  Real cos_theta_z_help;
  Real R;
  Real R_help;
  Real term;
  Modelica.Blocks.Interfaces.RealInput InHourAngleSun annotation(Placement(transformation(extent = {{-100, 10}, {-80, 30}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput InDeclinationSun annotation(Placement(transformation(extent = {{-100, -30}, {-80, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput InAzimutSun annotation(Placement(transformation(extent = {{-100, -70}, {-80, -50}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput InDiffRadHor annotation(Placement(transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput InBeamRadHor annotation(Placement(transformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Utilities.Interfaces.SolarRad_out OutTotalRadTilted annotation(Placement(transformation(extent = {{80, -30}, {100, -10}}, rotation = 0)));
equation
  // calculation of cos_theta_z [Duffie/Beckman, p.15], cos_theta_z is manually cut at 0 (no neg. values)
  cos_theta_z_help = sin(from_deg(InDeclinationSun)) * sin(from_deg(Latitude)) + cos(from_deg(InDeclinationSun)) * cos(from_deg(Latitude)) * cos(from_deg(InHourAngleSun));
  cos_theta_z = (cos_theta_z_help + abs(cos_theta_z_help)) / 2;
  // calculation of cos_theta [Duffie/Beckman, p.15], cos_theta is manually cut at 0 (no neg. values)
  term = cos(from_deg(InDeclinationSun)) * sin(from_deg(Tilt)) * sin(from_deg(Azimut)) * sin(from_deg(InHourAngleSun));
  cos_theta_help = sin(from_deg(InDeclinationSun)) * sin(from_deg(Latitude)) * cos(from_deg(Tilt)) - sin(from_deg(InDeclinationSun)) * cos(from_deg(Latitude)) * sin(from_deg(Tilt)) * cos(from_deg(Azimut)) + cos(from_deg(InDeclinationSun)) * cos(from_deg(Latitude)) * cos(from_deg(Tilt)) * cos(from_deg(InHourAngleSun)) + cos(from_deg(InDeclinationSun)) * sin(from_deg(Latitude)) * sin(from_deg(Tilt)) * cos(from_deg(Azimut)) * cos(from_deg(InHourAngleSun)) + term;
  cos_theta = (cos_theta_help + abs(cos_theta_help)) / 2;
  // calculation of R factor [Duffie/Beckman, p.25], due to numerical problems (cos_theta_z in denominator)
  // R is manually set to 0 for theta_z >= 80° (-> 90° means sunset)
  if noEvent(cos_theta_z <= 0.17365) then
    R_help = cos_theta_z * cos_theta;
  else
    R_help = cos_theta / cos_theta_z;
  end if;
  R = R_help;
  // calculation of total radiation on tilted surface according to model of Liu and Jordan
  // according to [Dissertation Nytsch-Geusen, p.98]
  OutTotalRadTilted.I = max(0, R * InBeamRadHor + 0.5 * (1 + cos(from_deg(Tilt))) * InDiffRadHor + GroundReflection * (InBeamRadHor + InDiffRadHor) * ((1 - cos(from_deg(Tilt))) / 2));
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, fillColor = {170, 213, 255}), Ellipse(extent = {{14, 36}, {66, -16}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {255, 225, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, -40}, {80, -100}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0, 127, 0}), Rectangle(extent = {{-80, -72}, {80, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {0, 127, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-60, -64}, {-22, -76}, {-22, -32}, {-60, -24}, {-60, -64}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {226, 226, 226}), Polygon(points = {{-60, -64}, {-80, -72}, {-80, -100}, {-60, -100}, {-22, -76}, {-60, -64}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 77, 0}), Text(extent = {{-100, 100}, {100, 60}}, lineColor = {0, 0, 255}, textString = "%name")}), DymolaStoredErrors, Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, fillColor = {170, 213, 255}), Ellipse(extent = {{14, 36}, {66, -16}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {255, 225, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-80, -40}, {80, -100}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0, 127, 0}), Rectangle(extent = {{-80, -72}, {80, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {0, 127, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-60, -64}, {-22, -76}, {-22, -32}, {-60, -24}, {-60, -64}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.VerticalCylinder, fillColor = {226, 226, 226}), Polygon(points = {{-60, -64}, {-80, -72}, {-80, -100}, {-60, -100}, {-22, -76}, {-60, -64}}, lineColor = {0, 0, 0}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, fillColor = {0, 77, 0})}), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>
 The <b>RadOnTiltedSurf</b> model calculates the total radiance on a tilted surface.
 </p>
 <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <p><h4><font color=\"#008000\">Concept</font></h4></p>
 <p>
 The <b>RadOnTiltedSurf</b> model uses output data of the <a href=\"Sun\"><b>Sun</b></a> model and weather data (beam and diffuse radiance on a horizontal surface) to compute total radiance on a tilted surface. It needs information on the tilt angle and the azimut angle of the surface, the latitude of the location and the ground reflection coefficient.
 </p>
 <p><h4><font color=\"#008000\">Example Results</font></h4></p>
 <p>The model is checked within the <a href=\"AixLib.Building.Components.Examples.Weather.WeatherModels\">weather</a> example as part of the <a href=\"AixLib.Building.Components.Weather.Weather\">weather</a> model. </p>
 </html>", revisions = "<html>
 <ul>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>March 14, 2005&nbsp;</i>
          by Timo Haase:<br>
          Implemented.</li>
 </ul>
 </html>"));
end RadOnTiltedSurf;