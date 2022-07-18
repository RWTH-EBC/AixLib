within AixLib.DataBase.Weather;
record WinterDay
  "Outdoor conditions on a cold winter day from TRY 2010_01_Wint.dat 08.01.2010"
  extends WeatherBaseDataDefinition(temperature = [0, -5.1, 0; 3600, -5, 0; 7200, -4.9, 0; 10800, -4.9, 0; 14400, -4.8, 0; 18000, -4.8, 0; 21600, -4.9, 0; 25200, -4.9, 0; 28800, -4.8, 0; 32400, -4.6, 19; 36000, -4.4, 39; 39600, -4.3, 51; 43200, -4, 51; 46800, -4.1, 40; 50400, -4.1, 21; 54000, -4.1, 1; 57600, -4.2, 0; 61200, -4.7, 0; 64800, -4.6, 0; 68400, -4.7, 0; 72000, -5.2, 0; 75600, -6.1, 0; 79200, -5.8, 0; 82800, -5.5, 0]);
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Very simple source to output weather conditions in the form of
  outdoor air temperature and solar irraditation. This record includes
  outdoor conditions for a cold winter day, taken from German Test
  Reference Year region 1 (TRY 2010_01_Wint.dat) for January 8 2010.
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
  Column 2: Temperature in C
</p>
<p>
  Column 3: Solar Irradiation in W/m2
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
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
end WinterDay;
