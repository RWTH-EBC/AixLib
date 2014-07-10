within AixLib.DataBase;
package Weather "Records describing weather conditions"
  extends Modelica.Icons.Package;
  record WeatherBaseDataDefinition "TYPE: Table with outdoor air tmeperature"
    extends Modelica.Icons.Record;
    parameter Real[:,3] temperature
      "Time in s | Temperature in °C | Solar irradiation in W/m2";

    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Very simple source to output weather conditions in the form of outdoor air temperature and solar irraditation.</p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Values at a certain timestamp represent the average temperature for the time between this timestamp and the timestampt before. E.g. a value with timestamp 3600 expresses the average value for t = [0; 3600]</p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>Only included are outdoor air temperature and solar irradiation.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Column 1: Time in s</p>
<p>Column 2: Temperature in C</p>
<p>Column 3: Solar Irradiation in W/m2</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.Sources.TempAndRad\">AixLib.HVAC.Sources.TempAndRad</a></p>
</html>",
        revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end WeatherBaseDataDefinition;

  record WinterDay
    "Outdoor conditions on a cold winter day from TRY 2010_01_Wint.dat 08.01.2010"
    extends WeatherBaseDataDefinition(
  temperature=[0,  -5.1,  0;
  3600,  -5,  0;
  7200,  -4.9,  0;
  10800,  -4.9,  0;
  14400,  -4.8,  0;
  18000,  -4.8,  0;
  21600,  -4.9,  0;
  25200,  -4.9,  0;
  28800,  -4.8,  0;
  32400,  -4.6,  19;
  36000,  -4.4,  39;
  39600,  -4.3,  51;
  43200,  -4,  51;
  46800,  -4.1,  40;
  50400,  -4.1,  21;
  54000,  -4.1,  1;
  57600,  -4.2,  0;
  61200,  -4.7,  0;
  64800,  -4.6,  0;
  68400,  -4.7,  0;
  72000,  -5.2,  0;
  75600,  -6.1,  0;
  79200,  -5.8,  0;
  82800,  -5.5,  0]);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Very simple source to output weather conditions in the form of outdoor air temperature and solar irraditation. This record includes outdoor conditions for a cold winter day, taken from German Test Reference Year region 1 (TRY 2010_01_Wint.dat) for January 8 2010.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Values at a certain timestamp represent the average temperature for the time between this timestamp and the timestampt before. E.g. a value with timestamp 3600 expresses the average value for t = [0; 3600]</p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>Only included are outdoor air temperature and solar irradiation.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Column 1: Time in s</p>
<p>Column 2: Temperature in C</p>
<p>Column 3: Solar Irradiation in W/m2</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Sources.TempAndRad\">AixLib.HVAC.Sources.TempAndRad</a></p>
</html>",
        revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end WinterDay;

  record SummerDay
    "Outdoor air temperature and solar radiation on a hot summer day from TRY 2010_01_Somm.dat 20.07.2010"
    extends WeatherBaseDataDefinition(
  temperature=[0, 21, 0;
  3600,  20.6,  0;
  7200,  20.5,  0;
  10800,  20.4,  0;
  14400,  20,  6;
  18000,  20.5,  106;
  21600,  22.4,  251;
  25200,  24.1,  402;
  28800,  26.3,  540;
  32400,  28.4,  657;
  36000,  30,  739;
  39600,  31.5,  777;
  43200,  31.5,  778;
  46800,  32.5,  737;
  50400,  32.5,  657;
  54000,  32.5,  544;
  57600,  32.5,  407;
  61200,  32.5,  257;
  64800,  31.6,  60;
  68400,  30.8,  5;
  72000,  22.9,  0;
  75600,  21.2,  0;
  79200,  20.6,  0;
  82800,  20.3,  0]);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Very simple source to output weather conditions in the form of outdoor air temperature and solar irraditation. This record includes outdoor conditions for a hot summer day, taken from German Test Reference Year region 1 (TRY 2010_01_Somm.dat) for July 20 2010.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Values at a certain timestamp represent the average temperature for the time between this timestamp and the timestampt before. E.g. a value with timestamp 3600 expresses the average value for t = [0; 3600]</p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>Only included are outdoor air temperature and solar irradiation.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Column 1: Time in s</p>
<p>Column 2: Temperature in C</p>
<p>Column 3: Solar Irradiation in W/m2</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.Sources.TempAndRad\">AixLib.HVAC.Sources.TempAndRad</a></p>
</html>",
        revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end SummerDay;

  package SurfaceOrientation "Collection of surface orientation data"
  extends Modelica.Icons.Package;
  record SurfaceOrientationBaseDataDefinition
    extends Modelica.Icons.Record;
    parameter Integer nSurfaces;
    parameter String[nSurfaces] name;
    parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg[nSurfaces] Azimut;
    parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg[nSurfaces] Tilt;
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Base data definition for the surface orientation</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added basic documentation</li>
</ul></p>
</html>
"));
  end SurfaceOrientationBaseDataDefinition;

  record SurfaceOrientationData_N_E_S_W_Hor
      "North, East, South, West, Horizontal"
    extends SurfaceOrientationBaseDataDefinition(
        nSurfaces=5,
        name={"N","O","S","W","Hor"},
        Azimut={180,-90,0,90,0},
        Tilt={90,90,90,90,0});
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Surface Orientation Data for N,E,S and W </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Data in this set: </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td style=\"background-color: #dcdcdc\"><p>Orientation</p></td>
<td style=\"background-color: #dcdcdc\"><p>Azimuth</p></td>
<td style=\"background-color: #dcdcdc\"><p>Tilt</p></td>
</tr>
<tr>
<td><p>N</p></td>
<td><p>180</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>E</p></td>
<td><p>-90</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>S</p></td>
<td><p>0</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>W</p></td>
<td><p>90</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>Hor</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
</table>
<p><br><br><h4><span style=\"color:#008000\">References</span></h4></p>
<p>Record is used in model <a href=\"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added basic documentation</li>
</ul></p>
</html>
"));
  end SurfaceOrientationData_N_E_S_W_Hor;

  record SurfaceOrientationData_NE_SE_SW_NW_Hor
      "Northeast, Southeast, Southwest, Northwest, Horizontal"
    extends SurfaceOrientationBaseDataDefinition(
        nSurfaces=5,
        name={"NE","SE","SW","NW","Hor"},
        Azimut={-135,-45,45,135,0},
        Tilt={90,90,90,90,0});
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Surface Orientation Data for NE,SE,SW and NW </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Data in this set: </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td style=\"background-color: #dcdcdc\"><p>Orientation</p></td>
<td style=\"background-color: #dcdcdc\"><p>Azimuth</p></td>
<td style=\"background-color: #dcdcdc\"><p>Tilt</p></td>
</tr>
<tr>
<td><p>NE</p></td>
<td><p>-135</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>SE</p></td>
<td><p>-45</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>SW</p></td>
<td><p>45</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>NW</p></td>
<td><p>135</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>Hor</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
</table>
<p><br><br><br><h4><span style=\"color:#008000\">References</span></h4></p>
<p>Record is used in model <a href=\"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added basic documentation</li>
</ul></p>
</html>
"));
  end SurfaceOrientationData_NE_SE_SW_NW_Hor;

  record SurfaceOrientationData_N_E_S_W_RoofN_Roof_S
      "North, East, South, West, Roof_N, Roof_S suitable to Standard OFD"
    extends SurfaceOrientationBaseDataDefinition(
        nSurfaces=6,
        name={"N","O","S","W","Roof_N","Roof_S"},
        Azimut={180,-90,0,90,180,0},
        Tilt={90,90,90,90,45,45});
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Surface Orientation Data for N,E,S,W,Roof_N and Roof_S suitable to standard OFD.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Data in this set: </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td style=\"background-color: #dcdcdc\"><p>Orientation</p></td>
<td style=\"background-color: #dcdcdc\"><p>Azimuth</p></td>
<td style=\"background-color: #dcdcdc\"><p>Tilt</p></td>
</tr>
<tr>
<td><p>N</p></td>
<td><p>180</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>E</p></td>
<td><p>-90</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>S</p></td>
<td><p>0</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>W</p></td>
<td><p>90</p></td>
<td><p>90</p></td>
</tr>
<tr>
<td><p>Roof_N</p></td>
<td><p>180</p></td>
<td><p>45</p></td>
</tr>
<tr>
<td><p>Roof_S</p></td>
<td><p>0</p></td>
<td><p>45</p></td>
</tr>
</table>
<p><br><br><h4><span style=\"color:#008000\">References</span></h4></p>
<p>Record is used in model <a href=\"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added basic documentation</li>
</ul></p>
</html>
"));
  end SurfaceOrientationData_N_E_S_W_RoofN_Roof_S;
  end SurfaceOrientation;

end Weather;
