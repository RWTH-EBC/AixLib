within AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.BaseClasses;
model Sun "Computes the sun's altitude of the current site"

import Modelica.Units.Conversions.from_deg;
import Modelica.Units.Conversions.to_deg;
  parameter Real TimeCorrection = 0.5 "for TRY = 0.5, for TMY = 0";
  parameter Modelica.Units.NonSI.Angle_deg Latitude "latitude of location";
  parameter Modelica.Units.NonSI.Angle_deg Longitude "longitude of location in";
  parameter Modelica.Units.NonSI.Time_hour DiffWeatherDataTime
    "difference between local time and UTC, e.g. +1 for MET";
  parameter Real Diff_localStandardTime_WeatherDataTime = 0
    "difference between weather data time and the time of the local time zone";

  Real NumberOfDay;
  Real SolarTime;
  Real TimeEquation;
  Modelica.Blocks.Interfaces.RealOutput OutHourAngleSun  annotation (Placement(transformation(extent={{80,-36},{100,-16}})));
  Modelica.Blocks.Interfaces.RealOutput OutDeclinationSun  annotation (Placement(transformation(extent={{80,-66},{100,-46}})));
  Modelica.Blocks.Interfaces.RealOutput OutDayAngleSun  annotation (Placement(transformation(extent={{80,-4},{100,16}})));

  Real DeclinationSun;
  Real HourAngleSun;
  Real DayAngleSun;
  Real StandardTime "the time of the standard time zone of the WeatherData";
equation
//calculation of the SolarTime (Duffie2006 chap. 1.5)

      // number of day: 1 = Jan 1st
      NumberOfDay = time/86400 + 1
    "NumberOfDay is calculated as float because then the variables that use NumberoOfDay in their calculation don't have to be interpolated between the time-steps. To get the integer value it has to be calculated with: NumberOfDay =floor(time/86400) + 1";

      // day angle of sun
      DayAngleSun = 360/365.25*(NumberOfDay - 1)
    "360 is an angle in degree and 365 is the number of days in one year. The earth rotation in one year is 360 degrees";

      OutDayAngleSun = DayAngleSun;

      // equation of time in hours - used to convert local time in solar time
      TimeEquation = 229.2*(0.000075+0.001868*cos(from_deg(DayAngleSun))-0.032077*sin(from_deg(DayAngleSun))-0.014615*cos(2*from_deg(DayAngleSun))-0.04089*sin(2*from_deg(DayAngleSun)))/60;
      StandardTime=mod(time/3600, 24);
      SolarTime =  StandardTime - TimeCorrection - (DiffWeatherDataTime + Diff_localStandardTime_WeatherDataTime) + 4 * (Longitude)/60 + TimeEquation
    "the difference between the UTC and the time standard is given by DiffWeatherDataTime and Diff_lokalStandardTime Longitude";

// hour angle of sun, first term calculates local time of day from continuous time signal
      HourAngleSun = (SolarTime-12) * 360/24 "HourAngleSun=0 deg means sun peak";
      if (HourAngleSun > 180) then
        OutHourAngleSun = HourAngleSun - 360;
      elseif (HourAngleSun < -180) then
        OutHourAngleSun = HourAngleSun + 360;
      else
        OutHourAngleSun = HourAngleSun;
      end if;

// declination of sun
      DeclinationSun = (to_deg(0.006918 - 0.399912 * cos(from_deg(DayAngleSun)) + 0.070257 * sin(from_deg(DayAngleSun)) - 0.006758 * cos(2*from_deg(DayAngleSun)) + 0.000907 * sin(2*from_deg(DayAngleSun)) - 0.002679 * cos(3*from_deg(DayAngleSun)) + 0.00148 * sin(3*from_deg(DayAngleSun))));
      OutDeclinationSun=DeclinationSun;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-80,60},{80,-100}},
          lineColor={0,0,0},
           pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={170,213,255}),
        Ellipse(
          extent={{-50,30},{50,-70}},
          lineColor={255,255,0},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,60}},
          lineColor={0,0,255},
          textString="%name")}),
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),            graphics={Rectangle(
          extent={{-80,60},{80,-100}},
          lineColor={0,0,0},
           pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={170,213,255}), Ellipse(
          extent={{-50,30},{50,-70}},
          lineColor={255,255,0},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The model <b>Sun</b> will mainly be used as part of the model
  <b><a href=
  \"Modelica://Building.Components.Weather.SunIrradiation\">SunIrradiation</a></b>
  and in this case as part of the model <b>Weather</b>. The ouput data
  of the <b>Sun</b> model is yet not very useful itself, but it is most
  commonly used as input data for e.g. <b><a href=
  \"RadOnTiltedSurf\">RadOnTiltedSurf</a></b> models to compute the solar
  radiance according to the azimut of a surface.
</p>
<p>
  Output: The <b>Sun</b> model computes the day angle, hour angle and
  the declination of the sun for a given set of geographic position and
  local solar time.
</p>
<p>
  Input: The model needs information on the difference between the
  local time zone (corresponding to the time basis of the simulation)
  and UTC (universal time coordinated) in hours.
</p>
<h4>
  <span style=\"color:#008000\">Known Limitations</span>
</h4>
<p>
  Be aware that the outputs of this model are only values that are
  calculated in the middle of the simulation interval and that they are
  no mean value. The parameter timeCorrection is for setting the
  calculation time of the outputs to the middle of the simulationi
  nterval. The variable that depends on the solar time are better
  approximated when the solar time is calculated for the middle of the
  hour, for which the horizontal solar radiation is given. For weather
  data in TRY format it is 0.5 h because the solar radiation values are
  the average measured values for the previous hours. Set according to
  the specifications of each weather file format.
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>December 20, 2012&#160;</i> by Jerome Feldhaus:<br/>
    new Output variable OutHourAngleSun and renaming from Sun to
    SunAltitude.
  </li>
  <li>
    <i>September 29, 2006&#160;</i> by Peter Matthes:<br/>
    Included ArgACOS variable to protect acos function from arguments
    &gt; 1. Added protection for some variables.
  </li>
  <li>
    <i>March 14, 2005&#160;</i> by Timo Haase:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Sun;
