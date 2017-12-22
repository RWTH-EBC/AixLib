within AixLib.DataBase.Weather;
record TRYWeatherBaseDataDefinition
  "TYPE: Table with TRY weather data for one day"
  extends Modelica.Icons.Record;
  parameter Real[:, 20] weatherData;
  annotation(Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Source to output weather conditions for one day of the TRY</p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p>see TRY specifications</p>
<p><b><font style=\"color: #008000; \">Known Limitations</font></b> </p>
<p>Only included one day of TRY</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>Columns: see TRY specifications</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.Sources.TempAndRad\">AixLib.HVAC.Sources.TempAndRad</a> </p>
</html>",  revisions="<html>
<p>October 2014, Peter Remmen </p>
<ul>
<li>implemented </li>
</ul>
</html>"));
end TRYWeatherBaseDataDefinition;
