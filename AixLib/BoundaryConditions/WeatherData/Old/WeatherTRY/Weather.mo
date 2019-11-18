within AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY;
model Weather "Complex weather model"
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude = 49.5
    "latitude of location"                                                                           annotation(Dialog(group = "Location Properties"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Longitude = 8.5
    "longitude of location"                                                                           annotation(Dialog(group = "Location Properties"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Time_hour DiffWeatherDataTime = 1
    "difference between weather data time and UTC, e.g. +1 for CET"                                                                                   annotation(Dialog(group = "Properties of Weather Data"));
  parameter Real GroundReflection = 0.2 "ground reflection coefficient" annotation(Dialog(group = "Location Properties"));
  parameter String tableName = "wetter"
    "table name on file or in function usertab"                                     annotation(Dialog(group = "Properties of Weather Data"));
  parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/TRY2010_12_Jahr_Modelica-Library.txt")
    "file where matrix is stored"                                                                                                     annotation(Dialog(group = "Properties of Weather Data", loadSelector(filter = "Text files (*.txt);;Matlab files (*.mat)", caption = "Open file in which table is present")));
  parameter Real offset[:] = {0} "offsets of output signals" annotation(Dialog(group = "Properties of Weather Data"));
  parameter Modelica.Blocks.Types.Smoothness smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"                                                                                                     annotation(Dialog(group = "Properties of Weather Data"));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic
    "Extrapolation of data outside the definition range"                                                                                                     annotation(Dialog(group = "Properties of Weather Data"));
  parameter Real startTime[1] = {0}
    "output = offset for time < startTime (same value for all columns)"                                 annotation(Dialog(group = "Properties of Weather Data"));

  replaceable model RadOnTiltedSurface =
      AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface.RadOnTiltedSurf_Liu
    constrainedby
    AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface.BaseClasses.PartialRadOnTiltedSurf
    "Model for calculating radiation on tilted surfaces"                                                                            annotation(Dialog(group="Solar radiation on oriented surfaces", descriptionLabel = true), choicesAllMatching= true);

  parameter
    DataBase.Weather.SurfaceOrientation.SurfaceOrientationBaseDataDefinition         SOD = DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor()
    "Surface orientation data"                                                                                                     annotation(Dialog(group = "Solar radiation on oriented surfaces", descriptionLabel = true), choicesAllMatching = true);
  Utilities.Interfaces.SolarRad_out SolarRadiation_OrientedSurfaces[SOD.nSurfaces] annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin={50,96}),    iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-78, -110})));
  parameter Integer Outopt = 2 "Output options" annotation(Dialog(tab = "Optional output vector", compact = true, descriptionLabel = true), choices(choice = 1
        "one vector",                                                                                                    choice = 2
        "individual vectors",                                                                                                    radioButtons = true));
  parameter Boolean Cloud_cover = false "Cloud cover [-] (TRY col 7)" annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Wind_dir = false "Wind direction [deg] (TRY col 8)" annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Wind_speed = false "Wind speed [m/s]  (TRY col 9)" annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Air_temp = false "Air temperature [K] (TRY col 10)" annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Air_press = false "Air pressure [Pa] (TRY col 11)" annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Mass_frac = false
    "Mass fraction of water in dry air [kg/kg] (TRY col 12)"                                   annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Rel_hum = false "Realtive humidity of air [-] (TRY col 13)" annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Sky_rad = false
    "Longwave sky radiation on horizontal [W/m2] (TRY col 18)"                                 annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  parameter Boolean Ter_rad = false
    "Longwave terrestric radiation from horizontal [W/m2] (TRY col 19)"                                 annotation(Dialog(tab = "Optional output vector", descriptionLabel = true), choices(checkBox = true));
  BaseClasses.Sun Sun(
    Longitude=Longitude,
    Latitude=Latitude,
    DiffWeatherDataTime=DiffWeatherDataTime) annotation (Placement(
        transformation(extent={{-62,18},{-38,42}})));
  RadOnTiltedSurface RadOnTiltedSurf[SOD.nSurfaces](each Latitude = Latitude, each GroundReflection = GroundReflection, Azimut = SOD.Azimut, Tilt = SOD.Tilt, each WeatherFormat=1) annotation(Placement(transformation(extent = {{-2, 18}, {22, 42}})));
  Modelica.Blocks.Sources.CombiTimeTable WeatherData(fileName = Modelica.Utilities.Files.loadResource(fileName), columns = columns, offset = offset, table = [0, 0; 1, 1], startTime = scalar(startTime), tableName = tableName, tableOnFile = tableName <> "NoName", smoothness = smoothness, extrapolation = extrapolation) annotation(Placement(transformation(extent = {{-60, -70}, {-40, -50}})));
  Modelica.Blocks.Routing.DeMultiplex3 deMultiplex(n3 = 9) annotation(Placement(transformation(extent = {{-26, -70}, {-6, -50}})));
  Modelica.Blocks.Interfaces.RealOutput WeatherDataVector[m] if Outopt == 1 and (Cloud_cover or Wind_dir or Wind_speed or Air_temp or Air_press or Mass_frac or Rel_hum or Sky_rad or Ter_rad) annotation(Placement(transformation(origin = {-1, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput CloudCover if Cloud_cover and Outopt == 2 "[0..8]" annotation(Placement(transformation(extent = {{114, 74}, {134, 94}}), iconTransformation(extent = {{150, 110}, {170, 130}})));
  Modelica.Blocks.Interfaces.RealOutput WindDirection(unit = "deg") if Wind_dir and Outopt == 2
    "in deg [0...360]"                                                                                             annotation(Placement(transformation(extent = {{126, 52}, {146, 72}}), iconTransformation(extent = {{150, 80}, {170, 100}})));
  Modelica.Blocks.Interfaces.RealOutput WindSpeed(unit = "m/s") if Wind_speed and Outopt == 2 "in m/s" annotation(Placement(transformation(extent = {{126, 32}, {146, 52}}), iconTransformation(extent = {{150, 50}, {170, 70}})));
  Modelica.Blocks.Interfaces.RealOutput AirTemp(unit = "K") if Air_temp and Outopt == 2
    "in Kelvin"                                                                                     annotation(Placement(transformation(extent = {{126, 14}, {146, 34}}), iconTransformation(extent = {{150, 20}, {170, 40}})));
  Modelica.Blocks.Interfaces.RealOutput AirPressure(unit = "Pa") if Air_press and Outopt == 2 "in Pa" annotation(Placement(transformation(extent = {{126, -8}, {146, 12}}), iconTransformation(extent = {{150, -10}, {170, 10}})));
  Modelica.Blocks.Interfaces.RealOutput WaterInAir if Mass_frac and Outopt == 2
    "in kg/kg"                                                                             annotation(Placement(transformation(extent = {{126, -24}, {146, -4}}), iconTransformation(extent = {{150, -40}, {170, -20}})));
  Modelica.Blocks.Interfaces.RealOutput RelHumidity if Rel_hum and Outopt == 2
    "in percent"                                                                            annotation(Placement(transformation(extent = {{126, -42}, {146, -22}}), iconTransformation(extent = {{150, -70}, {170, -50}})));
  Modelica.Blocks.Interfaces.RealOutput SkyRadiation(unit = "W/m2") if Sky_rad and Outopt == 2 "in W/m2"
                                                                                                        annotation(Placement(transformation(extent = {{126, -62}, {146, -42}}), iconTransformation(extent = {{150, -100}, {170, -80}})));
  Modelica.Blocks.Interfaces.RealOutput TerrestrialRadiation(unit = "W/m2") if Ter_rad and Outopt == 2 "in W/m2"
                                                                                                        annotation(Placement(transformation(extent = {{126, -78}, {146, -58}}), iconTransformation(extent = {{150, -130}, {170, -110}})));
  Modelica.Blocks.Math.Gain hPa_to_Pa(k = 100) if Air_press annotation(Placement(transformation(extent = {{26, -60}, {36, -50}})));
  Modelica.Blocks.Math.Gain percent_to_unit(k = 0.01) if Rel_hum annotation(Placement(transformation(extent = {{26, -78}, {36, -68}})));
  Modelica.Blocks.Math.Gain g_to_kg(k = 0.001) if Mass_frac annotation(Placement(transformation(extent = {{28, -96}, {38, -86}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC if Air_temp annotation(Placement(transformation(extent = {{26, -42}, {36, -32}})));
protected
  parameter Integer m = BaseClasses.CalculateNrOfOutputs(Cloud_cover, Wind_dir, Wind_speed, Air_temp, Air_press, Mass_frac, Rel_hum, Sky_rad, Ter_rad)
    "Number of chosen output variables";
  parameter Integer[9] PosWV = BaseClasses.DeterminePositionsInWeatherVector(Cloud_cover, Wind_dir, Wind_speed, Air_temp, Air_press, Mass_frac, Rel_hum, Sky_rad, Ter_rad)
    "Positions Weather Vector";
  parameter Integer columns[:] = {16, 15, 7, 8, 9, 10, 11, 12, 13, 18, 19};
initial equation
  assert(SOD.nSurfaces == size(SOD.name, 1), "name has to have the nSurfaces Elements (see Surface orientation data in the Weather Model)");
  assert(SOD.nSurfaces == size(SOD.Azimut, 1), "Azimut has to have the nSurfaces Elements (see Surface orientation data in the Weather Model)");
  assert(SOD.nSurfaces == size(SOD.Tilt, 1), "Tilt has to have the nSurfaces Elements (see Surface orientation data in the Weather Model)");
equation
  // cloud cover
  if Cloud_cover then
    if Outopt == 1 then
      connect(WeatherDataVector[PosWV[1]], deMultiplex.y3[1]);
    else
      connect(CloudCover, deMultiplex.y3[1]);
    end if;
  end if;
  // wind direction
  if Wind_dir then
    if Outopt == 1 then
      connect(WeatherDataVector[PosWV[2]], deMultiplex.y3[2]);
    else
      connect(WindDirection, deMultiplex.y3[2]);
    end if;
  end if;
  // wind speed
  if Wind_speed then
    if Outopt == 1 then
      connect(WeatherDataVector[PosWV[3]], deMultiplex.y3[3]);
    else
      connect(WindSpeed, deMultiplex.y3[3]);
    end if;
  end if;
  // air temperature
  if Air_temp then
    if Outopt == 1 then
      connect(deMultiplex.y3[4], from_degC.u);
      connect(WeatherDataVector[PosWV[4]], from_degC.y);
    else
      connect(deMultiplex.y3[4], from_degC.u);
      connect(AirTemp, from_degC.y);
    end if;
  end if;
  // air pressure, conversion from hPa to Pa
  if Air_press then
    if Outopt == 1 then
      connect(deMultiplex.y3[5], hPa_to_Pa.u);
      connect(WeatherDataVector[PosWV[5]], hPa_to_Pa.y);
    else
      connect(deMultiplex.y3[5], hPa_to_Pa.u);
      connect(AirPressure, hPa_to_Pa.y);
    end if;
  end if;
  // mass fraction water in dry air, conversion from g/kg to kg/kg
  if Mass_frac then
    if Outopt == 1 then
      connect(deMultiplex.y3[6], g_to_kg.u);
      connect(WeatherDataVector[PosWV[6]], g_to_kg.y);
    else
      connect(deMultiplex.y3[6], g_to_kg.u);
      connect(WaterInAir, g_to_kg.y);
    end if;
  end if;
  // rel. humidity, conversion from % to 0..1
  if Rel_hum then
    if Outopt == 1 then
      connect(deMultiplex.y3[7], percent_to_unit.u);
      connect(WeatherDataVector[PosWV[7]], percent_to_unit.y);
    else
      connect(deMultiplex.y3[7], percent_to_unit.u);
      connect(RelHumidity, percent_to_unit.y);
    end if;
  end if;
  // longwave sky radiation
  if Sky_rad then
    if Outopt == 1 then
      connect(WeatherDataVector[PosWV[8]], deMultiplex.y3[8]);
    else
      connect(SkyRadiation, deMultiplex.y3[8]);
    end if;
  end if;
  // longwave terrestric radiation
  if Ter_rad then
    if Outopt == 1 then
      connect(WeatherDataVector[PosWV[9]], deMultiplex.y3[9]);
    else
      connect(TerrestrialRadiation, deMultiplex.y3[9]);
    end if;
  end if;
  connect(WeatherData.y, deMultiplex.u) annotation(Line(points = {{-39, -60}, {-28, -60}}, color = {0, 0, 127}));
 // Connecting n RadOnTiltedSurf
  for i in 1:SOD.nSurfaces loop
    connect(Sun.OutDayAngleSun, RadOnTiltedSurf[i].InDayAngleSun);
    connect(Sun.OutHourAngleSun, RadOnTiltedSurf[i].InHourAngleSun);
    connect(Sun.OutDeclinationSun, RadOnTiltedSurf[i].InDeclinationSun);
    connect(deMultiplex.y1[1], RadOnTiltedSurf[i].solarInput2);
    connect(deMultiplex.y2[1], RadOnTiltedSurf[i].solarInput1);
  end for;

  connect(RadOnTiltedSurf.OutTotalRadTilted, SolarRadiation_OrientedSurfaces) annotation(Line(points={{20.8,
          34.8},{50.4,34.8},{50.4,96},{50,96}},                                                                                                    color = {255, 128, 0}));
  annotation(Dialog(group = "Solar radiation on oriented surfaces"), Dialog(tab = "Optional output vector", descriptionLabel = true), Diagram(coordinateSystem(preserveAspectRatio=false,  extent={{-150,
            -100},{150,100}}),                                                                                                    graphics={  Line(points = {{-36, 32}, {-4, 32}}, color = {0, 0, 255}), Line(points = {{-36, 28}, {-4, 28}}, color = {0, 0, 255}), Line(points = {{-36, 24}, {-4, 24}}, color = {0, 0, 255}), Line(points = {{5, 13}, {5, -53}, {-3, -53}}, color = {0, 0, 255}), Line(points = {{15, 14}, {15, -60}, {-3, -60}}, color = {0, 0, 255})}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-150, -100}, {150, 100}}), graphics={  Rectangle(extent = {{-150, 78}, {10, -82}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(
          extent={{-150,78},{10,-72}},
          lineColor={0,0,0},
           pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={170,213,255}),                                                                                                    Ellipse(extent = {{-96, 20}, {-44, -32}}, lineColor = {0, 0, 255},  pattern=LinePattern.None, fillColor = {255, 225, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-150, -22}, {10, -82}}, lineColor = {0, 0, 0},  pattern=LinePattern.None,
            fillPattern =                                                                                                   FillPattern.HorizontalCylinder, fillColor = {0, 127, 0}), Rectangle(extent = {{-150, -54}, {10, -82}}, lineColor = {0, 0, 255},  pattern=LinePattern.None, fillColor = {0, 127, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-126, -32}, {-118, -50}}, lineColor = {0, 0, 0},  pattern=LinePattern.None,
            fillPattern =                                                                                                   FillPattern.VerticalCylinder, fillColor = {180, 90, 0}), Ellipse(extent = {{-134, -12}, {-110, -36}}, lineColor = {0, 0, 0},  pattern=LinePattern.None,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {0, 158, 0}), Polygon(points = {{-126, -50}, {-138, -56}, {-130, -56}, {-118, -50}, {-126, -50}}, lineColor = {0, 0, 0},  pattern=LinePattern.None,
            fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {0, 77, 0}), Ellipse(extent = {{-125, -54}, {-150, -64}}, lineColor = {0, 0, 255},  pattern=LinePattern.None, fillColor = {0, 77, 0},
            fillPattern =                                                                                                   FillPattern.Solid), Ellipse(extent = {{-52, 46}, {-36, 38}}, lineColor = {0, 0, 255},  pattern=LinePattern.None, fillColor = {226, 226, 226},
            fillPattern =                                                                                                   FillPattern.Solid), Ellipse(extent = {{-42, 42}, {-28, 36}}, lineColor = {0, 0, 255},  pattern=LinePattern.None, fillColor = {226, 226, 226},
            fillPattern =                                                                                                   FillPattern.Solid), Ellipse(extent = {{-44, 42}, {-22, 50}}, lineColor = {0, 0, 255},  pattern=LinePattern.None, fillColor = {226, 226, 226},
            fillPattern =                                                                                                   FillPattern.Solid), Ellipse(extent = {{-40, 46}, {-16, 38}}, lineColor = {0, 0, 255},  pattern=LinePattern.None, fillColor = {226, 226, 226},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-12, -10}, {-2, -50}}, lineColor = {0, 0, 0},  pattern=LinePattern.None,
            fillPattern =                                                                                                   FillPattern.VerticalCylinder, fillColor = {226, 226, 226}), Line(points = {{-8, -16}, {-6, -16}}, color = {0, 0, 0}), Line(points = {{-8, -18}, {-6, -18}}, color = {0, 0, 0}), Line(points = {{-8, -28}, {-6, -28}}, color = {0, 0, 0}), Line(points = {{-8, -22}, {-6, -22}}, color = {0, 0, 0}), Line(points = {{-8, -20}, {-6, -20}}, color = {0, 0, 0}), Line(points = {{-8, -26}, {-6, -26}}, color = {0, 0, 0}), Line(points = {{-8, -24}, {-6, -24}}, color = {0, 0, 0}), Line(points = {{-8, -30}, {-6, -30}}, color = {0, 0, 0}), Line(points = {{-8, -32}, {-6, -32}}, color = {0, 0, 0}), Line(points = {{-8, -34}, {-6, -34}}, color = {0, 0, 0}), Line(points = {{-8, -36}, {-6, -36}}, color = {0, 0, 0}), Line(points = {{-8, -38}, {-6, -38}}, color = {0, 0, 0}), Line(points = {{-8, -40}, {-6, -40}}, color = {0, 0, 0}), Line(points = {{-7, -19}, {-7, -47}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-7, -43}, {-7, -47}}, color = {0, 0, 0}, thickness = 1), Text(extent = {{-9, -11}, {-5, -15}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1,
            fillPattern =                                                                                                   FillPattern.VerticalCylinder, fillColor = {226, 226, 226}, textString = "degC"), Text(extent = {{-176, 114}, {24, 74}}, lineColor=
              {0,0,255},
          textString="%name"),                                                                                                    Text(extent = {{12, 122}, {150, 110}}, lineColor = {0, 0, 255}, visible = Cloud_cover, textString = "Cloud cov.",
            horizontalAlignment =                                                                                                   TextAlignment.Right), Text(extent = {{10, 64}, {150, 52}}, lineColor = {0, 0, 255}, visible = Wind_speed, textString = "Wind speed",
            horizontalAlignment =                                                                                                   TextAlignment.Right), Text(extent = {{10, 94}, {150, 82}}, lineColor = {0, 0, 255}, visible = Wind_dir, textString = "Wind dir.",
            horizontalAlignment =                                                                                                   TextAlignment.Right), Text(extent = {{10, 34}, {150, 22}}, lineColor = {0, 0, 255}, visible = Air_temp, textString = "Air temp.",
            horizontalAlignment =                                                                                                   TextAlignment.Right), Text(extent = {{10, 6}, {150, -6}}, lineColor = {0, 0, 255}, visible = Air_press, textString = "Air pressure",
            horizontalAlignment =                                                                                                   TextAlignment.Right), Text(extent = {{10, -26}, {150, -38}}, lineColor = {0, 0, 255}, visible = Mass_frac, textString = "Water in air",
            horizontalAlignment =                                                                                                   TextAlignment.Right), Text(extent = {{10, -54}, {150, -66}}, lineColor = {0, 0, 255}, visible = Rel_hum, textString = "Rel. humidity",
            horizontalAlignment =                                                                                                   TextAlignment.Right), Text(extent = {{10, -84}, {150, -96}}, lineColor = {0, 0, 255}, visible = Sky_rad,
            horizontalAlignment =                                                                                                   TextAlignment.Right, textString = "Sky rad."), Text(extent = {{10, -114}, {150, -126}}, lineColor = {0, 0, 255}, visible = Ter_rad,
            horizontalAlignment =                                                                                                   TextAlignment.Right, textString = "Terrest. rad.")}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Supplies weather data using a TRY - data set. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Input: a TRY data set in an accepted Modelica format (.mat, .txt, with header). The structure should be exactly the one of a TRY, status: TRY 2011.</p>
 <p>Output: </p>
 <ul>
 <li>Total radiation on &quot;n&quot; oriented surfaces</li>
 <li>Cloud cover</li>
 <li>Wind direction</li>
 <li>Wind speed</li>
 <li>Air temperature</li>
 <li>Air pressure</li>
 <li>Mass fraction of water in dry air</li>
 <li>Relative humidity</li>
 <li>Long wave sky radiation on horizontal surface</li>
 <li>Long wave terrestrial radiation from horizontal surface</li>
 </ul>
 <p>The outputs can be supplied individually or in one vector, with the exception of total solar radiation, which are always supplied separately in a vector. </p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <p>Be aware that the calculation of the total solar radiation may cause problems at simulation times close to sunset and sunrise. In this case, change the cut-off angles. refer to model <a href=\"Modelica://AixLib.Building.Components.Weather.BaseClasses.RadOnTiltedSurf\">RadOnTiltedSurf.</a></p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>DWD: TRYHandbuch.2011.DWD,2011</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"Modelica://AixLib.Building.Components.Examples.Weather.WeatherModels\">Examples.Weather.WeatherModels</a> </p>
 </html>", revisions = "<html>
 <ul>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, Rewarded 5*****!</li>
   <li><i>Mai 1, 2012&nbsp;</i>
          by Moritz Lauster and Ana Constantin:<br/>
          Improved beyond belief.</li>
   <li><i>September 12, 2006&nbsp;</i>
          by Timo Haase:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end Weather;
