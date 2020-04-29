within AixLib.DataBase.Weather;
record TRYWeatherBaseDataDefinition
  "TYPE: Table with TRY weather data for one day"
  extends Modelica.Icons.Record;
  parameter Real[:, 20] weatherData;
  annotation(Documentation(info="<html><p>
  <b><span style=\"color: #008000\">Overview</span></b>
</p>
<p>
  Source to output weather conditions for one day of the TRY
</p>
<p>
  <b><span style=\"color: #008000\">Assumptions</span></b>
</p>
<p>
  see TRY specifications
</p>
<p>
  <b><span style=\"color: #008000\">Known Limitations</span></b>
</p>
<p>
  Only included one day of TRY
</p>
<p>
  <b><span style=\"color: #008000\">Concept</span></b>
</p>
<p>
  Columns: see TRY specifications
</p>
<p>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  Base data definition for record to be used in model <a href=
  \"AixLib.HVAC.Sources.TempAndRad\">AixLib.HVAC.Sources.TempAndRad</a>
</p>
<p>
  October 2014, Peter Remmen
</p>
<ul>
  <li>implemented
  </li>
</ul>
</html>"));
end TRYWeatherBaseDataDefinition;
