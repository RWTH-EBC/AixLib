within AixLib.Building.Components.Weather.BaseClasses;
model Sun "Solar radiation model"
  import Modelica.SIunits.Conversions.from_deg;
  import Modelica.SIunits.Conversions.to_deg;
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude
    "latitude of location";
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Longitude
    "longitude of location in";
  parameter Modelica.SIunits.Conversions.NonSIunits.Time_hour DiffWeatherDataTime
    "difference between local time and UTC, e.g. +1 for MET";
  Real NumberOfDay;
  Real AzimutSun;
  Real ElevationSun;
  Modelica.Blocks.Interfaces.RealOutput OutHourAngleSun annotation(Placement(transformation(extent = {{80, 10}, {100, 30}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput OutDeclinationSun annotation(Placement(transformation(extent = {{80, -30}, {100, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput OutAzimutSun annotation(Placement(transformation(extent = {{80, -70}, {100, -50}}, rotation = 0)));
protected
  Real DeclinationSun;
  Real HourAngleSun;
  Real TimeEquation;
  Real DayAngleSun;
  Real ArgACOS(min = -1, max = 1)
    "helper variable to protect 'acos' from Arguments > 1";
equation
  // number of day: 1 = Jan 1st
  NumberOfDay = time / 86400 + 1;
  // day angle of sun
  DayAngleSun = 360 / 365.25 * (NumberOfDay - 1);
  // equation of time in hours - used to convert local time in solar time
  TimeEquation = (-0.128 * sin(from_deg(DayAngleSun - 2.8))) - 0.165 * sin(from_deg(2 * DayAngleSun + 19.7));
  // hour angle of sun, first term calculates local time of day from continuous time signal
  HourAngleSun = 15 * (mod(time / 3600, 24) - DiffWeatherDataTime + TimeEquation + Longitude / 15 - 12);
  if HourAngleSun > 180 then
    OutHourAngleSun = HourAngleSun - 360;
  elseif HourAngleSun < (-180) then
    OutHourAngleSun = HourAngleSun + 360;
  else
    OutHourAngleSun = HourAngleSun;
  end if;
  // declination of sun
  DeclinationSun = noEvent(to_deg(asin(0.3978 * sin(from_deg(DayAngleSun - 80.2 + 1.92 * sin(from_deg(DayAngleSun - 2.8)))))));
  OutDeclinationSun = DeclinationSun;
  // elevation of sun over horizon
  ElevationSun = noEvent(to_deg(asin(cos(from_deg(DeclinationSun)) * cos(from_deg(OutHourAngleSun)) * cos(from_deg(Latitude)) + sin(from_deg(DeclinationSun)) * sin(from_deg(Latitude)))));
  // azimut of sun
  // AzimutSun = noEvent(to_deg(arctan((cos(from_deg(DeclinationSun))*sin(from_deg(
  //   OutHourAngleSun)))/(cos(from_deg(DeclinationSun))*cos(from_deg(
  //   OutHourAngleSun))*sin(from_deg(Latitude)) - sin(from_deg(
  //   DeclinationSun))*cos(from_deg(Latitude))))));
  ArgACOS = (sin(from_deg(ElevationSun)) * sin(from_deg(Latitude)) - sin(from_deg(DeclinationSun))) / (cos(from_deg(ElevationSun)) * cos(from_deg(Latitude)));
  AzimutSun = to_deg(acos(if noEvent(ArgACOS > 1) then 1 else if noEvent(ArgACOS < (-1)) then -1 else ArgACOS));
  if AzimutSun >= 0 then
    OutAzimutSun = 180 - AzimutSun;
  else
    OutAzimutSun = 180 + AzimutSun;
  end if;
algorithm
  // correcting azimut calculation for output
  // OutAzimutSun := AzimutSun;
  // while (OutAzimutSun < 0) loop
  //   OutAzimutSun := OutAzimutSun + 180;
  // end while;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0}, pattern=  LinePattern.None,
            fillPattern=                                                                                                    FillPattern.HorizontalCylinder, fillColor=  {170, 213, 255}), Ellipse(extent=  {{-50, 30}, {50, -70}}, lineColor=  {255, 255, 0},
            lineThickness=                                                                                                    0.5, fillColor=  {255, 255, 0},
            fillPattern=                                                                                                    FillPattern.Solid), Text(extent=  {{-100, 100}, {100, 60}}, lineColor=  {0, 0, 255}, textString=  "%name")}), DymolaStoredErrors, Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent=  {{-80, 60}, {80, -100}}, lineColor=  {0, 0, 0}, pattern=  LinePattern.None,
            fillPattern=                                                                                                    FillPattern.HorizontalCylinder, fillColor=  {170, 213, 255}), Ellipse(extent=  {{-50, 30}, {50, -70}}, lineColor=  {255, 255, 0},
            lineThickness=                                                                                                    0.5, fillColor=  {255, 255, 0},
            fillPattern=                                                                                                    FillPattern.Solid)}), Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p>The <b>Sun</b> model computes the hour angle, the declination and the azimut of the sun for a given set of geographic position and local time. </p>
 <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <p><h4><font color=\"#008000\">Concept</font></h4></p>
 <p>The model needs information on the difference between the local time zone (corresponding to the time basis of the simulation) and UTC (universal time coordinated) in hours. The ouput data of the <b>Sun</b> model is yet not very useful itself, but it is most commonly used as input data for e.g. <b><a href=\"RadOnTiltedSurf\">RadOnTiltedSurf</a></b> models to compute the solar radiance according to the azimut of a surface. </p>
 <p><h4><font color=\"#008000\">Example Results</font></h4></p>
 <p>The model is checked within the <a href=\"AixLib.Building.Components.Examples.Weather.WeatherModels\">weather</a> example as part of the <a href=\"AixLib.Building.Components.Weather.Weather\">weather</a> model. </p>
 </html>", revisions = "<html>
 <ul>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>September 29, 2006&nbsp;</i>
          by Peter Matthes:<br>
          Included ArgACOS variable to protect acos function from arguments &gt; 1. Added protection for some variables.</li>
   <li><i>March 14, 2005&nbsp;</i>
          by Timo Haase:<br>
          Implemented.</li>
 </ul>
 </html>"));
end Sun;

