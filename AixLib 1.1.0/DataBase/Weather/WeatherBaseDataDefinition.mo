within AixLib.DataBase.Weather;
record WeatherBaseDataDefinition "TYPE: Table with outdoor air tmeperature"
  extends Modelica.Icons.Record;
  parameter Real[:, 3] temperature
    "Time in s | Temperature in degC | Solar irradiation in W/m2";
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Very simple source to output weather conditions in the form of
  outdoor air temperature and solar irraditation.
</p>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<p>
  Values at a certain timestamp represent the average temperature for
  the time between this timestamp and the timestampt before. E.g. a
  value with timestamp 3600 expresses the average value for t = [0;
  3600]
</p>
<h4>
  <span style=\"color:#008000\">Known Limitations</span>
</h4>
<p>
  Only included are outdoor air temperature and solar irradiation.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Column 1: Time in s
</p>
<p>
  Column 2: Temperature in degC
</p>
<p>
  Column 3: Solar Irradiation in W/m2
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record to be used in model <a href=
  \"AixLib.HVAC.Sources.TempAndRad\">AixLib.HVAC.Sources.TempAndRad</a>
</p>
<p>
  October 2013, Marcus Fuchs
</p>
<ul>
  <li>implemented
  </li>
</ul>
</html>"));
end WeatherBaseDataDefinition;
