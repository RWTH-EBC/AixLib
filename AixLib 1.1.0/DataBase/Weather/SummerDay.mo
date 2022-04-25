within AixLib.DataBase.Weather;
record SummerDay
  "Outdoor air temperature and solar radiation on a hot summer day from TRY 2010_01_Somm.dat 20.07.2010"
  extends WeatherBaseDataDefinition(temperature = [0, 21, 0; 3600, 20.6, 0; 7200, 20.5, 0; 10800, 20.4, 0; 14400, 20, 6; 18000, 20.5, 106; 21600, 22.4, 251; 25200, 24.1, 402; 28800, 26.3, 540; 32400, 28.4, 657; 36000, 30, 739; 39600, 31.5, 777; 43200, 31.5, 778; 46800, 32.5, 737; 50400, 32.5, 657; 54000, 32.5, 544; 57600, 32.5, 407; 61200, 32.5, 257; 64800, 31.6, 60; 68400, 30.8, 5; 72000, 22.9, 0; 75600, 21.2, 0; 79200, 20.6, 0; 82800, 20.3, 0]);
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Very simple source to output weather conditions in the form of
  outdoor air temperature and solar irraditation. This record includes
  outdoor conditions for a hot summer day, taken from German Test
  Reference Year region 1 (TRY 2010_01_Somm.dat) for July 20 2010.
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
end SummerDay;
