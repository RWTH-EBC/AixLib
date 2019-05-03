package AixLib

  package BoundaryConditions "Package with models for boundary conditions"
    extends Modelica.Icons.Package;

    package WeatherData "Weather data reader"
      extends Modelica.Icons.VariantsPackage;

      expandable connector Bus "Data bus that stores weather data"
        extends Modelica.Icons.SignalBus;

        annotation (
          defaultComponentName="weaBus",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={Rectangle(
                extent={{-20,2},{22,-2}},
                lineColor={255,204,51},
                lineThickness=0.5)}),
          Documentation(info="<html>
<p>
This component is an expandable connector that is used to implement a bus that contains the weather data.
</p>
</html>",       revisions="<html>
<ul>
<li>
June 25, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
      end Bus;

      package Old "Old weather data reader of AixLib for TRY data"

        package WeatherTRY
          extends Modelica.Icons.Package;

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
 </html>",           revisions = "<html>
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

          package RadiationOnTiltedSurface

            model RadOnTiltedSurf_Liu
              "Calculates solar radiation on tilted surfaces according to Liu"
              extends BaseClasses.PartialRadOnTiltedSurf;

            import Modelica.SIunits.Conversions.from_deg;

              Real InBeamRadHor "beam irradiance on the horizontal surface";
              Real InDiffRadHor "diffuse irradiance on the horizontal surface";

              Real cos_theta;
              Real cos_theta_help;
              Real cos_theta_z;
              Real cos_theta_z_help;
              Real R;
              Real R_help;
              Real term;

            equation
              // calculation of cos_theta_z [Duffie/Beckman, p.15], cos_theta_z is manually cut at 0 (no neg. values)
              cos_theta_z_help = sin(from_deg(InDeclinationSun))*sin(from_deg(
                Latitude)) + cos(from_deg(InDeclinationSun))*cos(from_deg(Latitude))*
                cos(from_deg(InHourAngleSun));
              cos_theta_z = (cos_theta_z_help + abs(cos_theta_z_help))/2;

              // calculation of cos_theta [Duffie/Beckman, p.15], cos_theta is manually cut at 0 (no neg. values)
              term = cos(from_deg(InDeclinationSun))*sin(from_deg(Tilt))*sin(from_deg(
                Azimut))*sin(from_deg(InHourAngleSun));
              cos_theta_help = sin(from_deg(InDeclinationSun))*sin(from_deg(Latitude))
                *cos(from_deg(Tilt)) - sin(from_deg(InDeclinationSun))*cos(from_deg(
                Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut)) + cos(from_deg(
                InDeclinationSun))*cos(from_deg(Latitude))*cos(from_deg(Tilt))*cos(
                from_deg(InHourAngleSun)) + cos(from_deg(InDeclinationSun))*sin(
                from_deg(Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut))*cos(
                from_deg(InHourAngleSun)) + term;
              cos_theta = (cos_theta_help + abs(cos_theta_help))/2;

              // calculation of R factor [Duffie/Beckman, p.25], due to numerical problems (cos_theta_z in denominator)
              // R is manually set to 0 for theta_z >= 80 deg (-> 90 deg means sunset)
              if noEvent(cos_theta_z <= 0.17365) then
                R_help = cos_theta_z*cos_theta;

              else
                R_help = cos_theta/cos_theta_z;

              end if;

              R = R_help;

              // conversion of direct and diffuse horizontal radiation
              if WeatherFormat == 1 then // TRY
                InBeamRadHor = solarInput1;
                InDiffRadHor = solarInput2;
              else  // WeatherFormat == 2 , TMY then
                InBeamRadHor = solarInput1 * cos_theta_z;
                InDiffRadHor = max(solarInput2-InBeamRadHor, 0);
              end if;

              // calculation of total radiation on tilted surface according to model of Liu and Jordan
              // according to [Dissertation Nytsch-Geusen, p.98]
              OutTotalRadTilted.I = max(0, R*InBeamRadHor + 0.5*(1 + cos(from_deg(
                Tilt)))*InDiffRadHor + GroundReflection*(InBeamRadHor + InDiffRadHor)
                *((1 - cos(from_deg(Tilt)))/2));

              // Setting the outputs of direct. diffuse and ground reflection radiation on tilted surface and the angle of incidence
              OutTotalRadTilted.I_dir = R*InBeamRadHor;
              OutTotalRadTilted.I_diff = 0.5*(1 + cos(from_deg(Tilt)))*InDiffRadHor;
              OutTotalRadTilted.I_gr = GroundReflection*(InBeamRadHor + InDiffRadHor)*((1 - cos(from_deg(Tilt)))/2);

              OutTotalRadTilted.AOI = Modelica.Math.acos(cos_theta); // in rad

              annotation (
                Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                      {100,100}}), graphics={
                  Rectangle(
                    extent={{-80,60},{80,-100}},
                    lineColor={0,0,0},
                    fillColor={255,255,255},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-80,60},{80,-100}},
                    lineColor={0,0,0},
                     pattern=LinePattern.None,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={170,213,255}),
                  Ellipse(
                    extent={{14,36},{66,-16}},
                    lineColor={0,0,255},
                     pattern=LinePattern.None,
                    fillColor={255,225,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-80,-40},{80,-100}},
                    lineColor={0,0,0},
                     pattern=LinePattern.None,
                    fillPattern=FillPattern.HorizontalCylinder,
                    fillColor={0,127,0}),
                  Rectangle(
                    extent={{-80,-72},{80,-100}},
                    lineColor={0,0,255},
                     pattern=LinePattern.None,
                    fillColor={0,127,0},
                    fillPattern=FillPattern.Solid),
                  Polygon(
                    points={{-60,-64},{-22,-76},{-22,-32},{-60,-24},{-60,-64}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={226,226,226}),
                  Polygon(
                    points={{-60,-64},{-80,-72},{-80,-100},{-60,-100},{-22,-76},{-60,
                        -64}},
                    lineColor={0,0,0},
                     pattern=LinePattern.None,
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={0,77,0}),
                  Text(
                    extent={{-100,100},{100,60}},
                    lineColor={0,0,255},
                    textString="%name")}),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                        100,100}}),        graphics={
                    Rectangle(
                      extent={{-80,60},{80,-100}},
                      lineColor={0,0,0},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),
                    Rectangle(
                      extent={{-80,60},{80,-100}},
                      lineColor={0,0,0},
                       pattern=LinePattern.None,
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={170,213,255}),
                    Ellipse(
                      extent={{14,36},{66,-16}},
                      lineColor={0,0,255},
                       pattern=LinePattern.None,
                      fillColor={255,225,0},
                      fillPattern=FillPattern.Solid),
                    Rectangle(
                      extent={{-80,-40},{80,-100}},
                      lineColor={0,0,0},
                       pattern=LinePattern.None,
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={0,127,0}),
                    Rectangle(
                      extent={{-80,-72},{80,-100}},
                      lineColor={0,0,255},
                       pattern=LinePattern.None,
                      fillColor={0,127,0},
                      fillPattern=FillPattern.Solid),
                    Polygon(
                      points={{-60,-64},{-22,-76},{-22,-32},{-60,-24},{-60,-64}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.VerticalCylinder,
                      fillColor={226,226,226}),
                    Polygon(
                      points={{-60,-64},{-80,-72},{-80,-100},{-60,-100},{-22,-76},{-60,
                          -64}},
                      lineColor={0,0,0},
                       pattern=LinePattern.None,
                      fillPattern=FillPattern.VerticalCylinder,
                      fillColor={0,77,0})}),
                Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>RadOnTiltedSurf</b> model calculates the total radiance on a tilted surface. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The <b>RadOnTiltedSurf</b> model uses output data of the <b><a href=\"AixLib.Building.Components.Weather.BaseClasses.Sun\">Sun</a></b> model and weather data (beam and diffuse radiance on a horizontal surface for TRY format, or beam normal and global horizontal for TMY format) to compute total radiance on a tilted surface. It needs information on the tilt angle and the azimut angle of the surface, the latitude of the location and the ground reflection coefficient. </p>
<p>The input InDayAngleSun is not explicitly used in the model, but it is part of the partial model and it doesn&apos;t interfere with the calculations. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>The model is checked within the <a href=\"AixLib.Building.Examples.Weather.WeatherModels\">weather</a> example as part of the <a href=\"AixLib.Building.Components.Weather.Weather\">weather</a> model. </p>
</html>",       revisions="<html>
<ul>
  <li><i>March 23, 2015&nbsp;</i> by Ana Constantin:<br/>Adapted solar inputs so it cand work with both TRY and TMY weather format</li>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>March 14, 2005&nbsp;</i>
         by Timo Haase:<br/>
         Implemented.</li>
</ul>
</html>"));
            end RadOnTiltedSurf_Liu;

            package BaseClasses
            extends Modelica.Icons.BasesPackage;

              partial model PartialRadOnTiltedSurf
                parameter Integer WeatherFormat = 1 "Format weather file" annotation (Dialog(group=
                      "Properties of Weather Data",                                                                              compact = true, descriptionLabel = true), choices(choice = 1 "TRY", choice= 2 "TMY", radioButtons = true));
                parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude= 49.5
                  "latitude of location"
                  annotation (Dialog(group="Location Properties"));
                parameter Real GroundReflection=0.2 "ground reflection coefficient"
                  annotation (Dialog(group="Ground reflection"));

                parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Azimut = 13.400
                  "azimut of tilted surface, e.g. 0=south, 90=west, 180=north, -90=east" annotation(Dialog(group="Surface Properties"));
                parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Tilt = 90
                  "tilt of surface, e.g. 0=horizontal surface, 90=vertical surface" annotation (Dialog(group="Surface Properties"));

                  Modelica.Blocks.Interfaces.RealInput InHourAngleSun
                  annotation (Placement(transformation(
                        extent={{-16,-16},{16,16}},
                        origin={-98,0}),
                        iconTransformation(
                        extent={{9,-9},{-9,9}},
                        rotation=180,
                        origin={-79,-41})));
                  Modelica.Blocks.Interfaces.RealInput InDeclinationSun
                  annotation (Placement(transformation(
                        extent={{-16,-16},{16,16}},
                        origin={-98,-40}),
                        iconTransformation(
                        extent={{9,-9},{-9,9}},
                        rotation=180,
                        origin={-79,-61})));
                Modelica.Blocks.Interfaces.RealInput solarInput1
                  "beam horizontal for TRY; beam for TMY" annotation (Placement(
                      transformation(
                      origin={-60,90},
                      extent={{-10,-10},{10,10}},
                      rotation=270), iconTransformation(
                      extent={{-7,-7},{7,7}},
                      rotation=270,
                      origin={-61,73})));
                Modelica.Blocks.Interfaces.RealInput solarInput2
                  "diffuse horizontal for TRY; ground horizontal for TMY" annotation (
                    Placement(transformation(
                      origin={22,90},
                      extent={{-10,-10},{10,10}},
                      rotation=270), iconTransformation(
                      extent={{-7,-7},{7,7}},
                      rotation=270,
                      origin={37,73})));
                Utilities.Interfaces.SolarRad_out   OutTotalRadTilted
                  annotation (Placement(transformation(extent={{80,30},{100,50}})));
            public
                  Modelica.Blocks.Interfaces.RealInput InDayAngleSun
                  annotation (Placement(transformation(
                        extent={{-16,-16},{16,16}},
                        origin={-98,34}),
                        iconTransformation(
                        extent={{9,-9},{-9,9}},
                        rotation=180,
                        origin={-79,-21})));
                annotation ( Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Partial model for <b>RadOnTiltedSurf</b> modely, which calculate the total solar radiance on a tilted surface. </p>
</html>",               revisions="<html>
<ul>
<li><i>March 23, 2015&nbsp;</i> by Ana Constantin:<br/>Implemented. </li>
</ul>
</html>"));
              end PartialRadOnTiltedSurf;
            end BaseClasses;
          end RadiationOnTiltedSurface;

          package BaseClasses
            extends Modelica.Icons.BasesPackage;

            function CalculateNrOfOutputs "Calculates number of outputs"
              input Boolean Cloud_cover "Cloud cover";
              input Boolean Wind_dir "Wind direction";
              input Boolean Wind_speed "Wind speed";
              input Boolean Air_temp "Air temperature";
              input Boolean Air_press "Air pressure";
              input Boolean Mass_frac "Mass fraction of water in dry air";
              input Boolean Rel_hum "Relative humidity";
              input Boolean Sky_rad "Long wave radiation of the sky on horizontal surface";
              input Boolean Ter_rad
                "Long wave terrestrial radiation from horizontal surface";
              output Integer m "Number of Outputs";
            algorithm
              m := 0;
              if Cloud_cover then
                m := m + 1;
              end if;
              if Wind_dir then
                m := m + 1;
              end if;
              if Wind_speed then
                m := m + 1;
              end if;
              if Air_temp then
                m := m + 1;
              end if;
              if Air_press then
                m := m + 1;
              end if;
              if Mass_frac then
                m := m + 1;
              end if;
              if Rel_hum then
                m := m + 1;
              end if;
              if Sky_rad then
                m := m + 1;
              end if;
              if Ter_rad then
                m := m + 1;
              end if;
              annotation(Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Calculates the number of outputs based on the given inputs. </p>
 </html>",             revisions = "<html>
 <ul>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, added descriptions for variables</li>
 </ul>
 </html>"));
            end CalculateNrOfOutputs;

            function DeterminePositionsInWeatherVector
              "Determines position in weather vector"
              input Boolean Cloud_cover "Cloud cover";
              input Boolean Wind_dir "Wind direction";
              input Boolean Wind_speed "Wind speed";
              input Boolean Air_temp "Air temperature";
              input Boolean Air_press "Air pressure";
              input Boolean Mass_frac "Mass fraction of water in dry air";
              input Boolean Rel_hum "Relative humidity";
              input Boolean Sky_rad "Long wave sky radiation on horizontal surface";
              input Boolean Ter_rad
                "Long Wave terrestrial radiation from horizontal surface";
              output Integer[9] PosWV = fill(0, 9)
                "Determined postition in weather data vector";
          protected
              Integer m;
            algorithm
              m := 1;
              if Cloud_cover then
                PosWV[1] := m;
                m := m + 1;
              end if;
              if Wind_dir then
                PosWV[2] := m;
                m := m + 1;
              end if;
              if Wind_speed then
                PosWV[3] := m;
                m := m + 1;
              end if;
              if Air_temp then
                PosWV[4] := m;
                m := m + 1;
              end if;
              if Air_press then
                PosWV[5] := m;
                m := m + 1;
              end if;
              if Mass_frac then
                PosWV[6] := m;
                m := m + 1;
              end if;
              if Rel_hum then
                PosWV[7] := m;
                m := m + 1;
              end if;
              if Sky_rad then
                PosWV[8] := m;
                m := m + 1;
              end if;
              if Ter_rad then
                PosWV[9] := m;
                m := m + 1;
              end if;
              annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, added variable descriptions</li>
 </ul>
 </html>",             info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Determines the position of the given input(s) in the weather vector of the <a href=\"Building.Components.Weather.Weather\">weather</a> model. </p>
 </html>"));
            end DeterminePositionsInWeatherVector;

            model Sun "Computes the sun's altitude of the current site"

            import Modelica.SIunits.Conversions.from_deg;
            import Modelica.SIunits.Conversions.to_deg;
              parameter Real TimeCorrection = 0.5 "for TRY = 0.5, for TMY = 0";
              parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude
                "latitude of location";
              parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Longitude
                "longitude of location in";
              parameter Modelica.SIunits.Conversions.NonSIunits.Time_hour
                DiffWeatherDataTime
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
                Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The model <b>Sun</b> will mainly be used as part of the model <b><a href=\"Modelica://Building.Components.Weather.SunIrradiation\">SunIrradiation</a></b> and in this case as part of the model <b>Weather</b>. The ouput data of the <b>Sun</b> model is yet not very useful itself, but it is most commonly used as input data for e.g. <b><a href=\"RadOnTiltedSurf\">RadOnTiltedSurf</a></b> models to compute the solar radiance according to the azimut of a surface. </p>
<p>Output: The <b>Sun</b> model computes the day angle, hour angle and the declination of the sun for a given set of geographic position and local solar time.</p>
<p>Input: The model needs information on the difference between the local time zone (corresponding to the time basis of the simulation) and UTC (universal time coordinated) in hours.</p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>Be aware that the outputs of this model are only values that are calculated in the middle of the simulation interval and that they are no mean value. The parameter timeCorrection is for setting the calculation time of the outputs to the middle of the simulationi nterval. The variable that depends on the solar time are better approximated when the solar time is calculated for the middle of the hour, for which the horizontal solar radiation is given. For weather data in TRY format it is 0.5 h because the solar radiation values are the average measured values for the previous hours. Set according to the specifications of each weather file format. </p>
</html>",       revisions="<html>
<ul>
  <li><i>December 20, 2012&nbsp;</i>
         by Jerome Feldhaus:<br/>
         new Output variable OutHourAngleSun and renaming from Sun to SunAltitude.</li>
  <li><i>September 29, 2006&nbsp;</i>
         by Peter Matthes:<br/>
         Included ArgACOS variable to protect acos function from arguments &gt; 1. Added protection for some variables.</li>
  <li><i>March 14, 2005&nbsp;</i>
         by Timo Haase:<br/>
         Implemented.</li>
</ul>
</html>"));
            end Sun;
          end BaseClasses;
        end WeatherTRY;
      end Old;
    annotation (preferredView="info",
    Documentation(info="<html>
This package contains models to read weather data. It also contains
the <code>expandable connector</code>
<a href=\"modelica://AixLib.BoundaryConditions.WeatherData.Bus\">
AixLib.BoundaryConditions.WeatherData.Bus</a>
that is used in the library to provide weather data to the different models.
</html>"));
    end WeatherData;
  annotation (preferredView="info",
  Documentation(info="<html>
This package contains models to compute boundary conditions such as weather data.
For models that set boundary conditions for fluid flow systems,
see
<a href=\"modelica://AixLib.Fluid.Sources\">
AixLib.Fluid.Sources</a>.
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
          Ellipse(
          extent={{-76,80},{6,-2}},
          lineColor={255,255,255},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Line(
          points={{32,-24},{76,-82}},
          color={95, 95, 95}),
        Line(
          points={{4,-24},{48,-82}},
          color={95, 95, 95}),
        Line(
          points={{-26,-24},{18,-82}},
          color={95, 95, 95}),
        Line(
          points={{-56,-24},{-12,-82}},
          color={95, 95, 95}),
        Polygon(
          points={{64,6},{50,-2},{40,-18},{70,-24},{78,-52},{26,-52},{-6,-54},{
              -72,-52},{-72,-22},{-52,-10},{-42,10},{-78,34},{-44,52},{40,56},{76,
              40},{64,6}},
          lineColor={150,150,150},
          lineThickness=0.1,
          fillPattern=FillPattern.Sphere,
          smooth=Smooth.Bezier,
          fillColor={150,150,150})}));
  end BoundaryConditions;

  package Controls "Package with models for controls"
    extends Modelica.Icons.Package;

    package Continuous "Package with models for discrete time controls"
      extends Modelica.Icons.Package;

      model PITemp "PI controller that can switch the output range of the controller"

        Modelica.Blocks.Interfaces.RealInput setPoint annotation (Placement(
              transformation(
              origin={-80,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
            Placement(transformation(extent={{-70,-100},{-50,-80}}),
              iconTransformation(extent={{-70,-100},{-50,-80}})));
        parameter Real h = 1 "upper limit controller output" annotation(Dialog(group = "Control"));
        parameter Real l = 0 "lower limit of controller output" annotation(Dialog(group = "Control"));
        parameter Real KR = 1 "Gain" annotation(Dialog(group = "Control"));
        parameter Modelica.SIunits.Time TN = 1 "Time Constant (T>0 required)" annotation(Dialog(group = "Control"));
        Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{80, -10}, {100, 10}}), iconTransformation(extent = {{80, -10}, {100, 10}})));
        parameter Boolean rangeSwitch = false "Switch controller output range";
        Modelica.Blocks.Interfaces.BooleanInput onOff "Switches Controler on and off" annotation(Placement(transformation(extent = {{-120, -80}, {-80, -40}}), iconTransformation(extent = {{-100, -60}, {-80, -40}})));
        Modelica.Blocks.Logical.Switch switch1 annotation(Placement(transformation(extent = {{-40, 6}, {-20, -14}})));
        Modelica.Blocks.Logical.Switch switch2 annotation(Placement(transformation(extent = {{56, -18}, {76, 2}})));
        Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(rising = 0, falling = 60) annotation(Placement(transformation(extent = {{-40, -60}, {-20, -40}})));
        Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent = {{26, -34}, {46, -54}})));
        Modelica.Blocks.Continuous.LimPID PI(k = KR, yMax = if rangeSwitch then -l else h, yMin = if rangeSwitch then -h else l, controllerType = Modelica.Blocks.Types.SimpleController.PI, Ti = TN, Td = 0.1) annotation(Placement(transformation(extent = {{-18, 30}, {2, 50}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(origin = {-60, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      equation
        connect(onOff, switch1.u2) annotation(Line(points = {{-100, -60}, {-80, -60}, {-80, -4}, {-42, -4}}, color = {255, 0, 255}));
        connect(switch2.y, y) annotation(Line(points = {{77, -8}, {79.5, -8}, {79.5, 0}, {90, 0}}, color = {0, 0, 127}));
        connect(onOff, switch2.u2) annotation(Line(points = {{-100, -60}, {-80, -60}, {-80, -30}, {-16, -30}, {-16, -12}, {30, -12}, {30, -8}, {54, -8}}, color = {255, 0, 255}));
        connect(onOff, triggeredTrapezoid.u) annotation(Line(points = {{-100, -60}, {-80, -60}, {-80, -30}, {-50, -30}, {-50, -50}, {-42, -50}}, color = {255, 0, 255}));
        connect(triggeredTrapezoid.y, product.u1) annotation(Line(points = {{-19, -50}, {24, -50}}, color = {0, 0, 127}));
        connect(product.y, switch2.u3) annotation(Line(points = {{47, -44}, {50, -44}, {50, -16}, {54, -16}}, color = {0, 0, 127}));
        connect(switch1.y, PI.u_m) annotation(Line(points = {{-19, -4}, {-8, -4}, {-8, 28}}, color = {0, 0, 127}));
        connect(PI.y, switch2.u1) annotation(Line(points = {{3, 40}, {24, 40}, {24, 0}, {54, 0}}, color = {0, 0, 127}));
        connect(PI.y, product.u2) annotation(Line(points = {{3, 40}, {14, 40}, {14, -38}, {24, -38}}, color = {0, 0, 127}));
        connect(setPoint, PI.u_s)
          annotation (Line(points={{-80,90},{-80,40},{-20,40}}, color={0,0,127}));
        connect(setPoint, switch1.u3) annotation (Line(points={{-80,90},{-80,6},{-42,
                6},{-42,4}}, color={0,0,127}));
        connect(temperatureSensor.port, heatPort)
          annotation (Line(points={{-60,-80},{-60,-90}}, color={191,0,0}));
        connect(temperatureSensor.T, switch1.u1) annotation(Line(points = {{-60, -60}, {-60, -12}, {-42, -12}}, color = {0, 0, 127}));
        annotation (Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>
 Based on a model by Alexander Hoh with some modifications and the Modelica-Standard PI controller. If set to &quot;on&quot; it will controll the thermal port temperature to the target value (soll). If set to &quot;off&quot; the controller error will become zero and therefore the current output level of the PI controller will remain constant. When this switching occurs the TriggeredTrapezoid will level the current controller output down to zero in a selectable period of time.
 </p>
 </html>",       revisions = "<html>
 <ul>
   <li><i>April, 2016&nbsp;</i>
          by Peter Remmen:<br/>
          Moved from Utilities to Controls</li>
 </ul>
 <ul>
 <li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li>
          by Peter Matthes:<br/>
          implemented</li>
 </ul>
 </html> "),       Icon(graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
                  fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}));
      end PITemp;
    annotation (
    preferredView="info", Documentation(info="<html>
This package contains component models for continuous time controls.
For additional models, see also
<a href=\"modelica://Modelica.Blocks.Continuous\">
Modelica.Blocks.Discrete</a>.
</html>"),
    Icon(graphics={Line(
              origin={0.061,4.184},
              points={{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,
                  113.485},{-65.374,-61.217},{-78.061,-78.184}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Continuous;
  annotation (
  preferredView="info", Documentation(info="<html>
This package contains component models for controls.
For additional models, see also
<a href=\"modelica://Modelica.Blocks\">
Modelica.Blocks</a>.
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(
          origin={-51.25,0.0},
          points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(
          origin={51.25,0.0},
          points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
  end Controls;

  package DataBase "Package contains records for the models in the library."
    extends Modelica.Icons.Package;

    package Profiles
    "Profiles for ventilation, set temperatures, internal gains"
      extends Modelica.Icons.Package;

      record ProfileBaseDataDefinition "Base record for one-value time-series profiles"
        extends Modelica.Icons.Record;
        parameter Real[:, :] Profile "First column time";
        annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Profiles are to be understood as useage profiles. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>For example:</p>
 <ul>
 <li>Ventilation schedules</li>
 <li>Schedules for set room temperature</li>
 </ul>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"Modelica.Blocks.Sources.CombiTimeTable\">Modelica.Blocks.Sources.CombiTimeTable</a></p>
 </html>",       revisions = "<html>
 <ul>
 <li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>July 3, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
 </ul>
 </html>"));
      end ProfileBaseDataDefinition;

      record NineToFive
        extends ProfileBaseDataDefinition( Profile= [
        0, 0.0;
        28800, 0.0;
        28800, 1.0;
        61200, 1.0;
        61200, 0.0;
        86400, 0.0]);
      end NineToFive;
      annotation(Documentation(info = "<html>
 <p>Profiles are to be understood as use profiles.</p>
 <p>For example:</p>
 <ul>
 <li>Ventilation schedules</li>
 <li>Schedules for set room temperature</li>
 </ul>
 </html>"));
    end Profiles;

    package SolarElectric

      record PVBaseRecord
          extends Modelica.Icons.Record;
        parameter Modelica.SIunits.Efficiency Eta0(min=0, max=1)
          "Maximum efficiency";
        parameter Modelica.SIunits.LinearTemperatureCoefficient TempCoeff(min=0, max=1)
          "Temperature coeffient";
        parameter Modelica.SIunits.Temp_K NoctTempCell
          "Meassured cell temperature";
        parameter Modelica.SIunits.Temp_K NoctTemp
          "Defined temperature";
        parameter Modelica.SIunits.RadiantEnergyFluenceRate NoctRadiation
          "Defined radiation";
        parameter Modelica.SIunits.Area Area
          "Area of one Panel";

        annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition for photovoltaics </p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>
Record for record used with
<a href=\"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">
AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>",   revisions="<html>
<ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>"));
      end PVBaseRecord;

      record SymphonyEnergySE6M181 "Symphony Energy SE6M60 series "
        extends AixLib.DataBase.SolarElectric.PVBaseRecord(
          Eta0=0.126,
          TempCoeff=0.0043,
          NoctTempCell=46+273.15,
          NoctTemp=25+273.15,
          NoctRadiation=1000,
          Area=1.44);
        annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Polycrystalline Solar Module, single Area=1,44 m2 </p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>
Record for record used with
<a href=\"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">
AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>",   revisions="<html>
<ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>"));
      end SymphonyEnergySE6M181;
    end SolarElectric;

    package Surfaces "Outside surfaces of walls"
      extends Modelica.Icons.Package;

      package RoughnessForHT "Roughness coefficents for heat transfer"
            extends Modelica.Icons.Package;

        record Brick_RoughPlaster
          extends PolynomialCoefficients_ASHRAEHandbook(D = 12.49, E = 4.065, F = 0.028);
          annotation(Documentation(info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Material: Brick, Rough plaster </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"AixLib.Utilities.HeatTransfer.HeatConv_outside\">AixLib.Utilities.HeatTransfer.HeatConv_outside</a></p>
 <p>Source</p>
 <ul>
 <li>ASHRAE Handbook of Fundamentals. ASHRAE, 1989</li>
 <li>As cited inEnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56</li>
 </ul>
</html>",          revisions = "<html>
 <ul>
 <li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>March 21, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
 </ul>
 </html>"));
        end Brick_RoughPlaster;

        record PolynomialCoefficients_ASHRAEHandbook
            extends Modelica.Icons.Record;
          parameter Real D = 11.58;
          parameter Real E = 5.894;
          parameter Real F = 0.0;
          annotation(Documentation(info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Calculate the heat transfer coeficient alpha at outside surfaces depending on wind speed and surface type </p>
 <h4><span style=\"color:#008000\">Assumptions</span></h4>
 <p>Wind direction has no influence </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>alpha = D + E*V + R*V^2</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"AixLib.Utilities.HeatTransfer.HeatConv_outside\">AixLib.Utilities.HeatTransfer.HeatConv_outside</a></p>
 <p>Source</p>
 <ul>
 <li>ASHRAE Handbook of Fundamentals. ASHRAE, 1989</li>
 <li>As cited inEnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56</li>
 </ul>
</html>",          revisions = "<html>
 <ul>
 <li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Awarded stars</li>
 <li><i>March 21, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
 </ul>
 </html>"));
        end PolynomialCoefficients_ASHRAEHandbook;
        annotation (Documentation(info="<html>
</html>"));
      end RoughnessForHT;
    end Surfaces;

    package Walls "Database for different types of walls"
      extends Modelica.Icons.Package;

      record WallBaseDataDefinition "Wall base data definition"
        extends Modelica.Icons.Record;
        // pma 2010-04-28: REMOVED THE BASE DEFINITIONS to get errors thrown when using unparameterised wall models
        parameter Integer n(min = 1) = 3 "Number of wall layers" annotation(Dialog(tab = "Wall 1", group = "Wall 1 parameters"));
        parameter Modelica.SIunits.Length d[n] "Thickness of wall layers" annotation(Dialog(tab = "Wall 1", group = "Layer 1 parameters"));
        parameter Modelica.SIunits.Density rho[n] "Density of wall layers" annotation(Dialog(tab = "Wall 1", group = "Layer 1 parameters"));
        parameter Modelica.SIunits.ThermalConductivity lambda[n]
          "Thermal conductivity of wall layers"                                                        annotation(Dialog(tab = "Wall 1", group = "Wall 1 parameters"));
        parameter Modelica.SIunits.SpecificHeatCapacity c[n]
          "Specific heat capacity of wall layers"                                                    annotation(Dialog(tab = "Wall 1", group = "Wall 1 parameters"));
        parameter Modelica.SIunits.Emissivity eps = 0.95
          "Emissivity of inner wall surface"                                                annotation(Dialog(tab = "Wall 1", group = "Wall 1 parameters"));
        annotation(Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Wall BaseDataDefinition actually doesn&apos;t need predefined values and that is desirable to get errors thrown when using an unparameterised wall in a model. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><font color=\"#008000\">References</font></h4>
 <p>Base data definition for record to be used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 </html>",       revisions = "<html>
 <ul>
 <li><i>September 3, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 </ul>
 </html>"));
      end WallBaseDataDefinition;

      package EnEV2009
        extends Modelica.Icons.Package;

        package Ceiling
          extends Modelica.Icons.Package;

          record CEpartition_EnEV2009_SM_loHalf
            "Ceiling partition after EnEV 2009, for building of type S (schwer) and M (mittel), lower half"
            extends WallBaseDataDefinition(n(min = 1) = 3 "Number of wall layers", d = {0.02, 0.16, 0.015}
                "Thickness of wall layers",                                                                                            rho = {120, 2300, 1200}
                "Density of wall layers",                                                                                                    lambda = {0.045, 2.3, 0.51}
                "Thermal conductivity of wall layers",                                                                                                    c = {1030, 1000, 1000}
                "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
                "Emissivity of inner wall surface");
            annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",           info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
          end CEpartition_EnEV2009_SM_loHalf;
        end Ceiling;

        package Floor
          extends Modelica.Icons.Package;

          record FLground_EnEV2009_SML
            "Floor towards ground after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht)"
            extends WallBaseDataDefinition(n(min = 1) = 4 "Number of wall layers", d = {0.06, 0.25, 0.04, 0.06}
                "Thickness of wall layers",                                                                                                 rho = {140, 2300, 120, 2000}
                "Density of wall layers",                                                                                                    lambda = {0.040, 2.3, 0.035, 1.4}
                "Thermal conductivity of wall layers",                                                                                                    c = {1000, 1000, 1030, 1000}
                "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
                "Emissivity of inner wall surface");
            annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",           info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
          end FLground_EnEV2009_SML;

          record FLpartition_EnEV2009_SM_upHalf
            "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half"
            extends WallBaseDataDefinition(n(min = 1) = 2 "Number of wall layers", d = {0.02, 0.06}
                "Thickness of wall layers",                                                                                     rho = {120, 2000}
                "Density of wall layers",                                                                                                    lambda = {0.045, 1.4}
                "Thermal conductivity of wall layers",                                                                                                    c = {1030, 1000}
                "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
                "Emissivity of inner wall surface");
            annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",           info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
          end FLpartition_EnEV2009_SM_upHalf;
        end Floor;

        package IW
          extends Modelica.Icons.Package;

          record IWload_EnEV2009_M_half
            "Inner wall load-bearing after EnEV 2009, for building of type M (schwer), only half"
            extends WallBaseDataDefinition(n(min = 1) = 2 "Number of wall layers", d = {0.0875, 0.015}
                "Thickness of wall layers",                                                                                        rho = {1000, 1200}
                "Density of wall layers",                                                                                                    lambda = {0.315, 0.51}
                "Thermal conductivity of wall layers",                                                                                                    c = {1000, 1000}
                "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
                "Emissivity of inner wall surface");
            annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",           info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
          end IWload_EnEV2009_M_half;

          record IWsimple_EnEV2009_M_half
            "Inner wall simple after EnEV, for building of type M (mittel), only half"
            extends WallBaseDataDefinition(n(min = 1) = 2 "Number of wall layers", d = {0.0575, 0.015}
                "Thickness of wall layers",                                                                                        rho = {1000, 1200}
                "Density of wall layers",                                                                                                    lambda = {0.315, 0.51}
                "Thermal conductivity of wall layers",                                                                                                    c = {1000, 1000}
                "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
                "Emissivity of inner wall surface");
            annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",           info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
          end IWsimple_EnEV2009_M_half;
        end IW;

        package OW
          extends Modelica.Icons.Package;

          record OW_EnEV2009_M
            "outer wall after EnEV 2009, for building of type M (mittel)"
            extends WallBaseDataDefinition(n(min = 1) = 4 "Number of wall layers", d = {0.05, 0.06, 0.175, 0.015}
                "Thickness of wall layers",                                                                                                  rho = {1800, 120, 350, 1200}
                "Density of wall layers",                                                                                                    lambda = {1, 0.035, 0.11, 0.51}
                "Thermal conductivity of wall layers",                                                                                                    c = {1000, 1030, 1000, 1000}
                "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
                "Emissivity of inner wall surface");
            annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",           info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
          end OW_EnEV2009_M;

          record OW_EnEV2009_S
            "outer wall after EnEV 2009, for building of type S (schwer)"
            extends WallBaseDataDefinition(n(min = 1) = 4 "Number of wall layers", d = {0.05, 0.1, 0.24, 0.015}
                "Thickness of wall layers",                                                                                                 rho = {1800, 120, 1000, 1200}
                "Density of wall layers",                                                                                                    lambda = {1, 0.035, 0.5, 0.51}
                "Thermal conductivity of wall layers",                                                                                                    c = {1000, 1030, 1000, 1000}
                "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
                "Emissivity of inner wall surface");
            annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",           info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009</li>
 </ul>
 </html>"));
          end OW_EnEV2009_S;
        end OW;
      end EnEV2009;
      annotation(Documentation(info = "<html>
 <p><br/>Selectable wall types for easy setup of room configurations. </p>
 </html>"));
    end Walls;

    package Weather "Records describing weather conditions"
      extends Modelica.Icons.Package;

      package SurfaceOrientation "Collection of surface orientation data"
        extends Modelica.Icons.Package;

        record SurfaceOrientationBaseDataDefinition
          extends Modelica.Icons.Record;
          parameter Integer nSurfaces;
          parameter String[nSurfaces] name;
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg[nSurfaces] Azimut;
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg[nSurfaces] Tilt;
          annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Base data definition for the surface orientation</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a></p>
 </html>",         revisions = "<html>
 <ul>
 <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added basic documentation</li>
 </ul>
 </html>
 "));
        end SurfaceOrientationBaseDataDefinition;

        record SurfaceOrientationData_N_E_S_W_Hor
          "North, East, South, West, Horizontal"
          extends SurfaceOrientationBaseDataDefinition(nSurfaces = 5, name = {"N", "O", "S", "W", "Hor"}, Azimut = {180, -90, 0, 90, 0}, Tilt = {90, 90, 90, 90, 0});
          annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Surface Orientation Data for N,E,S and W </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Data in this set: </p>
 <table summary=\"Data\" cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
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
 <p><br/><br/><h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"AixLib.HVAC.Weather.Weather\">AixLib.HVAC.Weather.Weather</a></p>
 </html>",         revisions = "<html>
 <ul>
 <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added basic documentation</li>
 </ul>
 </html>
 "));
        end SurfaceOrientationData_N_E_S_W_Hor;
      end SurfaceOrientation;
    end Weather;

    package WindowsDoors "Windows and doors definition package"
      extends Modelica.Icons.Package;

      package Simple "Collection of simple window records"
        extends Modelica.Icons.Package;

        record OWBaseDataDefinition_Simple
          "Outer window base definition for simple model"
          extends Modelica.Icons.Record;
          parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw = 2.875
            "Thermal transmission coefficient of whole window: glass + frame";
          parameter Real g = 0.8 "coefficient of solar energy transmission";
          parameter Modelica.SIunits.Emissivity Emissivity = 0.84 "Material emissivity";
          parameter Real frameFraction = 0.2
            "frame fraction from total fenestration area";
          annotation(Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Base data definition for simple windows. </p>
 <h4><font color=\"#008000\">References</font></h4>
 <p>Base data definition for record to be used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
 </html>",         revisions = "<html>
 <ul>
 <li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 </ul>
 </html>"));
        end OWBaseDataDefinition_Simple;

        record WindowSimple_EnEV2009 "Window according to EnEV 2009"
          extends OWBaseDataDefinition_Simple(Uw = 1.3, g = 0.6, Emissivity = 0.9, frameFraction = 0.2);
          annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
 <li><i>July 5, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",         info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Window definition according to EnEV 2009 for a simple window. </p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>Record is used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a> </p>
<p>Source: </p>
<ul>
<li>For EnEV see Bundesregierung (Veranst.): Verordnung ueber energiesparenden Waermeschutz und energiesparende Anlagentechnik bei Gebaeuden. Berlin, 2009 </li>
</ul>
</html>"));
        end WindowSimple_EnEV2009;
      end Simple;
      annotation(Documentation(info = "<html>
 Window types as well as shading types.
 <dl>
 <dt><b>Main Author:</b>
 <dd>Peter Matthes<br/>
     RWTH Aachen University<br/>
     E.ON Energy Research Center<br/>
     EBC | Institute for Energy Efficient Buildings and Indoor Climate<br/>
     Mathieustra&szlig;e 6<br/>
     52074 Aachen<br/>
     e-mail: <a href=\"mailto:pmatthes@eonerc.rwth-aachen.de\">pmatthes@eonerc.rwth-aachen.de</a><br/>
 </dl>
 </html>"));
    end WindowsDoors;
    annotation(Icon(graphics={
        Rectangle(extent={{-68,68},{-8,26}}, lineColor={0,0,0}),
        Rectangle(extent={{-68,26},{-8,-20}}, lineColor={0,0,0}),
        Rectangle(extent={{-68,-20},{-8,-62}}, lineColor={0,0,0}),
        Rectangle(extent={{-6,68},{52,26}}, lineColor={0,0,0}),
        Rectangle(extent={{-6,26},{52,-20}}, lineColor={0,0,0}),
        Rectangle(extent={{-6,-20},{52,-62}}, lineColor={0,0,0})}),
                     Diagram, conversion(noneFromVersion = "0.1", noneFromVersion = "1.1", from(version = "2.0", script = "modelica://DataBase/Conversions/ConvertFromDataBase_2.0_To_2.1.mos"), from(version = "2.1", script = "Conversions/ConvertFromDataBase_2.1_To_2.2.mos")), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br/>This package contains records for the models in the library.</p>
 </html>",   revisions = "<html>

 </html>"),   preferedView = "diagram");
  end DataBase;

  package Electrical
  "This package contains models for electric components such as Photovoltaics or Batteries"
    extends Modelica.Icons.Package;

    package PVSystem
      extends Modelica.Icons.Package;

      model PVSystem "PVSystem"
        extends BaseClasses.PartialPVSystem;

        Modelica.Blocks.Interfaces.RealInput TOutside(final quantity=
              "ThermodynamicTemperature", final unit="K") "Ambient temperature"
          annotation (Placement(transformation(extent={{-140,56},{-100,96}}),
              iconTransformation(extent={{-140,56},{-100,96}})));
        AixLib.Utilities.Interfaces.SolarRad_in IcTotalRad
          "Solar radiation in W/m2"
          annotation (Placement(transformation(extent={{-124,-12},{-100,14}}),
              iconTransformation(extent={{-136,-24},{-100,14}})));

        Modelica.Blocks.Sources.RealExpression realExpression(y=IcTotalRad.I)
          annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
      equation

        connect(TOutside, PVModuleDC.T_amb) annotation (Line(points={{-120,76},{-62,
                76},{-62,66},{-15,66}}, color={0,0,127}));
        connect(realExpression.y, PVModuleDC.SolarIrradiationPerSquareMeter)
          annotation (Line(points={{-75,0},{-48,0},{-48,54.4},{-14.6,54.4}}, color={0,
                0,127}));
        annotation (
         Icon(
          coordinateSystem(extent={{-100,-100},{100,100}}),
          graphics={
           Rectangle(
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-100,100},{100,-100}}),
           Text(
            lineColor={0,0,0},
            extent={{-96,95},{97,-97}},
                 textString="PV")}),
           Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                   {100,100}})),
           Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>PV model is based on manufactory data and performance factor including the
NOC</p>
<p><br/>
<b><span style=\"color: #008000;\">Assumptions</span></b></p>
<p>PV model is based on manufactory data and performance factor.</p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>PV system data (DataBase Records) can be found: </p>
<ul>
<li><a href=\"http://www.eks-solar.de/pdfs/aleo_s24.pdf\">eks-solar</a></li>
<li><a href=\"https://www.solarelectricsupply.com/canadian-solar-cs6p-250-solar-panels-117\">solar-electric</a></li>
<li><a href=\"http://www.fl200.com/gourdinne/energie/Datenblatt_Kid_SME_1_Serie_DE.pdf\">schueco</a></li>
<li><a href=\"https://solarco.en.ec21.com/Solar_Module_SE6M60-Series--7320291_7320754.html\">solarco</a></li>
</ul>
<p><br/>
Source of literature for the calculation of the pv cell efficiency: </p>
<p><q>Thermal modelling to analyze the effect of cell temperature on PV
modules energy efficiency</q> by Romary, Florian et al.</p>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.Solar.Electric.Examples.ExamplePV\">AixLib.Fluid.Solar.Electric.Examples.ExamplePV</a></p>
</html>",      revisions="
<html>
<ul>
<li><i>October 20, 2017</i> ,by Larissa Kuehn:<br/>
Implementation of PartialPVSystem.</li>
<li><i>October 11, 2016</i> ,by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>Februar 21, 2013</i> ,by Corinna Leonhardt:<br/>
Implemented </li>
</ul>
</html>

"));
      end PVSystem;

      package BaseClasses
              extends Modelica.Icons.BasesPackage;

        model PVInverterRMS
          "Inverter model including system management"

         parameter Modelica.SIunits.Power uMax2
          "Upper limits of input signals (MaxOutputPower)";
         Modelica.Blocks.Interfaces.RealOutput PVPowerRmsW(
          final quantity="Power",
          final unit="W")
          "Output power of the PV system including the inverter"
          annotation(Placement(
          transformation(extent={{85,70},{105,90}}),
          iconTransformation(
           origin={100,0},
           extent={{-10,-10},{10,10}})));
         Modelica.Blocks.Interfaces.RealInput DCPowerInput(
          final quantity="Power",
          final unit="W")
          "DC output power of PV panels as input for the inverter"
          annotation(Placement(
          transformation(extent={{-80,55},{-40,95}}),
          iconTransformation(extent={{-122,-18},{-82,22}})));
         Modelica.Blocks.Nonlinear.Limiter MaxOutputPower(
           uMax(
            final quantity="Power",
            final displayUnit="Nm/s")=uMax2,
           uMin=0)
           "Limitier for maximum output power"
           annotation(Placement(transformation(extent={{40,70},{60,90}})));
         Modelica.Blocks.Tables.CombiTable1Ds EfficiencyConverterSunnyBoy3800(
           tableOnFile=false,
           table=[0,0.798700;100,0.848907;200,0.899131;250,0.911689;300,0.921732;350,0.929669;400,0.935906;450,0.940718;500,0.943985;550,0.946260;600,0.947839;700,0.950638;800,0.952875;900,0.954431;1000,0.955214;1250,0.956231;1500,0.956449;2000,0.955198;2500,0.952175;3000,0.948659;3500,0.944961;3800,0.942621])
             "Efficiency of the inverter for different operating points"
             annotation(Placement(transformation(extent={{-25,55},{-5,75}})));
         Modelica.Blocks.Math.Product Product2
             "Multiplies the output power of the PV cell with the efficiency of the inverter "
             annotation(Placement(transformation(extent={{10,70},{30,90}})));

        equation
          connect(Product2.u2,EfficiencyConverterSunnyBoy3800.y[1]) annotation(Line(
           points={{8,74},{3,74},{1,74},{1,65},{-4,65}},
           color={0,0,127}));
          connect(Product2.y,MaxOutputPower.u) annotation(Line(
           points={{31,80},{36,80},{33,80},{38,80}},
           color={0,0,127}));
          connect(MaxOutputPower.y,PVPowerRmsW) annotation(Line(
           points={{61,80},{65,80},{90,80},{95,80}},
           color={0,0,127}));
          connect(Product2.u1,DCPowerInput) annotation(Line(
           points={{8,86},{5,86},{-55,86},{-55,75},{-60,75}},
           color={0,0,127}));
          connect(EfficiencyConverterSunnyBoy3800.u,DCPowerInput) annotation(Line(
           points={{-27,65},{-30,65},{-55,65},{-55,75},{-60,75}},
           color={0,0,127}));
            annotation (
           Icon(
            coordinateSystem(extent={{-100,-100},{100,100}}),
            graphics={
             Rectangle(
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-100,100},{100,-100}}),
             Line(
              points={{-50,37},{53,37}},
              color={0,0,0}),
             Line(
              points={{-48,-34},{55,-34}},
              color={0,0,0})}),
           experiment(
            StopTime=1,
            StartTime=0),
             Documentation(revisions="<html>
<ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>Februar 21, 2013  </i>by Corinna Leonhardt:<br/>
Implemented</li>
</ul>
</html>",    info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The<b> PVinverterRMS</b> model represents a simple PV inverter. </p>
<p><br/>
<b><span style=\"color: #008000;\">Concept</span></b></p>
<p>PVinverterRMS&nbsp;with&nbsp;reliable&nbsp;system&nbsp;manager.</p>
</html>"));
        end PVInverterRMS;

        model PVModuleDC "partial model for PV module"

         parameter Modelica.SIunits.Area Area
          "Area of one Panel";
         parameter Modelica.SIunits.Efficiency Eta0
          "Maximum efficiency";
         parameter Modelica.SIunits.Temp_K NoctTemp
          "Defined temperature";
         parameter Modelica.SIunits.Temp_K NoctTempCell
          "Meassured cell temperature";
         parameter Modelica.SIunits.RadiantEnergyFluenceRate NoctRadiation
          "Defined radiation";
         parameter Modelica.SIunits.LinearTemperatureCoefficient TempCoeff
          "Temperature coeffient";
         Modelica.SIunits.Power PowerPV
          "Power of PV panels";
         Modelica.SIunits.Efficiency EtaVar
          "Efficiency of PV cell";
         Modelica.SIunits.Temp_K TCell
          "Cell temperature";

         Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
          final quantity="Power",
          final unit="W")
          "DC output power of PV panels"
          annotation(Placement(
          transformation(extent={{100,70},{120,90}}),
          iconTransformation(extent={{100,-10},{120,10}})));
         Modelica.Blocks.Interfaces.RealInput T_amb(final quantity=
                "ThermodynamicTemperature", final unit="K") "Ambient temperature"
            annotation (Placement(transformation(extent={{-139,40},{-99,80}}),
                iconTransformation(extent={{-140,40},{-100,80}})));

          Modelica.Blocks.Interfaces.RealInput SolarIrradiationPerSquareMeter
           annotation (Placement(
                transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
                  extent={{-132,-72},{-100,-40}})));

        equation
          TCell=T_amb + (NoctTempCell - NoctTemp)*SolarIrradiationPerSquareMeter/
            NoctRadiation;
          PowerPV=SolarIrradiationPerSquareMeter*Area*EtaVar;
          EtaVar=Eta0-TempCoeff*(TCell-NoctTemp)*Eta0;
          DCOutputPower=PowerPV;

          annotation (
           Icon(
            coordinateSystem(extent={{-100,-100},{100,100}}),
            graphics={
             Rectangle(
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-100,100},{100,-100}}),
             Line(
              points={{-3,100},{100,0},{0,-100}},
              color={0,0,0})}),
             Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The <b>PVmoduleDC_TMY3</b> model represents a simple PV cell. </p>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>PV moduleDC has a temperature&nbsp;dependency&nbsp;for&nbsp;efficiency.</p>
</html>",    revisions="<html>
<ul>
<li><i>October 20, 2017 </i>by Larissa K&uuml;hn:<br/>Modification of Input to make the model compatible with diffent weather models</li>
<li><i>October 11, 2016 </i>by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>Februar 21, 2013 </i>by Corinna Leonhardt:<br/>Implemented</li>
</ul>
</html>"),         Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end PVModuleDC;

        partial model PartialPVSystem "Partial model for PV System"

          parameter Integer NumberOfPanels = 1
            "Number of panels";
          parameter AixLib.DataBase.SolarElectric.PVBaseRecord data
            "PV data set"
            annotation (choicesAllMatching=true);
          parameter Modelica.SIunits.Power MaxOutputPower
            "Maximum output power for inverter";
          Modelica.Blocks.Interfaces.RealOutput PVPowerW(
            final quantity="Power",
            final unit="W")
            "Output Power of the PV system including the inverter"
             annotation (Placement(transformation(extent={{100,-10},{120,10}}),
                iconTransformation(extent={{100,-10},{120,10}})));

          BaseClasses.PVModuleDC PVModuleDC(
            final Eta0=data.Eta0,
            final NoctTemp=data.NoctTemp,
            final NoctTempCell=data.NoctTempCell,
            final NoctRadiation=data.NoctRadiation,
            final TempCoeff=data.TempCoeff,
            final Area=NumberOfPanels*data.Area)
            "PV module with temperature dependent efficiency"
            annotation (Placement(transformation(extent={{-13,50},{7,70}})));
          BaseClasses.PVInverterRMS PVInverterRMS(final uMax2=MaxOutputPower)
            "Inverter model including system management"
            annotation (Placement(transformation(extent={{40,0},{60,20}})));
        equation

          connect(PVModuleDC.DCOutputPower, PVInverterRMS.DCPowerInput) annotation (
              Line(points={{8,60},{28,60},{28,10.2},{39.8,10.2}}, color={0,0,127}));
          connect(PVInverterRMS.PVPowerRmsW, PVPowerW) annotation (Line(points={{60,10},
                  {82,10},{82,0},{110,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
             Rectangle(
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              extent={{-100,100},{100,-100}}),
             Text(
              lineColor={0,0,0},
              extent={{-96,95},{97,-97}},
                   textString="PV")}),                                   Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(revisions="<html>
<ul>
<li><i>October 20, 2017 </i> ,by Larissa Kuehn<br/>First implementation</li>
</ul>
</html>"));
        end PartialPVSystem;
      end BaseClasses;
      annotation (Icon(graphics={Polygon(points={{-80,-80},{-40,80},{80,80},{40,-80},
                  {-80,-80}}, lineColor={0,0,0}),
            Line(points={{-60,-76},{-20,76}}, color={0,0,0}),
            Line(points={{-34,-76},{6,76}}, color={0,0,0}),
            Line(points={{-8,-76},{32,76}}, color={0,0,0}),
            Line(points={{16,-76},{56,76}}, color={0,0,0}),
            Line(points={{-38,60},{68,60}}, color={0,0,0}),
            Line(points={{-44,40},{62,40}}, color={0,0,0}),
            Line(points={{-48,20},{58,20}}, color={0,0,0}),
            Line(points={{-54,0},{52,0}}, color={0,0,0}),
            Line(points={{-60,-20},{46,-20}}, color={0,0,0}),
            Line(points={{-64,-40},{42,-40}}, color={0,0,0}),
            Line(points={{-70,-60},{36,-60}}, color={0,0,0})}));
    end PVSystem;
    annotation (
    Documentation(info="<html>
<p>
This library contains electrical components to build up analog and digital circuits,
as well as machines to model electrical motors and generators,
especially three phase induction machines such as an asynchronous motor.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Rectangle(
        origin={20.3125,82.8571},
        extent={{-45.3125,-57.8571},{4.6875,-27.8571}}),
      Line(
        origin={8.0,48.0},
        points={{32.0,-58.0},{72.0,-58.0}}),
      Line(
        origin={9.0,54.0},
        points={{31.0,-49.0},{71.0,-49.0}}),
      Line(
        origin={-2.0,55.0},
        points={{-83.0,-50.0},{-33.0,-50.0}}),
      Line(
        origin={-3.0,45.0},
        points={{-72.0,-55.0},{-42.0,-55.0}}),
      Line(
        origin={1.0,50.0},
        points={{-61.0,-45.0},{-61.0,-10.0},{-26.0,-10.0}}),
      Line(
        origin={7.0,50.0},
        points={{18.0,-10.0},{53.0,-10.0},{53.0,-45.0}}),
      Line(
        origin={6.2593,48.0},
        points={{53.7407,-58.0},{53.7407,-93.0},{-66.2593,-93.0},{-66.2593,-58.0}})}));
  end Electrical;

  package Fluid "Package with models for fluid flow systems"
    extends Modelica.Icons.Package;

    package MixingVolumes "Package with mixing volumes"
      extends Modelica.Icons.VariantsPackage;

      model MixingVolumeMoistAir
        "Mixing volume with heat port for latent heat exchange, to be used if moisture is added or removed"
        extends BaseClasses.PartialMixingVolume(
          dynBal(
            final use_mWat_flow = true,
            final use_C_flow = use_C_flow),
          steBal(final use_mWat_flow = true,
            final use_C_flow = use_C_flow),
          final initialize_p = not Medium.singleState);

        parameter Boolean use_C_flow = false
          "Set to true to enable input connector for trace substance"
          annotation(Evaluate=true, Dialog(tab="Advanced"));

        Modelica.Blocks.Interfaces.RealInput mWat_flow(final quantity="MassFlowRate",
                                                       final unit = "kg/s")
          "Water flow rate added into the medium"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealOutput X_w(final unit="kg/kg")
          "Species composition of medium"
          annotation (Placement(transformation(extent={{100,-60},{140,-20}})));

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
          T(start=T_start))
          "Heat port for sensible plus latent heat exchange with the control volume"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

        Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_flow if use_C_flow
          "Trace substance mass flow rate added to the medium"
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));

    protected
        parameter Real s[Medium.nXi] = {
        if Modelica.Utilities.Strings.isEqual(string1=Medium.substanceNames[i],
                                                  string2="Water",
                                                  caseSensitive=false) then 1 else 0
                                                  for i in 1:Medium.nXi}
          "Vector with zero everywhere except where species is";

        Modelica.Blocks.Sources.RealExpression XLiq(y=s*Xi)
          "Species composition of the medium"
          annotation (Placement(transformation(extent={{72,-52},{94,-28}})));
      equation
        connect(mWat_flow, steBal.mWat_flow) annotation (Line(
            points={{-120,80},{-120,80},{4,80},{4,14},{18,14}},
            color={0,0,127}));
        connect(mWat_flow, dynBal.mWat_flow) annotation (Line(
            points={{-120,80},{-50,80},{52,80},{52,12},{58,12}},
            color={0,0,127}));
        connect(XLiq.y, X_w) annotation (Line(
            points={{95.1,-40},{120,-40}},
            color={0,0,127}));
        connect(heaFloSen.port_a, heatPort)
          annotation (Line(points={{-90,0},{-100,0}}, color={191,0,0}));
        connect(C_flow, steBal.C_flow) annotation (Line(points={{-120,-60},{-80,-60},{
                12,-60},{12,6},{18,6}}, color={0,0,127}));
        connect(C_flow, dynBal.C_flow) annotation (Line(points={{-120,-60},{-52,-60},{
                52,-60},{52,6},{58,6}}, color={0,0,127}));
        annotation (defaultComponentName="vol",
      Documentation(info="<html>
<p>
Model for an ideally mixed fluid volume and the ability
to store mass and energy. The volume is fixed,
and latent and sensible heat can be exchanged.
</p>
<p>
This model represents the same physics as
<a href=\"modelica://AixLib.Fluid.MixingVolumes.MixingVolume\">
AixLib.Fluid.MixingVolumes.MixingVolume</a>, but in addition, it allows
adding or subtracting water to the control volume.
The mass flow rate of the added or subtracted water is
specified at the port <code>mWat_flow</code>.
Adding <code>mWat_flow</code> itself does not affect the energy balance
in this model. Hence, the enthalpy that is added or removed with the
flow of <code>mWat_flow</code> needs to be added to the heat port
<code>heatPort</code>.
</p>
<p>
To increase the numerical robustness of the model, the constant
<code>prescribedHeatFlowRate</code> can be set by the user.
This constant only has an effect if the model has exactly two fluid ports connected,
and if it is used as a steady-state model.
Use the following settings:
</p>
<ul>
<li>Set <code>prescribedHeatFlowRate=true</code> if the <i>only</i> means of heat transfer
at the <code>heatPort</code> is a prescribed heat flow rate that
is <i>not</i> a function of the temperature difference
between the medium and an ambient temperature. Examples include an ideal electrical heater,
a pump that rejects heat into the fluid stream, or a chiller that removes heat based on a performance curve.
If the <code>heatPort</code> is not connected, then set <code>prescribedHeatFlowRate=true</code> as
in this case, <code>heatPort.Q_flow=0</code>.
</li>
<li>Set <code>prescribedHeatFlowRate=false</code> if there is heat flow at the <code>heatPort</code>
computed as <i>K * (T-heatPort.T)</i>, for some temperature <i>T</i> and some conductance <i>K</i>,
which may itself be a function of temperature or mass flow rate.<br/>
If there is a combination of <i>K * (T-heatPort.T)</i> and a prescribed heat flow rate,
for example a solar collector that dissipates heat to the ambient and receives heat from
the solar radiation, then set <code>prescribedHeatFlowRate=false</code>.
</li>
</ul>
<h4>Options</h4>
<p>
The parameter <code>mSenFac</code> can be used to increase the thermal mass of this model
without increasing its volume. This way, species concentrations are still calculated
correctly even though the thermal mass increases. The additional thermal mass is calculated
based on the density and the value of the function <code>HeatCapacityCp</code>
of the medium state <code>state_default</code>. <br/>
This parameter can for instance be useful in a pipe model when the developer wants to
lump the pipe thermal mass to the fluid volume. By default <code>mSenFac = 1</code>, hence
the mass is unchanged. For higher values of <code>mSenFac</code>, the mass will be scaled proportionally.
</p>
<p>
Set the parameter <code>use_C_flow = true</code> to enable an input connector for the trace substance flow rate.
This allows to directly add or subtract trace substances such as
CO2 to the volume.
See
<a href=\"modelica://AixLib.Fluid.Sensors.Examples.PPM\">AixLib.Fluid.Sensors.Examples.PPM</a>
for an example.
</p>
</html>",       revisions="<html>
<ul>
<li>
October 19, 2017, by Michael Wetter:<br/>
Set <code>initialize_p</code> to <code>final</code> so that it does not
appear as a user-selectable parameter. This is done because
<code>initialize_p</code> has been changed from a <code>constant</code>
to a <code>parameter</code> for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1013\">Buildings, issue 1013</a>.
</li>
<li>
April 11, 2017, by Michael Wetter:<br/>
Changed comment of heat port, as this needs to be the total heat flow
rate in order to be able to use this model for modeling steam humidifiers
and adiabatic humidifiers.<br/>
Removed blocks <code>QSen_flow</code> and
<code>QLat_flow</code>.<br/>
This is for issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/704\">Buildings #704</a>.
</li>
<li>
January 22, 2016 by Michael Wetter:<br/>
Removed assignment of <code>sensibleOnly</code> in <code>steBal</code>
as this constant is no longer used.
</li>
<li>
January 19, 2016, by Michael Wetter:<br/>
Updated documentation due to the addition of an input for trace substance
in the mixing volume.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/372\">
issue 372</a>.
</li>
<li>
February 11, 2014 by Michael Wetter:<br/>
Redesigned implementation of latent and sensible heat flow rates
as port of the correction of issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/197\">#197</a>.
</li>
<li>
December 18, 2013 by Michael Wetter:<br/>
Changed computation of <code>s</code> to allow this model to also be used
with <code>AixLib.Media.Water</code>.
</li>
<li>
October 21, 2013 by Michael Wetter:<br/>
Removed dublicate declaration of medium model.
</li>
<li>
September 27, 2013 by Michael Wetter:<br/>
Reformulated assignment of <code>i_w</code> to avoid a warning in OpenModelica.
</li>
<li>
September 17, 2013 by Michael Wetter:<br/>
Changed model to no longer use the obsolete model <code>AixLib.Fluid.MixingVolumes.BaseClasses.PartialMixingVolumeWaterPort</code>.
</li>
<li>
July 30, 2013 by Michael Wetter:<br/>
Changed connector <code>mXi_flow[Medium.nXi]</code>
to a scalar input connector <code>mWat_flow</code>
in the conservation equation model.
The reason is that <code>mXi_flow</code> does not allow
to compute the other components in <code>mX_flow</code> and
therefore leads to an ambiguous use of the model.
By only requesting <code>mWat_flow</code>, the mass balance
and species balance can be implemented correctly.
</li>
<li>
April 18, 2013 by Michael Wetter:<br/>
Removed the use of the deprecated
<code>cardinality</code> function.
Therefore, all input signals must be connected.
</li>
<li>
February 7, 2012 by Michael Wetter:<br/>
Revised base classes for conservation equations in <code>AixLib.Fluid.Interfaces</code>.
</li>
<li>
February 22, by Michael Wetter:<br/>
Improved the code that searches for the index of 'water' in the medium model.
</li>
<li>
May 29, 2010 by Michael Wetter:<br/>
Rewrote computation of index of water substance.
For the old formulation, Dymola 7.4 failed to differentiate the
model when trying to reduce the index of the DAE.
</li>
<li>
August 7, 2008 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end MixingVolumeMoistAir;

      package BaseClasses
      "Package with base classes for AixLib.Fluid.MixingVolumes"
        extends Modelica.Icons.BasesPackage;

        model PartialMixingVolume
          "Partial mixing volume with inlet and outlet ports (flow reversal is allowed)"

          extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
          parameter Boolean initialize_p = not Medium.singleState
            "= true to set up initial equations for pressure"
            annotation(HideResult=true, Evaluate=true, Dialog(tab="Advanced"));

          // We set prescribedHeatFlowRate=false so that the
          // volume works without the user having to set this advanced parameter,
          // but to get high robustness, a user can set it to the appropriate value
          // as described in the info section.
          constant Boolean prescribedHeatFlowRate = false
            "Set to true if the model has a prescribed heat flow at its heatPort. If the heat flow rate at the heatPort is only based on temperature difference, then set to false";

          constant Boolean simplify_mWat_flow = true
            "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero";

          parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
            "Nominal mass flow rate"
            annotation(Dialog(group = "Nominal condition"));
          // Port definitions
          parameter Integer nPorts=0 "Number of ports"
            annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));
          parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
            "Small mass flow rate for regularization of zero flow"
            annotation(Dialog(tab = "Advanced"));
          parameter Boolean allowFlowReversal = true
            "= false to simplify equations, assuming, but not enforcing, no flow reversal. Used only if model has two ports."
            annotation(Dialog(tab="Assumptions"), Evaluate=true);
          parameter Modelica.SIunits.Volume V "Volume";
          Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
              redeclare each package Medium = Medium) "Fluid inlets and outlets"
            annotation (Placement(transformation(extent={{-40,-10},{40,10}},
              origin={0,-100})));

          Medium.Temperature T = Medium.temperature_phX(p=p, h=hOut_internal, X=cat(1,Xi,{1-sum(Xi)}))
            "Temperature of the fluid";
          Modelica.Blocks.Interfaces.RealOutput U(unit="J")
            "Internal energy of the component";
          Modelica.SIunits.Pressure p = if nPorts > 0 then ports[1].p else p_start
            "Pressure of the fluid";
          Modelica.Blocks.Interfaces.RealOutput m(unit="kg") "Mass of the component";
          Modelica.SIunits.MassFraction Xi[Medium.nXi] = XiOut_internal
            "Species concentration of the fluid";
          Modelica.Blocks.Interfaces.RealOutput mXi[Medium.nXi](each unit="kg")
            "Species mass of the component";
          Medium.ExtraProperty C[Medium.nC](nominal=C_nominal) = COut_internal
            "Trace substance mixture content";
          Modelica.Blocks.Interfaces.RealOutput mC[Medium.nC](each unit="kg")
            "Trace substance mass of the component";

      protected
          AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation steBal(
            final simplify_mWat_flow = simplify_mWat_flow,
            redeclare final package Medium=Medium,
            final m_flow_nominal = m_flow_nominal,
            final allowFlowReversal = allowFlowReversal,
            final m_flow_small = m_flow_small,
            final prescribedHeatFlowRate=prescribedHeatFlowRate) if
                 useSteadyStateTwoPort "Model for steady-state balance if nPorts=2"
                annotation (Placement(transformation(extent={{20,0},{40,20}})));
          AixLib.Fluid.Interfaces.ConservationEquation dynBal(
            final simplify_mWat_flow = simplify_mWat_flow,
            redeclare final package Medium = Medium,
            final energyDynamics=energyDynamics,
            final massDynamics=massDynamics,
            final p_start=p_start,
            final T_start=T_start,
            final X_start=X_start,
            final C_start=C_start,
            final C_nominal=C_nominal,
            final fluidVolume = V,
            final initialize_p = initialize_p,
            m(start=V*rho_start),
            nPorts=nPorts,
            final mSenFac=mSenFac) if
                 not useSteadyStateTwoPort "Model for dynamic energy balance"
            annotation (Placement(transformation(extent={{60,0},{80,20}})));

          // Density at start values, used to compute initial values and start guesses
          parameter Modelica.SIunits.Density rho_start=Medium.density(
           state=state_start) "Density, used to compute start and guess values";
          final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
              T=Medium.T_default,
              p=Medium.p_default,
              X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
          // Density at medium default values, used to compute the size of control volumes
          final parameter Modelica.SIunits.Density rho_default=Medium.density(
            state=state_default) "Density, used to compute fluid mass";
          final parameter Medium.ThermodynamicState state_start = Medium.setState_pTX(
              T=T_start,
              p=p_start,
              X=X_start[1:Medium.nXi]) "Medium state at start values";
          // See info section for why prescribedHeatFlowRate is used here.
          // The condition below may only be changed if StaticTwoPortConservationEquation
          // contains a correct solution for all foreseeable parameters/inputs.
          // See Buildings, issue 282 for a discussion.
          final parameter Boolean useSteadyStateTwoPort=(nPorts == 2) and
              (prescribedHeatFlowRate or (not allowFlowReversal)) and (
              energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) and (
              massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) and (
              substanceDynamics == Modelica.Fluid.Types.Dynamics.SteadyState) and (
              traceDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
            "Flag, true if the model has two ports only and uses a steady state balance"
            annotation (Evaluate=true);
          // Outputs that are needed to assign the medium properties
          Modelica.Blocks.Interfaces.RealOutput hOut_internal(unit="J/kg")
            "Internal connector for leaving temperature of the component";
          Modelica.Blocks.Interfaces.RealOutput XiOut_internal[Medium.nXi](each unit="1")
            "Internal connector for leaving species concentration of the component";
          Modelica.Blocks.Interfaces.RealOutput COut_internal[Medium.nC](each unit="1")
            "Internal connector for leaving trace substances of the component";

          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem
            "Port temperature"
            annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
          Modelica.Blocks.Sources.RealExpression portT(y=T) "Port temperature"
            annotation (Placement(transformation(extent={{-10,-10},{-30,10}})));
          Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloSen
            "Heat flow sensor"
            annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
        equation
          ///////////////////////////////////////////////////////////////////////////
          // asserts
          if not allowFlowReversal then
            assert(ports[1].m_flow > -m_flow_small,
        "Model has flow reversal, but the parameter allowFlowReversal is set to false.
  m_flow_small    = "         + String(m_flow_small) + "
  ports[1].m_flow = "         + String(ports[1].m_flow) + "
");       end if;
          // Actual definition of port variables.
          //
          // If the model computes the energy and mass balances as steady-state,
          // and if it has only two ports,
          // then we use the same base class as for all other steady state models.
          if useSteadyStateTwoPort then
          connect(steBal.port_a, ports[1]) annotation (Line(
              points={{20,10},{10,10},{10,-20},{0,-20},{0,-20},{0,-100}},
              color={0,127,255}));

          connect(steBal.port_b, ports[2]) annotation (Line(
              points={{40,10},{46,10},{46,-20},{0,-20},{0,-100}},
              color={0,127,255}));
            U=0;
            mXi=zeros(Medium.nXi);
            m=0;
            mC=zeros(Medium.nC);
            connect(hOut_internal,  steBal.hOut);
            connect(XiOut_internal, steBal.XiOut);
            connect(COut_internal,  steBal.COut);
          else
              connect(dynBal.ports, ports) annotation (Line(
              points={{70,0},{70,-80},{62,-80},{2.22045e-15,-80},{2.22045e-15,-90},{2.22045e-15,
                    -100}},
              color={0,127,255}));
            connect(U,dynBal.UOut);
            connect(mXi,dynBal.mXiOut);
            connect(m,dynBal.mOut);
            connect(mC,dynBal.mCOut);
            connect(hOut_internal,  dynBal.hOut);
            connect(XiOut_internal, dynBal.XiOut);
            connect(COut_internal,  dynBal.COut);
          end if;

          connect(portT.y, preTem.T)
            annotation (Line(points={{-31,0},{-38,0}},   color={0,0,127}));
          connect(heaFloSen.port_b, preTem.port)
            annotation (Line(points={{-70,0},{-65,0},{-60,0}},    color={191,0,0}));
          connect(heaFloSen.Q_flow, steBal.Q_flow) annotation (Line(points={{-80,-10},{
                  -80,-16},{6,-16},{6,18},{18,18}},
                                             color={0,0,127}));
          connect(heaFloSen.Q_flow, dynBal.Q_flow) annotation (Line(points={{-80,-10},{
                  -80,-10},{-80,-16},{6,-16},{6,24},{50,24},{50,16},{58,16}},
                                                                       color={0,0,127}));
          annotation (
        defaultComponentName="vol",
        Documentation(info="<html>
<p>
This is a partial model of an instantaneously mixed volume.
It is used as the base class for all fluid volumes of the package
<a href=\"modelica://AixLib.Fluid.MixingVolumes\">
AixLib.Fluid.MixingVolumes</a>.
</p>


<h4>Typical use and important parameters</h4>
<p>
Set the constant <code>sensibleOnly=true</code> if the model that extends
or instantiates this model sets <code>mWat_flow = 0</code>.
</p>
<p>
Set the constant <code>simplify_mWat_flow = true</code> to simplify the equation
</p>
<pre>
  port_a.m_flow + port_b.m_flow = - mWat_flow;
</pre>
<p>
to
</p>
<pre>
  port_a.m_flow + port_b.m_flow = 0;
</pre>
<p>
This causes an error in the mass balance of about <i>0.5%</i>, but generally leads to
simpler equations because the pressure drop equations are then decoupled from the
mass exchange in this component.
</p>

<p>
To increase the numerical robustness of the model, the constant
<code>prescribedHeatFlowRate</code> can be set by the user.
This constant only has an effect if the model has exactly two fluid ports connected,
and if it is used as a steady-state model.
Use the following settings:
</p>
<ul>
<li>Set <code>prescribedHeatFlowRate=true</code> if the <i>only</i> means of heat transfer
at the <code>heatPort</code> is a prescribed heat flow rate that
is <i>not</i> a function of the temperature difference
between the medium and an ambient temperature. Examples include an ideal electrical heater,
a pump that rejects heat into the fluid stream, or a chiller that removes heat based on a performance curve.
If the <code>heatPort</code> is not connected, then set <code>prescribedHeatFlowRate=true</code> as
in this case, <code>heatPort.Q_flow=0</code>.
</li>
<li>Set <code>prescribedHeatFlowRate=false</code> if there is heat flow at the <code>heatPort</code>
computed as <i>K * (T-heatPort.T)</i>, for some temperature <i>T</i> and some conductance <i>K</i>,
which may itself be a function of temperature or mass flow rate.<br/>
If there is a combination of <i>K * (T-heatPort.T)</i> and a prescribed heat flow rate,
for example a solar collector that dissipates heat to the ambient and receives heat from
the solar radiation, then set <code>prescribedHeatFlowRate=false</code>.
</li>
</ul>
<p>
Set the parameter <code>use_C_flow = true</code> to enable an input connector
for the trace substance flow rate.
</p>
<h4>Implementation</h4>
<p>
If the model is (i) operated in steady-state,
(ii) has two fluid ports connected, and
(iii) <code>prescribedHeatFlowRate=true</code> or <code>allowFlowReversal=false</code>,
then the model uses
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation\">
AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation</a>
in order to use
the same energy and mass balance implementation as is used as in
steady-state component models.
In this situation, the functions <code>inStream</code> are used for the two
flow directions rather than the function
<code>actualStream</code>, which is less efficient.
However, the use of <code>inStream</code> has the disadvantage
that <code>hOut</code> has to be computed, in
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation\">
AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation</a>,
using
</p>
<pre>
if allowFlowReversal then
  hOut = AixLib.Utilities.Math.Functions.regStep(y1=port_b.h_outflow,
                                                    y2=port_a.h_outflow,
                                                    x=port_a.m_flow,
                                                    x_small=m_flow_small/1E3);
else
  hOut = port_b.h_outflow;
end if;
</pre>
<p>
Hence, for <code>allowFlowReversal=true</code>, if <code>hOut</code>
were to be used to compute the temperature that
drives heat transfer such as by conduction,
then the heat transfer would depend on upstream and the <i>downstream</i>
temperatures for small mass flow rates.
This can give wrong results. Consider for example a mass flow rate that is positive
but very close to zero. Suppose the upstream temperature is <i>20</i>&circ;C,
the downstream temperature is <i>10</i>&circ;C, and the heat port is
connected through a heat conductor to a boundary condition of <i>20</i>&circ;C.
Then, <code>hOut = (port_b.h_outflow + port_a.h_outflow)/2</code> and hence
the temperature <code>heatPort.T</code>
is <i>15</i>&circ;C. Therefore, heat is added to the component.
As the mass flow rate is by assumption very small, the fluid that leaves the component
will have a very high temperature, violating the 2nd law.
To avoid this situation, if
<code>prescribedHeatFlowRate=false</code>, then the model
<a href=\"modelica://AixLib.Fluid.Interfaces.ConservationEquation\">
AixLib.Fluid.Interfaces.ConservationEquation</a>
is used instead of
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation\">
AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation</a>.
</p>
<p>
For simple models that uses this model, see
<a href=\"modelica://AixLib.Fluid.MixingVolumes\">
AixLib.Fluid.MixingVolumes</a>.
</p>
</html>",         revisions="<html>
<ul>
<li>
October 19, 2017, by Michael Wetter:<br/>
Changed initialization of pressure from a <code>constant</code> to a <code>parameter</code>.<br/>
Removed <code>partial</code> keyword as this model is not partial.<br/>
Moved <code>C_flow</code> and <code>use_C_flow</code> to child classes.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1013\">Buildings, issue 1013</a>.
</li>
<li>
April 11, 2017, by Michael Wetter:<br/>
Moved heat port to the extending classes to provide better comment.
Otherwise, the mixing volume without water input would have a comment
that says latent heat can be added at this port.<br/>
Removed blocks <code>QSen_flow</code> and
<code>QLat_flow</code>.<br/>
This is for issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/704\">Buildings #704</a>.
</li>
<li>
February 19, 2016 by Filip Jorissen:<br/>
Added outputs U, m, mXi, mC for being able to
check conservation of quantities.
This if or <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/247\">
issue 247</a>.
</li>
<li>
January 22, 2016 by Michael Wetter:<br/>
Updated model to use the new parameter <code>use_mWat_flow</code>
rather than <code>sensibleOnly</code>.
</li>
<li>
January 17, 2016, by Michael Wetter:<br/>
Removed <code>protected</code> block <code>masExc</code> as
this revision introduces a conditional connector for the
moisture flow rate in the energy and mass balance models.
This change was done to use the same modeling concept for the
moisture input as is used for the trace substance input.
</li>
<li>
December 2, 2015, by Filip Jorissen:<br/>
Added conditional input <code>C_flow</code> for
handling trace substance insertions.
</li>
<li>
July 17, 2015, by Michael Wetter:<br/>
Added constant <code>simplify_mWat_flow</code> to remove dependencies of the pressure drop
calculation on the moisture balance.
</li>
<li>
July 1, 2015, by Filip Jorissen:<br/>
Set <code>prescribedHeatFlowRate=prescribedHeatflowRate</code> for
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation\">
AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation</a>.
This results in equations that are solved more easily.
See
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/282\">
issue 282</a> for a discussion.
</li>
<li>
June 9, 2015 by Michael Wetter:<br/>
Set start value for <code>heatPort.T</code> and changed
type of <code>T</code> to <code>Medium.Temperature</code> rather than
<code>Modelica.SIunits.Temperature</code>
to avoid an
error because of conflicting start values if
<code>AixLib.Fluid.Chillers.Carnot_y</code>
is translated using pedantic mode in Dymola 2016.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">#426</a>.
</li>
<li>
June 5, 2015, by Michael Wetter:<br/>
Moved assignment of <code>dynBal.U.start</code>
from instance <code>dynBal</code> to the actual model implementation.
This is required for a pedantic model check in Dymola 2016.
It addresses
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">
issue 266</a>.
</li>
<li>
May 6, 2015, by Michael Wetter:<br/>
Improved documentation and changed the test
<pre>
 final parameter Boolean useSteadyStateTwoPort=(nPorts == 2) and
 prescribedHeatFlowRate and ...
</pre>
to
<pre>
 final parameter Boolean useSteadyStateTwoPort=(nPorts == 2) and
 (prescribedHeatFlowRate or (not allowFlowReversal)) and ...
</pre>
The reason is that if there is no flow reversal, then
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation\">
AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation</a>
computes <code>hOut =  port_b.h_outflow;</code>, and hence
it is correct to use <code>hOut</code> to compute
temperature-driven heat flow, such as by conduction or convection.
See also the model documentation.<br/>
This is for issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/412\">
#412</a>.
</li>
<li>
February 5, 2015, by Michael Wetter:<br/>
Changed <code>initalize_p</code> from a <code>parameter</code> to a
<code>constant</code>. This is only required in finite volume models
of heat exchangers (to avoid consistent but redundant initial conditions)
and hence it should be set as a <code>constant</code>.
</li>
<li>
October 29, 2014, by Michael Wetter:<br/>
Made assignment of <code>mFactor</code> final, and changed computation of
density to use default medium states as are also used to compute the
specific heat capacity.
</li>
<li>
October 21, 2014, by Filip Jorissen:<br/>
Added parameter <code>mFactor</code> to increase the thermal capacity.
</li>
<li>
July 3, 2014, by Michael Wetter:<br/>
Added parameter <code>initialize_p</code>. This is required
to enable the coil models to initialize the pressure in the first
volume, but not in the downstream volumes. Otherwise,
the initial equations will be overdetermined, but consistent.
This change was done to avoid a long information message that appears
when translating models.
</li>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
February 11, 2014 by Michael Wetter:<br/>
Removed <code>Q_flow</code> and added <code>QSen_flow</code>.
This was done to clarify what is sensible and total heat flow rate
as part of the correction of issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/197\">#197</a>.
</li>
<li>
October 8, 2013 by Michael Wetter:<br/>
Removed propagation of <code>show_V_flow</code>
to instance <code>steBal</code> as it has no longer this parameter.
</li>
<li>
September 13, 2013 by Michael Wetter:<br/>
Renamed <code>rho_nominal</code> to <code>rho_start</code>
because this quantity is computed using start values and not
nominal values.
</li>
<li>
April 18, 2013 by Michael Wetter:<br/>
Removed the check of multiple connections to the same element
of a fluid port, as this check required the use of the deprecated
<code>cardinality</code> function.
</li>
<li>
February 7, 2012 by Michael Wetter:<br/>
Revised base classes for conservation equations in <code>AixLib.Fluid.Interfaces</code>.
</li>
<li>
September 17, 2011 by Michael Wetter:<br/>
Removed instance <code>medium</code> as this is already used in <code>dynBal</code>.
Removing the base properties led to 30% faster computing time for a solar thermal system
that contains many fluid volumes.
</li>
<li>
September 13, 2011 by Michael Wetter:<br/>
Changed in declaration of <code>medium</code> the parameter assignment
<code>preferredMediumStates=true</code> to
<code>preferredMediumStates= not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)</code>.
Otherwise, for a steady-state model, Dymola 2012 may differentiate the model to obtain <code>T</code>
as a state. See ticket Dynasim #13596.
</li>
<li>
July 26, 2011 by Michael Wetter:<br/>
Revised model to use new declarations from
<a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">
AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
</li>
<li>
July 14, 2011 by Michael Wetter:<br/>
Added start values for mass and internal energy of dynamic balance
model.
</li>
<li>
May 25, 2011 by Michael Wetter:<br/>
<ul>
<li>
Changed implementation of balance equation. The new implementation uses a different model if
exactly two fluid ports are connected, and in addition, the model is used as a steady-state
component. For this model configuration, the same balance equations are used as were used
for steady-state component models, i.e., instead of <code>actualStream(...)</code>, the
<code>inStream(...)</code> formulation is used.
This changed required the introduction of a new parameter <code>m_flow_nominal</code> which
is used for smoothing in the steady-state balance equations of the model with two fluid ports.
This implementation also simplifies the implementation of
<a href=\"modelica://AixLib.Fluid.MixingVolumes.BaseClasses.PartialMixingVolumeWaterPort\">
AixLib.Fluid.MixingVolumes.BaseClasses.PartialMixingVolumeWaterPort</a>,
which now uses the same equations as this model.
</li>
<li>
Another revision was the removal of the parameter <code>use_HeatTransfer</code> as there is
no noticeable overhead in always having the <code>heatPort</code> connector present.
</li>
</ul>
</li>
<li>
July 30, 2010 by Michael Wetter:<br/>
Added nominal value for <code>mC</code> to avoid wrong trajectory
when concentration is around 1E-7.
See also <a href=\"https://trac.modelica.org/Modelica/ticket/393\">
https://trac.modelica.org/Modelica/ticket/393</a>.
</li>
<li>
February 7, 2010 by Michael Wetter:<br/>
Simplified model and its base classes by removing the port data
and the vessel area.
Eliminated the base class <code>PartialLumpedVessel</code>.
</li>
<li>
October 12, 2009 by Michael Wetter:<br/>
Changed base class to
<a href=\"modelica://AixLib.Fluid.MixingVolumes.BaseClasses.ClosedVolume\">
AixLib.Fluid.MixingVolumes.BaseClasses.ClosedVolume</a>.
</li>
</ul>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                    100}}), graphics={Ellipse(
                  extent={{-100,98},{100,-102}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Sphere,
                  fillColor={170,213,255}), Text(
                  extent={{-58,14},{58,-18}},
                  lineColor={0,0,0},
                  textString="V=%V"),         Text(
                  extent={{-152,100},{148,140}},
                  textString="%name",
                  lineColor={0,0,255})}));
        end PartialMixingVolume;
      annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.MixingVolumes\">AixLib.Fluid.MixingVolumes</a>.
</p>
</html>"));
      end BaseClasses;
    annotation (Documentation(info="<html>
<p>
This package contains models for completely mixed volumes.
</p>
<p>
For most situations, the model
<a href=\"modelica://AixLib.Fluid.MixingVolumes.MixingVolume\">
AixLib.Fluid.MixingVolumes.MixingVolume</a> should be used.
The other models are only of interest if water should be added to
or subtracted from the fluid volume, such as in a
coil with water vapor condensation.
</p>
</html>"));
    end MixingVolumes;

    package Sensors "Package with sensor models"
      extends Modelica.Icons.SensorsPackage;

      model Density "Ideal one port density sensor"
        extends AixLib.Fluid.Sensors.BaseClasses.PartialAbsoluteSensor;
        extends Modelica.Icons.RotationalSensor;
        Modelica.Blocks.Interfaces.RealOutput d(final quantity="Density",
                                                final unit="kg/m3",
                                                min=0) "Density in port medium"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      equation
        d = Medium.density(
             state=Medium.setState_phX(
               p=port.p,
               h=inStream(port.h_outflow),
               X=inStream(port.Xi_outflow)));
      annotation (defaultComponentName="senDen",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={
              Line(points={{0,-70},{0,-100}}, color={0,0,127}),
              Text(
                extent={{-150,80},{150,120}},
                textString="%name",
                lineColor={0,0,255}),
              Text(
                extent={{154,-31},{56,-61}},
                lineColor={0,0,0},
                textString="d"),
              Line(points={{70,0},{100,0}}, color={0,0,127})}),
        Documentation(info="<html>
<p>
This model outputs the density of the fluid connected to its port.
The sensor is ideal, i.e. it does not influence the fluid.
</p>
<p>
Read the
<a href=\"modelica://AixLib.Fluid.Sensors.UsersGuide\">
AixLib.Fluid.Sensors.UsersGuide</a>
prior to using this model with one fluid port.
</p>
</html>",
      revisions="<html>
<ul>
<li>
September 29, 2009, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end Density;

      package BaseClasses "Package with base classes for AixLib.Fluid.Sensors"
        extends Modelica.Icons.BasesPackage;

        partial model PartialAbsoluteSensor
          "Partial component to model a sensor that measures a potential variable"

          replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
            "Medium in the sensor"
            annotation(choicesAllMatching=true);

          Modelica.Fluid.Interfaces.FluidPort_a port(redeclare package Medium=Medium, m_flow(min=0))
            annotation (Placement(transformation(
                origin={0,-100},
                extent={{-10,-10},{10,10}},
                rotation=90)));

        equation
          port.m_flow = 0;
          port.h_outflow = 0;
          port.Xi_outflow = zeros(Medium.nXi);
          port.C_outflow = zeros(Medium.nC);
          annotation (Documentation(info="<html>
<p>
Partial component to model an absolute sensor.
The component can be used for pressure sensor models.
Use for other properties such as temperature or density is discouraged, because the enthalpy at the connector can have different meanings, depending on the connection topology. For these properties, use
<a href=\"modelica://AixLib.Fluid.Sensors.BaseClasses.PartialFlowSensor\">
AixLib.Fluid.Sensors.BaseClasses.PartialFlowSensor</a>.
</p>
</html>",
        revisions="<html>
<ul>
<li>
September 7, 2018, by Michael Wetter:<br/>
Changed
<code>port(redeclare package Medium=Medium, m_flow(min=0, max=0))</code>
to
<code>port(redeclare package Medium=Medium, m_flow(min=0))</code>
to avoid in Dymola 2019FD01 beta1 the message
\"port.m_flow has the range [0,0] - which is suspicious since the max-value should be above the min-value\"
which causes an error in pedantic mode.
Note that the MSL also uses only a <code>min</code> value.
</li>
<li>
March 22, 2017, by Filip Jorissen:<br/>
Set <code>m_flow(max=0)</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/687\">#687</a>.
</li>
<li>
February 12, 2011, by Michael Wetter:<br/>
First implementation.
Implementation is based on <code>Modelica.Fluid</code>.
</li>
</ul>
</html>"));
        end PartialAbsoluteSensor;
      annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.Sensors\">AixLib.Fluid.Sensors</a>.
</p>
</html>"));
      end BaseClasses;
    annotation (preferredView="info",
    Documentation(info="<html>
<p>
Package <code>Sensors</code> consists of idealized sensor components that
provide variables of a medium as
output signals. These signals can be, e.g., further processed
with components of the
<a href=\"modelica://Modelica.Blocks\">
Modelica.Blocks</a>
library.
</p>
</html>", revisions="<html>
<ul>
<li><i>22 Dec 2008</i>
    by R&uuml;diger Franke
    <ul>
    <li>flow sensors based on Modelica.Fluid.Interfaces.PartialTwoPort</li>
    <li>adapted documentation to stream connectors, i.e. less need for two port sensors</li>
    </ul>
</li>
<li><i>4 Dec 2008</i>
    by Michael Wetter<br/>
       included sensors for trace substance</li>
<li><i>31 Oct 2007</i>
    by Carsten Heinrich<br/>
       updated sensor models, included one and two port sensors for thermodynamic state variables</li>
</ul>
</html>"));
    end Sensors;

    package Sources "Package with boundary condition models"
      extends Modelica.Icons.SourcesPackage;

      model MassFlowSource_T
        "Ideal flow source that produces a prescribed mass flow with prescribed temperature, composition and trace substances"
        extends AixLib.Fluid.Sources.BaseClasses.PartialSource_m_flow;
        extends AixLib.Fluid.Sources.BaseClasses.PartialSource_T;
        extends AixLib.Fluid.Sources.BaseClasses.PartialSource_Xi_C;
        annotation (defaultComponentName="boundary",
          Documentation(info="<html>
<p>
Models an ideal flow source, with prescribed values of flow rate, temperature, composition and trace substances:
</p>
<ul>
<li> Prescribed mass flow rate.</li>
<li> Prescribed temperature.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>
If <code>use_m_flow_in</code> is false (default option),
the <code>m_flow</code> parameter
is used as boundary pressure, and the <code>m_flow_in</code>
input connector is disabled; if <code>use_m_flow_in</code>
is true, then the <code>m_flow</code> parameter is ignored,
and the value provided by the input connector is used instead.
</p>
<p>
The same applies to the temperature <i>T</i>, composition <i>X<sub>i</sub></i> or <i>X</i> and trace substances <i>C</i>.
</p>
<h4>Options</h4>
<p>
Instead of using <code>Xi_in</code> (the <i>independent</i> composition fractions),
the advanced tab provides an option for setting all
composition fractions using <code>X_in</code>.
<code>use_X_in</code> and <code>use_Xi_in</code> cannot be used
at the same time.
</p>
<p>
Parameter <code>verifyInputs</code> can be set to <code>true</code>
to enable a check that verifies the validity of the used temperature
and pressures.
This removes the corresponding overhead from the model, which is
a substantial part of the overhead of this model.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/882\">#882</a>
for more information.
</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary flow rate, do not have an effect.
</p>
</html>",
      revisions="<html>
<ul>
<li>
February 2nd, 2018 by Filip Jorissen<br/>
Made <code>medium</code> conditional and refactored inputs.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/882\">#882</a>.
</li>
<li>
April 18, 2017, by Filip Jorissen:<br/>
Changed <code>checkBoundary</code> implementation
such that it is run as an initial equation
when it depends on parameters only.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/728\">#728</a>.
</li>
<li>
January 26, 2016, by Michael Wetter:<br/>
Added <code>unit</code> and <code>quantity</code> attributes.
</li>
<li>
September 29, 2009, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end MassFlowSource_T;

      model Outside
        "Boundary that takes weather data, and optionally trace substances, as an input"
        extends AixLib.Fluid.Sources.BaseClasses.Outside;

      equation
        connect(weaBus.pAtm, p_in_internal);
        connect(weaBus.TDryBul, T_in_internal);
        annotation (defaultComponentName="out",
          Documentation(info="<html>
<p>
This model describes boundary conditions for
pressure, enthalpy, and species concentration that can be obtained
from weather data.
</p>
<p>
To use this model, connect weather data from
<a href=\"modelica://AixLib.BoundaryConditions.WeatherData.ReaderTMY3\">
AixLib.BoundaryConditions.WeatherData.ReaderTMY3</a> to the port
<code>weaBus</code> of this model.
This will cause the medium of this model to be
at the pressure that is obtained from the weather file, and any flow that
leaves this model to be at the temperature and humidity that are obtained
from the weather data.
</p>
<p>If the parameter <code>use_C_in</code> is <code>false</code> (default option),
the <code>C</code> parameter
is used as the trace substance for flow that leaves the component, and the
<code>C_in</code> input connector is disabled; if <code>use_C_in</code> is <code>true</code>,
then the <code>C</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>
Note that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>",
      revisions="<html>
<ul>
<li>
October 26, 2011 by Michael Wetter:<br/>
Introduced new base class to allow implementation of wind pressure for natural ventilation.
</li>
<li>
April 27, 2011 by Michael Wetter:<br/>
Revised implementation to allow medium model that do not have water vapor.
</li>
<li>
Feb. 9, 2011 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end Outside;

      package BaseClasses "Package with base classes for AixLib.Fluid.Sources"
        extends Modelica.Icons.BasesPackage;

        partial model Outside
          "Boundary that takes weather data, and optionally trace substances, as an input"
          extends Modelica.Fluid.Sources.BaseClasses.PartialSource;
          parameter Boolean use_C_in = false
            "Get the trace substances from the input connector"
            annotation(Evaluate=true, HideResult=true);
          parameter Medium.ExtraProperty C[Medium.nC](
            final quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
            "Fixed values of trace substances"
            annotation (Dialog(enable = (not use_C_in) and Medium.nC > 0));

          Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC](
            final quantity=Medium.extraPropertiesNames) if use_C_in
            "Prescribed boundary trace substances"
            annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

          AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
                iconTransformation(extent={{-120,-18},{-80,22}})));
      protected
          final parameter Boolean singleSubstance = (Medium.nX == 1)
            "True if single substance medium";
          AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi if
               not singleSubstance "Block to compute water vapor concentration";

          Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX](
            each final unit="kg/kg",
            final quantity=Medium.substanceNames)
            "Needed to connect to conditional connector";
          Modelica.Blocks.Interfaces.RealInput T_in_internal(final unit="K",
                                                             displayUnit="degC")
            "Needed to connect to conditional connector";
          Modelica.Blocks.Interfaces.RealInput p_in_internal(final unit="Pa")
            "Needed to connect to conditional connector";
          Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC](
               quantity=Medium.extraPropertiesNames)
            "Needed to connect to conditional connector";

        equation
          // Check medium properties
          Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
            Medium.singleState, true, medium.X, "Boundary_pT");

          // Conditional connectors for trace substances
          connect(C_in, C_in_internal);
          if not use_C_in then
            C_in_internal = C;
          end if;
          // Connections to input. This is required to obtain the data from
          // the weather bus in case that the component x_pTphi is conditionally removed
          connect(weaBus.TDryBul, T_in_internal);

          // Connections to compute species concentration
          connect(p_in_internal, x_pTphi.p_in);
          connect(T_in_internal, x_pTphi.T);
          connect(weaBus.relHum, x_pTphi.phi);

          connect(X_in_internal, x_pTphi.X);
          if singleSubstance then
            X_in_internal = ones(Medium.nX);
          end if;
          // Assign medium properties
          medium.p = p_in_internal;
          medium.T = T_in_internal;
          medium.Xi = X_in_internal[1:Medium.nXi];
          ports.C_outflow = fill(C_in_internal, nPorts);
          annotation (
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
                Ellipse(
                  extent={{-98,100},{102,-100}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Sphere,
                  fillColor={0,127,255}),
                Text(
                  extent={{-150,110},{150,150}},
                  textString="%name",
                  lineColor={0,0,255}),
                Line(
                  visible=use_C_in,
                  points={{-100,-80},{-60,-80}},
                  color={0,0,255}),
                Text(
                  visible=use_C_in,
                  extent={{-164,-90},{-62,-130}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="C")}),
            Documentation(info="<html>
<p>
This is the base class for models that describes boundary conditions for
pressure, enthalpy, and species concentration that can be obtained
from weather data, and that may be modified based on the wind pressure.
</p>
<p>If the parameter <code>use_C_in</code> is <code>false</code> (default option),
the <code>C</code> parameter
is used as the trace substance for flow that leaves the component, and the
<code>C_in</code> input connector is disabled; if <code>use_C_in</code> is <code>true</code>,
then the <code>C</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>
Note that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>",
        revisions="<html>
<ul>
<li>
May 30, 2017 by Jianjun Hu:<br/>
Corrected <code>X_in_internal = zeros()</code> to be <code>X_in_internal = ones()</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/787\"> #787</a>.
</li>
<li>
April, 25, 2016 by Marcus Fuchs:<br/>
Introduced missing <code>each</code> keyword. This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/454\"> #454</a>,
to prevent a warning in OpenModelica.
</li>
<li>
January 26, 2016, by Michael Wetter:<br/>
Added <code>unit</code> and <code>quantity</code> attributes.
</li>
<li>
May 30, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
October 26, 2011 by Michael Wetter:<br/>
Introduced new base class to allow implementation of wind pressure for natural ventilation.
</li>
<li>
April 27, 2011 by Michael Wetter:<br/>
Revised implementation to allow medium model that do not have water vapor.
</li>
<li>
Feb. 9, 2011 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
        end Outside;

        partial model PartialSource
          "Partial component source with one fluid connector"

          replaceable package Medium =
              Modelica.Media.Interfaces.PartialMedium
              "Medium model within the source"
             annotation (choicesAllMatching=true);

          parameter Integer nPorts=0 "Number of ports" annotation(Dialog(connectorSizing=true));
          parameter Boolean verifyInputs = false
            "Set to true to stop the simulation with an error if the medium temperature is outside its allowable range"
            annotation(Dialog(tab="Advanced"));

          Modelica.Fluid.Interfaces.FluidPorts_b ports[nPorts](
            redeclare each package Medium = Medium,
            m_flow(each max=if flowDirection == Modelica.Fluid.Types.PortFlowDirection.Leaving
                     then 0 else +Modelica.Constants.inf,
                   each min=if flowDirection == Modelica.Fluid.Types.PortFlowDirection.Entering
                   then 0 else -Modelica.Constants.inf))
            annotation (Placement(transformation(extent={{90,40},{110,-40}})));

      protected
          parameter Modelica.Fluid.Types.PortFlowDirection flowDirection=Modelica.Fluid.Types.PortFlowDirection.Bidirectional
            "Allowed flow direction" annotation (Evaluate=true, Dialog(tab="Advanced"));
          Modelica.Blocks.Interfaces.RealInput p_in_internal(final unit="Pa")
            "Needed to connect to conditional connector";
          Medium.BaseProperties medium if verifyInputs "Medium in the source";
          Modelica.Blocks.Interfaces.RealInput Xi_in_internal[Medium.nXi](
            each final unit = "kg/kg")
            "Needed to connect to conditional connector";
          Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX](
            each final unit = "kg/kg")
            "Needed to connect to conditional connector";
          Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC](
            final quantity=Medium.extraPropertiesNames)
            "Needed to connect to conditional connector";


        initial equation
          // Only one connection allowed to a port to avoid unwanted ideal mixing
          for i in 1:nPorts loop
            assert(cardinality(ports[i]) <= 1,"
Each ports[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place in these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");       end for;

        equation
          connect(medium.p, p_in_internal);

          annotation (defaultComponentName="bou",
          Documentation(info="<html>
<p>
Partial model for a fluid source that either prescribes
pressure or mass flow rate.
Models that extend this partial model need to prescribe the outflowing
specific enthalpy, composition and trace substances.
This partial model only declares the <code>ports</code>
and ensures that the pressures at all ports are equal.
</p>
<h4>Implementation</h4>
<p>
If the parameter <code>verifyInputs</code> is set to <code>true</code>,
then a protected instance of medium base properties is enabled.
This instance verifies that the
medium temperature is within the bounds <code>T_min</code> and <code>T_max</code>,
where <code>T_min</code> and <code>T_max</code> are constants of the <code>Medium</code>.
If the temperature is outside these bounds, the simulation will stop with an error.
</p>
</html>",         revisions="<html>
<ul>
<li>
May 30, 2018, by Michael Wetter:<br/>
Improved documentation.
</li>
<li>
February 2nd, 2018 by Filip Jorissen<br/>
Initial version for refactoring inputs of sources.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/882\">#882</a>.
</li>
</ul>
</html>"));
        end PartialSource;

        model PartialSource_T "Boundary with prescribed temperature"
          extends AixLib.Fluid.Sources.BaseClasses.PartialSource;
          parameter Boolean use_T_in= false
            "Get the temperature from the input connector"
            annotation(Evaluate=true, HideResult=true,Dialog(group="Conditional inputs"));
          parameter Medium.Temperature T = Medium.T_default
            "Fixed value of temperature"
            annotation (Dialog(enable = not use_T_in,group="Fixed inputs"));
          Modelica.Blocks.Interfaces.RealInput T_in(final unit="K",
                                                    displayUnit="degC") if use_T_in
            "Prescribed boundary temperature"
            annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
      protected
          Modelica.Blocks.Interfaces.RealInput T_in_internal(final unit="K",
                                                             displayUnit="degC")
            "Needed to connect to conditional connector";
          Modelica.Blocks.Interfaces.RealInput h_internal = Medium.specificEnthalpy(Medium.setState_pTX(p_in_internal, T_in_internal, X_in_internal));

        equation
          connect(T_in, T_in_internal);
          if not use_T_in then
            T_in_internal = T;
          end if;
          for i in 1:nPorts loop
             ports[i].h_outflow  = h_internal;
          end for;
          connect(medium.h, h_internal);
          annotation (
            Documentation(info="<html>
<p>
Partial model that defines
<code>ports.h_outflow</code> using an optional input for
the temperature.
Otherwise the parameter value is used.
</p>
</html>",
        revisions="<html>
<ul>
<li>
February 2nd, 2018 by Filip Jorissen<br/>
Initial version for refactoring inputs of sources.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/882\">#882</a>.
</li>
</ul>
</html>"),         Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Text(
                  visible=use_T_in,
                  extent={{-162,34},{-60,-6}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="T")}));
        end PartialSource_T;

        partial model PartialSource_Xi_C
          "Partial component source with parameter definitions for Xi and C"
          extends AixLib.Fluid.Sources.BaseClasses.PartialSource;

          parameter Boolean use_X_in = false
            "Get the composition (all fractions) from the input connector"
            annotation(Evaluate=true, HideResult=true, Dialog(tab="Advanced"));
          parameter Boolean use_Xi_in = false
            "Get the composition (independent fractions) from the input connector"
            annotation(Evaluate=true, HideResult=true, Dialog(group="Conditional inputs"));
          parameter Boolean use_C_in = false
            "Get the trace substances from the input connector"
            annotation(Evaluate=true, HideResult=true, Dialog(group="Conditional inputs"));
          parameter Medium.MassFraction X[Medium.nX](
            final quantity=Medium.substanceNames) = Medium.X_default
            "Fixed value of composition"
            annotation (Dialog(enable = (not use_X_in) and Medium.nXi > 0, group="Fixed inputs"));
          parameter Medium.ExtraProperty C[Medium.nC](
            final quantity=Medium.extraPropertiesNames) = fill(0, Medium.nC)
            "Fixed values of trace substances"
            annotation (Dialog(enable = (not use_C_in) and Medium.nC > 0, group="Fixed inputs"));
          Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX](
            each final unit = "kg/kg",
            final quantity=Medium.substanceNames) if use_X_in
            "Prescribed boundary composition"
            annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
          Modelica.Blocks.Interfaces.RealInput Xi_in[Medium.nXi](
            each final unit = "kg/kg",
            final quantity=Medium.substanceNames[1:Medium.nXi]) if use_Xi_in
            "Prescribed boundary composition"
            annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
          Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC](
            final quantity=Medium.extraPropertiesNames) if use_C_in
            "Prescribed boundary trace substances"
            annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

        initial equation
          assert(not use_X_in or not use_Xi_in,
            "Cannot use both X and Xi inputs, choose either use_X_in or use_Xi_in.");

          if not use_X_in and not use_Xi_in then
            Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
              Medium.singleState, true, X_in_internal, "Boundary_pT");
          end if;

        equation
          if use_X_in or use_Xi_in then
            Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
              Medium.singleState, true, X_in_internal, "Boundary_pT");
          end if;
          connect(X_in[1:Medium.nXi], Xi_in_internal);
          connect(X_in,X_in_internal);
          connect(Xi_in, Xi_in_internal);
          connect(C_in, C_in_internal);

          connect(medium.Xi, Xi_in_internal);
          if not use_X_in and not use_Xi_in then
            Xi_in_internal = X[1:Medium.nXi];
          end if;
          if not use_X_in then
            X_in_internal[1:Medium.nXi] = Xi_in_internal[1:Medium.nXi];
            X_in_internal[Medium.nX] = 1-sum(X_in_internal[1:Medium.nXi]);
          end if;
          if not use_C_in then
            C_in_internal = C;
          end if;

          for i in 1:nPorts loop
            ports[i].Xi_outflow = Xi_in_internal;
            ports[i].C_outflow = C_in_internal;
          end for;


          annotation (defaultComponentName="boundary",
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Text(
                  visible=use_X_in,
                  extent={{-164,4},{-62,-36}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="X"),
                Text(
                  visible=use_Xi_in,
                  extent={{-164,4},{-62,-36}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="Xi"),
                Text(
                  visible=use_C_in,
                  extent={{-164,-90},{-62,-130}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="C")}),
                  Documentation(info="<html>
<p>
Partial model that defines outflowing properties
<code>ports.Xi_outflow</code> and <code>ports.C_outflow</code>
using an optional input for both.
Otherwise the parameter value is used.
</p>
</html>",         revisions="<html>
<ul>
<li>
February 13, 2018, by Michael Wetter:<br/>
Corrected error in quantity assignment for <code>Xi_in</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/882\">#882</a>.
</li>
<li>
February 2nd, 2018 by Filip Jorissen<br/>
Initial version for refactoring inputs of sources.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/882\">#882</a>.
</li>
</ul>
</html>"));
        end PartialSource_Xi_C;

        model PartialSource_m_flow "Partial source with prescribed flow rate"
          extends AixLib.Fluid.Sources.BaseClasses.PartialSource;
          parameter Boolean use_m_flow_in = false
            "Get the mass flow rate from the input connector"
            annotation(Evaluate=true, HideResult=true, Dialog(group="Conditional inputs"));
          parameter Modelica.SIunits.MassFlowRate m_flow = 0
            "Fixed mass flow rate going out of the fluid port"
            annotation (Dialog(enable = not use_m_flow_in,group="Fixed inputs"));
          Modelica.Blocks.Interfaces.RealInput m_flow_in(final unit="kg/s") if use_m_flow_in
            "Prescribed mass flow rate"
            annotation (Placement(transformation(extent={{-140,60},{-100,100}}),iconTransformation(extent={{-140,60},
                    {-100,100}})));
      protected
          Modelica.Blocks.Interfaces.RealInput m_flow_in_internal(final unit="kg/s")
            "Needed to connect to conditional connector";
        equation
          connect(m_flow_in, m_flow_in_internal);
          if not use_m_flow_in then
            m_flow_in_internal = m_flow;
          end if;
          for i in 1:nPorts loop
            ports[i].p = p_in_internal;
          end for;
          sum(ports.m_flow) = -m_flow_in_internal;

          annotation (Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={1,1}), graphics={
                Rectangle(
                  extent={{35,45},{100,-45}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={0,127,255}),
                Ellipse(
                  extent={{-100,80},{60,-80}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-60,70},{60,0},{-60,-68},{-60,70}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  visible=use_m_flow_in,
                  extent={{-185,132},{-45,100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="m_flow"),
                Text(
                  extent={{-54,32},{16,-30}},
                  lineColor={255,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="m"),
                Text(
                  extent={{-150,130},{150,170}},
                  textString="%name",
                  lineColor={0,0,255}),
                Ellipse(
                  extent={{-26,30},{-18,22}},
                  lineColor={255,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid)}),
              Documentation(revisions="<html>
<ul>
<li>
February 2nd, 2018 by Filip Jorissen<br/>
Initial version for refactoring inputs of sources.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/882\">#882</a>.
</li>
</ul>
</html>",         info="<html>
<p>
Partial model that defines the <i>sum</i> of
<code>ports.m_flow</code> using an optional input for
the total mass flow rate.
All port pressures are assumed equal.
Otherwise the parameter value is used.
</p>
</html>"));
        end PartialSource_m_flow;
      annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.Sources\">AixLib.Fluid.Sources</a>.
</p>
</html>"));
      end BaseClasses;
    annotation (preferredView="info",
    Documentation(info="<html>
<p>
Package <b>Sources</b> contains generic sources for fluid connectors
to define fixed or prescribed ambient conditions.
</p>
</html>"));
    end Sources;

    package Interfaces "Package with interfaces for fluid models"
      extends Modelica.Icons.InterfacesPackage;

      model ConservationEquation "Lumped volume with mass and energy balance"

        extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

        // Constants
        parameter Boolean initialize_p = not Medium.singleState
          "= true to set up initial equations for pressure"
          annotation(HideResult=true, Evaluate=true, Dialog(tab="Advanced"));

        constant Boolean simplify_mWat_flow = true
          "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero. Used only if Medium.nX > 1";

        // Port definitions
        parameter Integer nPorts=0 "Number of ports"
          annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));

        parameter Boolean use_mWat_flow = false
          "Set to true to enable input connector for moisture mass flow rate"
          annotation(Evaluate=true, Dialog(tab="Advanced"));
        parameter Boolean use_C_flow = false
          "Set to true to enable input connector for trace substance"
          annotation(Evaluate=true, Dialog(tab="Advanced"));

        Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
          "Sensible plus latent heat flow rate transferred into the medium"
          annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
        Modelica.Blocks.Interfaces.RealInput mWat_flow(final quantity="MassFlowRate",
                                                       unit="kg/s") if
             use_mWat_flow "Moisture mass flow rate added to the medium"
          annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
        Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_flow if
             use_C_flow "Trace substance mass flow rate added to the medium"
          annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

        // Outputs that are needed in models that use this model
        Modelica.Blocks.Interfaces.RealOutput hOut(unit="J/kg",
                                                   start=hStart)
          "Leaving specific enthalpy of the component"
           annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,110})));
        Modelica.Blocks.Interfaces.RealOutput XiOut[Medium.nXi](each unit="1",
                                                                each min=0,
                                                                each max=1)
          "Leaving species concentration of the component"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,110})));
        Modelica.Blocks.Interfaces.RealOutput COut[Medium.nC](each min=0)
          "Leaving trace substances of the component"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,110})));
        Modelica.Blocks.Interfaces.RealOutput UOut(unit="J")
          "Internal energy of the component" annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={110,20})));
        Modelica.Blocks.Interfaces.RealOutput mXiOut[Medium.nXi](each min=0, each unit=
             "kg") "Species mass of the component"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              origin={110,-20})));
        Modelica.Blocks.Interfaces.RealOutput mOut(min=0, unit="kg")
          "Mass of the component" annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={110,60})));
        Modelica.Blocks.Interfaces.RealOutput mCOut[Medium.nC](each min=0, each unit="kg")
          "Trace substance mass of the component"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              origin={110,-60})));

        Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
            redeclare each final package Medium = Medium) "Fluid inlets and outlets"
          annotation (Placement(transformation(extent={{-40,-10},{40,10}},
            origin={0,-100})));

        // Set nominal attributes where literal values can be used.
        Medium.BaseProperties medium(
          p(start=p_start),
          h(start=hStart),
          T(start=T_start),
          Xi(start=X_start[1:Medium.nXi]),
          X(start=X_start),
          d(start=rho_start)) "Medium properties";

        Modelica.SIunits.Energy U(start=fluidVolume*rho_start*
          Medium.specificInternalEnergy(Medium.setState_pTX(
           T=T_start,
           p=p_start,
           X=X_start[1:Medium.nXi])) +
          (T_start - Medium.reference_T)*CSen,
          nominal = 1E5) "Internal energy of fluid";

        Modelica.SIunits.Mass m(
          start=fluidVolume*rho_start,
          stateSelect=if massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState
          then StateSelect.default else StateSelect.prefer)
          "Mass of fluid";

        Modelica.SIunits.Mass[Medium.nXi] mXi(
          start=fluidVolume*rho_start*X_start[1:Medium.nXi])
          "Masses of independent components in the fluid";
        Modelica.SIunits.Mass[Medium.nC] mC(
          start=fluidVolume*rho_start*C_start)
          "Masses of trace substances in the fluid";
        // C need to be added here because unlike for Xi, which has medium.Xi,
        // there is no variable medium.C
        Medium.ExtraProperty C[Medium.nC](nominal=C_nominal)
          "Trace substance mixture content";

        Modelica.SIunits.MassFlowRate mb_flow "Mass flows across boundaries";
        Modelica.SIunits.MassFlowRate[Medium.nXi] mbXi_flow
          "Substance mass flows across boundaries";
        Medium.ExtraPropertyFlowRate[Medium.nC] mbC_flow
          "Trace substance mass flows across boundaries";
        Modelica.SIunits.EnthalpyFlowRate Hb_flow
          "Enthalpy flow across boundaries or energy source/sink";

        // Parameters that need to be defined by an extending class
        parameter Modelica.SIunits.Volume fluidVolume "Volume";
        final parameter Modelica.SIunits.HeatCapacity CSen=
          (mSenFac - 1)*rho_default*cp_default*fluidVolume
          "Aditional heat capacity for implementing mFactor";
    protected
        Medium.EnthalpyFlowRate ports_H_flow[nPorts];
        Modelica.SIunits.MassFlowRate ports_mXi_flow[nPorts,Medium.nXi];
        Medium.ExtraPropertyFlowRate ports_mC_flow[nPorts,Medium.nC];
        parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
        Medium.specificHeatCapacityCp(state=state_default)
          "Heat capacity, to compute additional dry mass";
        parameter Modelica.SIunits.Density rho_start=Medium.density(
         Medium.setState_pTX(
           T=T_start,
           p=p_start,
           X=X_start[1:Medium.nXi])) "Density, used to compute fluid mass";

        // Parameter for avoiding extra overhead calculations when CSen==0
        final parameter Boolean computeCSen = CSen > Modelica.Constants.eps
          annotation(Evaluate=true);
        final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
            T=Medium.T_default,
            p=Medium.p_default,
            X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
        // Density at medium default values, used to compute the size of control volumes
        final parameter Modelica.SIunits.Density rho_default=Medium.density(
          state=state_default) "Density, used to compute fluid mass";
        // Parameter that is used to construct the vector mXi_flow
        final parameter Real s[Medium.nXi] = {if Modelica.Utilities.Strings.isEqual(
                                                  string1=Medium.substanceNames[i],
                                                  string2="Water",
                                                  caseSensitive=false)
                                                  then 1 else 0 for i in 1:Medium.nXi}
          "Vector with zero everywhere except where species is";
        parameter Modelica.SIunits.SpecificEnthalpy hStart=
          Medium.specificEnthalpy_pTX(p_start, T_start, X_start)
          "Start value for specific enthalpy";

        // Set _simplify_mWat_flow == false for Glycol47; otherwise Dymola 2018FD01
        // cannot differentiate the equations.
        constant Boolean _simplify_mWat_flow = simplify_mWat_flow and Medium.nX > 1
         "If true, then port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero, and equations are simplified";

        // Conditional connectors
        Modelica.Blocks.Interfaces.RealInput mWat_flow_internal(unit="kg/s")
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput C_flow_internal[Medium.nC]
          "Needed to connect to conditional connector";

      initial equation
        // Assert that the substance with name 'water' has been found.
        assert(Medium.nXi == 0 or abs(sum(s)-1) < 1e-5,
            "If Medium.nXi > 1, then substance 'water' must be present for one component.'"
               + Medium.mediumName + "'.\n"
               + "Check medium model.");

        // Make sure that if energyDynamics is SteadyState, then
        // massDynamics is also SteadyState.
        // Otherwise, the system of ordinary differential equations may be inconsistent.
        if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
          assert(massDynamics == energyDynamics, "
         If 'massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState', then it is
         required that 'energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState'.
         Otherwise, the system of equations may not be consistent.
         You need to select other parameter values.");
        end if;

        // initialization of balances
        if energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
            medium.T = T_start;
        else
          if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
              der(medium.T) = 0;
          end if;
        end if;

        if massDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
          if initialize_p then
            medium.p = p_start;
          end if;
        else
          if massDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
            if initialize_p then
              der(medium.p) = 0;
            end if;
          end if;
        end if;

        if substanceDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
          medium.Xi = X_start[1:Medium.nXi];
        else
          if substanceDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
            der(medium.Xi) = zeros(Medium.nXi);
          end if;
        end if;

        if traceDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
          C = C_start[1:Medium.nC];
        else
          if traceDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
            der(C) = zeros(Medium.nC);
          end if;
        end if;

      equation
        // Conditional connectors
        connect(mWat_flow, mWat_flow_internal);
        if not use_mWat_flow then
          mWat_flow_internal = 0;
        end if;

        connect(C_flow, C_flow_internal);
        if not use_C_flow then
          C_flow_internal = zeros(Medium.nC);
        end if;

        // Total quantities
        if massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
          m = fluidVolume*rho_start;
        else
          if _simplify_mWat_flow then
            // If moisture is neglected in mass balance, assume for computation
            // of the mass of air that the air is at Medium.X_default.
            m = fluidVolume*Medium.density(Medium.setState_phX(
              p = medium.p,
              h = hOut,
              X = Medium.X_default));
          else
            // Use actual density
            m = fluidVolume*medium.d;
          end if;
        end if;
        mXi = m*medium.Xi;
        if computeCSen then
          U = m*medium.u + CSen*(medium.T-Medium.reference_T);
        else
          U = m*medium.u;
        end if;
        mC = m*C;

        hOut = medium.h;
        XiOut = medium.Xi;
        COut = C;

        for i in 1:nPorts loop
          //The semiLinear function should be used for the equations below
          //for allowing min/max simplifications.
          //See https://github.com/ibpsa/modelica-ibpsa/issues/216 for a discussion and motivation
          ports_H_flow[i]     = semiLinear(ports[i].m_flow, inStream(ports[i].h_outflow), ports[i].h_outflow)
            "Enthalpy flow";
          for j in 1:Medium.nXi loop
            ports_mXi_flow[i,j] = semiLinear(ports[i].m_flow, inStream(ports[i].Xi_outflow[j]), ports[i].Xi_outflow[j])
              "Component mass flow";
          end for;
          for j in 1:Medium.nC loop
            ports_mC_flow[i,j]  = semiLinear(ports[i].m_flow, inStream(ports[i].C_outflow[j]),  ports[i].C_outflow[j])
              "Trace substance mass flow";
          end for;
        end for;

        for i in 1:Medium.nXi loop
          mbXi_flow[i] = sum(ports_mXi_flow[:,i]);
        end for;

        for i in 1:Medium.nC loop
          mbC_flow[i]  = sum(ports_mC_flow[:,i]);
        end for;

        mb_flow = sum(ports.m_flow);
        Hb_flow = sum(ports_H_flow);

        // Energy and mass balances
        if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
          0 = Hb_flow + Q_flow;
        else
          der(U) = Hb_flow + Q_flow;
        end if;

        if massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
          0 = mb_flow + (if simplify_mWat_flow then 0 else mWat_flow_internal);
        else
          der(m) = mb_flow + (if simplify_mWat_flow then 0 else mWat_flow_internal);
        end if;

        if substanceDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
          zeros(Medium.nXi) = mbXi_flow + mWat_flow_internal * s;
        else
          der(mXi) = mbXi_flow + mWat_flow_internal * s;
        end if;

        if traceDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
          zeros(Medium.nC)  = mbC_flow + C_flow_internal;
        else
          der(mC)  = mbC_flow + C_flow_internal;
        end if;

        // Properties of outgoing flows
        for i in 1:nPorts loop
            ports[i].p          = medium.p;
            ports[i].h_outflow  = medium.h;
            ports[i].Xi_outflow = medium.Xi;
            ports[i].C_outflow  = C;
        end for;
        UOut=U;
        mXiOut=mXi;
        mOut=m;
        mCOut=mC;
        annotation (
          Documentation(info="<html>
<p>
Basic model for an ideally mixed fluid volume with the ability to store mass and energy.
It implements a dynamic or a steady-state conservation equation for energy and mass fractions.
The model has zero pressure drop between its ports.
</p>
<p>
If the constant <code>simplify_mWat_flow = true</code> then adding
moisture does not increase the mass of the volume or the leaving mass flow rate.
It does however change the mass fraction <code>medium.Xi</code>.
This allows to decouple the moisture balance from the pressure drop equations.
If <code>simplify_mWat_flow = false</code>, then
the outlet mass flow rate is
<i>m<sub>out</sub> = m<sub>in</sub>  (1 + &Delta; X<sub>w</sub>)</i>,
where
<i>&Delta; X<sub>w</sub></i> is the change in water vapor mass
fraction across the component. In this case,
this component couples
the energy calculation to the
pressure drop versus mass flow rate calculations.
However, in typical building HVAC systems,
<i>&Delta; X<sub>w</sub></i> &lt; <i>0.005</i> kg/kg.
Hence, by tolerating a relative error of <i>0.005</i> in the mass balance,
one can decouple these equations.
Decoupling these equations avoids having
to compute the energy balance of the humidifier
and its upstream components when solving for the
pressure drop of downstream components.
Therefore, the default value is <code>simplify_mWat_flow = true</code>.
</p>
<h4>Typical use and important parameters</h4>
<p>
Set the parameter <code>use_mWat_flow_in=true</code> to enable an
input connector for <code>mWat_flow</code>.
Otherwise, the model uses <code>mWat_flow = 0</code>.
</p>
<p>
If the constant <code>simplify_mWat_flow = true</code>, which is its default value,
then the equation
</p>
<pre>
  port_a.m_flow + port_b.m_flow = - mWat_flow;
</pre>
<p>
is simplified as
</p>
<pre>
  port_a.m_flow + port_b.m_flow = 0;
</pre>
<p>
This causes an error in the mass balance of about <i>0.5%</i>, but generally leads to
simpler equations because the pressure drop equations are then decoupled from the
mass exchange in this component.
The model
<a href=\"modelica://AixLib.Fluid.MixingVolumes.Validation.MixingVolumeAdiabaticCooling\">
AixLib.Fluid.MixingVolumes.Validation.MixingVolumeAdiabaticCooling</a>
shows that the relative error on the temperature difference between these
two options of <code>simplify_mWat_flow</code> is less than
<i>0.1%</i>.
</p>

<h4>Implementation</h4>
<p>
When extending or instantiating this model, the input
<code>fluidVolume</code>, which is the actual volume occupied by the fluid,
needs to be assigned.
For most components, this can be set to a parameter.
</p>
Input connectors of the model are
<ul>
<li>
<code>Q_flow</code>, which is the sensible plus latent heat flow rate added to the medium,
</li>
<li>
<code>mWat_flow</code>, which is the moisture mass flow rate added to the medium, and
</li>
<li>
<code>C_flow</code>, which is the trace substance mass flow rate added to the medium.
</li>
</ul>

<p>
The model can be used as a dynamic model or as a steady-state model.
However, for a steady-state model with exactly two fluid ports connected,
the model
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation\">
AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation</a>
provides a more efficient implementation.
</p>
<p>
For a model that instantiates this model, see
<a href=\"modelica://AixLib.Fluid.MixingVolumes.MixingVolume\">
AixLib.Fluid.MixingVolumes.MixingVolume</a>.
</p>
</html>",       revisions="<html>
<ul>
<li>
April 16, 2018, by Michael Wetter:<br/>
Reformulated mass calculation so that Dymola can differentiate the equations.<br/>
This is for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/910\">AixLib, issue 910</a>.
</li>
<li>
November 3, 2017, by Michael Wetter:<br/>
Set <code>start</code> attributes.<br/>
This is for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/727\">727</a>.
</li>
<li>
October 19, 2017, by Michael Wetter:<br/>
Changed initialization of pressure from a <code>constant</code> to a <code>parameter</code>.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1013\">Buildings, issue 1013</a>.
</li>
<li>
January 27, 2017, by Michael Wetter:<br/>
Added <code>stateSelect</code> for mass <code>m</code>.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/642\">
Buildings, #642</a>.
</li>
<li>
December 22, 2016, by Michael Wetter:<br/>
Set nominal value for <code>U</code>.<br/>
This is for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/637\">637</a>.
</li>
<li>
February 19, 2016 by Filip Jorissen:<br/>
Added outputs UOut, mOut, mXiOut, mCOut for being able to
check conservation of quantities.
This is for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/247\">
issue 247</a>.
</li>
<li>
January 17, 2016, by Michael Wetter:<br/>
Added parameter <code>use_C_flow</code> and converted <code>C_flow</code>
to a conditionally removed connector.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/372\">#372</a>.
</li>
<li>
December 16, 2015, by Michael Wetter:<br/>
Added <code>C_flow</code> to the steady-state trace substance balance,
and removed the units of <code>C_flow</code> to allow for PPM.
</li>
<li>
December 2, 2015, by Filip Jorissen:<br/>
Added input <code>C_flow</code> and code for handling trace substance insertions.
</li>
<li>
September 3, 2015, by Filip Jorissen and Michael Wetter:<br/>
Revised implementation for allowing moisture mass flow rate
to be approximated using parameter <code>simplify_mWat_flow</code>.
This may lead to smaller algebraic loops.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/247\">#247</a>.
</li>
<li>
July 17, 2015, by Michael Wetter:<br/>
Added constant <code>simplify_mWat_flow</code> to remove dependencies of the pressure drop
calculation on the moisture balance.
</li>
<li>
June 5, 2015 by Michael Wetter:<br/>
Removed <code>preferredMediumStates= false</code> in
the instance <code>medium</code> as the default
is already <code>false</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/260\">#260</a>.
</li>
<li>
June 5, 2015 by Filip Jorissen:<br/>
Removed <pre>
Xi(start=X_start[1:Medium.nXi],
       each stateSelect=if (not (substanceDynamics == Modelica.Fluid.Types.Dynamics.SteadyState))
       then StateSelect.prefer else StateSelect.default),
</pre>
and set
<code>preferredMediumStates = false</code>
because the previous declaration led to more equations and
translation problems in large models.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/260\">#260</a>.
</li>
<li>
June 5, 2015, by Michael Wetter:<br/>
Moved assignment of <code>dynBal.U.start</code>
from instance <code>dynBal</code> of <code>PartialMixingVolume</code>
to this model implementation.
This is required for a pedantic model check in Dymola 2016.
It addresses
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">
issue 266</a>.
This revison also renames the protected variable
<code>rho_nominal</code> to <code>rho_start</code>
as it depends on the start values and not the nominal values.
</li>
<li>
May 22, 2015 by Michael Wetter:<br/>
Removed <pre>
p(stateSelect=if not (massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
then StateSelect.prefer else StateSelect.default)
</pre>
because the previous declaration led to the translation error
<pre>
The model requires derivatives of some inputs as listed below:
1 inlet.m_flow
1 inlet.p
</pre>
when translating
<code>Buildings.Fluid.FMI.ExportContainers.Examples.FMUs.HeaterCooler_u</code>
with a dynamic energy balance.
</li>
<li>
May 6, 2015, by Michael Wetter:<br/>
Corrected documentation.
</li>
<li>
April 13, 2015, by Filip Jorissen:<br/>
Now using <code>semiLinear()</code> function for calculation of
<code>ports_H_flow</code>. This enables Dymola to simplify based on
the <code>min</code> and <code>max</code> attribute of the mass flow rate.
</li>
<li>
February 16, 2015, by Filip Jorissen:<br/>
Fixed SteadyState massDynamics implementation for compressible media.
Mass <code>m</code> is now constant.
</li>
<li>
February 5, 2015, by Michael Wetter:<br/>
Changed <code>initalize_p</code> from a <code>parameter</code> to a
<code>constant</code>. This is only required in finite volume models
of heat exchangers (to avoid consistent but redundant initial conditions)
and hence it should be set as a <code>constant</code>.
</li>
<li>
February 3, 2015, by Michael Wetter:<br/>
Removed <code>stateSelect.prefer</code> for temperature.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/160\">#160</a>.
</li>
<li>
October 21, 2014, by Filip Jorissen:<br/>
Added parameter <code>mFactor</code> to increase the thermal capacity.
</li>
<li>
October 6, 2014, by Michael Wetter:<br/>
Changed medium declaration in ports to be final.
</li>
<li>
October 6, 2014, by Michael Wetter:<br/>
Set start attributes in <code>medium</code> to avoid in OpenModelica the warning
alias set with several free start values.
</li>
<li>
October 3, 2014, by Michael Wetter:<br/>
Changed assignment of nominal value to avoid in OpenModelica the warning
alias set with different nominal values.
</li>
<li>
July 3, 2014, by Michael Wetter:<br/>
Added parameter <code>initialize_p</code>. This is required
to enable the coil models to initialize the pressure in the first
volume, but not in the downstream volumes. Otherwise,
the initial equations will be overdetermined, but consistent.
This change was done to avoid a long information message that appears
when translating models.
</li>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
February 11, 2014 by Michael Wetter:<br/>
Improved documentation for <code>Q_flow</code> input.
</li>
<li>
September 17, 2013 by Michael Wetter:<br/>
Added start value for <code>hOut</code>.
</li>
<li>
September 10, 2013 by Michael Wetter:<br/>
Removed unrequired parameter <code>i_w</code>.<br/>
Corrected the syntax error
<code>Medium.ExtraProperty C[Medium.nC](each nominal=C_nominal)</code>
to
<code>Medium.ExtraProperty C[Medium.nC](nominal=C_nominal)</code>
because <code>C_nominal</code> is a vector.
This syntax error caused a compilation error in OpenModelica.
</li>
<li>
July 30, 2013 by Michael Wetter:<br/>
Changed connector <code>mXi_flow[Medium.nXi]</code>
to a scalar input connector <code>mWat_flow</code>.
The reason is that <code>mXi_flow</code> does not allow
to compute the other components in <code>mX_flow</code> and
therefore leads to an ambiguous use of the model.
By only requesting <code>mWat_flow</code>, the mass balance
and species balance can be implemented correctly.
</li>
<li>
March 27, 2013 by Michael Wetter:<br/>
Removed wrong unit attribute of <code>COut</code>,
and added min and max attributes for <code>XiOut</code>.
</li>
<li>
July 31, 2011 by Michael Wetter:<br/>
Added test to stop model translation if the setting for
<code>energyBalance</code> and <code>massBalance</code>
can lead to inconsistent equations.
</li>
<li>
July 26, 2011 by Michael Wetter:<br/>
Removed the option to use <code>h_start</code>, as this
is not needed for building simulation.
Also removed the reference to <code>Modelica.Fluid.System</code>.
Moved parameters and medium to
<a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">
AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
</li>
<li>
July 14, 2011 by Michael Wetter:<br/>
Added start value for medium density.
</li>
<li>
March 29, 2011 by Michael Wetter:<br/>
Changed default value for <code>substanceDynamics</code> and
<code>traceDynamics</code> from <code>energyDynamics</code>
to <code>massDynamics</code>.
</li>
<li>
September 28, 2010 by Michael Wetter:<br/>
Changed array index for nominal value of <code>Xi</code>.
</li>
<li>
September 13, 2010 by Michael Wetter:<br/>
Set nominal attributes for medium based on default medium values.
</li>
<li>
July 30, 2010 by Michael Wetter:<br/>
Added parameter <code>C_nominal</code> which is used as the nominal attribute for <code>C</code>.
Without this value, the ODE solver gives wrong results for concentrations around 1E-7.
</li>
<li>
March 21, 2010 by Michael Wetter:<br/>
Changed pressure start value from <code>system.p_start</code>
to <code>Medium.p_default</code> since HVAC models may have water and
air, which are typically at different pressures.
</li>
<li><i>February 6, 2010</i> by Michael Wetter:<br/>
Added to <code>Medium.BaseProperties</code> the initialization
<code>X(start=X_start[1:Medium.nX])</code>. Previously, the initialization
was only done for <code>Xi</code> but not for <code>X</code>, which caused the
medium to be initialized to <code>reference_X</code>, ignoring the value of <code>X_start</code>.
</li>
<li><i>October 12, 2009</i> by Michael Wetter:<br/>
Implemented first version in <code>Buildings</code> library, based on model from
<code>Modelica.Fluid 1.0</code>.
</li>
</ul>
</html>"),Icon(graphics={            Rectangle(
                extent={{-100,100},{100,-100}},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Text(
                extent={{-89,17},{-54,34}},
                lineColor={0,0,127},
                textString="mWat_flow"),
              Text(
                extent={{-89,52},{-54,69}},
                lineColor={0,0,127},
                textString="Q_flow"),
              Line(points={{-56,-73},{81,-73}}, color={255,255,255}),
              Line(points={{-42,55},{-42,-84}}, color={255,255,255}),
              Polygon(
                points={{-42,67},{-50,45},{-34,45},{-42,67}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{87,-73},{65,-65},{65,-81},{87,-73}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-42,-28},{-6,-28},{18,4},{40,12},{66,14}},
                color={255,255,255},
                smooth=Smooth.Bezier),
              Text(
                extent={{-155,-120},{145,-160}},
                lineColor={0,0,255},
                textString="%name")}));
      end ConservationEquation;

      partial model PartialTwoPort "Partial component with two ports"

        replaceable package Medium =
            Modelica.Media.Interfaces.PartialMedium "Medium in the component"
            annotation (choicesAllMatching = true);

        parameter Boolean allowFlowReversal = true
          "= false to simplify equations, assuming, but not enforcing, no flow reversal"
          annotation(Dialog(tab="Assumptions"), Evaluate=true);

        Modelica.Fluid.Interfaces.FluidPort_a port_a(
          redeclare final package Medium = Medium,
           m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
           h_outflow(start = Medium.h_default, nominal = Medium.h_default))
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(
          redeclare final package Medium = Medium,
          m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
           h_outflow(start = Medium.h_default, nominal = Medium.h_default))
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{110,-10},{90,10}})));

        annotation (
          Documentation(info="<html>
<p>
This partial model defines an interface for components with two ports.
The treatment of the design flow direction and of flow reversal are predefined based on the parameter <code>allowFlowReversal</code>.
The component may transport fluid and may have internal storage for a given fluid <code>Medium</code>.
</p>
<h4>Implementation</h4>
<p>
This model is similar to
<a href=\"modelica://Modelica.Fluid.Interfaces.PartialTwoPort\">
Modelica.Fluid.Interfaces.PartialTwoPort</a>
but it does not use the <code>outer system</code> declaration.
This declaration is omitted as in building energy simulation,
many models use multiple media, an in practice,
users have not used this global definition to assign parameters.
</p>
</html>",       revisions="<html>
<ul>
<li>
July 8, 2018, by Filip Jorissen:<br/>
Added nominal value of <code>h_outflow</code> in <code>FluidPorts</code>.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/977\">#977</a>.
</li>
<li>
November 19, 2015, by Michael Wetter:<br/>
Removed parameters
<code>port_a_exposesState</code> and
<code>port_b_exposesState</code>
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/351\">#351</a>
and
<code>showDesignFlowDirection</code>
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/349\">#349</a>.
</li>
<li>
November 13, 2015, by Michael Wetter:<br/>
Assinged <code>start</code> attribute for leaving
enthalpy at <code>port_a</code> and <code>port_b</code>.
This was done to make the model similar to
<a href=\"modelica://AixLib.Fluid.Interfaces.PartialFourPort\">
AixLib.Fluid.Interfaces.PartialFourPort</a>.
</li>
<li>
November 12, 2015, by Michael Wetter:<br/>
Removed import statement.
</li>
<li>
October 21, 2014, by Michael Wetter:<br/>
Revised implementation.
Declared medium in ports to be <code>final</code>.
</li>
<li>
October 20, 2014, by Filip Jorisson:<br/>
First implementation.
</li>
</ul>
</html>"),Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{20,-70},{60,-85},{20,-100},{20,-70}},
                lineColor={0,128,255},
                fillColor={0,128,255},
                fillPattern=FillPattern.Solid,
                visible=not allowFlowReversal),
              Line(
                points={{55,-85},{-60,-85}},
                color={0,128,255},
                visible=not allowFlowReversal),
              Text(
                extent={{-149,-114},{151,-154}},
                lineColor={0,0,255},
                textString="%name")}));
      end PartialTwoPort;

      partial model PartialTwoPortInterface
        "Partial model transporting fluid between two ports without storing mass or energy"
        extends AixLib.Fluid.Interfaces.PartialTwoPort(
          port_a(p(start=Medium.p_default)),
          port_b(p(start=Medium.p_default)));

        parameter Modelica.SIunits.MassFlowRate m_flow_nominal
          "Nominal mass flow rate"
          annotation(Dialog(group = "Nominal condition"));
        parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
          "Small mass flow rate for regularization of zero flow"
          annotation(Dialog(tab = "Advanced"));
        // Diagnostics
         parameter Boolean show_T = false
          "= true, if actual temperature at port is computed"
          annotation(Dialog(tab="Advanced",group="Diagnostics"));

        Modelica.SIunits.MassFlowRate m_flow(start=_m_flow_start) = port_a.m_flow
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";

        Modelica.SIunits.PressureDifference dp(start=_dp_start, displayUnit="Pa") = port_a.p - port_b.p
          "Pressure difference between port_a and port_b";

        Medium.ThermodynamicState sta_a=
            Medium.setState_phX(port_a.p,
                                noEvent(actualStream(port_a.h_outflow)),
                                noEvent(actualStream(port_a.Xi_outflow))) if
               show_T "Medium properties in port_a";

        Medium.ThermodynamicState sta_b=
            Medium.setState_phX(port_b.p,
                                noEvent(actualStream(port_b.h_outflow)),
                                noEvent(actualStream(port_b.Xi_outflow))) if
                show_T "Medium properties in port_b";

    protected
        final parameter Modelica.SIunits.MassFlowRate _m_flow_start = 0
        "Start value for m_flow, used to avoid a warning if not set in m_flow, and to avoid m_flow.start in parameter window";
        final parameter Modelica.SIunits.PressureDifference _dp_start(displayUnit="Pa") = 0
        "Start value for dp, used to avoid a warning if not set in dp, and to avoid dp.start in parameter window";

        annotation (
          preferredView="info",
          Documentation(info="<html>
<p>
This component defines the interface for models that
transports a fluid between two ports. It is similar to
<a href=\"Modelica://Modelica.Fluid.Interfaces.PartialTwoPortTransport\">
Modelica.Fluid.Interfaces.PartialTwoPortTransport</a>, but it does not
include the species balance
</p>
<pre>
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);
</pre>
<p>
Thus, it can be used as a base class for a heat <i>and</i> mass transfer component
</p>
<p>
The model is used by other models in this package that add heat transfer,
mass transfer and pressure drop equations. See for example
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortHeatMassExchanger\">
AixLib.Fluid.Interfaces.StaticTwoPortHeatMassExchanger</a>.
</p>
</html>",       revisions="<html>
<ul>
<li>
November 3, 2016, by Michael Wetter:<br/>
Renamed protected parameter <code>m_flow_start</code> to avoid
a name clash with
<a href=\"modelica://AixLib.Fluid.Movers.FlowControlled_m_flow\">
AixLib.Fluid.Movers.FlowControlled_m_flow</a>
which leads to an error as the definition were different,
and also renamed protected parameter <code>dp_start</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/552\">#552</a>
<br/>
Moved computation of pressure drop to variable assignment so that
the model won't mix graphical with textual modeling if used as a base
class for a graphically implemented model.
</li>
<li>
November 3, 2016, by Michael Wetter:<br/>
Removed start values for mass flow rate and pressure difference
to simplify the parameter window.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/552\">#552</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
October 3, 2014, by Michael Wetter:<br/>
Changed assignment of nominal value to avoid in OpenModelica the warning
alias set with different nominal values.
</li>
<li>
November 12, 2013 by Michael Wetter:<br/>
Removed <code>import Modelica.Constants;</code> statement.
</li>
<li>
November 11, 2013 by Michael Wetter:<br/>
Removed the parameter <code>homotopyInitialization</code>
as it is no longer used in this model.
</li>
<li>
November 10, 2013 by Michael Wetter:<br/>
In the computation of <code>sta_a</code> and <code>sta_b</code>,
removed the branch that uses the homotopy operator.
The rational is that these variables are conditionally enables (because
of <code>... if show_T</code>). Therefore, the Modelica Language Specification
does not allow for these variables to be used in any equation. Hence,
the use of the homotopy operator is not needed here.
</li>
<li>
October 10, 2013 by Michael Wetter:<br/>
Added <code>noEvent</code> to the computation of the states at the port.
This is correct, because the states are only used for reporting, but not
to compute any other variable.
Use of the states to compute other variables would violate the Modelica
language, as conditionally removed variables must not be used in any equation.
</li>
<li>
October 8, 2013 by Michael Wetter:<br/>
Removed the computation of <code>V_flow</code> and removed the parameter
<code>show_V_flow</code>.
The reason is that the computation of <code>V_flow</code> required
the use of <code>sta_a</code> (to compute the density),
but <code>sta_a</code> is also a variable that is conditionally
enabled. However, this was not correct Modelica syntax as conditional variables
can only be used in a <code>connect</code>
statement, not in an assignment. Dymola 2014 FD01 beta3 is checking
for this incorrect syntax. Hence, <code>V_flow</code> was removed as its
conditional implementation would require a rather cumbersome implementation
that uses a new connector that carries the state of the medium.
</li>
<li>
April 26, 2013 by Marco Bonvini:<br/>
Moved the definition of <code>dp</code> because it causes some problem with PyFMI.
</li>
<li>
March 27, 2012 by Michael Wetter:<br/>
Changed condition to remove <code>sta_a</code> to also
compute the state at the inlet port if <code>show_V_flow=true</code>.
The previous implementation resulted in a translation error
if <code>show_V_flow=true</code>, but worked correctly otherwise
because the erroneous function call is removed if  <code>show_V_flow=false</code>.
</li>
<li>
March 27, 2011 by Michael Wetter:<br/>
Added <code>homotopy</code> operator.
</li>
<li>
March 21, 2010 by Michael Wetter:<br/>
Changed pressure start value from <code>system.p_start</code>
to <code>Medium.p_default</code> since HVAC models may have water and
air, which are typically at different pressures.
</li>
<li>
September 19, 2008 by Michael Wetter:<br/>
Added equations for the mass balance of extra species flow,
i.e., <code>C</code> and <code>mC_flow</code>.
</li>
<li>
March 11, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end PartialTwoPortInterface;

      model StaticTwoPortConservationEquation
        "Partial model for static energy and mass conservation equations"
        extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

        constant Boolean simplify_mWat_flow = true
          "Set to true to cause port_a.m_flow + port_b.m_flow = 0 even if mWat_flow is non-zero";

        constant Boolean prescribedHeatFlowRate = false
          "Set to true if the heat flow rate is not a function of a temperature difference to the fluid temperature";

        parameter Boolean use_mWat_flow = false
          "Set to true to enable input connector for moisture mass flow rate"
          annotation(Evaluate=true, Dialog(tab="Advanced"));

        parameter Boolean use_C_flow = false
          "Set to true to enable input connector for trace substance"
          annotation(Evaluate=true, Dialog(tab="Advanced"));

        Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
          "Sensible plus latent heat flow rate transferred into the medium"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput mWat_flow(final quantity="MassFlowRate",
                                                       unit="kg/s") if
             use_mWat_flow "Moisture mass flow rate added to the medium"
          annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
        Modelica.Blocks.Interfaces.RealInput[Medium.nC] C_flow if
             use_C_flow "Trace substance mass flow rate added to the medium"
          annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

        // Outputs that are needed in models that extend this model
        Modelica.Blocks.Interfaces.RealOutput hOut(unit="J/kg",
                                                   start=Medium.specificEnthalpy_pTX(
                                                           p=Medium.p_default,
                                                           T=Medium.T_default,
                                                           X=Medium.X_default))
          "Leaving specific enthalpy of the component"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,110}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,110})));

        Modelica.Blocks.Interfaces.RealOutput XiOut[Medium.nXi](each unit="1",
                                                                each min=0,
                                                                each max=1)
          "Leaving species concentration of the component"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,110})));
        Modelica.Blocks.Interfaces.RealOutput COut[Medium.nC](each min=0)
          "Leaving trace substances of the component"
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,110})));

    protected
        final parameter Boolean use_m_flowInv=
          (prescribedHeatFlowRate or use_mWat_flow or use_C_flow)
          "Flag, true if m_flowInv is used in the model"
          annotation (Evaluate=true);
        final parameter Real s[Medium.nXi] = {if Modelica.Utilities.Strings.isEqual(string1=Medium.substanceNames[i],
                                                  string2="Water",
                                                  caseSensitive=false)
                                                  then 1 else 0 for i in 1:Medium.nXi}
          "Vector with zero everywhere except where species is";

        Real m_flowInv(unit="s/kg") "Regularization of 1/m_flow of port_a";

        Modelica.SIunits.MassFlowRate mXi_flow[Medium.nXi]
          "Mass flow rates of independent substances added to the medium";

        // Parameters for inverseXRegularized.
        // These are assigned here for efficiency reason.
        // Otherwise, they would need to be computed each time
        // the function is invocated.
        final parameter Real deltaReg = m_flow_small/1E3
          "Smoothing region for inverseXRegularized";

        final parameter Real deltaInvReg = 1/deltaReg
          "Inverse value of delta for inverseXRegularized";

        final parameter Real aReg = -15*deltaInvReg
          "Polynomial coefficient for inverseXRegularized";
        final parameter Real bReg = 119*deltaInvReg^2
          "Polynomial coefficient for inverseXRegularized";
        final parameter Real cReg = -361*deltaInvReg^3
          "Polynomial coefficient for inverseXRegularized";
        final parameter Real dReg = 534*deltaInvReg^4
          "Polynomial coefficient for inverseXRegularized";
        final parameter Real eReg = -380*deltaInvReg^5
          "Polynomial coefficient for inverseXRegularized";
        final parameter Real fReg = 104*deltaInvReg^6
          "Polynomial coefficient for inverseXRegularized";

        final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
            T=Medium.T_default,
            p=Medium.p_default,
            X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
        // Density at medium default values, used to compute the size of control volumes
        final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
          Medium.specificHeatCapacityCp(state=state_default)
          "Specific heat capacity, used to verify energy conservation";
        constant Modelica.SIunits.TemperatureDifference dTMax(min=1) = 200
          "Maximum temperature difference across the StaticTwoPortConservationEquation";
        // Conditional connectors
        Modelica.Blocks.Interfaces.RealInput mWat_flow_internal(unit="kg/s")
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput C_flow_internal[Medium.nC]
          "Needed to connect to conditional connector";
      initial equation
        // Assert that the substance with name 'water' has been found.
        assert(Medium.nXi == 0 or abs(sum(s)-1) < 1e-5,
            "If Medium.nXi > 1, then substance 'water' must be present for one component.'"
               + Medium.mediumName + "'.\n"
               + "Check medium model.");

      equation
        // Conditional connectors
        connect(mWat_flow, mWat_flow_internal);
        if not use_mWat_flow then
          mWat_flow_internal = 0;
        end if;

        connect(C_flow, C_flow_internal);
        if not use_C_flow then
          C_flow_internal = zeros(Medium.nC);
        end if;

        // Species flow rate from connector mWat_flow
        mXi_flow = mWat_flow_internal * s;

        // Regularization of m_flow around the origin to avoid a division by zero
        // m_flowInv is only used if prescribedHeatFlowRate == true, or
        // if the input connectors mWat_flow or C_flow are enabled.
        if use_m_flowInv then
          m_flowInv = AixLib.Utilities.Math.Functions.inverseXRegularized(
                             x=port_a.m_flow,
                             delta=deltaReg, deltaInv=deltaInvReg,
                             a=aReg, b=bReg, c=cReg, d=dReg, e=eReg, f=fReg);
        else
          // m_flowInv is not used.
          m_flowInv = 0;
        end if;

        if prescribedHeatFlowRate then
          assert(noEvent( abs(Q_flow) < dTMax*cp_default*max(m_flow_small/1E3, abs(m_flow))),
         "In " + getInstanceName() + ":
   The heat flow rate equals "       + String(Q_flow) +
         " W and the mass flow rate equals " + String(m_flow) + " kg/s,
   which results in a temperature difference "       +
         String(abs(Q_flow)/ (dTMax*cp_default*max(m_flow_small/1E3, abs(m_flow)))) +
         " K > dTMax=" +String(dTMax) + " K.
   This may indicate that energy is not conserved for small mass flow rates.
   The implementation may require prescribedHeatFlowRate = false.");
        end if;

        if allowFlowReversal then
          // Formulate hOut using spliceFunction. This avoids an event iteration.
          // The introduced error is small because deltax=m_flow_small/1e3
          hOut = AixLib.Utilities.Math.Functions.regStep(y1=port_b.h_outflow,
                                                          y2=port_a.h_outflow,
                                                          x=port_a.m_flow,
                                                          x_small=m_flow_small/1E3);
          XiOut = AixLib.Utilities.Math.Functions.regStep(y1=port_b.Xi_outflow,
                                                           y2=port_a.Xi_outflow,
                                                           x=port_a.m_flow,
                                                           x_small=m_flow_small/1E3);
          COut = AixLib.Utilities.Math.Functions.regStep(y1=port_b.C_outflow,
                                                          y2=port_a.C_outflow,
                                                          x=port_a.m_flow,
                                                          x_small=m_flow_small/1E3);
        else
          hOut =  port_b.h_outflow;
          XiOut = port_b.Xi_outflow;
          COut =  port_b.C_outflow;
        end if;

        //////////////////////////////////////////////////////////////////////////////////////////
        // Energy balance and mass balance

          // Mass balance (no storage)
          port_a.m_flow + port_b.m_flow = if simplify_mWat_flow then 0 else -mWat_flow_internal;

          // Substance balance
          // a) forward flow
          if use_m_flowInv then
            port_b.Xi_outflow = inStream(port_a.Xi_outflow) + mXi_flow * m_flowInv;
          else // no water is added
            assert(use_mWat_flow == false, "In " + getInstanceName() + ": Wrong implementation for forward flow.");
            port_b.Xi_outflow = inStream(port_a.Xi_outflow);
          end if;

          // b) backward flow
          if allowFlowReversal then
            if use_m_flowInv then
              port_a.Xi_outflow = inStream(port_b.Xi_outflow) - mXi_flow * m_flowInv;
            else // no water added
              assert(use_mWat_flow == false, "In " + getInstanceName() + ": Wrong implementation for reverse flow.");
              port_a.Xi_outflow = inStream(port_b.Xi_outflow);
            end if;
          else // no  flow reversal
            port_a.Xi_outflow = Medium.X_default[1:Medium.nXi];
          end if;

          // Energy balance.
          // This equation is approximate since m_flow = port_a.m_flow is used for the mass flow rate
          // at both ports. Since mWat_flow_internal << m_flow, the error is small.
          if prescribedHeatFlowRate then
            port_b.h_outflow = inStream(port_a.h_outflow) + Q_flow * m_flowInv;
            if allowFlowReversal then
              port_a.h_outflow = inStream(port_b.h_outflow) - Q_flow * m_flowInv;
            else
              port_a.h_outflow = Medium.h_default;
            end if;
          else
            // Case with prescribedHeatFlowRate == false.
            // port_b.h_outflow is known and the equation needs to be solved for Q_flow.
            // Hence, we cannot use m_flowInv as for m_flow=0, any Q_flow would satisfiy
            // Q_flow * m_flowInv = 0.
            // The same applies for port_b.Xi_outflow and mXi_flow.
            port_a.m_flow * (inStream(port_a.h_outflow) - port_b.h_outflow)     = -Q_flow;
            if allowFlowReversal then
              port_a.m_flow * (inStream(port_b.h_outflow)  - port_a.h_outflow)  = +Q_flow;
            else
              // When allowFlowReversal = false, the downstream enthalpy does not matter.
              // Therefore a dummy value is used to avoid algebraic loops
              port_a.h_outflow = Medium.h_default;
            end if;
          end if;

        // Transport of trace substances
        if use_m_flowInv and use_C_flow then
          port_b.C_outflow =  inStream(port_a.C_outflow) + C_flow_internal * m_flowInv;
        else // no trace substance added.
          assert(not use_C_flow, "In " + getInstanceName() + ": Wrong implementation of trace substance balance for forward flow.");
          port_b.C_outflow =  inStream(port_a.C_outflow);
        end if;

        if allowFlowReversal then
          if use_C_flow then
            port_a.C_outflow = inStream(port_b.C_outflow) - C_flow_internal * m_flowInv;
          else
            port_a.C_outflow = inStream(port_b.C_outflow);
          end if;
        else
          port_a.C_outflow = zeros(Medium.nC);
        end if;

        ////////////////////////////////////////////////////////////////////////////
        // No pressure drop in this model
        port_a.p = port_b.p;

        annotation (
          preferredView="info",
          Documentation(info="<html>
<p>
This model transports fluid between its two ports, without storing mass or energy.
It implements a steady-state conservation equation for energy and mass fractions.
The model has zero pressure drop between its ports.
</p>

<h4>Typical use and important parameters</h4>
<p>
Set the parameter <code>use_mWat_flow_in=true</code> to enable an
input connector for <code>mWat_flow</code>.
Otherwise, the model uses <code>mWat_flow = 0</code>.
</p>
<p>
If the constant <code>simplify_mWat_flow = true</code>, which is its default value,
then the equation
</p>
<pre>
  port_a.m_flow + port_b.m_flow = - mWat_flow;
</pre>
<p>
is simplified as
</p>
<pre>
  port_a.m_flow + port_b.m_flow = 0;
</pre>
<p>
This causes an error in the mass balance of about <i>0.5%</i>, but generally leads to
simpler equations because the pressure drop equations are then decoupled from the
mass exchange in this component.
</p>

<p>
To increase the numerical robustness of the model, the constant
<code>prescribedHeatFlowRate</code> can be set.
Use the following settings:
</p>
<ul>
<li>Set <code>prescribedHeatFlowRate=true</code> if the <i>only</i> means of heat transfer
at the <code>heatPort</code> is a prescribed heat flow rate that
is <i>not</i> a function of the temperature difference
between the medium and an ambient temperature. Examples include an ideal electrical heater,
a pump that rejects heat into the fluid stream, or a chiller that removes heat based on a performance curve.
If the <code>heatPort</code> is not connected, then set <code>prescribedHeatFlowRate=true</code> as
in this case, <code>heatPort.Q_flow=0</code>.
</li>
<li>Set <code>prescribedHeatFlowRate=false</code> if there is heat flow at the <code>heatPort</code>
computed as <i>K * (T-heatPort.T)</i>, for some temperature <i>T</i> and some conductance <i>K</i>,
which may itself be a function of temperature or mass flow rate.<br/>
If there is a combination of <i>K * (T-heatPort.T)</i> and a prescribed heat flow rate,
for example a solar collector that dissipates heat to the ambient and receives heat from
the solar radiation, then set <code>prescribedHeatFlowRate=false</code>.
</li>
</ul>
<p>
If <code>prescribedHeatFlow=true</code>, then energy and mass balance
equations are formulated to guard against numerical problems near
zero flow that can occur if <code>Q_flow</code> or <code>m_flow</code>
are the results of an iterative solver.
</p>
<h4>Implementation</h4>
<p>
Input connectors of the model are
</p>
<ul>
<li>
<code>Q_flow</code>, which is the sensible plus latent heat flow rate added to the medium,
</li>
<li>
<code>mWat_flow</code>, which is the moisture mass flow rate added to the medium, and
</li>
<li>
<code>C_flow</code>, which is the trace substance mass flow rate added to the medium.
</li>
</ul>

<p>
The model can only be used as a steady-state model with two fluid ports.
For a model with a dynamic balance, and more fluid ports, use
<a href=\"modelica://AixLib.Fluid.Interfaces.ConservationEquation\">
AixLib.Fluid.Interfaces.ConservationEquation</a>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
June 23, 2018, by Filip Jorissen:<br/>
Added more details to energy conservation assert to facilitate
debugging.<br/>
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/962\">#962</a>.
</li>
<li>
March 30, 2018, by Filip Jorissen:<br/>
Added <code>getInstanceName()</code> in asserts to facilitate
debugging.<br/>
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/901\">#901</a>.
</li>
<li>
April 24, 2017, by Michael Wetter and Filip Jorissen:<br/>
Reimplemented check for energy conversion.<br/>
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/741\">#741</a>.
</li>
<li>
April 24, 2017, by Michael Wetter:<br/>
Reverted change from April 21, 2017.<br/>
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/741\">#741</a>.
</li>
<li>
April 21, 2017, by Filip Jorissen:<br/>
Revised test for energy conservation at small mass flow rates.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/741\">#741</a>.
</li>
<li>
October 23, 2016, by Filip Jorissen:<br/>
Added test for energy conservation at small mass flow rates.
</li>
<li>
March 17, 2016, by Michael Wetter:<br/>
Refactored model and implmented <code>regStep</code> instead of <code>spliceFunction</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/247\">#247</a>
and for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/300\">#300</a>.
</li>
<li>
September 3, 2015, by Filip Jorissen:<br/>
Revised implementation of conservation of vapor mass.
Added new variable <code>mFlow_inv_b</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/247\">#247</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Removed <code>constant sensibleOnly</code> as this is no longer used because
the model uses <code>use_mWat_flow</code>.<br/>
Changed condition that determines whether <code>m_flowInv</code> needs to be
computed because the change from January 20 introduced an error in
<a href=\"modelica://AixLib.Fluid.MassExchangers.Examples.ConstantEffectiveness\">
AixLib.Fluid.MassExchangers.Examples.ConstantEffectiveness</a>.
</li>
<li>
January 20, 2016, by Filip Jorissen:<br/>
Removed if-else block in code for parameter <code>sensibleOnly</code>
since this is no longer needed to simplify the equations.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/372\">#372</a>.
</li>
<li>
January 17, 2016, by Michael Wetter:<br/>
Added parameter <code>use_C_flow</code> and converted <code>C_flow</code>
to a conditionally removed connector.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/372\">#372</a>.
</li>
<li>
December 16, 2015, by Michael Wetter:<br/>
Removed the units of <code>C_flow</code> to allow for PPM.
</li>
<li>
December 2, 2015, by Filip Jorissen:<br/>
Added input <code>C_flow</code> and code for handling trace substance insertions.
November 19, 2015, by Michael Wetter:<br/>
Removed assignment of parameter
<code>showDesignFlowDirection</code> in <code>extends</code> statement.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/349\">#349</a>.
</li>
<li>
September 14, 2015, by Filip Jorissen:<br/>
Rewrote some equations for better readability.
</li>
<li>
August 11, 2015, by Michael Wetter:<br/>
Refactored implementation of
<a href=\"modelica://AixLib.Utilities.Math.Functions.inverseXRegularized\">
AixLib.Utilities.Math.Functions.inverseXRegularized</a>
to allow function to be inlined and to factor out the computation
of arguments that only depend on parameters.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/302\">issue 302</a>.
</li>
<li>
July 17, 2015, by Michael Wetter:<br/>
Corrected bug for situation with latent heat exchange and flow reversal not
allowed.
The previous formulation was singular.
This caused some models to not translate.
The error was introduced in
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/282\">#282</a>.
</li>
<li>
July 17, 2015, by Michael Wetter:<br/>
Added constant <code>simplify_mWat_flow</code> to remove dependencies of the pressure drop
calculation on the moisture balance.
</li>
<li>
July 2, 2015 by Michael Wetter:<br/>
Revised implementation of conservation equations,
added default values for outlet quantities at <code>port_a</code>
if <code>allowFlowReversal=false</code> and
updated documentation.
See
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/281\">
issue 281</a> for a discussion.
</li>
<li>
July 1, 2015, by Filip Jorissen:<br/>
Revised implementation so that equations are always consistent
and do not lead to division by zero,
also when connecting a <code>prescribedHeatFlowRate</code>
to <code>MixingVolume</code> instances.
Renamed <code>use_safeDivision</code> into <code>prescribedHeatFlowRate</code>.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/282\">#282</a>
for a discussion.
</li>
<li>
May 6, 2015, by Michael Wetter:<br/>
Corrected documentation.
</li>
<li>
February 11, 2014 by Michael Wetter:<br/>
Improved documentation for <code>Q_flow</code> input.
</li>
<li>
October 21, 2013 by Michael Wetter:<br/>
Corrected sign error in the equation that is used if <code>use_safeDivision=false</code>
and <code>sensibleOnly=true</code>.
This only affects internal numerical tests, but not any examples in the library
as the constant <code>use_safeDivision</code> is set to <code>true</code> by default.
</li>
<li>
September 25, 2013 by Michael Wetter:<br/>
Reformulated computation of outlet properties to avoid an event at zero mass flow rate.
</li>
<li>
September 17, 2013 by Michael Wetter:<br/>
Added start value for <code>hOut</code>.
</li>
<li>September 10, 2013 by Michael Wetter:<br/>
Removed unrequired parameter <code>i_w</code>.
</li>
<li>
May 7, 2013 by Michael Wetter:<br/>
Removed <code>for</code> loops for species balance and trace substance balance,
as they cause the error <code>Error: Operand port_a.Xi_outflow[1] to operator inStream is not a stream variable.</code>
in OpenModelica.
</li>
<li>
March 27, 2013 by Michael Wetter:<br/>
Removed wrong unit attribute of <code>COut</code>,
and added min and max attributes for <code>XiOut</code>.
</li>
<li>
June 22, 2012 by Michael Wetter:<br/>
Reformulated implementation with <code>m_flowInv</code> to use <code>port_a.m_flow * ...</code>
if <code>use_safeDivision=false</code>. This avoids a division by zero if
<code>port_a.m_flow=0</code>.
</li>
<li>
February 7, 2012 by Michael Wetter:<br/>
Revised base classes for conservation equations in <code>AixLib.Fluid.Interfaces</code>.
</li>
<li>
December 14, 2011 by Michael Wetter:<br/>
Changed assignment of <code>hOut</code>, <code>XiOut</code> and
<code>COut</code> to no longer declare that it is continuous.
The declaration of continuity, i.e, the
<code>smooth(0, if (port_a.m_flow >= 0) then ...)</code> declaration,
was required for Dymola 2012 to simulate, but it is no longer needed
for Dymola 2012 FD01.
</li>
<li>
August 19, 2011, by Michael Wetter:<br/>
Changed assignment of <code>hOut</code>, <code>XiOut</code> and
<code>COut</code> to declare that it is not differentiable.
</li>
<li>
August 4, 2011, by Michael Wetter:<br/>
Moved linearized pressure drop equation from the function body to the equation
section. With the previous implementation,
the symbolic processor may not rearrange the equations, which can lead
to coupled equations instead of an explicit solution.
</li>
<li>
March 29, 2011, by Michael Wetter:<br/>
Changed energy and mass balance to avoid a division by zero if <code>m_flow=0</code>.
</li>
<li>
March 27, 2011, by Michael Wetter:<br/>
Added <code>homotopy</code> operator.
</li>
<li>
August 19, 2010, by Michael Wetter:<br/>
Fixed bug in energy and moisture balance that affected results if a component
adds or removes moisture to the air stream.
In the old implementation, the enthalpy and species
outflow at <code>port_b</code> was multiplied with the mass flow rate at
<code>port_a</code>. The old implementation led to small errors that were proportional
to the amount of moisture change. For example, if the moisture added by the component
was <code>0.005 kg/kg</code>, then the error was <code>0.5%</code>.
Also, the results for forward flow and reverse flow differed by this amount.
With the new implementation, the energy and moisture balance is exact.
</li>
<li>
March 22, 2010, by Michael Wetter:<br/>
Added constant <code>sensibleOnly</code> to
simplify species balance equation.
</li>
<li>
April 10, 2009, by Michael Wetter:<br/>
Added model to compute flow friction.
</li>
<li>
April 22, 2008, by Michael Wetter:<br/>
Revised to add mass balance.
</li>
<li>
March 17, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              grid={1,1}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Text(
                extent={{-93,72},{-58,89}},
                lineColor={0,0,127},
                textString="Q_flow"),
              Text(
                extent={{-93,37},{-58,54}},
                lineColor={0,0,127},
                textString="mWat_flow"),
              Text(
                extent={{-41,103},{-10,117}},
                lineColor={0,0,127},
                textString="hOut"),
              Text(
                extent={{10,103},{41,117}},
                lineColor={0,0,127},
                textString="XiOut"),
              Text(
                extent={{61,103},{92,117}},
                lineColor={0,0,127},
                textString="COut"),
              Line(points={{-42,55},{-42,-84}}, color={255,255,255}),
              Polygon(
                points={{-42,67},{-50,45},{-34,45},{-42,67}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{87,-73},{65,-65},{65,-81},{87,-73}},
                lineColor={255,255,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-56,-73},{81,-73}}, color={255,255,255}),
              Line(points={{6,14},{6,-37}},     color={255,255,255}),
              Line(points={{54,14},{6,14}},     color={255,255,255}),
              Line(points={{6,-37},{-42,-37}},  color={255,255,255})}));
      end StaticTwoPortConservationEquation;

      record LumpedVolumeDeclarations "Declarations for lumped volumes"
        replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium in the component"
            annotation (choicesAllMatching = true);

        // Assumptions
        parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
          "Type of energy balance: dynamic (3 initialization options) or steady state"
          annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
        parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
          "Type of mass balance: dynamic (3 initialization options) or steady state"
          annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
        final parameter Modelica.Fluid.Types.Dynamics substanceDynamics=energyDynamics
          "Type of independent mass fraction balance: dynamic (3 initialization options) or steady state"
          annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
        final parameter Modelica.Fluid.Types.Dynamics traceDynamics=energyDynamics
          "Type of trace substance balance: dynamic (3 initialization options) or steady state"
          annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

        // Initialization
        parameter Medium.AbsolutePressure p_start = Medium.p_default
          "Start value of pressure"
          annotation(Dialog(tab = "Initialization"));
        parameter Medium.Temperature T_start=Medium.T_default
          "Start value of temperature"
          annotation(Dialog(tab = "Initialization"));
        parameter Medium.MassFraction X_start[Medium.nX](
             quantity=Medium.substanceNames) = Medium.X_default
          "Start value of mass fractions m_i/m"
          annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
        parameter Medium.ExtraProperty C_start[Medium.nC](
             quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
          "Start value of trace substances"
          annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
        parameter Medium.ExtraProperty C_nominal[Medium.nC](
             quantity=Medium.extraPropertiesNames) = fill(1E-2, Medium.nC)
          "Nominal value of trace substances. (Set to typical order of magnitude.)"
         annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
        parameter Real mSenFac(min=1)=1
          "Factor for scaling the sensible thermal mass of the volume"
          annotation(Dialog(tab="Dynamics"));

      annotation (preferredView="info",
      Documentation(info="<html>
<p>
This class contains parameters and medium properties
that are used in the lumped  volume model, and in models that extend the
lumped volume model.
</p>
<p>
These parameters are used for example by
<a href=\"modelica://AixLib.Fluid.Interfaces.ConservationEquation\">
AixLib.Fluid.Interfaces.ConservationEquation</a>,
<a href=\"modelica://AixLib.Fluid.MixingVolumes.MixingVolume\">
AixLib.Fluid.MixingVolumes.MixingVolume</a> and
<a href=\"modelica://AixLib.Fluid.HeatExchangers.Radiators.RadiatorEN442_2\">
AixLib.Fluid.HeatExchangers.Radiators.RadiatorEN442_2</a>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
April 11, 2016 by Michael Wetter:<br/>
Corrected wrong hyperlink in documentation for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/450\">issue 450</a>.
</li>
<li>
January 26, 2016, by Michael Wetter:<br/>
Added <code>quantity=Medium.substanceNames</code> for <code>X_start</code>.
</li>
<li>
October 21, 2014, by Filip Jorissen:<br/>
Added parameter <code>mFactor</code> to increase the thermal capacity.
</li>
<li>
August 2, 2011, by Michael Wetter:<br/>
Set <code>substanceDynamics</code> and <code>traceDynamics</code> to final
and equal to <code>energyDynamics</code>,
as there is no need to make them different from <code>energyDynamics</code>.
</li>
<li>
August 1, 2011, by Michael Wetter:<br/>
Changed default value for <code>energyDynamics</code> to
<code>Modelica.Fluid.Types.Dynamics.DynamicFreeInitial</code> because
<code>Modelica.Fluid.Types.Dynamics.SteadyStateInitial</code> leads
to high order DAE that Dymola cannot reduce.
</li>
<li>
July 31, 2011, by Michael Wetter:<br/>
Changed default value for <code>energyDynamics</code> to
<code>Modelica.Fluid.Types.Dynamics.SteadyStateInitial</code>.
</li>
<li>
April 13, 2009, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end LumpedVolumeDeclarations;
    annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains basic classes that are used to build
component models that change the state of the
fluid. The classes are not directly usable, but can
be extended when building a new model.
</p>
</html>"));
    end Interfaces;
  annotation (
  preferredView="info", Documentation(info="<html>
This package contains components for fluid flow systems such as
pumps, valves and sensors. For other fluid flow models, see
<a href=\"modelica://Modelica.Fluid\">Modelica.Fluid</a>.
</html>"),
  Icon(graphics={
          Polygon(points={{-70,26},{68,-44},{68,26},{2,-10},{-70,-42},{-70,26}},
              lineColor={0,0,0}),
          Line(points={{2,42},{2,-10}}),
          Rectangle(
            extent={{-18,50},{22,42}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end Fluid;

  package Media "Package with medium models"
    extends Modelica.Icons.Package;

    package Air
      "Package with moist air model that decouples pressure and temperature"
      extends Modelica.Media.Interfaces.PartialCondensingGases(
         mediumName="Air",
         final substanceNames={"water", "air"},
         final reducedX=true,
         final singleState = false,
         reference_X={0.01,0.99},
         final fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,
                                 Modelica.Media.IdealGases.Common.FluidData.N2},
         reference_T=273.15,
         reference_p=101325,
         AbsolutePressure(start=p_default),
         Temperature(start=T_default));
      extends Modelica.Icons.Package;

      constant Integer Water=1
        "Index of water (in substanceNames, massFractions X, etc.)";
      constant Integer Air=2
        "Index of air (in substanceNames, massFractions X, etc.)";

      constant AbsolutePressure pStp = reference_p
        "Pressure for which fluid density is defined";
      constant Density dStp = 1.2 "Fluid density at pressure pStp";

      // Redeclare ThermodynamicState to avoid the warning
      // "Base class ThermodynamicState is replaceable"
      // during model check
      redeclare record extends ThermodynamicState
        "ThermodynamicState record for moist air"
      end ThermodynamicState;
      // There must not be any stateSelect=StateSelect.prefer for
      // the pressure.
      // Otherwise, translateModel("Buildings.Fluid.FMI.ExportContainers.Examples.FMUs.ResistanceVolume")
      // will fail as Dymola does an index reduction and outputs
      //   Differentiated the equation
      //   vol.dynBal.medium.p+res.dp-inlet.p = 0.0;
      //   giving
      //   der(vol.dynBal.medium.p)+der(res.dp) = der(inlet.p);
      //
      //   The model requires derivatives of some inputs as listed below:
      //   1 inlet.m_flow
      //   1 inlet.p
      // Therefore, the statement
      //   p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)
      // has been removed.
      redeclare replaceable model extends BaseProperties(
        Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
        T(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),
        final standardOrderComponents=true) "Base properties"

    protected
        constant Modelica.SIunits.MolarMass[2] MMX = {steam.MM,dryair.MM}
          "Molar masses of components";

        MassFraction X_steam "Mass fraction of steam water";
        MassFraction X_air "Mass fraction of air";
        Modelica.SIunits.TemperatureDifference dT(start=T_default-reference_T)
          "Temperature difference used to compute enthalpy";
      equation
        assert(T >= 200.0 and T <= 423.15, "
Temperature T is not in the allowed range
200.0 K <= (T ="   + String(T) + " K) <= 423.15 K
required from medium model \""         + mediumName + "\".");

        MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);

        X_steam  = Xi[Water]; // There is no liquid in this medium model
        X_air    = 1-Xi[Water];

        dT = T - reference_T;
        h = dT*dryair.cp * X_air +
           (dT * steam.cp + h_fg) * X_steam;
        R = dryair.R*X_air + steam.R*X_steam;

        // Equation for ideal gas, from h=u+p*v and R*T=p*v, from which follows that  u = h-R*T.
        // u = h-R*T;
        // However, in this medium, the gas law is d/dStp=p/pStp, from which follows using h=u+pv that
        // u= h-p*v = h-p/d = h-pStp/dStp
        u = h-pStp/dStp;

        // In this medium model, the density depends only
        // on temperature, but not on pressure.
        //  d = p/(R*T);
        d/dStp = p/pStp;

        state.p = p;
        state.T = T;
        state.X = X;
      end BaseProperties;

    redeclare function density "Gas density"
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output Density d "Density";
    algorithm
      d :=state.p*dStp/pStp;
      annotation(smoothOrder=5,
      Inline=true,
      Documentation(info="<html>
Density is computed from pressure, temperature and composition in the thermodynamic state record applying the ideal gas law.
</html>"));
    end density;

    redeclare function extends dynamicViscosity
        "Return the dynamic viscosity of dry air"
    algorithm
      eta := 4.89493640395e-08 * state.T + 3.88335940547e-06;
      annotation (
      smoothOrder=99,
      Inline=true,
    Documentation(info="<html>
<p>
This function returns the dynamic viscosity.
</p>
<h4>Implementation</h4>
<p>
The function is based on the 5th order polynomial
of
<a href=\"modelica://Modelica.Media.Air.MoistAir.dynamicViscosity\">
Modelica.Media.Air.MoistAir.dynamicViscosity</a>.
However, for the typical range of temperatures encountered
in building applications, a linear function sufficies.
This implementation is therefore the above 5th order polynomial,
linearized around <i>20</i>&deg;C.
The relative error of this linearization is
<i>0.4</i>% at <i>-20</i>&deg;C,
and less then
<i>0.2</i>% between  <i>-5</i>&deg;C and  <i>+50</i>&deg;C.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end dynamicViscosity;

    redeclare function enthalpyOfCondensingGas
        "Enthalpy of steam per unit mass of steam"
      extends Modelica.Icons.Function;

      input Temperature T "temperature";
      output SpecificEnthalpy h "steam enthalpy";
    algorithm
      h := (T-reference_T) * steam.cp + h_fg;
      annotation(smoothOrder=5,
      Inline=true,
      derivative=der_enthalpyOfCondensingGas);
    end enthalpyOfCondensingGas;

    redeclare replaceable function extends enthalpyOfGas
        "Enthalpy of gas mixture per unit mass of gas mixture"
    algorithm
      h := enthalpyOfCondensingGas(T)*X[Water]
           + enthalpyOfDryAir(T)*(1.0-X[Water]);
    annotation (
      Inline=true);
    end enthalpyOfGas;

    redeclare replaceable function extends enthalpyOfLiquid
        "Enthalpy of liquid (per unit mass of liquid) which is linear in the temperature"
    algorithm
      h := (T - reference_T)*cpWatLiq;
      annotation (
        smoothOrder=5,
        Inline=true,
        derivative=der_enthalpyOfLiquid);
    end enthalpyOfLiquid;

    redeclare function enthalpyOfNonCondensingGas
        "Enthalpy of non-condensing gas per unit mass of steam"
      extends Modelica.Icons.Function;

      input Temperature T "temperature";
      output SpecificEnthalpy h "enthalpy";
    algorithm
      h := enthalpyOfDryAir(T);
      annotation (
      smoothOrder=5,
      Inline=true,
      derivative=der_enthalpyOfNonCondensingGas);
    end enthalpyOfNonCondensingGas;

    redeclare function extends enthalpyOfVaporization
        "Enthalpy of vaporization of water"
    algorithm
      r0 := h_fg;
      annotation (
        Inline=true);
    end enthalpyOfVaporization;

    redeclare function extends gasConstant
        "Return ideal gas constant as a function from thermodynamic state, only valid for phi<1"

    algorithm
        R := dryair.R*(1 - state.X[Water]) + steam.R*state.X[Water];
      annotation (
        smoothOrder=2,
        Inline=true,
        Documentation(info="<html>
The ideal gas constant for moist air is computed from <a href=\"modelica://Modelica.Media.Air.MoistAir.ThermodynamicState\">thermodynamic state</a> assuming that all water is in the gas phase.
</html>"));
    end gasConstant;

    redeclare function extends pressure
        "Returns pressure of ideal gas as a function of the thermodynamic state record"

    algorithm
      p := state.p;
      annotation (
      smoothOrder=2,
      Inline=true,
      Documentation(info="<html>
Pressure is returned from the thermodynamic state record input as a simple assignment.
</html>"));
    end pressure;

    redeclare function extends isobaricExpansionCoefficient
        "Isobaric expansion coefficient beta"
    algorithm
      beta := 0;
      annotation (
        smoothOrder=5,
        Inline=true,
    Documentation(info="<html>
<p>
This function returns the isobaric expansion coefficient at constant pressure,
which is zero for this medium.
The isobaric expansion coefficient at constant pressure is
</p>
<p align=\"center\" style=\"font-style:italic;\">
&beta;<sub>p</sub> = - 1 &frasl; v &nbsp; (&part; v &frasl; &part; T)<sub>p</sub> = 0,
</p>
<p>
where
<i>v</i> is the specific volume,
<i>T</i> is the temperature and
<i>p</i> is the pressure.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end isobaricExpansionCoefficient;

    redeclare function extends isothermalCompressibility
        "Isothermal compressibility factor"
    algorithm
      kappa := -1/state.p;
      annotation (
        smoothOrder=5,
        Inline=true,
        Documentation(info="<html>
<p>
This function returns the isothermal compressibility coefficient.
The isothermal compressibility is
</p>
<p align=\"center\" style=\"font-style:italic;\">
&kappa;<sub>T</sub> = -1 &frasl; v &nbsp; (&part; v &frasl; &part; p)<sub>T</sub>
  = -1 &frasl; p,
</p>
<p>
where
<i>v</i> is the specific volume,
<i>T</i> is the temperature and
<i>p</i> is the pressure.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end isothermalCompressibility;

    redeclare function extends saturationPressure
        "Saturation curve valid for 223.16 <= T <= 373.16 (and slightly outside with less accuracy)"

    algorithm
      psat := AixLib.Utilities.Psychrometrics.Functions.saturationPressure(Tsat);
      annotation (
      smoothOrder=5,
      Inline=true);
    end saturationPressure;

    redeclare function extends specificEntropy
        "Return the specific entropy, only valid for phi<1"

    protected
        Modelica.SIunits.MoleFraction[2] Y "Molar fraction";
    algorithm
        Y := massToMoleFractions(
             state.X, {steam.MM,dryair.MM});
        s := specificHeatCapacityCp(state) * Modelica.Math.log(state.T/reference_T)
             - Modelica.Constants.R *
             sum(state.X[i]/MMX[i]*
                 Modelica.Math.log(max(Y[i], Modelica.Constants.eps)*state.p/reference_p) for i in 1:2);
      annotation (
      Inline=true,
        Documentation(info="<html>
<p>
This function computes the specific entropy.
</p>
<p>
The specific entropy of the mixture is obtained from
</p>
<p align=\"center\" style=\"font-style:italic;\">
s = s<sub>s</sub> + s<sub>m</sub>,
</p>
<p>
where
<i>s<sub>s</sub></i> is the entropy change due to the state change
(relative to the reference temperature) and
<i>s<sub>m</sub></i> is the entropy change due to mixing
of the dry air and water vapor.
</p>
<p>
The entropy change due to change in state is obtained from
</p>
<p align=\"center\" style=\"font-style:italic;\">
s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(v/v<sub>0</sub>) <br/>
= c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(&rho;<sub>0</sub>/&rho;)
</p>
<p>If we assume <i>&rho; = p<sub>0</sub>/(R T)</i>,
and because <i>c<sub>p</sub> = c<sub>v</sub> + R</i>,
we can write
</p>
<p align=\"center\" style=\"font-style:italic;\">
s<sub>s</sub> = c<sub>v</sub> ln(T/T<sub>0</sub>) + R ln(T/T<sub>0</sub>) <br/>
=c<sub>p</sub> ln(T/T<sub>0</sub>).
</p>
<p>
Next, the entropy of mixing is obtained from a reversible isothermal
expansion process. Hence,
</p>
<p align=\"center\" style=\"font-style:italic;\">
  s<sub>m</sub> = -R &sum;<sub>i</sub>( X<sub>i</sub> &frasl; M<sub>i</sub>
  ln(Y<sub>i</sub> p/p<sub>0</sub>)),
</p>
<p>
where <i>R</i> is the gas constant,
<i>X</i> is the mass fraction,
<i>M</i> is the molar mass, and
<i>Y</i> is the mole fraction.
</p>
<p>
To obtain the state for a given pressure, entropy and mass fraction, use
<a href=\"modelica://AixLib.Media.Air.setState_psX\">
AixLib.Media.Air.setState_psX</a>.
</p>
<h4>Limitations</h4>
<p>
This function is only valid for a relative humidity below 100%.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 27, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end specificEntropy;

    redeclare function extends density_derp_T
        "Return the partial derivative of density with respect to pressure at constant temperature"
    algorithm
      ddpT := dStp/pStp;
      annotation (
      Inline=true,
    Documentation(info="<html>
<p>
This function returns the partial derivative of density
with respect to pressure at constant temperature.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end density_derp_T;

    redeclare function extends density_derT_p
        "Return the partial derivative of density with respect to temperature at constant pressure"
    algorithm
      ddTp := 0;

      annotation (
      smoothOrder=99,
      Inline=true,
      Documentation(info=
    "<html>
<p>
This function computes the derivative of density with respect to temperature
at constant pressure.
</p>
</html>",     revisions=
    "<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end density_derT_p;

    redeclare function extends density_derX
        "Return the partial derivative of density with respect to mass fractions at constant pressure and temperature"
    algorithm
      dddX := fill(0, nX);
    annotation (
      smoothOrder=99,
      Inline=true,
      Documentation(info="<html>
<p>
This function returns the partial derivative of density
with respect to mass fraction.
This value is zero because in this medium, density is proportional
to pressure, but independent of the species concentration.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end density_derX;

    redeclare replaceable function extends specificHeatCapacityCp
        "Specific heat capacity of gas mixture at constant pressure"
    algorithm
      cp := dryair.cp*(1-state.X[Water]) +steam.cp*state.X[Water];
        annotation (
      smoothOrder=99,
      Inline=true,
      derivative=der_specificHeatCapacityCp);
    end specificHeatCapacityCp;

    redeclare replaceable function extends specificHeatCapacityCv
        "Specific heat capacity of gas mixture at constant volume"
    algorithm
      cv:= dryair.cv*(1-state.X[Water]) +steam.cv*state.X[Water];
      annotation (
        smoothOrder=99,
        Inline=true,
        derivative=der_specificHeatCapacityCv);
    end specificHeatCapacityCv;

    redeclare function setState_dTX
        "Return thermodynamic state as function of density d, temperature T and composition X"
      extends Modelica.Icons.Function;
      input Density d "Density";
      input Temperature T "Temperature";
      input MassFraction X[:]=reference_X "Mass fractions";
      output ThermodynamicState state "Thermodynamic state";

    algorithm
        // Note that d/dStp = p/pStp, hence p = d*pStp/dStp
        state := if size(X, 1) == nX then
                   ThermodynamicState(p=d*pStp/dStp, T=T, X=X)
                 else
                   ThermodynamicState(p=d*pStp/dStp,
                                      T=T,
                                      X=cat(1, X, {1 - sum(X)}));
        annotation (
        smoothOrder=2,
        Inline=true,
        Documentation(info="<html>
<p>
The <a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">thermodynamic state record</a>
    is computed from density <code>d</code>, temperature <code>T</code> and composition <code>X</code>.
</p>
</html>"));
    end setState_dTX;

    redeclare function extends setState_phX
        "Return thermodynamic state as function of pressure p, specific enthalpy h and composition X"
    algorithm
      state := if size(X, 1) == nX then
        ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=X)
     else
        ThermodynamicState(p=p, T=temperature_phX(p, h, X), X=cat(1, X, {1 - sum(X)}));
      annotation (
      smoothOrder=2,
      Inline=true,
      Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic state record</a> is computed from pressure p, specific enthalpy h and composition X.
</html>"));
    end setState_phX;

    redeclare function extends setState_pTX
        "Return thermodynamic state as function of p, T and composition X or Xi"
    algorithm
        state := if size(X, 1) == nX then
                    ThermodynamicState(p=p, T=T, X=X)
                 else
                    ThermodynamicState(p=p, T=T, X=cat(1, X, {1 - sum(X)}));
        annotation (
      smoothOrder=2,
      Inline=true,
      Documentation(info="<html>
The <a href=\"modelica://Modelica.Media.Interfaces.PartialMixtureMedium.ThermodynamicState\">
thermodynamic state record</a> is computed from pressure p, temperature T and composition X.
</html>"));
    end setState_pTX;

    redeclare function extends setState_psX
        "Return the thermodynamic state as function of p, s and composition X or Xi"
    protected
        Modelica.SIunits.MassFraction[2] X_int=
          if size(X, 1) == nX then X else cat(1, X, {1 - sum(X)}) "Mass fraction";
        Modelica.SIunits.MoleFraction[2] Y "Molar fraction";
        Modelica.SIunits.Temperature T "Temperature";
    algorithm
       Y := massToMoleFractions(
             X_int, {steam.MM,dryair.MM});
        // The next line is obtained from symbolic solving the
        // specificEntropy function for T.
        // In this formulation, we can set T to any value when calling
        // specificHeatCapacityCp as cp does not depend on T.
        T := 273.15 * Modelica.Math.exp((s + Modelica.Constants.R *
               sum(X_int[i]/MMX[i]*
                 Modelica.Math.log(max(Y[i], Modelica.Constants.eps)) for i in 1:2))
                 / specificHeatCapacityCp(setState_pTX(p=p,
                                                       T=273.15,
                                                       X=X_int)));

        state := ThermodynamicState(p=p,
                                    T=T,
                                    X=X_int);

    annotation (
    Inline=true,
    Documentation(info="<html>
<p>
This function returns the thermodynamic state based on pressure,
specific entropy and mass fraction.
</p>
<p>
The state is computed by symbolically solving
<a href=\"modelica://AixLib.Media.Air.specificEntropy\">
AixLib.Media.Air.specificEntropy</a>
for temperature.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 27, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end setState_psX;

    redeclare replaceable function extends specificEnthalpy
        "Compute specific enthalpy from pressure, temperature and mass fraction"
    algorithm
      h := (state.T - reference_T)*dryair.cp * (1 - state.X[Water]) +
           ((state.T-reference_T) * steam.cp + h_fg) * state.X[Water];
      annotation (
       smoothOrder=5,
       Inline=true);
    end specificEnthalpy;

    redeclare replaceable function specificEnthalpy_pTX "Specific enthalpy"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Pressure p "Pressure";
      input Modelica.SIunits.Temperature T "Temperature";
      input Modelica.SIunits.MassFraction X[:] "Mass fractions of moist air";
      output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy at p, T, X";

    algorithm
      h := specificEnthalpy(setState_pTX(p, T, X));
      annotation(smoothOrder=5,
                 Inline=true,
                 inverse(T=temperature_phX(p, h, X)),
                 Documentation(info="<html>
Specific enthalpy as a function of temperature and species concentration.
The pressure is input for compatibility with the medium models, but the specific enthalpy
is independent of the pressure.
</html>",
    revisions="<html>
<ul>
<li>
April 30, 2015, by Filip Jorissen and Michael Wetter:<br/>
Added <code>Inline=true</code> for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/227\">
issue 227</a>.
</li>
</ul>
</html>"));
    end specificEnthalpy_pTX;

    redeclare replaceable function extends specificGibbsEnergy
        "Specific Gibbs energy"
    algorithm
      g := specificEnthalpy(state) - state.T*specificEntropy(state);
      annotation (
        Inline=true);
    end specificGibbsEnergy;

    redeclare replaceable function extends specificHelmholtzEnergy
        "Specific Helmholtz energy"
    algorithm
      f := specificEnthalpy(state) - gasConstant(state)*state.T - state.T*specificEntropy(state);
      annotation (
        Inline=true);
    end specificHelmholtzEnergy;

    redeclare function extends isentropicEnthalpy "Return the isentropic enthalpy"
    algorithm
      h_is := specificEnthalpy(setState_psX(
                p=p_downstream,
                s=specificEntropy(refState),
                X=refState.X));
    annotation (
      Inline=true,
      Documentation(info="<html>
<p>
This function computes the specific enthalpy for
an isentropic state change from the temperature
that corresponds to the state <code>refState</code>
to <code>reference_T</code>.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end isentropicEnthalpy;

    redeclare function extends specificInternalEnergy "Specific internal energy"
      extends Modelica.Icons.Function;
    algorithm
      u := specificEnthalpy(state) - pStp/dStp;
      annotation (
        Inline=true);
    end specificInternalEnergy;

    redeclare function extends temperature
        "Return temperature of ideal gas as a function of the thermodynamic state record"
    algorithm
      T := state.T;
      annotation (
      smoothOrder=2,
      Inline=true,
      Documentation(info="<html>
Temperature is returned from the thermodynamic state record input as a simple assignment.
</html>"));
    end temperature;

    redeclare function extends molarMass "Return the molar mass"
    algorithm
        MM := 1/(state.X[Water]/MMX[Water]+(1.0-state.X[Water])/MMX[Air]);
        annotation (
    Inline=true,
    smoothOrder=99,
    Documentation(info="<html>
<p>
This function returns the molar mass.
</p>
</html>",
    revisions="<html>
<ul>
<li>
December 18, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end molarMass;

    redeclare replaceable function temperature_phX
        "Compute temperature from specific enthalpy and mass fraction"
        extends Modelica.Icons.Function;
      input AbsolutePressure p "Pressure";
      input SpecificEnthalpy h "specific enthalpy";
      input MassFraction[:] X "mass fractions of composition";
      output Temperature T "temperature";
    algorithm
      T := reference_T + (h - h_fg * X[Water])
           /((1 - X[Water])*dryair.cp + X[Water] * steam.cp);
      annotation(smoothOrder=5,
                 Inline=true,
                 inverse(h=specificEnthalpy_pTX(p, T, X)),
                 Documentation(info="<html>
Temperature as a function of specific enthalpy and species concentration.
The pressure is input for compatibility with the medium models, but the temperature
is independent of the pressure.
</html>",
    revisions="<html>
<ul>
<li>
April 30, 2015, by Filip Jorissen and Michael Wetter:<br/>
Added <code>Inline=true</code> for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/227\">
issue 227</a>.
</li>
</ul>
</html>"));
    end temperature_phX;

    redeclare function extends thermalConductivity
        "Thermal conductivity of dry air as a polynomial in the temperature"
    algorithm
      lambda := Modelica.Media.Incompressible.TableBased.Polynomials_Temp.evaluate(
          {(-4.8737307422969E-008), 7.67803133753502E-005, 0.0241814385504202},
       Modelica.SIunits.Conversions.to_degC(state.T));
    annotation(LateInline=true);
    end thermalConductivity;
    //////////////////////////////////////////////////////////////////////
    // Protected classes.
    // These classes are only of use within this medium model.
    // Models generally have no need to access them.
    // Therefore, they are made protected. This also allows to redeclare the
    // medium model with another medium model that does not provide an
    // implementation of these classes.
  protected
      record GasProperties
        "Coefficient data record for properties of perfect gases"
        extends Modelica.Icons.Record;

        Modelica.SIunits.MolarMass MM "Molar mass";
        Modelica.SIunits.SpecificHeatCapacity R "Gas constant";
        Modelica.SIunits.SpecificHeatCapacity cp
          "Specific heat capacity at constant pressure";
        Modelica.SIunits.SpecificHeatCapacity cv = cp-R
          "Specific heat capacity at constant volume";
        annotation (
          preferredView="info",
          defaultComponentName="gas",
          Documentation(info="<html>
<p>
This data record contains the coefficients for perfect gases.
</p>
</html>",     revisions="<html>
<ul>
<li>
September 12, 2014, by Michael Wetter:<br/>
Corrected the wrong location of the <code>preferredView</code>
and the <code>revisions</code> annotation.
</li>
<li>
November 21, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
      end GasProperties;
      // In the assignments below, we compute cv as OpenModelica
      // cannot evaluate cv=cp-R as defined in GasProperties.
      constant GasProperties dryair(
        R =    Modelica.Media.IdealGases.Common.SingleGasesData.Air.R,
        MM =   Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM,
        cp =   AixLib.Utilities.Psychrometrics.Constants.cpAir,
        cv =   AixLib.Utilities.Psychrometrics.Constants.cpAir
                 -Modelica.Media.IdealGases.Common.SingleGasesData.Air.R)
        "Dry air properties";
      constant GasProperties steam(
        R =    Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R,
        MM =   Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
        cp =   AixLib.Utilities.Psychrometrics.Constants.cpSte,
        cv =   AixLib.Utilities.Psychrometrics.Constants.cpSte
                 -Modelica.Media.IdealGases.Common.SingleGasesData.H2O.R)
        "Steam properties";

      constant Real k_mair =  steam.MM/dryair.MM "Ratio of molar weights";

      constant Modelica.SIunits.MolarMass[2] MMX={steam.MM,dryair.MM}
        "Molar masses of components";

      constant Modelica.SIunits.SpecificEnergy h_fg=
        AixLib.Utilities.Psychrometrics.Constants.h_fg
        "Latent heat of evaporation of water";
      constant Modelica.SIunits.SpecificHeatCapacity cpWatLiq=
        AixLib.Utilities.Psychrometrics.Constants.cpWatLiq
        "Specific heat capacity of liquid water";

    replaceable function der_enthalpyOfLiquid
        "Temperature derivative of enthalpy of liquid per unit mass of liquid"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of liquid enthalpy";
    algorithm
      der_h := cpWatLiq*der_T;
      annotation (
        Inline=true);
    end der_enthalpyOfLiquid;

    function der_enthalpyOfCondensingGas
        "Derivative of enthalpy of steam per unit mass of steam"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of steam enthalpy";
    algorithm
      der_h := steam.cp*der_T;
      annotation (
        Inline=true);
    end der_enthalpyOfCondensingGas;

    replaceable function enthalpyOfDryAir
        "Enthalpy of dry air per unit mass of dry air"
      extends Modelica.Icons.Function;

      input Temperature T "Temperature";
      output SpecificEnthalpy h "Dry air enthalpy";
    algorithm
      h := (T - reference_T)*dryair.cp;
      annotation (
        smoothOrder=5,
        Inline=true,
        derivative=der_enthalpyOfDryAir);
    end enthalpyOfDryAir;

    replaceable function der_enthalpyOfDryAir
        "Derivative of enthalpy of dry air per unit mass of dry air"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of dry air enthalpy";
    algorithm
      der_h := dryair.cp*der_T;
      annotation (
        Inline=true);
    end der_enthalpyOfDryAir;

    replaceable function der_enthalpyOfNonCondensingGas
        "Derivative of enthalpy of non-condensing gas per unit mass of steam"
      extends Modelica.Icons.Function;
      input Temperature T "Temperature";
      input Real der_T "Temperature derivative";
      output Real der_h "Derivative of steam enthalpy";
    algorithm
      der_h := der_enthalpyOfDryAir(T, der_T);
      annotation (
        Inline=true);
    end der_enthalpyOfNonCondensingGas;

    replaceable function der_specificHeatCapacityCp
        "Derivative of specific heat capacity of gas mixture at constant pressure"
      extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state";
        input ThermodynamicState der_state "Derivative of thermodynamic state";
        output Real der_cp(unit="J/(kg.K.s)")
          "Derivative of specific heat capacity";
    algorithm
      der_cp := (steam.cp-dryair.cp)*der_state.X[Water];
      annotation (
        Inline=true);
    end der_specificHeatCapacityCp;

    replaceable function der_specificHeatCapacityCv
        "Derivative of specific heat capacity of gas mixture at constant volume"
      extends Modelica.Icons.Function;
        input ThermodynamicState state "Thermodynamic state";
        input ThermodynamicState der_state "Derivative of thermodynamic state";
        output Real der_cv(unit="J/(kg.K.s)")
          "Derivative of specific heat capacity";
    algorithm
      der_cv := (steam.cv-dryair.cv)*der_state.X[Water];
      annotation (
        Inline=true);
    end der_specificHeatCapacityCv;
      annotation(preferredView="info", Documentation(info="<html>
<p>
This medium package models moist air using a gas law in which pressure and temperature
are independent, which often leads to significantly faster and more robust computations.
The specific heat capacities at constant pressure and at constant volume are constant.
The air is assumed to be not saturated.
</p>
<p>
This medium uses the gas law
</p>
<p align=\"center\" style=\"font-style:italic;\">
&rho;/&rho;<sub>stp</sub> = p/p<sub>stp</sub>,
</p>
<p>
where
<i>p<sub>std</sub></i> and <i>&rho;<sub>stp</sub></i> are constant reference
temperature and density, rathern than the ideal gas law
</p>
<p align=\"center\" style=\"font-style:italic;\">
&rho; = p &frasl;(R T),
</p>
<p>
where <i>R</i> is the gas constant and <i>T</i> is the temperature.
</p>
<p>
This formulation often leads to smaller systems of nonlinear equations
because equations for pressure and temperature are decoupled.
Therefore, if air inside a control volume such as room air is heated, it
does not increase its specific volume. Consequently, merely heating or cooling
a control volume does not affect the air flow calculations in a duct network
that may be connected to that volume.
Note that multizone air exchange simulation in which buoyancy drives the
air flow is still possible as the models in
<a href=\"modelica://AixLib.Airflow.Multizone\">
AixLib.Airflow.Multizone</a> compute the mass density using the function
<a href=\"modelica://AixLib.Utilities.Psychrometrics.Functions.density_pTX\">
AixLib.Utilities.Psychrometrics.Functions.density_pTX</a> in which density
is a function of temperature.
</p>
<p>
Note that models in this package implement the equation for the internal energy as
</p>
<p align=\"center\" style=\"font-style:italic;\">
  u = h - p<sub>stp</sub> &frasl; &rho;<sub>stp</sub>,
</p>
<p>
where
<i>u</i> is the internal energy per unit mass,
<i>h</i> is the enthalpy per unit mass,
<i>p<sub>stp</sub></i> is the static pressure and
<i>&rho;<sub>stp</sub></i> is the mass density at standard pressure and temperature.
The reason for this implementation is that in general,
</p>
<p align=\"center\" style=\"font-style:italic;\">
  h = u + p v,
</p>
<p>
from which follows that
</p>
<p align=\"center\" style=\"font-style:italic;\">
  u = h - p v = h - p &frasl; &rho; = h - p<sub>stp</sub> &frasl; &rho;<sub>std</sub>,
</p>
<p>
because <i>p &frasl; &rho; = p<sub>stp</sub> &frasl; &rho;<sub>stp</sub></i> in this medium model.
</p>
<p>
The enthalpy is computed using the convention that <i>h=0</i>
if <i>T=0</i> &deg;C and no water vapor is present.
</p>
</html>",     revisions="<html>
<ul>
<li>
November 4, 2016, by Michael Wetter:<br/>
Set default value for <code>dT.start</code> in base properties.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/575\">#575</a>.
</li>
<li>
June 6, 2015, by Michael Wetter:<br/>
Set <code>AbsolutePressure(start=p_default)</code> to avoid
a translation error if
<a href=\"modelica://AixLib.Fluid.Sources.Examples.TraceSubstancesFlowSource\">
AixLib.Fluid.Sources.Examples.TraceSubstancesFlowSource</a>
is translated in pedantic mode in Dymola 2016.
The reason is that pressures use <code>Medium.p_default</code> as start values,
but
<a href=\"modelica://Modelica.Media.Interfaces.Types\">
Modelica.Media.Interfaces.Types</a>
sets a default value of <i>1E-5</i>.
A similar change has been done for pressure.
This fixes
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">#266</a>.
</li>
<li>
June 5, 2015, by Michael Wetter:<br/>
Added <code>stateSelect</code> attribute in <code>BaseProperties.T</code>
to allow correct use of <code>preferredMediumState</code> as
described in
<a href=\"modelica://Modelica.Media.Interfaces.PartialMedium\">
Modelica.Media.Interfaces.PartialMedium</a>.
Note that the default is <code>preferredMediumState=false</code>
and hence the same states are used as were used before.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/260\">#260</a>.
</li>
<li>
May 11, 2015, by Michael Wetter:<br/>
Removed
<code>p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)</code>
in declaration of <code>BaseProperties</code>.
Otherwise, when models that contain a fluid volume
are exported as an FMU, their pressure would be
differentiated with respect to time. This would require
the time derivative of the inlet pressure, which is not available,
causing the translation to stop with an error.
</li>
<li>
May 1, 2015, by Michael Wetter:<br/>
Added <code>Inline=true</code> for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/227\">
issue 227</a>.
</li>
<li>
March 20, 2015, by Michael Wetter:<br/>
Added missing term <code>state.p/reference_p</code> in function
<code>specificEntropy</code>.
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/193\">#193</a>.
</li>
<li>
February 3, 2015, by Michael Wetter:<br/>
Removed <code>stateSelect.prefer</code> for temperature.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/160\">#160</a>.
</li>
<li>
July 24, 2014, by Michael Wetter:<br/>
Changed implementation to use
<a href=\"modelica://AixLib.Utilities.Psychrometrics.Constants\">
AixLib.Utilities.Psychrometrics.Constants</a>.
This was done to use consistent values throughout the library.
</li>
<li>
November 16, 2013, by Michael Wetter:<br/>
Revised and simplified the implementation.
</li>
<li>
November 14, 2013, by Michael Wetter:<br/>
Removed function
<code>HeatCapacityOfWater</code>
which is neither needed nor implemented in the
Modelica Standard Library.
</li>
<li>
November 13, 2013, by Michael Wetter:<br/>
Removed non-used computations in <code>specificEnthalpy_pTX</code> and
in <code>temperature_phX</code>.
</li>
<li>
March 29, 2013, by Michael Wetter:<br/>
Added <code>final standardOrderComponents=true</code> in the
<code>BaseProperties</code> declaration. This avoids an error
when models are checked in Dymola 2014 in the pedenatic mode.
</li>
<li>
April 12, 2012, by Michael Wetter:<br/>
Added keyword <code>each</code> to <code>Xi(stateSelect=...)</code>.
</li>
<li>
April 4, 2012, by Michael Wetter:<br/>
Added redeclaration of <code>ThermodynamicState</code> to avoid a warning
during model check and translation.
</li>
<li>
August 3, 2011, by Michael Wetter:<br/>
Fixed bug in <code>u=h-R*T</code>, which is only valid for ideal gases.
For this medium, the function is <code>u=h-pStd/dStp</code>.
</li>
<li>
January 27, 2010, by Michael Wetter:<br/>
Fixed bug in <code>else</code> branch of function <code>setState_phX</code>
that lead to a run-time error when the constructor of this function was called.
</li>
<li>
January 22, 2010, by Michael Wetter:<br/>
Added implementation of function
<a href=\"modelica://AixLib.Media.GasesPTDecoupled.MoistAirUnsaturated.enthalpyOfNonCondensingGas\">
enthalpyOfNonCondensingGas</a> and its derivative.
</li>
<li>
January 13, 2010, by Michael Wetter:<br/>
Fixed implementation of derivative functions.
</li>
<li>
August 28, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(graphics={
            Ellipse(
              extent={{-78,78},{-34,34}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={120,120,120}),
            Ellipse(
              extent={{-18,86},{26,42}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={120,120,120}),
            Ellipse(
              extent={{48,58},{92,14}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={120,120,120}),
            Ellipse(
              extent={{-22,32},{22,-12}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={120,120,120}),
            Ellipse(
              extent={{36,-32},{80,-76}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={120,120,120}),
            Ellipse(
              extent={{-36,-30},{8,-74}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={120,120,120}),
            Ellipse(
              extent={{-90,-6},{-46,-50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={120,120,120})}));
    end Air;
    annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains media models for water and moist air.
The media models in this package are
compatible with
<a href=\"modelica://Modelica.Media\">
Modelica.Media</a>
but the implementation is in general simpler, which often
leads to more efficient simulation.
Due to the simplifications, the media model of this package
are generally accurate for a smaller temperature range than the
models in <a href=\"modelica://Modelica.Media\">
Modelica.Media</a>, but the smaller temperature range may often be
sufficient for building HVAC applications.
</p>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Line(
            points = {{-76,-80},{-62,-30},{-32,40},{4,66},{48,66},{73,45},{62,-8},{48,-50},{38,-80}},
            color={64,64,64},
            smooth=Smooth.Bezier),
          Line(
            points={{-40,20},{68,20}},
            color={175,175,175}),
          Line(
            points={{-40,20},{-44,88},{-44,88}},
            color={175,175,175}),
          Line(
            points={{68,20},{86,-58}},
            color={175,175,175}),
          Line(
            points={{-60,-28},{56,-28}},
            color={175,175,175}),
          Line(
            points={{-60,-28},{-74,84},{-74,84}},
            color={175,175,175}),
          Line(
            points={{56,-28},{70,-80}},
            color={175,175,175}),
          Line(
            points={{-76,-80},{38,-80}},
            color={175,175,175}),
          Line(
            points={{-76,-80},{-94,-16},{-94,-16}},
            color={175,175,175})}));
  end Media;

  package ThermalZones "Models for BuildingPhysics"
      extends Modelica.Icons.Package;

    package HighOrder "Standard house models"
      extends Modelica.Icons.Package;

      package Components

        package Sunblinds
          extends Modelica.Icons.Package;

          model Sunblind "Reduces beam at Imax and TOutAirLimit"
            extends BaseClasses.PartialSunblind;

            parameter Modelica.SIunits.Temperature TOutAirLimit
              "Temperature at which sunblind closes (see also Imax)";

            Modelica.Blocks.Interfaces.RealInput TOutAir(unit="K", displayUnit="degC")
              "Outdoor air (dry bulb) temperature"
              annotation (Placement(transformation(extent={{-132,-56},{-100,-24}})));
          equation
             for i in 1:n loop
               if (Rad_In[i].I>Imax and TOutAir > TOutAirLimit) then
                 Rad_Out[i].I=Rad_In[i].I*gsunblind[i];
                 Rad_Out[i].I_dir=Rad_In[i].I_dir*gsunblind[i];
                 Rad_Out[i].I_diff=Rad_In[i].I_diff*gsunblind[i];
                 Rad_Out[i].I_gr=Rad_In[i].I_gr*gsunblind[i];
                 Rad_Out[i].AOI=Rad_In[i].AOI;
                 sunblindonoff[i]=1-gsunblind[i];
               else // quantity of solar radiation remains unchanged
                 Rad_Out[i].I=Rad_In[i].I;
                 Rad_Out[i].I_dir=Rad_In[i].I_dir;
                 Rad_Out[i].I_diff=Rad_In[i].I_diff;
                 Rad_Out[i].I_gr=Rad_In[i].I_gr;
                 Rad_Out[i].AOI=Rad_In[i].AOI;
                 sunblindonoff[i]=0;
               end if;
               end for;
                      annotation ( Icon(coordinateSystem(
                    preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                          graphics={
                  Rectangle(
                    extent={{-80,80},{80,-80}},
                    lineColor={0,0,0},
                    fillColor={87,205,255},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-80,80},{80,66}},
                    lineColor={0,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.HorizontalCylinder),
                  Ellipse(
                    extent={{-36,44},{36,-22}},
                    lineColor={255,255,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-80,16},{80,2}},
                    lineColor={0,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.HorizontalCylinder),
                  Rectangle(
                    extent={{-80,32},{80,18}},
                    lineColor={0,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.HorizontalCylinder),
                  Rectangle(
                    extent={{-80,48},{80,34}},
                    lineColor={0,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.HorizontalCylinder),
                  Rectangle(
                    extent={{-80,64},{80,50}},
                    lineColor={0,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.HorizontalCylinder),
                  Rectangle(
                    extent={{-80,80},{-76,2}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,0}),
                  Rectangle(
                    extent={{76,80},{80,2}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,0}),
                  Rectangle(
                    extent={{-56,-14},{-54,-44}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{-59,-17},{-55,-9},{-51,-17}},
                    thickness=1),
                  Line(
                    points={{-51,-41},{-55,-49},{-59,-41}},
                    thickness=1),
                  Rectangle(
                    extent={{-76,-64},{76,-76}},
                    lineColor={0,127,0},
                    fillColor={0,127,0},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-70,-56},{-12,-70}},
                    lineColor={0,0,0},
                    lineThickness=1,
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Imax"),
                  Rectangle(
                    extent={{-2,80},{2,-80}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,0},
                    origin={0,-78},
                    rotation=-90),
                  Rectangle(
                    extent={{-80,2},{-76,-76}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,0}),
                  Rectangle(
                    extent={{76,2},{80,-76}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,0}),
                  Rectangle(
                    extent={{-2,80},{2,-80}},
                    lineColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    fillColor={0,0,0},
                    origin={0,78},
                    rotation=-90),
                  Rectangle(
                    extent={{46,-52},{52,-64}},
                    lineColor={144,72,0},
                    fillColor={144,72,0},
                    fillPattern=FillPattern.Solid),
                  Ellipse(
                    extent={{42,-38},{56,-54}},
                    lineColor={0,127,0},
                    fillColor={0,127,0},
                    fillPattern=FillPattern.Solid)}),
              Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model represents a sunblind to reduce the vectorial radiance on facades, windows. etc. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<ul>
<li>You can define the amount of radiance hitting the facade with gsunblind, which states how much radiance goes through the closed sunblind</li>
<li>At which amount of radiance the sunblind will be closed is defined by Imax. Each directon is independent from all other directions and closes/opens seperately due to the radiance hitting the direction.</li>
<li>The output sunblindonoff can be used to transfer the state of the shading to another model component. It contains 1-gsunblind, which is the amount of radiances, detained by the shading.</li>
</ul>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Each direction closes seperatly, which means that in reality each direction has to have his own sensor. It seems, that if a building uses automatic shading, the sensor is on the roof and computes the radiance on each facade. This is quite similar to the concept of different sensors for different directions, as both systems close the sunblinds seperately for each direction.</p>
<p>All three components of the solar radiation of the tilted surface (direct, diffuse and reflected from ground) are reduced by the same factor.</p>
<p>There is no possibilty to disable the sunblind in a specific direction. This isn&apos;t necessary, as you can set gsunblind in this direction to 1, which means, that the whole radiance is passing through the closed sunblind.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a> and checked in the Examples <a href=\"AixLib.Building.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
</html>",         revisions="<html>
<ul>
<li><i>January 16, 2015&nbsp;</i> by Ana Constantin:<br/>Implemented as extending from PartialSunblind and using the new solar radiation connectors</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul>
</html>"));
          end Sunblind;

          package BaseClasses
            extends Modelica.Icons.BasesPackage;

            partial model PartialSunblind "A Base Class for Sunblindes"

              parameter Integer n=4
                "Size of solar vector (orientations)";
              parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n](each min=0.0,
                each max=1.0) = {1,1,1,1}
                "Total energy transmittances if sunblind is closed";
              parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax
                "Intensity at which the sunblind closes (see also TOutAirLimit)";

              Utilities.Interfaces.SolarRad_in
                                             Rad_In[n]
                annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
              Modelica.Blocks.Interfaces.RealOutput sunblindonoff[n] annotation (Placement(
                    transformation(
                    extent={{-10,-10},{10,10}},
                    rotation=-90,
                    origin={8,-100}), iconTransformation(
                    extent={{-10,-10},{10,10}},
                    rotation=-90,
                    origin={0,-90})));
              Utilities.Interfaces.SolarRad_out
                                              Rad_Out[n]
                annotation (Placement(transformation(extent={{80,0},{100,20}})));

            initial equation
              assert(n==size(gsunblind,1),"gsunblind has to have n elements");

            end PartialSunblind;
          end BaseClasses;
        end Sunblinds;

        package Walls "Wall models"
          extends Modelica.Icons.Package;

          model Wall
            "Simple wall model for outside and inside walls with windows and doors"
            import BaseLib = AixLib.Utilities;
            //Type parameter
            parameter Boolean outside = true
              "Choose if the wall is an outside or an inside wall"                                annotation(Dialog(group = "General Wall Type Parameter", compact = true), choices(choice = true
                  "Outside Wall",                                                                                                    choice = false
                  "Inside Wall",                                                                                                    radioButtons = true));
            // general wall parameters
            parameter DataBase.Walls.WallBaseDataDefinition WallType = DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
              "Choose an outside wall type from the database"                                                                                                     annotation(Dialog(group = "Room Geometry"), choicesAllMatching = true);
            parameter Modelica.SIunits.Length wall_length = 2 "Length of wall" annotation(Dialog(group = "Room Geometry"));
            parameter Modelica.SIunits.Height wall_height = 2 "Height of wall" annotation(Dialog(group = "Room Geometry"));
            // Surface parameters
            parameter Real solar_absorptance = 0.25
              "Solar absorptance coefficient of outside wall surface"                                       annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside));
            parameter Integer Model = 1
              "Choose the model for calculation of heat convection at outside surface"                           annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside, compact = true), choices(choice = 1
                  "DIN 6946",                                                                                                    choice = 2
                  "ASHRAE Fundamentals",                                                                                                    choice = 3
                  "Custom alpha",                                                                                                    radioButtons = true));
            parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 25
              "Custom alpha for convection (just for manual selection, not recommended)"                                                                      annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 3 and outside));
           DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook         surfaceType = DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
              "Surface type of outside wall"                                                                                                     annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 2 and outside), choicesAllMatching = true);
            parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1
                  "vertical wall",                                                                                                    choice = 2 "floor", choice = 3 "ceiling", radioButtons = true));
            parameter Integer calculationMethod = 1
              "Choose the model for calculation of heat convection at inside surface" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
                choice=2 "By Bernd Glueck",
                choice=3 "Constant alpha",radioButtons = true));
            parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_constant = 2.5
              "Constant alpha for convection (just for manual selection, not recommended)" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", enable = calculationMethod == 3));
            // window parameters
            parameter Boolean withWindow = false
              "Choose if the wall has got a window (only outside walls)"                                    annotation(Dialog(tab = "Window", enable = outside));
            replaceable model Window =

              AixLib.ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple
            constrainedby
            AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
              "Model for window"
                               annotation(Dialog( tab="Window",  enable = withWindow and outside), choicesAllMatching=true);
            parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType = DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
              "Choose a window type from the database"                                                                                                     annotation(Dialog(tab = "Window", enable = withWindow and outside), choicesAllMatching = true);
            parameter Modelica.SIunits.Area windowarea = 2 "Area of window" annotation(Dialog(tab = "Window", enable = withWindow and outside));
            parameter Boolean withSunblind = false "enable support of sunblinding?" annotation(Dialog(tab = "Window", enable = outside and withWindow));
            parameter Real Blinding = 0 "blinding factor: 0 means total blocking of solar irradiation" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
            parameter Real LimitSolIrr if withWindow and outside and withSunblind
              "Minimum specific total solar radiation in W/m2 for blinding becoming active (see also TOutAirLimit)"
              annotation(Dialog(tab="Window",   enable=withWindow and outside and
                    withSunblind));
            parameter Modelica.SIunits.Temperature TOutAirLimit if withWindow and outside and withSunblind
              "Temperature at which sunblind closes (see also LimitSolIrr)"
              annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
            // door parameters
            parameter Boolean withDoor = false "Choose if the wall has got a door" annotation(Dialog(tab = "Door"));
            parameter Modelica.SIunits.CoefficientOfHeatTransfer U_door = 1.8
              "Thermal transmission coefficient of door"                                                                 annotation(Dialog(tab = "Door", enable = withDoor));
            parameter Modelica.SIunits.Emissivity eps_door = 0.9
              "Solar emissivity of door material"                                                    annotation(Dialog(tab = "Door", enable = withDoor));
            parameter Modelica.SIunits.Length door_height = 2 annotation(Dialog(tab = "Door", enable = withDoor));
            parameter Modelica.SIunits.Length door_width = 1 annotation(Dialog(tab = "Door", enable = withDoor));
            // Calculation of clearance
            final parameter Modelica.SIunits.Area clearance = if not outside and withDoor then door_height * door_width else if outside and withDoor and withWindow then windowarea + door_height * door_width else if outside and withWindow then windowarea else if outside and withDoor then door_height * door_width else 0
              "Wall clearance";
            // Initial temperature
            parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20)
              "Initial temperature"                                                                                      annotation(Dialog(tab = "Advanced Parameters"));
            // COMPONENT PART
            BaseClasses.ConvNLayerClearanceStar Wall(h = wall_height, l = wall_length, T0 = T0, clearance = clearance, selectable = true, eps = WallType.eps, wallType = WallType, surfaceOrientation = ISOrientation, calcMethod = calculationMethod, alpha_constant = alpha_constant) "Wall" annotation(Placement(transformation(extent = {{-20, 14}, {2, 34}})));
            Utilities.HeatTransfer.SolarRadToHeat SolarAbsorption(coeff = solar_absorptance, A = wall_height * wall_length - clearance) if outside annotation(Placement(transformation(origin = {-39, 89}, extent = {{-10, -10}, {10, 10}})));
            BaseLib.Interfaces.SolarRad_in   SolarRadiationPort if outside annotation(Placement(transformation(extent = {{-116, 79}, {-96, 99}}), iconTransformation(extent = {{-36, 100}, {-16, 120}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside annotation(Placement(transformation(extent = {{-108, -6}, {-88, 14}}), iconTransformation(extent = {{-31, -10}, {-11, 10}})));
            Modelica.Blocks.Interfaces.RealInput WindSpeedPort if outside and (Model ==1 or Model == 2)  annotation(Placement(transformation(extent = {{-113, 54}, {-93, 74}}), iconTransformation(extent = {{-31, 78}, {-11, 98}})));
            Sunblinds.Sunblind Sunblind(
              final n=1,
              final gsunblind={Blinding},
              final Imax=LimitSolIrr,
              final TOutAirLimit=TOutAirLimit) if
                                   outside and withWindow and withSunblind
              annotation (Placement(transformation(extent={{-44,-21},{-21,5}})));
            WindowsDoors.Door Door(
              T0=T0,
              door_area=door_height*door_width,
              eps=eps_door,
              U=if outside then U_door else U_door*2) if withDoor
              annotation (Placement(transformation(extent={{-21,-102},{11,-70}})));
            Window windowSimple(T0 = T0, windowarea = windowarea, WindowType = WindowType) if outside and withWindow annotation(Placement(transformation(extent = {{-15, -48}, {11, -22}})));
            Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(A = wall_length * wall_height - clearance, Model = Model, surfaceType = surfaceType, alpha_custom = alpha_custom) if outside annotation(Placement(transformation(extent = {{-47, 48}, {-27, 68}})));
            Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 180, origin = {69, -1})));
            Utilities.Interfaces.HeatStarComb thermStarComb_inside annotation(Placement(transformation(extent = {{92, -10}, {112, 10}}), iconTransformation(extent = {{10, -10}, {30, 10}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempOutAirSensor
              "Outdoor air (dry bulb) temperature sensor"
              annotation (Placement(transformation(extent={{-66,-18},{-58,-10}})));
          equation
            //   if outside and cardinality(WindSpeedPort) < 2 then
            //     WindSpeedPort = 3;
            //   end if;
            //******************************************************************
            // **********************standard connection************************
            //******************************************************************
            connect(Wall.Star, heatStarToComb.star) annotation(Line(points={{2,30.2},{48,30.2},
                    {48,4.8},{58.6,4.8}},                                                                                   color = {95, 95, 95}, pattern = LinePattern.Solid));
            connect(Wall.port_b, heatStarToComb.therm) annotation(Line(points={{2,24},{48,
                    24},{48,-6.1},{58.9,-6.1}},                                                                                  color = {191, 0, 0}));
            //******************************************************************
            // **********************standard connection for inside wall********
            //******************************************************************
            if not outside then
              connect(Wall.port_a, port_outside) annotation(Line(points={{-20,24},{-56.45,
                      24},{-56.45,4},{-98,4}},                                                                                color = {191, 0, 0}));
            end if;
            //******************************************************************
            // ********************standard connection for outside wall*********
            //******************************************************************
            if outside then
              connect(SolarRadiationPort, SolarAbsorption.solarRad_in) annotation(Line(points = {{-106, 89}, {-77, 89}, {-77, 87}, {-49.1, 87}}, color = {255, 128, 0}));
              if Model == 1 or Model == 2 then
                connect(WindSpeedPort, heatTransfer_Outside.WindSpeedPort) annotation(Line(points = {{-103, 64}, {-68, 64}, {-68, 50.8}, {-46.2, 50.8}}, color = {0, 0, 127}));
              end if;
              connect(heatTransfer_Outside.port_a, port_outside) annotation(Line(points = {{-47, 58}, {-56, 58}, {-56, 4}, {-98, 4}}, color = {191, 0, 0}));
              connect(heatTransfer_Outside.port_b, Wall.port_a) annotation(Line(points={{-27,58},
                      {-24,58},{-24,24},{-20,24}},                                                                                       color = {191, 0, 0}));
              connect(SolarAbsorption.heatPort, Wall.port_a) annotation(Line(points={{-30,87},
                      {-26,87},{-26,84},{-20,84},{-20,24}},                                                                                        color = {191, 0, 0}));
            end if;
            //******************************************************************
            // *******standard connections for wall with door************
            //******************************************************************
            if withDoor then
              connect(Door.port_a, port_outside) annotation(Line(points = {{-19.4, -86}, {-56, -86}, {-56, 24}, {-24, 24}, {-24, 4}, {-98, 4}}, color = {191, 0, 0}));
              connect(Door.port_b, heatStarToComb.therm) annotation(Line(points = {{9.4, -86}, {48, -86}, {48, -6.1}, {58.9, -6.1}}, color = {191, 0, 0}));
              connect(Door.Star, heatStarToComb.star) annotation(Line(points = {{9.4, -76.4}, {48, -76.4}, {48, 4.8}, {58.6, 4.8}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
            end if;
            //******************************************************************
            // ****standard connections for outside wall with window***********
            //******************************************************************
            if outside and withWindow then
              connect(windowSimple.Star, heatStarToComb.star) annotation(Line(points = {{9.7, -27.2}, {48, -27.2}, {48, 4.8}, {58.6, 4.8}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
              connect(windowSimple.port_inside, heatStarToComb.therm) annotation(Line(points = {{9.7, -36.3}, {48, -36.3}, {48, -6.1}, {58.9, -6.1}}, color = {191, 0, 0}));
              connect(windowSimple.port_outside, port_outside) annotation(Line(points = {{-13.7, -36.3}, {-56, -36.3}, {-56, 4}, {-98, 4}}, color = {191, 0, 0}));
            end if;
            //******************************************************************
            // **** connections for outside wall with window without sunblind****
            //******************************************************************
            if outside and withWindow and not withSunblind then
              connect(windowSimple.solarRad_in, SolarRadiationPort) annotation(Line(points = {{-13.7, -27.2}, {-81, -27.2}, {-81, 89}, {-106, 89}}, color = {255, 128, 0}));
            end if;
            //******************************************************************
            // **** connections for outside wall with window and sunblind****
            //******************************************************************
            if outside and withWindow and withSunblind then
              connect(Sunblind.Rad_Out[1], windowSimple.solarRad_in) annotation(Line(points={{-22.15,
                      -6.7},{-18,-6.7},{-18,-27.2},{-13.7,-27.2}},                                                                                         color = {255, 128, 0}));
              connect(Sunblind.Rad_In[1], SolarRadiationPort) annotation(Line(points={{-42.85,
                      -6.7},{-81,-6.7},{-81,89},{-106,89}},                                                                                  color = {255, 128, 0}));
            end if;
            connect(heatStarToComb.thermStarComb, thermStarComb_inside) annotation(Line(points = {{78.4, -1.1}, {78.4, -1.05}, {102, -1.05}, {102, 0}}, color = {191, 0, 0}));
            connect(port_outside, port_outside) annotation(Line(points = {{-98, 4}, {-98, 4}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
            connect(tempOutAirSensor.T, Sunblind.TOutAir) annotation (Line(points={{-58,
                    -14},{-54,-14},{-54,-13.2},{-45.84,-13.2}}, color={0,0,127}));
            connect(port_outside, tempOutAirSensor.port) annotation (Line(points={{-98,4},
                    {-70,4},{-70,-14},{-66,-14}}, color={191,0,0}));
            annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-20, -120}, {20, 120}}, grid = {1, 1}), graphics={  Rectangle(extent = {{-16, 120}, {15, -60}}, fillColor = {215, 215, 215},
                      fillPattern =                                                                                                   FillPattern.Backward,  pattern=LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-16, -90}, {15, -120}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                      fillPattern =                                                                                                   FillPattern.Backward), Rectangle(extent = {{-16, -51}, {15, -92}}, lineColor = {0, 0, 0},  pattern=LinePattern.None, fillColor = {215, 215, 215},
                      fillPattern =                                                                                                   FillPattern.Backward, visible = not withDoor), Rectangle(extent = {{-16, 80}, {15, 20}}, fillColor = {255, 255, 255},
                      fillPattern =                                                                                                   FillPattern.Solid, visible = outside and withWindow, lineColor = {255, 255, 255}), Line(points = {{-2, 80}, {-2, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 80}, {1, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 77}, {-2, 77}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 23}, {-2, 23}}, color = {0, 0, 0}, visible = outside and withWindow), Ellipse(extent = {{-16, -60}, {44, -120}}, lineColor = {0, 0, 0}, startAngle = 359, endAngle = 450, visible = withDoor), Rectangle(extent = {{-16, -60}, {15, -90}}, visible = withDoor, lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
                      fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{1, 50}, {-2, 50}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{15, 80}, {15, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, 80}, {-16, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, -60}, {-16, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{15, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -90}, {15, -60}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Flexible Model for Inside Walls and Outside Walls. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The<b> WallSimple</b> model models </p>
 <ul>
 <li>Conduction and convection for a wall (different on the inside surface depending on the surface orientation: vertical wall, floor or ceiling)</li>
 <li>Outside walls may have a window and/ or a door</li>
 <li>Inside walls may have a door</li>
 </ul>
 <p>This model uses a <a href=\"AixLib.Utilities.Interfaces.HeatStarComb\">HeatStarComb</a> Connector for an easier connection of temperature and radiance inputs.</p>
 <p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
 <ul>
 <li>Outside walls are represented as complete walls</li>
 <li>Inside walls are modeled as a half of a wall, you need to connect a corresponding second half with the same values</li>
 <li>Door and window got a constant U-value</li>
 <li>No heat storage in doors or window </li>
 </ul>
 <p>Have a closer look at the used models to get more information about the assumptions. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">AixLib.Building.Components.Examples.Walls.InsideWall</a> </p>
 </html>",           revisions="<html>
 <ul>
 <li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters on upper model level. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/215\">issue 215</a></li>
 <li><i>August 22, 2014&nbsp;</i> by Ana Constantin:<br/>Corrected implementation of door also for outside walls. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/13\">issue 13</a></li>
 <li><i>May 19, 2014&nbsp;</i> by Ana Constantin:<br/>Formatted documentation appropriately</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>June 22, 2012&nbsp;</i> by Lukas Mencher:<br/>Outside wall may have a door now, icon adjusted</li>
 <li><i>Mai 24, 2012&nbsp;</i> by Ana Constantin:<br/>Added inside surface orientation</li>
 <li><i>April, 2012&nbsp;</i> by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"));
          end Wall;

          package BaseClasses
            extends Modelica.Icons.BasesPackage;

            model ConvNLayerClearanceStar
              "Wall consisting of n layers, with convection on one surface and (window) clearance"
              parameter Modelica.SIunits.Height h = 3 "Height" annotation(Dialog(group = "Geometry"));
              parameter Modelica.SIunits.Length l = 4 "Length" annotation(Dialog(group = "Geometry"));
              parameter Modelica.SIunits.Area clearance = 0 "Area of clearance" annotation(Dialog(group = "Geometry"));
              parameter Boolean selectable = false
                "Determines if wall type is set manually (false) or by definitions (true)"                                    annotation(Dialog(group = "Structure of wall layers"));
              parameter DataBase.Walls.WallBaseDataDefinition wallType = DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
                "Type of wall"                                                                                                     annotation(Dialog(group = "Structure of wall layers", enable = selectable), choicesAllMatching = true);
              parameter Integer n(min = 1) = if selectable then wallType.n else 8
                "Number of layers"                                                                   annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
              parameter Modelica.SIunits.Thickness d[n] = if selectable then wallType.d else fill(0.1, n)
                "Thickness"                                                                                           annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
              parameter Modelica.SIunits.Density rho[n] = if selectable then wallType.rho else fill(1600, n)
                "Density"                                                                                              annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
              parameter Modelica.SIunits.ThermalConductivity lambda[n] = if selectable then wallType.lambda else fill(2.4, n)
                "Thermal conductivity"                                                                                                     annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
              parameter Modelica.SIunits.SpecificHeatCapacity c[n] = if selectable then wallType.c else fill(1000, n)
                "Specific heat capacity"                                                                                                     annotation(Dialog(group = "Structure of wall layers", enable = not selectable));
              // which orientation of surface?
              parameter Integer surfaceOrientation = 1 "Surface orientation" annotation(Dialog(descriptionLabel = true, enable = if IsAlphaConstant == true then false else true), choices(choice = 1
                    "vertical",                                                                                                    choice = 2
                    "horizontal facing up",                                                                                                    choice = 3
                    "horizontal facing down",                                                                                                    radioButtons = true));
              parameter Integer calcMethod = 1
                "Choose the model for calculation of heat convection at inside surface" annotation (Dialog(descriptionLabel = true), choices(
                  choice = 1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
                  choice=2 "By Bernd Glueck",
                  choice=3 "Constant alpha",radioButtons = true));
              parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_constant = 2
                "Constant heat transfer coefficient"                                                                     annotation(Dialog(group = "Convection", enable = calcMethod == 1));
              parameter Modelica.SIunits.Emissivity eps = if selectable then wallType.eps else 0.95
                "Longwave emission coefficient"                                                                                     annotation(Dialog(group = "Radiation"));
              parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(16)
                "Initial temperature"                                                                                      annotation(Dialog(group = "Thermal"));
              // 2n HeatConds
              // n Loads
              Utilities.HeatTransfer.HeatConv_inside HeatConv1(port_b(T(start = T0)), alpha_custom = alpha_constant, A = A, surfaceOrientation = surfaceOrientation, calcMethod = calcMethod) annotation(Placement(transformation(origin={62,0},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
              Utilities.Interfaces.Star Star annotation(Placement(transformation(extent={{90,52},
                        {110,72}})));
              Utilities.HeatTransfer.HeatToStar twoStar_RadEx(A = A, eps = eps, Therm(T(start = T0)), Star(T(start = T0))) annotation(Placement(transformation(extent={{54,28},
                        {74,48}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent={{-110,
                        -10},{-90,10}}),                                                                                                        iconTransformation(extent={{-110,
                        -10},{-90,10}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent={{90,-10},
                        {110,10}}),                                                                                                          iconTransformation(extent={{90,-10},
                        {110,10}})));
              AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayer(
                final A=A,
                final n=n,
                final d=d,
                final rho=rho,
                final lambda=lambda,
                final c=c,
                final T0=T0)
                annotation (Placement(transformation(extent={{-14,-12},{12,12}})));

          protected
              parameter Modelica.SIunits.Area A = h * l - clearance;

              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a dummyTherm
                "This really helps to solve initialisation problems in huge equation systems ..."                   annotation(Placement(transformation(extent = {{49, -41}, {54, -36}})));

            equation
              connect(port_a, simpleNLayer.port_a) annotation (Line(points={{-100,0},{-14,0}},
                                                color={191,0,0}));
              connect(simpleNLayer.port_b, HeatConv1.port_b) annotation (Line(points={{12,0},{
                      52,0}},                               color={191,0,0}));
              // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--HeatConv1--port_b
              connect(HeatConv1.port_a, port_b) annotation(Line(points={{72,0},{100,0}},                             color = {200, 100, 0}));
              connect(HeatConv1.port_b, twoStar_RadEx.Therm) annotation(Line(points={{52,0},{
                      50,0},{50,38},{54.8,38}},                                                                                   color = {200, 100, 0}));
              connect(twoStar_RadEx.Star, Star) annotation(Line(points={{73.1,38},{100,38},
                      {100,62}},                                                                           color = {95, 95, 95}, pattern = LinePattern.Solid));
              connect(HeatConv1.port_b, dummyTherm) annotation(Line(points={{52,0},{51.5,0},
                      {51.5,-38.5}},                                                                                color = {200, 100, 0}));
              // computing approximated longwave radiation exchange

              annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),                                                                                  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{24, 100}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-56, 100}, {0, -100}}, lineColor = {166, 166, 166}, pattern = LinePattern.None, fillColor = {190, 190, 190},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-64, 100}, {-56, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-72, 100}, {-64, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 100}, {-72, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{0, 100}, {8, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{16, 100}, {24, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{8, 100}, {16, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, -30}, {80, -42}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {255, 255, 255},
                        fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, -32}, {80, -39}}, lineColor = {0, 0, 0}, pattern = LinePattern.Dash, fillColor = {215, 215, 215},
                        fillPattern =                                                                                                   FillPattern.Solid, textString = "gap"), Text(extent = {{-44, -40}, {52, -114}}, lineColor = {0, 0, 0}, textString = "n")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>ConvNLayerClearanceStar</b> model represents a wall, consisting of n different layers with natural convection on one side and (window) clearance.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>There is one inner and one outer <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector to simulate one-dimensional heat transfer through the wall and heat storage within the wall.</p>
 <p>The <b>ConvNLayerClearanceStar</b> model extends the basic concept by adding the functionality of approximated longwave radiation exchange. Simply connect all radiation exchanging surfaces via their <b><a href=\"Modelica://AixLib.Utilities.Interfaces.Star\">Star</a></b>-connectors. </p>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a>  therefore also part of the corresponding examples <a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
 </html>",             revisions="<html>
 <ul>
<li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters</li>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>Aug. 08, 2006&nbsp;</i>
          by Peter Matthes:<br/>
          Fixed wrong connection with heatConv-Module and added connection graphics.</li>

<li><i>June 19, 2006&nbsp;</i>
          by Timo Haase:<br/>
          Implemented.</li>
 </ul>
 </html>"));
            end ConvNLayerClearanceStar;

            model SimpleNLayer "Wall consisting of n layers"
              parameter Modelica.SIunits.Area A = 12 "Area" annotation(Dialog(group = "Geometry"));
              parameter Integer n(min = 1) = 8 "Number of layers" annotation(Dialog(group = "Structure of wall layers"));
              parameter Modelica.SIunits.Thickness d[n] = fill(0.1, n) "Thickness" annotation(Dialog(group = "Structure of wall layers"));
              parameter Modelica.SIunits.Density rho[n] = fill(1600, n) "Density" annotation(Dialog(group = "Structure of wall layers"));
              parameter Modelica.SIunits.ThermalConductivity lambda[n] = fill(2.4, n)
                "Thermal conductivity"                                                                       annotation(Dialog(group = "Structure of wall layers"));
              parameter Modelica.SIunits.SpecificHeatCapacity c[n] = fill(1000, n)
                "Specific heat capacity"                                                                    annotation(Dialog(group = "Structure of wall layers"));
              parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(16)
                "Initial temperature"                                                                                      annotation(Dialog(group = "Thermal"));
              // 2n HeatConds
              Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCondb[n](G = A .* lambda ./ (d / 2)) annotation(Placement(transformation(extent={{30,-10},
                        {50,10}})));
              Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatConda[n](G = A .* lambda ./ (d / 2)) annotation(Placement(transformation(extent={{-52,-10},
                        {-32,10}})));
              // n Loads
              Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load[n](T(start = fill(T0, n)), C = c .* rho .* A .* d) annotation(Placement(transformation(extent={{-10,-42},
                        {10,-22}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent={{-110,
                        -10},{-90,10}}),                                                                                                        iconTransformation(extent={{-110,
                        -10},{-90,10}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent={{90,-10},
                        {110,10}}),                                                                                                           iconTransformation(extent={{90,-10},
                        {110,10}})));
            equation
              // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
              for i in 1:n loop
                connect(HeatConda[i].port_b, Load[i].port) annotation (Line(
                  points={{-32,0},{-18,0},{-18,-42},{0,-42}},
                  color={191,0,0},
                  pattern=LinePattern.DashDotDot));
                connect(Load[i].port, HeatCondb[i].port_a) annotation (Line(
                  points={{0,-42},{18,-42},{18,0},{30,0}},
                  color={191,0,0},
                  pattern=LinePattern.DashDotDot));
              end for;
              // establishing n-1 connections of HeatCondb--Load--HeatConda groups
              for i in 1:n - 1 loop
                connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a) annotation (Line(
                  points={{50,0},{58,0},{58,24},{-58,24},{-58,0},{-52,0}},
                  color={191,0,0},
                  pattern=LinePattern.DashDotDot));
              end for;
              // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--port_b
              connect(HeatConda[1].port_a, port_a) annotation (Line(
                  points={{-52,0},{-100,0}},
                  color={191,0,0},
                  pattern=LinePattern.DashDotDot));
              connect(HeatCondb[n].port_b, port_b)
                                                  annotation (Line(
                  points={{50,0},{100,0}},
                  color={191,0,0},
                  pattern=LinePattern.DashDotDot));
              annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),                                                                                  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}), Rectangle(extent = {{-32, 60}, {32, -100}}, lineColor = {166, 166, 166}, pattern = LinePattern.None, fillColor = {190, 190, 190},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {135, 135, 135}), Rectangle(extent = {{-48, 60}, {-32, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-64, 60}, {-48, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 60}, {-64, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{64, 60}, {80, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{32, 60}, {48, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
                        fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{48, 60}, {64, -100}}, lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
                        fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{10, -36}, {106, -110}}, lineColor = {0, 0, 0}, textString = "n")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>SimpleNLayer</b> model represents a simple wall, consisting of n different layers. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>There is one inner and one outer <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector to simulate one-dimensional heat transfer through the wall and heat storage within the wall.</p>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
 </html>
 ",             revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>March 14, 2005&nbsp;</i>
          by Timo Haase:<br/>
          Implemented.</li>
 </ul>
 </html>"));
            end SimpleNLayer;
          end BaseClasses;
          annotation(Documentation(info = "<html>
 <p>
 This package contains aggregated models for definition of walls.
 </p>

 <dl>
 <dt><b>Main Author:</b>
 <dd>Timo Haase <br/>
     Technische Universtit&auml;t Berlin <br/>
     Hermann-Rietschel-Institut <br/>
     Marchstr. 4 <br/>
     D-10587 Berlin <br/>
     e-mail: <a href=\"mailto:timo.haase@tu-berlin.de\">timo.haase@tu-berlin.de</a><br/>
 </dl>
 <br/>

 </html>"));
        end Walls;

        package WindowsDoors "Models for windows and doors"
          extends Modelica.Icons.Package;

          model Door "Simple door"
            parameter Modelica.SIunits.Area door_area = 2 "Total door area" annotation(Dialog(group = "Geometry"));
            parameter Modelica.SIunits.CoefficientOfHeatTransfer U = 1.8
              "Thermal transmission coefficient"                                                            annotation(Dialog(group = "Properties"));
            parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20)
              "Initial temperature"                                                                                      annotation(Dialog(group = "Properties"));
            parameter Modelica.SIunits.Emissivity eps = 0.9 "Emissivity of door material" annotation(Dialog(group = "Properties"));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-100, -10}, {-80, 10}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{80, -10}, {100, 10}})));
            Utilities.HeatTransfer.HeatToStar twoStar_RadEx(Therm(T(start = T0)), Star(T(start = T0)), A = door_area, eps = eps) annotation(Placement(transformation(extent = {{30, 50}, {50, 70}})));
            Utilities.Interfaces.Star Star annotation(Placement(transformation(extent = {{80, 50}, {100, 70}})));
            Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(G = door_area * U) annotation(Placement(transformation(extent = {{-10, -8}, {10, 12}})));
            Utilities.HeatTransfer.HeatToStar twoStar_RadEx1(Therm(T(start = T0)), Star(T(start = T0)), A = door_area, eps = eps) annotation(Placement(transformation(extent = {{-32, 50}, {-52, 70}})));
            Utilities.Interfaces.Star Star1 annotation(Placement(transformation(extent = {{-100, 50}, {-80, 70}})));
          equation
            connect(twoStar_RadEx.Star, Star) annotation(Line(points = {{49.1, 60}, {90, 60}}, pattern = LinePattern.Solid));
            connect(port_a, HeatTrans.port_a) annotation(Line(points = {{-90, 0}, {-49.5, 0}, {-49.5, 2}, {-10, 2}}));
            connect(HeatTrans.port_b, port_b) annotation(Line(points = {{10, 2}, {49.5, 2}, {49.5, 0}, {90, 0}}));
            connect(twoStar_RadEx.Therm, HeatTrans.port_b) annotation(Line(points = {{30.8, 60}, {20, 60}, {20, 2}, {10, 2}}, color = {191, 0, 0}));
            connect(twoStar_RadEx1.Therm, HeatTrans.port_a) annotation(Line(points = {{-32.8, 60}, {-20, 60}, {-20, 2}, {-10, 2}}, color = {191, 0, 0}));
            connect(twoStar_RadEx1.Star, Star1) annotation(Line(points = {{-51.1, 60}, {-90, 60}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
            annotation(Dialog(group = "Air exchange"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Line(points = {{-40, 18}, {-36, 18}}, color = {255, 255, 0}), Rectangle(extent = {{-52, 82}, {48, -78}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                      fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-46, 76}, {40, -68}}, lineColor = {0, 0, 0},
                      fillPattern =                                                                                                   FillPattern.Solid, fillColor = {127, 0, 0}), Rectangle(extent = {{28, 12}, {36, 0}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                      fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>The<b> Door</b> model models </p>
 <ul>
 <li>the conductive heat transfer through the door with a U-Value is set to 1.8 W/(m&sup2;K) (EnEV2009)</li>
 <li>the radiative heat transfer on both sides</li>
 </ul>
 <h4><span style=\"color:#008000\">Assumptions</span></h4>
 <ul>
 <li>Constant U-value.</li>
 </ul>
 <h4><span style=\"color:#008000\">References/ U-values special doors</span></h4>
 <ul>
 <li>Doors of wood or plastic 40 mm: 2,2 W/(m&sup2;K)</li>
 <li>Doors of wood 60 mm: 1,7 W/(m&sup2;K)</li>
 <li>Doors of wood with glass:</li>
 <li>7 mm wired glass: 4,5 W/(m&sup2;K)</li>
 <li>20 mm insulated glass: 2,8 W/(m&sup2;K) </li>
 </ul>
 <p>- Doors with a frame of light metal and with glass:</p>
 <ul>
 <li>7 mm wired glass: 5,5 W/(m&sup2;K)</li>
 <li>20 mm insulated glass: 3,5 W/(m&sup2;K) </li>
 </ul>
 <p>- Doors of wood or plastic for new building (standard construction): 1,6 W/(m&sup2;K)</p>
 <p>- insulated doors of wood or plastic with triplex glass: 0,7 W/(m&sup2;K)</p>
 <p>Reference:[Hessisches Ministerium f&uuml;r Umwelt 2011] UMWELT, Energie Landwirtschaft und V. f.: Energieeinsparung</p>
 <p>an Fenstern und Au&szlig;entueren. Version: 2011. www.hmuelv.hessen.de, p.10</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.Building.Components.Examples.WindowsDoors.DoorSimple\">AixLib.Building.Examples.WindowsDoors.DoorSimple </a></p>
 </html>",           revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>March 30, 2012&nbsp;</i>
          by Corinna Leonhardt and Ana Constantin:<br/>
          Implemented.</li>
 </ul>
 </html>"),           Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0})}));
          end Door;

          model WindowSimple "Window with radiation and U-Value"
            extends
            AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow;
            //  parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
            parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
            parameter Modelica.SIunits.Temperature T0=293.15 "Initial temperature";
            parameter Boolean selectable=true "Select window type"
              annotation (Dialog(group="Window type", descriptionLabel=true));
            parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType=
               DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "Window type"
              annotation (Dialog(
                group="Window type",
                enable=selectable,
                descriptionLabel=true), choicesAllMatching=true);
            parameter Real frameFraction(
              min=0.0,
              max=1.0) = if selectable then WindowType.frameFraction else 0.2
              "Frame fraction" annotation (Dialog(
                group="Window type",
                enable=not selectable,
                descriptionLabel=true));
            parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw=if selectable then
                WindowType.Uw else 1.50
              "Thermal transmission coefficient of whole window"
              annotation (Dialog(group="Window type", enable=not selectable));
            parameter Real g=if selectable then WindowType.g else 0.60
              "Coefficient of solar energy transmission"
              annotation (Dialog(group="Window type", enable=not selectable));

            replaceable model correctionSolarGain =
                BaseClasses.CorrectionSolarGain.NoCorG constrainedby
            BaseClasses.CorrectionSolarGain.PartialCorG
              "Model for correction of solar gain factor" annotation (Dialog(
                  descriptionLabel=true), choicesAllMatching=true);
            correctionSolarGain corG(
              final Uw=Uw,
              final n=1)
              annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
            Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(
              final G=windowarea*Uw)
              annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
            Modelica.Blocks.Math.Gain Ag(
              final k(unit="m2", min=0.0) = (1 - frameFraction)*windowarea*g)
              annotation (Placement(transformation(extent={{-16,54},{-4,66}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
              annotation (Placement(transformation(extent={{2,50},{22,70}})));
          equation
            connect(corG.solarRadWinTrans[1], Ag.u)
              annotation (Line(points={{-31,60},{-17.2,60}}, color={0,0,127}));
            connect(Ag.y, prescribedHeatFlow.Q_flow)
              annotation (Line(points={{-3.4,60},{2,60}}, color={0,0,127}));
            connect(Star, prescribedHeatFlow.port)
              annotation (Line(points={{90,60},{22,60}}, color={95,95,95}));
            connect(solarRad_in, corG.SR_input[1]) annotation (Line(points={{-90,60},{-70,
                    60},{-70,59.9},{-49.8,59.9}}, color={255,128,0}));
            connect(twoStar_RadEx.Star, Star)
              annotation (Line(points={{49.1,60},{90,60}}, color={95,95,95}));
            connect(port_outside, HeatTrans.port_a) annotation (Line(points={{-90,-10},{
                    -50,-10},{-50,-10},{-10,-10}}, color={191,0,0}));
            connect(HeatTrans.port_b, port_inside)
              annotation (Line(points={{10,-10},{90,-10}}, color={191,0,0}));
            annotation (
              Icon(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  grid={2,2}), graphics={
                  Line(points={{-66,18},{-62,18}}, color={255,255,0}),
                  Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
                  Rectangle(
                    extent={{-80,80},{80,-80}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-4,42},{10,-76}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-76,46},{74,38}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Line(points={{2,40},{2,-76},{76,-76},{76,40},{2,40}}, color={0,0,0}),
                  Line(points={{-76,40},{-76,-76},{-2,-76},{-2,40},{-76,40}}, color={0,0,0}),
                  Line(points={{-76,76},{-76,44},{76,44},{76,76},{-76,76}}, color={0,0,0}),
                  Rectangle(
                    extent={{4,-8},{6,-20}},
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Line(points={{-72,72},{-72,48},{72,48},{72,72},{-72,72}}, color={0,0,0}),
                  Rectangle(
                    extent={{-72,72},{72,48}},
                    lineColor={0,0,0},
                    fillColor={211,243,255},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{10,36},{72,-72}},
                    lineColor={0,0,0},
                    fillColor={211,243,255},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-72,36},{-8,-72}},
                    lineColor={0,0,0},
                    fillColor={211,243,255},
                    fillPattern=FillPattern.Solid),
                  Line(points={{-8,36},{-8,-72},{-72,-72},{-72,36},{-8,36}}, color={0,0,0}),
                  Line(points={{72,36},{72,-72},{10,-72},{10,36},{72,36}}, color={0,0,0}),
                  Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
              Documentation(info="<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>WindowSimple</b> model represents a window described by the thermal transmission coefficient and the coefficient of solar energy transmission. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>Phenomena being simulated: </p>
 <ul>
 <li>Solar energy transmission through the glass</li>
 <li>Heat transmission through the whole window</li>
 </ul>
 <h4><font color=\"#008000\">References</font></h4>
 <p>Exemplary U-Values for windows from insulation standards</p>
 <ul>
 <li>WschV 1984: specified &quot;two panes&quot; assumed 2,5 W/m2K</li>
 <li>WschV 1995: 1,8 W/m2K</li>
 <li>EnEV 2002: 1,7 W/m2K</li>
 <li>EnEV 2009: 1,3 W/m2K</li>
 </ul>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p><a href=\"AixLib.Building.Components.Examples.WindowsDoors.WindowSimple\">AixLib.Building.Components.Examples.WindowsDoors.WindowSimple</a></p>
 </html>",           revisions="<html>
 <ul>
 <li><i>November 2, 2018Mai 19, 2014&nbsp;</i> by Fabian Wüllhorst:<br/>Remove redundand twoStar_radEx from model. 
This is for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/651\">#651</a>.</li>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>March 30, 2012&nbsp;</i> by Ana Constantin and Corinna Leonhardt:<br/>Implemented.</li>
 </ul>
 </html>"),   Diagram(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  grid={2,2}), graphics={Rectangle(extent={{-80,80},{80,-80}}, lineColor={
                        0,0,0})}));
          end WindowSimple;

          package BaseClasses
            extends Modelica.Icons.BasesPackage;

            partial model PartialWindow "Partial model for windows"

              parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
              parameter Modelica.SIunits.Temperature T0= 293.15 "Initial temperature";

              Utilities.Interfaces.SolarRad_in
                                             solarRad_in
            annotation (Placement(
                transformation(extent={{-100,50},{-80,70}}),
                    iconTransformation(extent={{-100,50},{-80,70}})));
              Utilities.Interfaces.Star
                                      Star
                                   annotation (Placement(transformation(extent={{80,50},{
                        100,70}}), iconTransformation(extent={{80,50},{100,70}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_inside
            annotation (
             Placement(transformation(extent={{80,-20},{100,0}}),
                    iconTransformation(extent={{80,-20},{100,0}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
            annotation (Placement(transformation(extent={{-100,-20},{-80,0}}), iconTransformation(extent={{-100,-20},{-80,0}})));
              annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                        -100},{100,100}}),
                                  graphics={
                                           Rectangle(extent={{-80,80},{80,-80}},
                        lineColor={0,0,0})}), Icon(coordinateSystem(preserveAspectRatio=false,
                      extent={{-100,-100},{100,100}}), graphics={
                  Line(
                    points={{-66,18},{-62,18}},
                    color={255,255,0}),
                  Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
                  Rectangle(
                    extent={{-80,80},{80,-80}},
                    lineColor={0,0,255},
                     pattern=LinePattern.None,
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-4,42},{10,-76}},
                    lineColor={0,0,255},
                     pattern=LinePattern.None,
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-76,46},{74,38}},
                    lineColor={0,0,255},
                     pattern=LinePattern.None,
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{2,40},{2,-76},{76,-76},{76,40},{2,40}}),
                  Line(
                    points={{-76,40},{-76,-76},{-2,-76},{-2,40},{-76,40}}),
                  Line(
                    points={{-76,76},{-76,44},{76,44},{76,76},{-76,76}}),
                  Rectangle(
                    extent={{4,-8},{6,-20}},
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{-72,72},{-72,48},{72,48},{72,72},{-72,72}}),
                  Rectangle(
                    extent={{-72,72},{72,48}},
                    lineColor={0,0,0},
                    fillColor={211,243,255},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{10,36},{72,-72}},
                    lineColor={0,0,0},
                    fillColor={211,243,255},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-72,36},{-8,-72}},
                    lineColor={0,0,0},
                    fillColor={211,243,255},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{-8,36},{-8,-72},{-72,-72},{-72,36},{-8,36}}),
                  Line(
                    points={{72,36},{72,-72},{10,-72},{10,36},{72,36}}),
                  Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}));
            end PartialWindow;

            package CorrectionSolarGain
              extends Modelica.Icons.Package;

              model NoCorG "No correction for solar gain factor"
                extends CorrectionSolarGain.PartialCorG;
              equation
                  for i in 1:n loop
                    solarRadWinTrans[i] = SR_input[i].I;
                  end for;

                annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple model with no correction of transmitted solar radiation depending on incidence angle.</p>
</html>"));
              end NoCorG;

              partial model PartialCorG
                "partial model for correction of the solar gain factor"

                 parameter Integer n = 1 "vector size for input and output";
                 parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw = 3
                  "Thermal transmission coefficient of whole window";

            public
                Utilities.Interfaces.SolarRad_in SR_input[n] annotation (Placement(
                      transformation(extent={{-122,-20},{-80,20}}),
                      iconTransformation(
                      extent={{18,-19},{-18,19}},
                      rotation=180,
                      origin={-98,-1})));
                Modelica.Blocks.Interfaces.RealOutput solarRadWinTrans[n](unit="W/m2")
                  "transmitted solar radiation through window"
                  annotation (Placement(transformation(extent={{80,-10},{100,10}}),
                      iconTransformation(extent={{80,-10},{100,10}})));
                annotation ( Icon(coordinateSystem(
                        preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                      Rectangle(
                        extent={{-80,80},{80,-80}},
                        lineColor={0,0,0},
                        fillColor={215,215,215},
                        fillPattern=FillPattern.Solid), Text(
                        extent={{-52,24},{62,-16}},
                        lineColor={0,0,0},
                        textString="%name")}),
                  Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Partial model for correction cofficient for transmitted solar radiation through a window.</p>
</html>"));
              end PartialCorG;
            end CorrectionSolarGain;
          end BaseClasses;
        end WindowsDoors;
      end Components;
      annotation(conversion(noneFromVersion = "", noneFromVersion = "1.0", noneFromVersion = "1.1", noneFromVersion = "1.2", from(version = "1.3", script = "Conversions/ConvertFromHouse_Models_1.3.mos"), from(version = "2.0", script = "Conversions/ConvertFromHouse_Models_2.0_To_2.1"), from(version = "2.1", script = "Conversions/ConvertFromHouse_Models_2.1_To_2.2")), Documentation(revisions = "", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Package for standard house models, derived form the EBC-Library HouseModels.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The H library aims to provide standard models for one family dwellings (stand alone house), single apartments and multi-family dwellings consisting of several apartments. The particularity of this library lies in providing ready to use models for the dynamic simulation of building energy systems, while allowing for a degree of flexibility in adapting or extending these models to ones needs.</p>
 <p>A library with models for standard houses as such does not yet exist. While at the moment the standard house models are tailor-made for the German market, it is possible to adapt them to other markets.</p>
 <p>When developing the HouseModels library we followed several goals: </p>
 <ul>
 <li>develop standard models</li>
 <li>model only the necessary physical processes</li>
 <li>build a model so that changing the parameters is easy, quick and will not lead to hidden mistakes</li>
 <li>have an easy to use graphical interface</li>
 <li>ensure a degree of flexibility for expanding or building new models</li>
 </ul>
 <p><br/>We call these house models standard for the following reasons:</p>
 <ul>
 <li>the floor layouts were made based on existing buildings, by analyzing data provided by the German Federal Statistical Office and by consulting with experts</li>
 <li>for modeling realistical wall structures building catalogues as well as experts were consulted</li>
 <li>the physical properties of the materials for the wall layers were chosen to satisfy the insulation requirements of current and past German energy saving ordinances: WSchV 1984, WSchV1995, EnEV 2002 and EnEV 2009</li>
 </ul>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Ana Constantin, Rita Streblow and Dirk Mueller The Modelica HouseModels Library: Presentation and Evaluation of a Room Model with the ASHRAE Standard 140 in Proceedings of Modelica Conference, Lund 2014, Pages 293-299. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096293\">10.3384/ECP14096293</a></p>
 </html>"));
    end HighOrder;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-70,68},{78,-62}},
          lineColor={0,0,0}),
        Line(points={{-70,68},{-38,28},{42,28},{78,68}}, color={0,0,0}),
        Line(points={{-70,-62},{-38,-28},{-38,28}}, color={0,0,0}),
        Line(points={{-38,-28},{42,-28},{78,-62}}, color={0,0,0}),
        Line(points={{42,28},{42,-28}}, color={0,0,0})}), Documentation(info="<html>
<p>This package contains models for building physics of thermal zones.</p>
</html>"));
  end ThermalZones;

  package Utilities "Package with utility functions such as for I/O"
    extends Modelica.Icons.Package;

    package HeatTransfer "Models for different types of heat transfer"
      extends Modelica.Icons.Package;

      model HeatConv_inside
        "Natural convection computation according to B. Glueck or EN ISO 6946, with choice between several types of surface orientation, or a constant convective heat transfer coefficient"
        /* calculation of natural convection in the inside of a building according to B.Glueck, EN ISO 6946 or using a constant convective heat transfer coefficient alpha_custom
  */
        extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

        parameter Integer calcMethod=1 "Calculation Method" annotation (Dialog(
              descriptionLabel=true), choices(
            choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
            choice=2 "By Bernd Glueck",
            choice=3 "Constant alpha",
            radioButtons=true));

        parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 2.5
          "Constant heat transfer coefficient" annotation (Dialog(descriptionLabel=true,
              enable=if calcMethod == 3 then true else false));


        // which orientation of surface?
        parameter Integer surfaceOrientation=1 "Surface orientation" annotation (
            Dialog(descriptionLabel=true, enable=if calcMethod == 3 then false else true),
            choices(
            choice=1 "vertical",
            choice=2 "horizontal facing up",
            choice=3 "horizontal facing down",
            radioButtons=true));
        parameter Modelica.SIunits.Area A=16 "Area of surface";
        Modelica.SIunits.CoefficientOfHeatTransfer alpha
          "variable heat transfer coefficient";

    protected
        Modelica.SIunits.Temp_C posDiff=noEvent(abs(port_b.T - port_a.T))
          "Positive temperature difference";
      equation

        /*
        port_b -> wall
        port_a -> air
  */

        // ++++++++++++++++EN ISO 6946 Appendix A >>Flat Surfaces<<++++++++++++++++
        if calcMethod == 1 then
          if surfaceOrientation == 2 then
            // upward heat flow
            if port_b.T >= port_a.T then
              alpha = 5;
              // downward heat flow
            else
              alpha = 0.7;
            end if;
          elseif surfaceOrientation == 3 then
            // downward heat flow
            if port_b.T >= port_a.T then
              alpha = 0.7;
              // upward heat flow
            else
              alpha = 5;
            end if;
          else
            alpha = 2.5;
          end if;
        // ++++++++++++++++Bernd Glueck++++++++++++++++
        elseif calcMethod == 2 then

          // top side of horizontal plate
      // ------------------------------------------------------
        if surfaceOrientation == 2 then
            alpha = 2*(posDiff^0.31);  // equation 1.27, page 26 (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)

      // down side of horizontal plate
      // ------------------------------------------------------

        else
          if surfaceOrientation == 3 then
             alpha = 0.54*(posDiff^0.31);  //equation 1.28, page 26 (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)

      // vertical plate
      //-------------------------------------------------
          else
            alpha = 1.6*(posDiff^0.3);  // equation 1.26 page 26 (Bernd Glueck: Heizen und Kuehlen mit Niedrigexergie - Innovative Waermeuebertragung und Waermespeicherung (LowEx) 2008)
          end if;
        end if;
        // ++++++++++++++++alpha_custom++++++++++++++++
        else
          // if calcMethod == 3 then
          alpha = alpha_custom;
          // end if;
        end if;

        port_a.Q_flow = alpha*A*(port_a.T - port_b.T);
        annotation (
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Rectangle(
                extent={{-80,60},{0,-100}},
                lineColor={0,255,255},
                fillColor={211,243,255},
                fillPattern=FillPattern.Solid),
              Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
              Rectangle(
                extent={{60,60},{80,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={244,244,244},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{40,60},{60,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={207,207,207},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{20,60},{40,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={182,182,182},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,60},{20,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={156,156,156},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{80,60},{80,60},{60,20},{60,60},{80,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={157,166,208},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{60,60},{60,20},{40,-20},{40,60},{60,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={102,110,139},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{40,60},{40,-20},{20,-60},{20,60},{40,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={75,82,103},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{20,60},{20,-60},{0,-100},{0,60},{20,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={51,56,70},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-58,20},{-68,8}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-58,20},{-58,-60}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-40,20},{-50,8}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-40,20},{-40,-60}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-22,20},{-32,8}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-22,20},{-22,-60}},
                color={0,0,255},
                thickness=0.5)}),
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={2,2}), graphics={
              Rectangle(
                extent={{0,60},{20,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={156,156,156},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{20,60},{40,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={182,182,182},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{40,60},{60,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={207,207,207},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{60,60},{80,-100}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                fillColor={244,244,244},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,60},{0,-100}},
                lineColor={0,255,255},
                fillColor={211,243,255},
                fillPattern=FillPattern.Solid),
              Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
              Polygon(
                points={{80,60},{80,60},{60,20},{60,60},{80,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={157,166,208},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{60,60},{60,20},{40,-20},{40,60},{60,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={102,110,139},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{40,60},{40,-20},{20,-60},{20,60},{40,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={75,82,103},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{20,60},{20,-60},{0,-100},{0,60},{20,60}},
                lineColor={0,0,255},
                pattern = LinePattern.None,
                lineThickness=0.5,
                fillColor={51,56,70},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-20,16},{-20,-64}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-20,16},{-30,4}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-38,16},{-48,4}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-54,16},{-64,4}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-38,16},{-38,-64}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{-54,16},{-54,-64}},
                color={0,0,255},
                thickness=0.5)}),
          Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>HeatConv_inside</b> model represents the phenomenon of heat convection at inside surfaces, with different choice for surface orientation. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>In this model the orientation of the surface can be chosen from a menu for an easier adoption to new situations. This allows calculating <code>alpha</code> depending on orientation and respective direction of heat flow. The equations for <code>alpha</code> are taken from EN ISO 6946 (appendix A.1) and B. Glueck. </p>
<p>The model can in this way be used on inside surfaces. There is also the possibility of setting a constant alpha value.</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<ul>
<li>EN ISO 6946:2008-04, appendix A. Building components and building elements - Thermal resistance and thermal transmittance.</li>
<li>Bernd Glueck:<i> Heizen und K&uuml;hlen mit Niedrigexergie - Innovative W&auml;rme&uuml;bertragung und W&auml;rmespeicherung (LowEx) 2008.</i> </li>
</ul>
<p><b><font style=\"color: #008000; \">Example Results</font></b> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test </a></p>
</html>",        revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters</li>
<li><i>June 17, 2015&nbsp;</i> by Philipp Mehrfeld:<br/>Added EN ISO 6946 equations and corrected usage of constant alpha_custom </li>
<li><i>March 26, 2015&nbsp;</i> by Ana Constantin:<br/>Changed equations for differnet surface orientations according to newer work from Gl&uuml;ck </li>
<li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions </li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl<br/>Formatted documentation according to standards </li>
<li><i>December 15, 2005&nbsp;</i> by Peter Matthes:<br/>Implemented. </li>
</ul>
</html>"));
      end HeatConv_inside;

      model HeatConv_outside
        "Model for heat transfer at outside surfaces. Choice between multiple models"
        extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
        parameter Integer Model = 1 "Model" annotation(Evaluate = true, Dialog(group = "Computational Models", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals (convective + radiative)",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));
        parameter Modelica.SIunits.Area A = 16 "Area of surface" annotation(Dialog(group = "Surface properties", descriptionLabel = true));
        parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 25
          "Custom alpha"                                                                      annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable = Model == 3));
        parameter
          DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook         surfaceType = DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
          "Surface type"                                                                                                     annotation(Dialog(group = "Surface properties", descriptionLabel = true, enable = Model == 2), choicesAllMatching = true);
        // Variables
        Modelica.SIunits.CoefficientOfHeatTransfer alpha;
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort if   Model==1 or Model ==2                         annotation(Placement(transformation(extent = {{-102, -82}, {-82, -62}}), iconTransformation(extent = {{-102, -82}, {-82, -62}})));

    protected
        Modelica.Blocks.Interfaces.RealInput WindSpeed_internal(unit="m/s");
      equation
        // Main equation of heat transfer
        port_a.Q_flow = alpha*A*(port_a.T - port_b.T);

        //Determine alpha
        if Model == 1 then
          alpha = (4 + 4*WindSpeed_internal);
        elseif Model == 2 then
          alpha = surfaceType.D + surfaceType.E*WindSpeed_internal + surfaceType.F*(WindSpeed_internal^2);
        else
          alpha = alpha_custom;
          WindSpeed_internal = 0;
        end if;

        connect(WindSpeedPort, WindSpeed_internal);
        annotation(Icon(graphics={  Rectangle(extent = {{-80, 70}, {80, -90}}, lineColor = {0, 0, 0}), Rectangle(extent = {{0, 70}, {20, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {156, 156, 156},
                  fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{20, 70}, {40, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {182, 182, 182},
                  fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{40, 70}, {60, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {207, 207, 207},
                  fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{60, 70}, {80, -90}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {244, 244, 244},
                  fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 70}, {0, -90}}, lineColor = {255, 255, 255}, fillColor = {85, 85, 255},
                  fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-80, 70}, {80, -90}}, lineColor = {0, 0, 0}), Polygon(points = {{80, 70}, {80, 70}, {60, 30}, {60, 70}, {80, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
                  lineThickness =                                                                                                   0.5, fillColor = {157, 166, 208},
                  fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{60, 70}, {60, 30}, {40, -10}, {40, 70}, {60, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
                  lineThickness =                                                                                                   0.5, fillColor = {102, 110, 139},
                  fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{40, 70}, {40, -10}, {20, -50}, {20, 70}, {40, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
                  lineThickness =                                                                                                   0.5, fillColor = {75, 82, 103},
                  fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{20, 70}, {20, -50}, {0, -90}, {0, 70}, {20, 70}}, lineColor = {0, 0, 255},  pattern = LinePattern.None,
                  lineThickness =                                                                                                   0.5, fillColor = {51, 56, 70},
                  fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-20, 26}, {-20, -54}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-20, 26}, {-30, 14}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-38, 26}, {-48, 14}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-54, 26}, {-64, 14}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-38, 26}, {-38, -54}}, color = {255, 255, 255}, thickness = 0.5), Line(points = {{-54, 26}, {-54, -54}}, color = {255, 255, 255}, thickness = 0.5)}), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>The <b>HeatTransfer_outside </b>is a model for the convective heat transfer at outside walls </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>It allows the choice between three different models: </p>
<ul>
<li>after DIN 6946: <img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-vd3eY3hw.png\"
    alt=\"alpha = 4 + 4*v\"/> , where
    <img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-MU6LPHRs.png\"
    alt=\"alpha\"/> (<b>alpha)</b> is the heat transfer coefficent and
    <b>v</b> is the wind speed </li>
<li>after the ASHRAE Fundamentals Handbook from 1989, the way it is presented
in EnergyPlus Engineering reference from 2011:
<img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-A5RXdOdd.png\"
alt=\"alpha  = D + E*v + F*v^2\"/>, where
<img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-LDgZSLyY.png\" alt=\"alpha\"/>
(<b>alpha</b>) and <b>v</b> are as above and the coefficients <b>D, E, F</b>
depend on the surface of the outer wall.<br/><b>
<span style=\"color: #ff0000;\">Attention:</span></b>
This is a combined coefficient for convective and radiative heat exchange.</li>
<li>with a custom constant <img src=\"modelica://AixLib/Resources/Images/Utilities/HeatTransfer/HeatConv_outside/equation-BjHulWj5.png\"
alt=\"alpha \"/> (<b>alpha)</b> value </li>
</ul>
<p><b><span style=\"color: #008000;\">References</span></b> </p>
<ul>
<li>DIN 6946 p.20 </li>
<li>ASHRAEHandbook1989, as cited in EnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56 </li>
</ul>
<p><b><span style=\"color: #008000;\">Example Results</span></b> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatTransfer_test\">AixLib.Utilities.Examples.HeatTransfer_test</a> </p>
<p><a href=\"AixLib.Utilities.Examples.HeatConv_outside\">AixLib.Utilities.Examples.HeatConv_outside</a> </p>
</html>",        revisions="<html>
 <ul>
 <li><i>November 16, 2016&nbsp;</i> by Ana Constantin:<br/>Conditioned input WindSpeedPort and introduced protected input WindSpeed_internal</li>
 </ul>
 <ul>
 <li><i>April 1, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 </ul>
 <ul>
   <li><i>March 30, 2012&nbsp;</i>
          by Ana Constantin:<br/>
          Implemented.</li>
 </ul>
 </html>"));
      end HeatConv_outside;

      model HeatToStar "Adaptor for approximative longwave radiation exchange"
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm annotation(Placement(transformation(extent = {{-102, -10}, {-82, 10}})));
        AixLib.Utilities.Interfaces.Star Star annotation(Placement(transformation(extent = {{81, -10}, {101, 10}})));
        parameter Modelica.SIunits.Area A = 12 "Area of radiation exchange";
        parameter Modelica.SIunits.Emissivity eps = 0.95 "Emissivity";
      equation
        Therm.Q_flow + Star.Q_flow = 0;

        // To prevent negative solutions for T, the max() expression is used.
        // Negative solutions also occur when using max(T,0), therefore, 1 K is used.
        Therm.Q_flow = Modelica.Constants.sigma * eps * A * (
          max(Therm.T,1) * max(Therm.T,1) * max(Therm.T,1) * max(Therm.T,1) -
          max(Star.T,1) * max(Star.T,1) * max(Star.T,1) * max(Star.T,1));
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>TwoStar_RadEx</b> model cobines the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> and the <b><a href=\"Interfaces.Star\">Star</a></b> connector. To model longwave radiation exchange of a surfaces, just connect the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> to the outmost layer of the surface and connect the <b><a href=\"Interfaces.Star\">Star</a></b> connector to the <b><a href=\"Interfaces.Star\">Star</a></b> connectors of an unlimited number of corresponding surfaces. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>Since exact calculation of longwave radiation exchange inside a room demands for the computation of view factors, it may be very complex to achieve for non-rectangular room layouts. Therefore, an approximated calculation of radiation exchange basing on the proportions of the affected surfaces is an alternative. The underlying concept of this approach is known as the &quot;two star&quot; room model. </p>
 </html>",       revisions = "<html>
 <ul>
 <li><i>February 16, 2018&nbsp;</i> by Philipp Mehrfeld:<br/>Introduce max(T,100) to prevent negative solutions for the temperature</li>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Moved and Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li><i>June 16, 2006&nbsp;</i> by Timo Haase:<br/>Implemented.</li>
 </ul>
 </html>"));
      end HeatToStar;

      model HeatToStar_Avar
        "Adaptor for approximative longwave radiation exchange with variable surface Area"
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm annotation(Placement(transformation(extent = {{-102, -10}, {-82, 10}})));
        Modelica.Blocks.Interfaces.RealInput A "Area of radiation exchange" annotation(Placement(transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
        parameter Modelica.SIunits.Emissivity eps = 0.95 "Emissivity";
        AixLib.Utilities.Interfaces.Star Star annotation(Placement(transformation(extent = {{81, -10}, {101, 10}})));
      equation
        Therm.Q_flow + Star.Q_flow = 0;
        Therm.Q_flow = Modelica.Constants.sigma * eps * A * (Therm.T * Therm.T * Therm.T * Therm.T - Star.T * Star.T * Star.T * Star.T);
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
                  fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>TwoStar_RadEx</b> model cobines the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> and the <b><a href=\"Interfaces.Star\">Star</a></b> connector. To model longwave radiation exchange of surfaces, just connect the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> connector to the outmost layer of the surface and connect the <b><a href=\"Interfaces.Star\">Star</a></b> connector to the <b><a href=\"Interfaces.Star\">Star</a></b> connectors of an unlimited number of corresponding surfaces. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>Since exact calculation of longwave radiation exchange inside a room demands for the computation of view factors, it may be very complex to achieve for non-rectangular room layouts. Therefore, an approximated calculation of radiation exchange basing on the proportions of the affected surfaces is an alternative. The underlying concept of this approach is known as the &quot;two star&quot; room model. </p>
 </html>",       revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Moved and Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li><i>June 21, 2007&nbsp;</i> by Peter Mattes:<br/>Extended model based on TwoStar_RadEx.</li>
 </ul>
 </html>"));
      end HeatToStar_Avar;

      model SolarRadToHeat "Compute the heat flow caused by radiation on a surface"
        parameter Real coeff = 0.6 "Weight coefficient";
        // parameter Modelica.SIunits.Area A=6 "Area of surface";
        parameter Real A = 10 "Area of surface";
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(transformation(extent = {{80, -30}, {100, -10}})));
        AixLib.Utilities.Interfaces.SolarRad_in solarRad_in annotation(Placement(transformation(extent = {{-122, -40}, {-80, 0}})));
      equation
        heatPort.Q_flow = -solarRad_in.I * A * coeff;
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-48, 2}, {-4, -42}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                  fillPattern =                                                                                                   FillPattern.Solid, textString = "I"), Text(extent = {{4, 0}, {56, -44}}, lineColor = {0, 0, 0}, textString = "J"), Polygon(points = {{-12, -24}, {-12, -16}, {10, -16}, {10, -10}, {22, -20}, {10, -30}, {10, -24}, {-12, -24}}, lineColor = {0, 0, 0})}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 60}, {80, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 0}, {-14, -44}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                  fillPattern =                                                                                                   FillPattern.Solid, textString = "I"), Text(extent = {{0, -2}, {52, -46}}, lineColor = {0, 0, 0}, textString = "J"), Polygon(points = {{-22, -24}, {-22, -16}, {0, -16}, {0, -10}, {12, -20}, {0, -30}, {0, -24}, {-22, -24}}, lineColor = {0, 0, 0}), Text(extent = {{-100, 100}, {100, 60}}, lineColor = {0, 0, 255}, textString = "%name")}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>
 The <b>RadCondAdapt</b> model computes a heat flow rate caused by the absorbance of radiation. The amount of radiation being transformed into a heat flow is controlled by a given coefficient.
 </p>
 </html>
 ",       revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Moved and Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 </ul>
 </html>"));
      end SolarRadToHeat;
    end HeatTransfer;

    package Math "Library with functions such as for smoothing"
      extends Modelica.Icons.Package;

      package Functions "Package with mathematical functions"
        extends Modelica.Icons.VariantsPackage;

        function inverseXRegularized
          "Function that approximates 1/x by a twice continuously differentiable function"
          extends Modelica.Icons.Function;
         input Real x "Abscissa value";
         input Real delta(min=Modelica.Constants.eps)
            "Abscissa value below which approximation occurs";
         input Real deltaInv = 1/delta "Inverse value of delta";

         input Real a = -15*deltaInv "Polynomial coefficient";
         input Real b = 119*deltaInv^2 "Polynomial coefficient";
         input Real c = -361*deltaInv^3 "Polynomial coefficient";
         input Real d = 534*deltaInv^4 "Polynomial coefficient";
         input Real e = -380*deltaInv^5 "Polynomial coefficient";
         input Real f = 104*deltaInv^6 "Polynomial coefficient";

         output Real y "Function value";

        algorithm
          y :=if (x > delta or x < -delta) then 1/x elseif (x < delta/2 and x > -delta/2) then x/(delta*delta) else
            AixLib.Utilities.Math.Functions.BaseClasses.smoothTransition(
               x=x,
               delta=delta, deltaInv=deltaInv,
               a=a, b=b, c=c, d=d, e=e, f=f);

          annotation (smoothOrder=2,
          derivative(order=1,
                  zeroDerivative=delta,
                  zeroDerivative=deltaInv,
                  zeroDerivative=a,
                  zeroDerivative=b,
                  zeroDerivative=c,
                  zeroDerivative=d,
                  zeroDerivative=e,
                  zeroDerivative=f)=AixLib.Utilities.Math.Functions.BaseClasses.der_inverseXRegularized,
                      Inline=true,
        Documentation(info="<html>
<p>
Function that approximates <i>y=1 &frasl; x</i>
inside the interval <i>-&delta; &le; x &le; &delta;</i>.
The approximation is twice continuously differentiable with a bounded derivative on the whole
real line.
</p>
<p>
See the plot of
<a href=\"modelica://AixLib.Utilities.Math.Functions.Examples.InverseXRegularized\">
AixLib.Utilities.Math.Functions.Examples.InverseXRegularized</a>
for the graph.
</p>
<p>
For efficiency, the polynomial coefficients
<code>a, b, c, d, e, f</code> and
the inverse of the smoothing parameter <code>deltaInv</code>
are exposed as arguments to this function.
Typically, these coefficients only depend on parameters and hence
can be computed once.
They must be equal to their default values, otherwise the function
is not twice continuously differentiable.
By exposing these coefficients as function arguments, models
that call this function can compute them as parameters, and
assign these parameter values in the function call.
This avoids that the coefficients are evaluated for each time step,
as they would otherwise be if they were to be computed inside the
body of the function. However, assigning the values is optional
as otherwise, at the expense of efficiency, the values will be
computed each time the function is invoked.
See
<a href=\"modelica://AixLib.Utilities.Math.Functions.Examples.InverseXRegularized\">
AixLib.Utilities.Math.Functions.Examples.InverseXRegularized</a>
for how to efficiently call this function.
</p>
</html>",         revisions="<html>
<ul>
<li>
August 10, 2015, by Michael Wetter:<br/>
Removed dublicate entry <code>smoothOrder = 1</code>
and reimplmented the function so it is twice continuously differentiable.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/302\">issue 302</a>.
</li>
<li>
February 5, 2015, by Filip Jorissen:<br/>
Added <code>smoothOrder = 1</code>.
</li>
<li>
May 10, 2013, by Michael Wetter:<br/>
Reformulated implementation to avoid unrequired computations.
</li>
<li>
April 18, 2011, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
        end inverseXRegularized;

        function regStep
          "Approximation of a general step, such that the approximation is continuous and differentiable"
          extends Modelica.Icons.Function;
          input Real x "Abscissa value";
          input Real y1 "Ordinate value for x > 0";
          input Real y2 "Ordinate value for x < 0";
          input Real x_small(min=0) = 1e-5
            "Approximation of step for -x_small <= x <= x_small; x_small >= 0 required";
          output Real y "Ordinate value to approximate y = if x > 0 then y1 else y2";
        algorithm
          y := smooth(1, if x >  x_small then y1 else
                         if x < -x_small then y2 else
                         if x_small > 0 then (x/x_small)*((x/x_small)^2 - 3)*(y2-y1)/4 + (y1+y2)/2 else (y1+y2)/2);

          annotation(Inline=true,
          Documentation(revisions="<html>
<ul>
<li><i>February 18, 2016</i>
    by Marcus Fuchs:<br/>
    Add function with <code>Inline = true</code> in annotations to package for better performance,
    as suggested in <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/300\">#300</a> .</li>
<li><i>April 29, 2008</i>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br/>
    Designed and implemented.</li>
<li><i>August 12, 2008</i>
    by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br/>
    Minor modification to cover the limit case <code>x_small -> 0</code> without division by zero.</li>
</ul>
</html>",         info="<html>
<p>
This function is used to approximate the equation
</p>
<pre>
    y = <b>if</b> x &gt; 0 <b>then</b> y1 <b>else</b> y2;
</pre>

<p>
by a smooth characteristic, so that the expression is continuous and differentiable:
</p>

<pre>
   y = <b>smooth</b>(1, <b>if</b> x &gt;  x_small <b>then</b> y1 <b>else</b>
                 <b>if</b> x &lt; -x_small <b>then</b> y2 <b>else</b> f(y1, y2));
</pre>

<p>
In the region <code>-x_small &lt; x &lt; x_small</code> a 2nd order polynomial is used
for a smooth transition from <code>y1</code> to <code>y2</code>.
</p>
</html>"));
        end regStep;

        package BaseClasses
        "Package with base classes for AixLib.Utilities.Math.Functions"
          extends Modelica.Icons.BasesPackage;

          function der_2_smoothTransition
            "Second order derivative of smoothTransition with respect to x"
            extends Modelica.Icons.Function;
            input Real x "Abscissa value";
            input Real delta(min=Modelica.Constants.eps)
              "Abscissa value below which approximation occurs";

            input Real deltaInv "Inverse value of delta";
            input Real a "Polynomial coefficient";
            input Real b "Polynomial coefficient";
            input Real c "Polynomial coefficient";
            input Real d "Polynomial coefficient";
            input Real e "Polynomial coefficient";
            input Real f "Polynomial coefficient";

            input Real x_der "Derivative of x";
            input Real x_der2 "Second order derivative of x";
            output Real y_der2 "Second order derivative of function value";
        protected
            Real aX "Absolute value of x";
            Real ex "Intermediate expression";
          algorithm
           aX:= abs(x);
           ex     := 2*c + aX*(6*d + aX*(12*e + aX*20*f));
           y_der2 := (b + aX*(2*c + aX*(3*d + aX*(4*e + aX*5*f))))*x_der2
                   + x_der*x_der*( if x > 0 then ex else -ex);

          annotation (
          Documentation(info="<html>
<p>
This function is the 2nd order derivative of
<a href=\"modelica://AixLib.Utilities.Math.Functions.BaseClasses.smoothTransition\">
AixLib.Utilities.Math.Functions.BaseClasses.smoothTransition</a>.
</p>
<h4>Implementation</h4>
<p>
For efficiency, the polynomial coefficients
<code>a, b, c, d, e, f</code> and
the inverse of the smoothing parameter <code>deltaInv</code>
are exposed as arguments to this function.
</p>
</html>",           revisions="<html>
<ul>
<li>
August 11, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
          end der_2_smoothTransition;

          function der_inverseXRegularized "Derivative of inverseXRegularised function"
            extends Modelica.Icons.Function;
           input Real x "Abscissa value";
           input Real delta(min=Modelica.Constants.eps)
              "Abscissa value below which approximation occurs";
           input Real deltaInv = 1/delta "Inverse value of delta";

           input Real a = -15*deltaInv "Polynomial coefficient";
           input Real b = 119*deltaInv^2 "Polynomial coefficient";
           input Real c = -361*deltaInv^3 "Polynomial coefficient";
           input Real d = 534*deltaInv^4 "Polynomial coefficient";
           input Real e = -380*deltaInv^5 "Polynomial coefficient";
           input Real f = 104*deltaInv^6 "Polynomial coefficient";

           input Real x_der "Abscissa value";
           output Real y_der "Function value";

          algorithm
            y_der :=if (x > delta or x < -delta) then -x_der/x/x elseif (x < delta/2 and x > -delta/2) then x_der/(delta*delta) else
              AixLib.Utilities.Math.Functions.BaseClasses.der_smoothTransition(
                 x=x,
                 x_der=x_der,
                 delta=delta,
                 deltaInv=deltaInv,
                 a=a, b=b, c=c, d=d, e=e, f=f);
          annotation (
          Documentation(
          info="<html>
<p>
Implementation of the first derivative of the function
<a href=\"modelica://AixLib.Utilities.Math.Functions.inverseXRegularized\">
AixLib.Utilities.Math.Functions.inverseXRegularized</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
June 22, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
          end der_inverseXRegularized;

          function der_smoothTransition
            "First order derivative of smoothTransition with respect to x"
            extends Modelica.Icons.Function;
            input Real x "Abscissa value";
            input Real delta(min=Modelica.Constants.eps)
              "Abscissa value below which approximation occurs";

            input Real deltaInv "Inverse value of delta";
            input Real a "Polynomial coefficient";
            input Real b "Polynomial coefficient";
            input Real c "Polynomial coefficient";
            input Real d "Polynomial coefficient";
            input Real e "Polynomial coefficient";
            input Real f "Polynomial coefficient";

            input Real x_der "Derivative of x";
            output Real y_der "Derivative of function value";

        protected
            Real aX "Absolute value of x";
          algorithm
           aX:= abs(x);
           y_der := (b + aX*(2*c + aX*(3*d + aX*(4*e + aX*5*f))))*x_der;
           annotation(smoothOrder=1,
                    derivative(order=2,
                    zeroDerivative=delta,
                    zeroDerivative=deltaInv,
                    zeroDerivative=a,
                    zeroDerivative=b,
                    zeroDerivative=c,
                    zeroDerivative=d,
                    zeroDerivative=e,
                    zeroDerivative=f)=AixLib.Utilities.Math.Functions.BaseClasses.der_2_smoothTransition,
          Documentation(info="<html>
<p>
This function is the 1st order derivative of
<a href=\"modelica://AixLib.Utilities.Math.Functions.BaseClasses.smoothTransition\">
AixLib.Utilities.Math.Functions.BaseClasses.smoothTransition</a>.
</p>
<h4>Implementation</h4>
<p>
For efficiency, the polynomial coefficients
<code>a, b, c, d, e, f</code> and
the inverse of the smoothing parameter <code>deltaInv</code>
are exposed as arguments to this function.
Also,
its derivative is provided in
<a href=\"modelica://AixLib.Utilities.Math.Functions.BaseClasses.der_2_smoothTransition\">
AixLib.Utilities.Math.Functions.BaseClasses.der_2__smoothTransition</a>.
</p>
</html>",           revisions="<html>
<ul>
<li>
August 11, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
          end der_smoothTransition;

          function smoothTransition
            "Twice continuously differentiable transition between the regions"
            extends Modelica.Icons.Function;

            // The function that transitions between the regions is implemented
            // using its own function. This allows Dymola 2016 to inline the function
            // inverseXRegularized.

          input Real x "Abscissa value";
          input Real delta(min=Modelica.Constants.eps)
              "Abscissa value below which approximation occurs";
          input Real deltaInv = 1/delta "Inverse value of delta";

          input Real a = -15*deltaInv "Polynomial coefficient";
          input Real b = 119*deltaInv^2 "Polynomial coefficient";
          input Real c = -361*deltaInv^3 "Polynomial coefficient";
          input Real d = 534*deltaInv^4 "Polynomial coefficient";
          input Real e = -380*deltaInv^5 "Polynomial coefficient";
          input Real f = 104*deltaInv^6 "Polynomial coefficient";
          output Real y "Function value";
        protected
            Real aX "Absolute value of x";

          algorithm
           aX:= abs(x);
           y := (if x >= 0 then 1 else -1) * (a + aX*(b + aX*(c + aX*(d + aX*(e + aX*f)))));
          annotation(smoothOrder=2,
            derivative(order=1,
                    zeroDerivative=delta,
                    zeroDerivative=deltaInv,
                    zeroDerivative=a,
                    zeroDerivative=b,
                    zeroDerivative=c,
                    zeroDerivative=d,
                    zeroDerivative=e,
                    zeroDerivative=f)=AixLib.Utilities.Math.Functions.BaseClasses.der_smoothTransition,
              Documentation(info="<html>
<p>
This function is used by
<a href=\"modelica://AixLib.Utilities.Math.Functions.inverseXRegularized\">
AixLib.Utilities.Math.Functions.inverseXRegularized</a>
to provide a twice continuously differentiable transition between
the different regions.
The code has been implemented in a function as this allows
to implement the function
<a href=\"modelica://AixLib.Utilities.Math.Functions.inverseXRegularized\">
AixLib.Utilities.Math.Functions.inverseXRegularized</a>
in such a way that Dymola inlines it.
However, this function will not be inlined as its body is too large.
</p>
<h4>Implementation</h4>
<p>
For efficiency, the polynomial coefficients
<code>a, b, c, d, e, f</code> and
the inverse of the smoothing parameter <code>deltaInv</code>
are exposed as arguments to this function.
Also,
derivatives are provided in
<a href=\"modelica://AixLib.Utilities.Math.Functions.BaseClasses.der_smoothTransition\">
AixLib.Utilities.Math.Functions.BaseClasses.der_smoothTransition</a>
and in
<a href=\"modelica://AixLib.Utilities.Math.Functions.BaseClasses.der_2_smoothTransition\">
AixLib.Utilities.Math.Functions.BaseClasses.der_2__smoothTransition</a>.
</p>
</html>",           revisions="<html>
<ul>
<li>
September 12, 2018, by David Blum:<br/>
Change if-statement to if-expression.  
For issue <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1019\">#1019</a>.
</li>
<li>
August 11, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
          end smoothTransition;
        annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Utilities.Math.Functions\">AixLib.Utilities.Math.Functions</a>.
</p>
</html>"));
        end BaseClasses;
      annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains functions for commonly used
mathematical operations. The functions are used in
the blocks
<a href=\"modelica://AixLib.Utilities.Math\">
AixLib.Utilities.Math</a>.
</p>
</html>"));
      end Functions;
    annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains blocks and functions for commonly used
mathematical operations.
The classes in this package augment the classes
<a href=\"modelica://Modelica.Blocks\">
Modelica.Blocks</a>.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},
                {-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{
                -26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,
                -50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},
                {51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={
                0,0,0}, smooth=Smooth.Bezier)}));
    end Math;

    package Psychrometrics "Library with psychrometric functions"
      extends Modelica.Icons.VariantsPackage;

      package Constants "Library of constants for psychometric functions"
        extends Modelica.Icons.Package;

        constant Modelica.SIunits.SpecificHeatCapacity cpAir=1006
          "Specific heat capacity of air";

        constant Modelica.SIunits.SpecificHeatCapacity cpSte=1860
          "Specific heat capacity of water vapor";

        constant Modelica.SIunits.SpecificHeatCapacity cpWatLiq = 4184
          "Specific heat capacity of liquid water";

        constant Modelica.SIunits.SpecificEnthalpy h_fg = 2501014.5
          "Enthalpy of evaporation of water at the reference temperature";
        annotation (
          Documentation(info="<html>
<p>
This package provides constants for functions used
in the calculation of thermodynamic properties of moist air.
</p>
</html>",       revisions="<html>
<ul>
<li>
May 24, 2016, by Filip Jorissen:<br/>
Added reference temperature.
</li>
<li>
July 24, 2014, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
            Polygon(
              origin={-9.2597,25.6673},
              fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,-15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,-0.097}},
              smooth=Smooth.Bezier),
            Polygon(
              origin={-19.9923,-8.3993},
              fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,-20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,37.145}},
              smooth=Smooth.Bezier),
            Polygon(
              origin={23.753,-11.5422},
              fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,-24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,41.214},{-2.671,41.214}},
              smooth=Smooth.Bezier)}));
      end Constants;

      block X_pTphi
        "Return steam mass fraction as a function of relative humidity phi and temperature T"
        extends
        AixLib.Utilities.Psychrometrics.BaseClasses.HumidityRatioVaporPressure;

        package Medium = AixLib.Media.Air "Medium model";
        Modelica.Blocks.Interfaces.RealInput T(final unit="K",
                                                 displayUnit="degC",
                                                 min = 0) "Temperature"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealInput phi(min = 0, max=1)
          "Relative humidity (0...1)"
          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
        Modelica.Blocks.Interfaces.RealOutput X[Medium.nX](each min=0, each max=1)
          "Steam mass fraction"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    protected
        Modelica.SIunits.AbsolutePressure pSat "Saturation pressure";
        parameter Integer i_w=
         sum({(
           if Modelica.Utilities.Strings.isEqual(
             string1=Medium.substanceNames[i],
             string2="Water",
             caseSensitive=false)
           then i else 0)
           for i in 1:Medium.nX});
        parameter Integer i_nw = if i_w == 1 then 2 else 1 "Index for non-water substance";
        parameter Boolean found = i_w > 0 "Flag, used for error checking";

      initial equation
        assert(Medium.nX==2, "The implementation is only valid if Medium.nX=2.");
        assert(found, "Did not find medium species 'water' in the medium model. Change medium model.");

      equation
        pSat =  AixLib.Media.Air.saturationPressure(T);
        X[i_w] =  AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(
           pSat=pSat,
           p=p_in_internal,
           phi=phi);
        //sum(X[:]) = 1; // The formulation with a sum in an equation section leads to a nonlinear equation system
        X[i_nw] =  1 - X[i_w];
        annotation (Documentation(info="<html>
<p>
Block to compute the water vapor concentration based on
pressure, temperature and relative humidity.
</p>
<p>
If <code>use_p_in</code> is false (default option), the <code>p</code> parameter
is used as atmospheric pressure,
and the <code>p_in</code> input connector is disabled;
if <code>use_p_in</code> is true, then the <code>p</code> parameter is ignored,
and the value provided by the input connector is used instead.
</p>
</html>",       revisions="<html>
<ul>
<li>November 3, 2017 by Filip Jorissen:<br/>
Converted (initial) algorithm section into (initial) equation section.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/847\">#847</a>.
</li>
<li>July 24, 2014 by Michael Wetter:<br/>
Added <code>assert</code> to verify that <code>Medium.nX==2</code>
as the implementation is only valid for such media.
</li>
<li>April 26, 2013 by Michael Wetter:<br/>
Set the medium model to <code>AixLib.Media.Air</code>.
This was required to allow a pedantic model check in Dymola 2014.
</li>
<li>August 21, 2012 by Michael Wetter:<br/>
Added function call to compute water vapor content.
</li>
<li>
February 22, 2010 by Michael Wetter:<br/>
Improved the code that searches for the index of 'water' in the medium model.
</li>
<li>
February 17, 2010 by Michael Wetter:<br/>
Renamed block from <code>MassFraction_pTphi</code> to <code>X_pTphi</code>
</li>
<li>
February 4, 2009 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),       Icon(graphics={
              Text(
                extent={{-96,16},{-54,-22}},
                lineColor={0,0,0},
                textString="T"),
              Text(
                extent={{-86,-18},{-36,-100}},
                lineColor={0,0,0},
                textString="phi"),
              Text(
                extent={{26,56},{90,-54}},
                lineColor={0,0,0},
                textString="X_steam")}));
      end X_pTphi;

      package Functions "Package with psychrometric functions"
        extends Modelica.Icons.Package;

        function X_pSatpphi "Humidity ratio for given water vapor pressure"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.AbsolutePressure pSat "Saturation pressure";
          input Modelica.SIunits.Pressure p "Pressure of the fluid";
          input Real phi(min=0, max=1) "Relative humidity";
          output Modelica.SIunits.MassFraction X_w(
            min=0,
            max=1,
            nominal=0.01) "Water vapor concentration per total mass of air";

      protected
          constant Real k = 0.621964713077499 "Ratio of molar masses";
        algorithm
          X_w := phi*k/(k*phi+p/pSat-phi);

          annotation (
            smoothOrder=99,
            Inline=true,
            Documentation(info="<html>
<p>
Function to compute the water vapor concentration based on
saturation pressure, absolute pressure and relative humidity.
</p>
</html>",         revisions="<html>
<ul>
<li>
August 21, 2012 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
        end X_pSatpphi;

        function saturationPressure
          "Saturation curve valid for 223.16 <= T <= 373.16 (and slightly outside with less accuracy)"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature TSat(displayUnit="degC",
                                                  nominal=300) "Saturation temperature";
          output Modelica.SIunits.AbsolutePressure pSat(
                                                  displayUnit="Pa",
                                                  nominal=1000) "Saturation pressure";

        algorithm
          pSat := AixLib.Utilities.Math.Functions.regStep(
                     y1=AixLib.Utilities.Psychrometrics.Functions.saturationPressureLiquid(TSat),
                     y2=AixLib.Utilities.Psychrometrics.Functions.sublimationPressureIce(TSat),
                     x=TSat-273.16,
                     x_small=1.0);
          annotation(Inline=true,
            smoothOrder=1,
            Documentation(info="<html>
<p>
Saturation pressure of water, computed from temperature,
according to Wagner <i>et al.</i> (1993).
The range of validity is between
<i>190</i> and <i>373.16</i> Kelvin.
</p>
<h4>References</h4>
<p>
Wagner W., A. Saul, A. Pruss.
 <i>International equations for the pressure along the melting and along the sublimation curve of ordinary water substance</i>,
equation 3.5. 1993.
<a href=\"http://www.nist.gov/data/PDFfiles/jpcrd477.pdf\">
http://www.nist.gov/data/PDFfiles/jpcrd477.pdf</a>.
</p>
</html>",
        revisions="<html>
<ul>
<li>
March 15, 2016, by Michael Wetter:<br/>
Replaced <code>spliceFunction</code> with <code>regStep</code>.
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/300\">issue 300</a>.
</li>
<li>
August 19, 2015 by Michael Wetter:<br/>
Changed <code>smoothOrder</code> from <i>5</i> to <i>1</i> as
<a href=\"modelica://AixLib.Utilities.Math.Functions.spliceFunction\">
AixLib.Utilities.Math.Functions.spliceFunction</a> is only once
continuously differentiable.
Inlined the function.
</li>
<li>
November 20, 2013 by Michael Wetter:<br/>
First implementation, moved from <code>AixLib.Media</code>.
</li>
</ul>
</html>"));
        end saturationPressure;

        function saturationPressureLiquid
          "Return saturation pressure of water as a function of temperature T in the range of 273.16 to 373.16 K"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature TSat(displayUnit="degC",
                                                  nominal=300) "Saturation temperature";
          output Modelica.SIunits.AbsolutePressure pSat(
                                              displayUnit="Pa",
                                              nominal=1000) "Saturation pressure";
        algorithm
          pSat := 611.657*Modelica.Math.exp(17.2799 - 4102.99/(TSat - 35.719));

          annotation (
            smoothOrder=99,
            derivative=AixLib.Utilities.Psychrometrics.Functions.BaseClasses.der_saturationPressureLiquid,
            Inline=true,
            Documentation(info="<html>
<p>
Saturation pressure of water above the triple point temperature computed from temperature
according to Wagner <i>et al.</i> (1993). The range of validity is between
<i>273.16</i> and <i>373.16</i> Kelvin.
</p>
<h4>References</h4>
<p>
Wagner W., A. Saul, A. Pruss.
 <i>International equations for the pressure along the melting and along the sublimation curve of ordinary water substance</i>,
equation 3.5. 1993.
<a href=\"http://www.nist.gov/data/PDFfiles/jpcrd477.pdf\">
http://www.nist.gov/data/PDFfiles/jpcrd477.pdf</a>.
</p>
</html>",
        revisions="<html>
<ul>
<li>
November 20, 2013 by Michael Wetter:<br/>
First implementation, moved from <code>AixLib.Media</code>.
</li>
</ul>
</html>"));
        end saturationPressureLiquid;

        function sublimationPressureIce
          "Return sublimation pressure of water as a function of temperature T between 190 and 273.16 K"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.Temperature TSat(displayUnit="degC",
                                                  nominal=300) "Saturation temperature";
          output Modelica.SIunits.AbsolutePressure pSat(
                                              displayUnit="Pa",
                                              nominal=1000) "Saturation pressure";
      protected
          Modelica.SIunits.Temperature TTriple=273.16 "Triple point temperature";
          Modelica.SIunits.AbsolutePressure pTriple=611.657 "Triple point pressure";
          Real r1=TSat/TTriple "Common subexpression";
          Real a[2]={-13.9281690,34.7078238} "Coefficients a[:]";
          Real n[2]={-1.5,-1.25} "Coefficients n[:]";
        algorithm
          pSat := exp(a[1] - a[1]*r1^n[1] + a[2] - a[2]*r1^n[2])*pTriple;
          annotation (
            Inline=false,
            smoothOrder=5,
            derivative=AixLib.Utilities.Psychrometrics.Functions.BaseClasses.der_sublimationPressureIce,
            Documentation(info="<html>
<p>
Sublimation pressure of water below the triple point temperature, computed from temperature,
according to Wagner <i>et al.</i> (1993).
The range of validity is between
<i>190</i> and <i>273.16</i> Kelvin.
</p>
<h4>References</h4>
<p>
Wagner W., A. Saul, A. Pruss.
 <i>International equations for the pressure along the melting and along the sublimation curve of ordinary water substance</i>,
equation 3.5. 1993.
<a href=\"http://www.nist.gov/data/PDFfiles/jpcrd477.pdf\">
http://www.nist.gov/data/PDFfiles/jpcrd477.pdf</a>.
</p>
</html>",
        revisions="<html>
<ul>
<li>
November 20, 2013 by Michael Wetter:<br/>
First implementation, moved from <code>AixLib.Media</code>.
</li>
</ul>
</html>"));
        end sublimationPressureIce;

        package BaseClasses
        "Package with base classes for AixLib.Utilities.Psychrometrics.Functions"
          extends Modelica.Icons.BasesPackage;

          function der_saturationPressureLiquid
            "Derivative of the function saturationPressureLiquid"
            extends Modelica.Icons.Function;
            input Modelica.SIunits.Temperature Tsat "Saturation temperature";
            input Real dTsat(unit="K/s") "Saturation temperature derivative";
            output Real psat_der(unit="Pa/s") "Differential of saturation pressure";

          algorithm
            psat_der:=611.657*Modelica.Math.exp(17.2799 - 4102.99
                      /(Tsat - 35.719))*4102.99*dTsat/(Tsat - 35.719)^2;

            annotation(Inline=false,
              smoothOrder=5,
              Documentation(info="<html>
<p>
Derivative of function
<a href=\"modelica://AixLib.Utilities.Psychrometrics.Functions.saturationPressureLiquid\">
AixLib.Utilities.Psychrometrics.Functions.saturationPressureLiquid</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 20, 2013 by Michael Wetter:<br/>
First implementation, moved from <code>AixLib.Media</code>.
</li>
</ul>
</html>"));
          end der_saturationPressureLiquid;

          function der_sublimationPressureIce
            "Derivative of function sublimationPressureIce"
              extends Modelica.Icons.Function;
              input Modelica.SIunits.Temperature TSat(displayUnit="degC",
                                                      nominal=300)
              "Saturation temperature";
              input Real dTsat(unit="K/s") "Sublimation temperature derivative";
              output Real psat_der(unit="Pa/s") "Sublimation pressure derivative";
        protected
              Modelica.SIunits.Temperature TTriple=273.16 "Triple point temperature";
              Modelica.SIunits.AbsolutePressure pTriple=611.657 "Triple point pressure";
              Real r1=TSat/TTriple "Common subexpression 1";
              Real r1_der=dTsat/TTriple "Derivative of common subexpression 1";
              Real a[2]={-13.9281690,34.7078238} "Coefficients a[:]";
              Real n[2]={-1.5,-1.25} "Coefficients n[:]";
          algorithm
              psat_der := exp(a[1] - a[1]*r1^n[1] + a[2] - a[2]*r1^n[2])*pTriple*(-(a[1]
                *(r1^(n[1] - 1)*n[1]*r1_der)) - (a[2]*(r1^(n[2] - 1)*n[2]*r1_der)));
              annotation (
                Inline=false,
                smoothOrder=5,
                Documentation(info="<html>
<p>
Derivative of function
<a href=\"modelica://AixLib.Utilities.Psychrometrics.Functions.sublimationPressureIce\">
AixLib.Utilities.Psychrometrics.Functions.sublimationPressureIce</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 20, 2013 by Michael Wetter:<br/>
First implementation, moved from <code>AixLib.Media</code>.
</li>
</ul>
</html>"));
          end der_sublimationPressureIce;
        annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Utilities.Psychrometrics.Functions\">AixLib.Utilities.Psychrometrics.Functions</a>.
</p>
</html>"));
        end BaseClasses;
        annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains functions for psychrometric calculations.
</p>

The nomenclature used in this package is described at
<a href=\"modelica://AixLib.UsersGuide.Conventions\">
AixLib.UsersGuide.Conventions</a>.
</html>"));
      end Functions;

      package BaseClasses
      "Package with base classes for AixLib.Utilities.Psychrometrics"
        extends Modelica.Icons.BasesPackage;

        partial block HumidityRatioVaporPressure
          "Humidity ratio for given water vapor pressure"
          extends Modelica.Blocks.Icons.Block;
          parameter Boolean use_p_in = true "Get the pressure from the input connector"
            annotation(Evaluate=true, HideResult=true);

          parameter Modelica.SIunits.Pressure p = 101325 "Fixed value of pressure"
            annotation (Dialog(enable = not use_p_in));
          Modelica.Blocks.Interfaces.RealInput p_in(final quantity="Pressure",
                                                 final unit="Pa",
                                                 displayUnit="Pa",
                                                 min = 0) if  use_p_in
            "Atmospheric Pressure"
            annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

      protected
          Modelica.Blocks.Interfaces.RealInput p_in_internal
            "Needed to connect to conditional connector";
        equation
          connect(p_in, p_in_internal);
          if not use_p_in then
            p_in_internal = p;
          end if;
          annotation (
            Documentation(info="<html>
<p>
Partial Block to compute the relation between humidity ratio and water vapor partial pressure.
</p>
<p>If <code>use_p_in</code> is false (default option), the <code>p</code> parameter
is used as atmospheric pressure,
and the <code>p_in</code> input connector is disabled;
if <code>use_p_in</code> is true, then the <code>p</code> parameter is ignored,
and the value provided by the input connector is used instead.
</p>
</html>",         revisions="<html>
<ul>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
April 14, 2009 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
                    100}}), graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-96,96},{96,-96}},
                  fillPattern=FillPattern.Sphere,
                  pattern=LinePattern.None,
                  lineColor={255,255,255},
                  fillColor={170,213,255}),
                Text(
                  visible=use_p_in,
                  extent={{-90,108},{-34,16}},
                  lineColor={0,0,0},
                  textString="p_in")}));
        end HumidityRatioVaporPressure;
      annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Utilities.Psychrometrics\">AixLib.Utilities.Psychrometrics</a>.
</p>
</html>"));
      end BaseClasses;
    annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains blocks and functions for psychrometric calculations.
</p>
<p>
The nomenclature used in this package is described at
<a href=\"modelica://AixLib.UsersGuide.Conventions\">
AixLib.UsersGuide.Conventions</a>.
</p>
</html>"));
    end Psychrometrics;

    package Sources "Sources"
      extends Modelica.Icons.Package;

      package HeaterCooler "HeaterCooler"
        extends Modelica.Icons.Package;

        partial model PartialHeaterCooler

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRoom
            "Heat port to thermal zone"                                                                annotation(Placement(transformation(extent={{80,-50},
                    {100,-30}}), iconTransformation(extent={{80,-50},{100,-30}})));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                           graphics={  Rectangle(extent={{-94,-30},{80,-50}},    lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
                    fillPattern =                                                                                                   FillPattern.Solid),                                                                                                    Line(points={{
                      -46,-30},{-46,60}},                                                                                                    color={0,
                      128,255}),                                                                                                    Line(points={{
                      -66,36},{-46,60},{-26,36}},                                                                                                    color={0,
                      128,255}),                                                                                                    Line(points={{
                      30,-30},{30,60}},                                                                                                    color={255,
                      0,0}),                                                                                                    Line(points={{
                      10,36},{30,60},{50,36}}, color={255,0,0}),
                Rectangle(
                  extent={{-68,-20},{-24,-30}},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Rectangle(
                  extent={{8,-20},{52,-30}},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None)}),                                                                                                    Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension.</p>
 </html>",         revisions="<html>
 <ul>
 <li><i>October, 2015&nbsp;</i> by Moritz Lauster:<br/>Adapted to Annex60 and restructuring</li>
 </ul>
 <ul>
 <li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
 </ul>
 </html>"));
        end PartialHeaterCooler;
      end HeaterCooler;
    end Sources;

    package Interfaces
    "Interfaces that are not defined in MSL or Annex60-Library"
      extends Modelica.Icons.InterfacesPackage;

      connector HeatStarComb "Combines therm connector and star connector."
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm;
        AixLib.Utilities.Interfaces.Star Star;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-100, 102}, {102, -100}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0},
                  fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-9, 86}, {17, 86}, {17, 12}, {81, 34}, {89, 6}, {26, -14}, {66, -72}, {41, -88}, {4, -28}, {-31, -88}, {-56, -72}, {-18, -14}, {-81, 6}, {-73, 34}, {-9, 12}, {-9, 86}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                  fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>
 This connector makes a single connection for a combination of Radiation and Convection possible.
 </p>
 </html>
 ",       revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li>by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"));
      end HeatStarComb;

      connector SolarRad_in
        "Scalar total radiation connector (input) with additional direct, diffuse and from ground reflected radiation"
        input Modelica.SIunits.RadiantEnergyFluenceRate I
          "total radiation normal to the surface";
        input Modelica.SIunits.RadiantEnergyFluenceRate I_dir
          "direct radiation normal to the surface";
        input Modelica.SIunits.RadiantEnergyFluenceRate I_diff
          "diffuse radiation normal to the surface";
        input Modelica.SIunits.RadiantEnergyFluenceRate I_gr
          "radiation due to the ground reflection normal to the surface";
        input Real  AOI(unit = "rad") "Angle of incidence of surface";
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-20, 58}, {96, -58}}, lineColor = {255, 128, 0}), Rectangle(extent = {{52, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{38, 62}, {38, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-24, 0}, {-78, 0}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-6, 44}, {-46, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-20, 22}, {-72, 40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{14, 58}, {2, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{14, -58}, {2, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-8, -44}, {-46, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-20, -22}, {-74, -40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{38, -80}, {38, -62}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Polygon(points = {{0, 6}, {0, 28}, {0, 28}, {52, 0}, {0, -26}, {0, -26}, {0, -6}, {0, 6}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                  fillPattern =                                                                                                    FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{-20, 58}, {96, -58}}, lineColor = {255, 128, 0}), Rectangle(extent = {{52, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                    FillPattern.Solid), Line(points = {{38, 62}, {38, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-24, 0}, {-78, 0}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-6, 44}, {-46, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-20, 22}, {-72, 40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{14, 58}, {2, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{14, -58}, {2, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-8, -44}, {-46, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-20, -22}, {-74, -40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{38, -80}, {38, -62}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Polygon(points = {{0, 6}, {0, 28}, {0, 28}, {52, 0}, {0, -26}, {0, -26}, {0, -6}, {0, 6}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                  fillPattern =                                                                                                    FillPattern.Solid)}), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>SolarRad_in</b> connector is used for total radiation input and its main components. Is explicitly defined as an input.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>It contains information on:</p>
<ul>
<li>total radiation</li>
<li>direct radiation (as part of the total radiation)</li>
<li>diffuse radiaton (as part of the total radiation)</li>
<li>radiation reflected from the ground (as part of the total radiation)</li>
<li>angle of incidence on the surface</li>
</ul>
<p><br/>which can be needed by certain models, but is not neccesarry for all models. As this connector replaces the old connector, please make sure to write the appropriate equations for all the connector&apos;s components.</p>
</html>",        revisions="<html>
 <ul>
<li><i>February 22, 2015&nbsp;</i> by Ana Constantin:<br/>Added the components of the total radiation</li>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 </ul>
 </html>"));
      end SolarRad_in;

      connector SolarRad_out
        "Scalar total radiation connector (output) with additional direct, diffuse and from ground reflected radiation"

        output Modelica.SIunits.RadiantEnergyFluenceRate I
          "total radiation normal to the surface";
        output Modelica.SIunits.RadiantEnergyFluenceRate I_dir
          "direct radiation normal to the surface";
        output Modelica.SIunits.RadiantEnergyFluenceRate I_diff
          "diffuse radiation normal to the surface";
        output Modelica.SIunits.RadiantEnergyFluenceRate I_gr
          "radiation due to the ground reflection normal to the surface";

        output Real  AOI(unit = "rad") "Angle of incidence of surface";
        annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{18, 58}, {-98, -58}}, lineColor = {255, 128, 0}), Line(points = {{-40, 62}, {-40, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{24, 0}, {78, 0}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{6, 44}, {46, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{20, 22}, {72, 40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-14, 58}, {-2, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-14, -58}, {-2, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{8, -44}, {46, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{20, -22}, {74, -40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-40, -80}, {-40, -62}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Rectangle(extent = {{-100, 100}, {-60, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-60, 6}, {-60, 28}, {-60, 28}, {-8, 0}, {-60, -26}, {-60, -26}, {-60, -6}, {-60, 6}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                  fillPattern =                                                                                                   FillPattern.Solid)}), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent = {{18, 58}, {-98, -58}}, lineColor = {255, 128, 0}), Line(points = {{-40, 62}, {-40, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{24, 0}, {78, 0}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{6, 44}, {46, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{20, 22}, {72, 40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-14, 58}, {-2, 80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-14, -58}, {-2, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{8, -44}, {46, -80}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{20, -22}, {74, -40}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Line(points = {{-40, -80}, {-40, -62}}, color = {255, 128, 0}, smooth = Smooth.Bezier), Rectangle(extent = {{-100, 100}, {-60, -100}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                  fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-60, 6}, {-60, 28}, {-60, 28}, {-8, 0}, {-60, -26}, {-60, -26}, {-60, -6}, {-60, 6}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                  fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>The <b>SolarRad_out</b> connector is used for the total radiation output and its main components. Is explicitly defined as an output. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>It contains information on:</p>
<ul>
<li>total radiation</li>
<li>direct radiation (as part of the total radiation)</li>
<li>diffuse radiaton (as part of the total radiation)</li>
<li>radiation reflected from the ground (as part of the total radiation)</li>
<li>angle of incidence on the surface</li>
</ul>
<p><br/>which can be needed by certain models, but is not neccesarry for all models. As this connector replaces the old connector, please make sure to write the appropriate equations for all the connector&apos;s components.</p>
</html>",        revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 </ul>
 </html>"));
      end SolarRad_out;

      connector Star "Connector for twostar (approximated) radiation exchange"
        extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
        annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {95, 95, 95},  pattern = LinePattern.None, fillColor = {255, 255, 255},
                  fillPattern =                                                                                                    FillPattern.Solid), Polygon(points = {{-13, 86}, {13, 86}, {13, 12}, {77, 34}, {85, 6}, {22, -14}, {62, -72}, {37, -88}, {0, -28}, {-35, -88}, {-60, -72}, {-22, -14}, {-85, 6}, {-77, 34}, {-13, 12}, {-13, 86}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                  fillPattern =                                                                                                    FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-82, 84}, {78, -76}}, lineColor = {0, 0, 255},  pattern = LinePattern.None, fillColor = {255, 255, 255},
                  fillPattern =                                                                                                    FillPattern.Solid), Polygon(points = {{-13, 86}, {13, 86}, {13, 12}, {77, 34}, {85, 6}, {22, -14}, {62, -72}, {37, -88}, {0, -28}, {-35, -88}, {-60, -72}, {-22, -14}, {-85, 6}, {-77, 34}, {-13, 12}, {-13, 86}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                  fillPattern =                                                                                                    FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>The <b>Star</b> connector extends from the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> connector. But the carried data has to be interpreted in a different way: the temperature T is a virtual temperature describing the potential of longwave radiation exchange inside the room. The heat flow Q_flow is the resulting energy flow due to longwave radiation. </p>
 </html>",       revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>July 12, 2009&nbsp;</i>
          by Peter Matthes:<br/>
          Switched to Modelica.SIunits.Temperature.</li>
   <li><i>June 16, 2006&nbsp;</i>
          by Timo Haase:<br/>
          Implemented.</li>

 </ul>
 </html>"));
      end Star;

      package Adaptors
        extends Modelica.Icons.Package;

        model HeatStarToComb
          AixLib.Utilities.Interfaces.HeatStarComb thermStarComb annotation(Placement(transformation(extent = {{-120, -10}, {-76, 36}}), iconTransformation(extent = {{-116, -24}, {-72, 22}})));
          AixLib.Utilities.Interfaces.Star star annotation(Placement(transformation(extent = {{84, 38}, {124, 78}}), iconTransformation(extent = {{84, 38}, {124, 78}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a therm annotation(Placement(transformation(extent = {{84, -68}, {118, -34}}), iconTransformation(extent = {{84, -68}, {118, -34}})));
        equation
          connect(thermStarComb.Star, star);
          connect(thermStarComb.Therm, therm);
          annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {100, 80}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -80}, {100, 80}}), graphics={  Polygon(points = {{-76, 0}, {86, -72}, {86, 70}, {-76, 0}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 0},
                    fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This adaptor makes it possible to connect HeatStarComb with either Star or Heat connector or both. </p>
 </html>",         revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 01, 2014 </i> by Moritz Lauster:<br/>Renamed</li>
 <li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
 <li>by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"));
        end HeatStarToComb;
      end Adaptors;
    end Interfaces;
  annotation (
  preferredView="info", Documentation(info="<html>
<p>
This package contains utility models such as for thermal comfort calculation, input/output, co-simulation, psychrometric calculations and various functions that are used throughout the library.
</p>
</html>"),
  Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Polygon(
        origin={1.3835,-4.1418},
        rotation=45.0,
        fillColor={64,64,64},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),
      Polygon(
        origin={10.1018,5.218},
        rotation=-45.0,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        points={{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},{20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}})}));
  end Utilities;

  package PlugNHarvest

    package Components

      package Controls

        model Cooler "Controller cooling generation "
          extends
          PlugNHarvest.Components.Controls.BaseClasses.PartialExternalControl;

            parameter Modelica.SIunits.Temperature T_room_Threshold=23 + 273.15 "Threshold of the room temperature";

          Modelica.Blocks.Sources.Constant const_setpoint(k=T_room_Threshold)
            annotation (Placement(transformation(extent={{26,26},{46,46}})));
        equation

          connect(const_setpoint.y, ControlBus.setT_room) annotation (Line(points={{47,36},
                  {99.8213,36},{99.8213,22.5675}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(isOn, ControlBus.isOn) annotation (Line(points={{-99.75,83.25},{-60,
                  83.25},{-60,-10},{99.8213,-10},{99.8213,22.5675}}, color={255,0,255}),
              Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                        Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={28,108,200},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{30,102},{-36,62}},
                  lineColor={0,0,0},
                  fillColor={244,125,35},
                  fillPattern=FillPattern.None,
                  fontSize=72,
                  textString="Chiller"),
                Rectangle(
                  extent={{-100,64},{100,-100}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid)}),                      Diagram(
                coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                  extent={{98,98},{-98,-52}},
                  lineColor={28,108,200},
                  fillColor={255,170,85},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{74,102},{30,84}},
                  lineColor={0,0,0},
                  fillColor={244,125,35},
                  fillPattern=FillPattern.Solid,
                  fontSize=18,
                  textString="Controller")}),
            Documentation(revisions="<html>
<ul>
<li><i>November 26, 2072&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
        end Cooler;

        model Heater "Controller heat generation"
          extends
          PlugNHarvest.Components.Controls.BaseClasses.PartialExternalControl;
          parameter Modelica.SIunits.Temperature Toutside_Threshold=16 + 273.15 "Heating limit";
            parameter Modelica.SIunits.Temperature Tset=19 + 273.15 "Threshold of the room temperature";

          Modelica.Blocks.Logical.And Checker
            annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
          Modelica.Blocks.Logical.LessThreshold    cooling(threshold=Toutside_Threshold)
            annotation (Placement(transformation(extent={{-52,-38},{-32,-18}})));
          Modelica.Blocks.Sources.Constant const_setpoint(k=Tset)
            annotation (Placement(transformation(extent={{26,26},{46,46}})));
        equation

          connect(cooling.y, Checker.u2) annotation (Line(points={{-31,-28},{-28,-28},{-28,
                  -10},{-12,-10}}, color={255,0,255}));
          connect(isOn, Checker.u1) annotation (Line(points={{-99.75,83.25},{-76,83.25},
                  {-76,-2},{-12,-2},{-12,-2}}, color={255,0,255}));
          connect(Toutside, cooling.u) annotation (Line(points={{-100,-7.5},{-76,-7.5},{
                  -76,-28},{-54,-28}}, color={0,0,127}));
          connect(const_setpoint.y, ControlBus.setT_room) annotation (Line(points={{47,36},
                  {99.8213,36},{99.8213,22.5675}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(Checker.y, ControlBus.isOn) annotation (Line(points={{11,-2},{99.8213,
                  -2},{99.8213,22.5675}}, color={255,0,255}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                        Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,85,85},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{64,102},{-78,60}},
                  lineColor={0,0,0},
                  fillColor={244,125,35},
                  fillPattern=FillPattern.None,
                  fontSize=72,
                  textString="Heater"),
                Rectangle(
                  extent={{-100,64},{100,-100}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={238,46,47},
                  fillPattern=FillPattern.Solid)}),                      Diagram(
                coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                  extent={{98,98},{-98,-52}},
                  lineColor={28,108,200},
                  fillColor={255,170,85},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{74,102},{30,84}},
                  lineColor={0,0,0},
                  fillColor={244,125,35},
                  fillPattern=FillPattern.Solid,
                  fontSize=18,
                  textString="Controller")}),
            Documentation(revisions="<html>
<ul>
<li><i>November 26, 2072&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
        end Heater;

        package BaseClasses
          extends Modelica.Icons.BasesPackage;

          partial model PartialExternalControl "With inputs and control bus"

            Modelica.Blocks.Interfaces.RealInput Toutside(
              final quantity="ThermodynamicTemperature",
              final unit="K",
              displayUnit="degC") "Outside temperature [K]"
              annotation (Placement(transformation(
                  extent={{-13.5,-13.5},{13.5,13.5}},
                  rotation=0,
                  origin={-100,-7.5}),iconTransformation(extent={{-10.75,-10.5},{10.75,10.5}},
                    origin={-97.25,-4.5})));
            Modelica.Blocks.Interfaces.BooleanInput isOn
              "On/Off switch for the boiler"
              annotation (Placement(transformation(extent={{-112.5,70.5},{-87,96}}),
                  iconTransformation(extent={{-105,78},{-87,96}})));
            Modelica.Blocks.Interfaces.BooleanInput switchToNightMode
              "Connector of boolean input signal"
              annotation (Placement(transformation(extent={{-13.75,-13.75},{13.75,13.75}},
                  rotation=0,
                  origin={-100.25,37.75}), iconTransformation(
                  extent={{-8.25,-8.5},{8.25,8.5}},
                  rotation=0,
                  origin={-99.5,56.25})));

            Bus.GenEnegGenControlBus ControlBus "control bus for a heater"
              annotation (Placement(transformation(extent={{85.5,9},{114,36}})));
          equation
            if cardinality(isOn) < 2 then
              isOn = true;
            end if;

            annotation (Diagram(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  grid={1.5,1.5})),           Icon(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}},
                  grid={1.5,1.5}), graphics={
                                      Rectangle(
                    extent={{-84,85.5},{91.5,-82.5}},
                    lineColor={175,175,175},
                    lineThickness=0.5,
                    fillPattern=FillPattern.Solid,
                    fillColor={255,255,170}),
                  Text(
                    extent={{-79.5,19.5},{82.5,-4.5}},
                    lineColor={0,0,0},
                    fillColor={255,255,170},
                    fillPattern=FillPattern.Solid,
                    textString="%name")}),
              Documentation(info="<html>
</html>", revisions="<html>
<ul>
<li><i>November 26, 2017</i> by Ana Constantin:<br/>Implemented</li>
</ul>
</html>"));
          end PartialExternalControl;
        end BaseClasses;

        package Bus

          expandable connector GenEnegGenControlBus
            "General control data bus for energy generator: (ideal) heater/cooler"
            extends Modelica.Icons.SignalBus;

           Modelica.SIunits.ThermodynamicTemperature setT_supply
             "Set supply temperature for the conditioning medium: water or air";

           Modelica.SIunits.ThermodynamicTemperature setT_room
             "Set room temperature";

           Modelica.SIunits.ThermodynamicTemperature Toutside "outside temperature";

           Boolean isOn
             "is heater on";

           Boolean isNightMode "true if night mode active";

            annotation (
              Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)),
              Documentation(info="<html>
<p>Definition of a standard bus for a heater</p>
</html>",           revisions="<html>
<p>November 2017, by Ana Constantini:</p>
<p>First implementation. </p>
</html>"));

          end GenEnegGenControlBus;
        end Bus;
      end Controls;

      package EnergySystem

        package IdealHeaterCooler

          model HeaterCoolerPI_withPel
            extends
            PlugNHarvest.Components.EnergySystem.IdealHeaterCooler.BaseClasses.PartialHeaterCoolerPI;

            parameter Boolean isEl_heater = false "heater is electrical";
            parameter Boolean isEl_cooler = true "cooler is electrical";
            parameter Real etaEl_heater = 2.5 "electrical efficiency of heater";
            parameter Real etaEl_cooler = 3.0 "electrical efficiency of cooler";
            Modelica.Blocks.Interfaces.RealOutput electricalPower_heater(final unit="W",
                final quantity="ElectricityFlowRate") "Electrical power for heating"
                                                                          annotation (
                Placement(transformation(extent={{80,-90},{120,-50}}), iconTransformation(
                    extent={{80,-80},{100,-60}})));
            Modelica.Blocks.Interfaces.RealOutput electricalPower_cooler(final unit="W",
                final quantity="ElectricityFlowRate") "Electrical power for cooling"
                                                                          annotation (
                Placement(transformation(extent={{80,-116},{120,-76}}),
                  iconTransformation(extent={{80,-100},{100,-80}})));

            Controls.Bus.GenEnegGenControlBus              ControlBus_idealHeater
              annotation (Placement(transformation(extent={{-64,-108},{-26,-76}})));
            Controls.Bus.GenEnegGenControlBus              ControlBus_idealCooler
              annotation (Placement(transformation(extent={{4,-106},{42,-74}})));
          equation
            if isEl_heater then
              electricalPower_heater = heatingPower / etaEl_heater;
            else
              electricalPower_heater = 0.0;
            end if;

            if isEl_cooler then
              electricalPower_cooler = (-1) * coolingPower / etaEl_cooler;
            else
              electricalPower_cooler = 0.0;
            end if;

            connect(pITempCool.setPoint, ControlBus_idealCooler.setT_room) annotation (
                Line(points={{-18,-29},{-18,-36},{-30,-36},{-30,-90},{-4,-90},{-4,
                    -89.92},{23.095,-89.92}},                          color={0,0,127}),
                Text(
                string="%second",
                index=1,
                extent={{6,3},{6,3}}));
            connect(pITempHeat.setPoint, ControlBus_idealHeater.setT_room) annotation (
                Line(points={{-18,29},{-18,34},{-30,34},{-30,-92},{-36,-92},{-36,-91.92},
                    {-44.905,-91.92}},                              color={0,0,127}),
                Text(
                string="%second",
                index=1,
                extent={{6,3},{6,3}}));
            connect(pITempHeat.onOff, ControlBus_idealHeater.isOn) annotation (Line(
                  points={{-19,15},{-30,15},{-30,-14},{-60,-14},{-60,-91.92},{-44.905,
                    -91.92}},                                             color={255,0,255}),
                Text(
                string="%second",
                index=1,
                extent={{6,3},{6,3}}));
            connect(pITempCool.onOff, ControlBus_idealCooler.isOn) annotation (Line(
                  points={{-19,-15},{-19,-14},{-28,-14},{-28,-14},{-60,-14},{-60,-89.92},
                    {23.095,-89.92}},                               color={255,0,255}),
                Text(
                string="%second",
                index=1,
                extent={{6,3},{6,3}}));
            annotation (Documentation(info="<html>
<h4>Objective</h4>
<p>An ideal heater cooler with PI controller which also outputs the electrical power.</p>
<p>It uses control buses to conect with the controllers.</p>
</html>",           revisions="<html>
<ul>
<li><i>November 26, 2072&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
          end HeaterCoolerPI_withPel;

          package BaseClasses
            extends Modelica.Icons.BasesPackage;

            partial model PartialHeaterCoolerPI
              extends AixLib.Utilities.Sources.HeaterCooler.PartialHeaterCooler;
              parameter Real h_heater = 0 "Upper limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
              parameter Real l_heater = 0 "Lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
              parameter Real KR_heater = 1000 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
              parameter Modelica.SIunits.Time TN_heater = 1
                "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
              parameter Real h_cooler = 0 "Upper limit controller output of the cooler"
                                                                                       annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
              parameter Real l_cooler = 0 "Lower limit controller output of the cooler"          annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
              parameter Real KR_cooler = 1000 "Gain of the cooling controller"
                                                                              annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
              parameter Modelica.SIunits.Time TN_cooler = 1
                "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));

              Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling annotation(Placement(transformation(extent={{26,-23},
                        {6,-2}})));
              AixLib.Controls.Continuous.PITemp pITempCool(
                rangeSwitch=false,
                h=h_cooler,
                l=l_cooler,
                KR=KR_cooler,
                TN=TN_cooler)
                "PI control for cooler"
                annotation (Placement(transformation(extent={{-20,-10},{0,-30}})));
              Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating annotation(Placement(transformation(extent={{26,22},
                        {6,2}})));
              AixLib.Controls.Continuous.PITemp pITempHeat(
                rangeSwitch=false,
                h=h_heater,
                l=l_heater,
                KR=KR_heater,
                TN=TN_heater)
                "PI control for heater"
                annotation (Placement(transformation(extent={{-20,10},{0,30}})));
              Modelica.Blocks.Interfaces.RealOutput heatingPower(
               final quantity="HeatFlowRate",
               final unit="W") "Power for heating"
                annotation (Placement(transformation(extent={{80,20},{120,60}}),
                    iconTransformation(extent={{80,20},{100,40}})));
              Modelica.Blocks.Interfaces.RealOutput coolingPower(
               final quantity="HeatFlowRate",
               final unit="W") "Power for cooling"
                annotation (Placement(transformation(extent={{80,-26},{120,14}}),
                    iconTransformation(extent={{80,-2},{100,18}})));
            equation
              connect(Heating.port, heatCoolRoom) annotation (Line(
                    points={{6,12},{2,12},{2,-40},{90,-40}},
                    color={191,0,0},
                    smooth=Smooth.None));
              connect(pITempHeat.heatPort, heatCoolRoom) annotation (Line(
                  points={{-16,11},{-16,-40},{90,-40}},
                  color={191,0,0},
                  smooth=Smooth.None));
              connect(pITempCool.y, Cooling.Q_flow) annotation (Line(
                    points={{-1,-20},{26,-20},{26,-12.5}},
                    color={0,0,127},
                    smooth=Smooth.None));
              connect(Cooling.port, heatCoolRoom) annotation (Line(
                    points={{6,-12.5},{2.4,-12.5},{2.4,-40},{90,-40}},
                    color={191,0,0},
                    smooth=Smooth.None));
              connect(pITempCool.heatPort, heatCoolRoom) annotation (Line(
                  points={{-16,-11},{-16,-40},{90,-40}},
                  color={191,0,0},
                  smooth=Smooth.None));
              connect(Heating.Q_flow, pITempHeat.y) annotation (Line(points={{26,12},{26,20},{-1,20}}, color={0,0,127}));
              connect(Heating.Q_flow,heatingPower)
                annotation (Line(points={{26,12},{26,40},{100,40}}, color={0,0,127}));
              connect(Cooling.Q_flow,coolingPower)  annotation (Line(points={{26,-12.5},{56,
                      -12.5},{56,-6},{100,-6}}, color={0,0,127}));
              annotation (Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension. It extends another base class and adds some basic elements.</p>
 </html>",             revisions="<html>
 <ul>
 <li><i>October, 2015&nbsp;</i> by Moritz Lauster:<br/>Adapted to Annex60 and restructuring, implementing new functionalities</li>
 </ul>
 <ul>
 <li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
 </ul>
 </html>"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                        100}})),
                Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
            end PartialHeaterCoolerPI;
          end BaseClasses;
        end IdealHeaterCooler;
      end EnergySystem;

      package InternalGains

        package Facilities

          package ElAppliances
          "Electrical appliances used in the zones, for other purposes than climatisation"

            model ElAppliancesForZone
              extends
              PlugNHarvest.Components.InternalGains.BaseClasses.PartialElectricalEquipment;

              parameter Modelica.SIunits.Area zoneArea = 100 "zone area";
              parameter Real spPelSurface(unit = "W/m2") =  22 "specific Pel per surface area for type of machines";
              parameter Real coeffThermal = 0.5 "coeff = Pth/Pel";
              parameter Real coeffRadThermal = 0.75 "coeff = Pth,rad/Pth";
              parameter Real emissivityMachine =  0.9 "emissivity of machine";
              Modelica.Blocks.Sources.Constant AreaofZone(k=zoneArea)
                annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
              Modelica.Blocks.Sources.Constant SpecificElectricalPower(k=spPelSurface)
                "in W/m2 for area"
                annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
              Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
                annotation (Placement(transformation(extent={{-16,-8},{-4,4}})));
              Modelica.Blocks.Math.Gain coeffPthermal(k=coeffThermal)
                annotation (Placement(transformation(extent={{12,14},{24,26}})));
              Modelica.Blocks.Math.Gain coefPth_conv(k=1 - coeffRadThermal)
                annotation (Placement(transformation(extent={{30,34},{38,42}})));
              Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat             annotation(Placement(transformation(extent={{46,28},
                        {66,48}})));
              Modelica.Blocks.Math.Gain coeffOth_rad(k=coeffRadThermal)
                annotation (Placement(transformation(extent={{30,-4},{38,4}})));
              Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow RadiativeHeat                    annotation(Placement(transformation(extent={{46,-10},
                        {66,10}})));
              AixLib.Utilities.HeatTransfer.HeatToStar
                                              RadiationConvertor(eps=emissivityMachine, A=
                   max(1e-4, zoneArea/10.0))
                annotation (Placement(transformation(extent={{70,-8},{90,12}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat
                "convective heat connector"                                                            annotation(Placement(transformation(extent={{80,60},
                        {100,80}}),                                                                                                                                         iconTransformation(extent={{80,60},
                        {100,80}})));
              AixLib.Utilities.Interfaces.Star
                                        RadHeat "radiative heat connector" annotation(Placement(transformation(extent={{100,-8},
                        {120,12}}),                                                                                                               iconTransformation(extent={{80,2},{
                        100,22}})));
            equation
              connect(AreaofZone.y,multiProduct. u[1]) annotation (Line(points={{-39,30},
                      {-28,30},{-28,0.8},{-16,0.8}},
                                              color={0,0,127}));
              connect(SpecificElectricalPower.y,multiProduct. u[2]) annotation (Line(points={{-39,-30},
                      {-28,-30},{-28,-2},{-16,-2}},               color={0,0,127}));
              connect(multiProduct.y,coeffPthermal. u) annotation (Line(points={{-2.98,-2},
                      {0,-2},{0,20},{10.8,20}},color={0,0,127}));
              connect(coefPth_conv.y,ConvectiveHeat. Q_flow)
                annotation (Line(points={{38.4,38},{46,38}}, color={0,0,127}));
              connect(ConvectiveHeat.port,ConvHeat)  annotation(Line(points={{66,38},{74,
                      38},{74,70},{90,70}},                                                                             color = {191, 0, 0}, pattern = LinePattern.Solid));
              connect(coeffOth_rad.y,RadiativeHeat. Q_flow)
                annotation (Line(points={{38.4,0},{46,0}}, color={0,0,127}));
              connect(RadiationConvertor.Star,RadHeat)  annotation (Line(
                  points={{89.1,2},{110,2}},
                  color={95,95,95},
                  pattern=LinePattern.Solid));
              connect(coeffPthermal.y,coefPth_conv. u) annotation (Line(points={{24.6,20},
                      {26,20},{26,38},{29.2,38}},
                                              color={0,0,127}));
              connect(coeffPthermal.y,coeffOth_rad. u) annotation (Line(points={{24.6,20},
                      {26,20},{26,0},{29.2,0}},
                                            color={0,0,127}));
              connect(RadiativeHeat.port,RadiationConvertor. Therm)
                annotation (Line(points={{66,0},{70,0},{70,2},{70.8,2}}, color={191,0,0}));
              connect(Schedule, multiProduct.u[3]) annotation (Line(points={{-100,0},{-60,
                      0},{-60,-4.8},{-16,-4.8}}, color={0,0,127}));
              connect(multiProduct.y, Pel) annotation (Line(points={{-2.98,-2},{0,-2},{0,
                      -50},{100,-50}}, color={0,0,127}));
              annotation (Icon(graphics={
                    Polygon(
                      points={{-80,-60},{60,-60},{80,-34},{80,52},{-60,52},{-80,36},{-80,
                          -60}},
                      lineColor={0,0,0},
                      lineThickness=1,
                      fillColor={28,108,200},
                      fillPattern=FillPattern.Solid),
                    Line(
                      points={{-80,36},{60,36},{60,-60}},
                      color={0,0,0},
                      thickness=1),
                    Ellipse(
                      extent={{-28,8},{8,-26}},
                      lineColor={0,0,0},
                      lineThickness=1,
                      fillColor={28,108,200},
                      fillPattern=FillPattern.Solid),
                    Line(
                      points={{-12,14},{-12,20},{-2,20},{-4,14},{4,10},{8,16},{14,8},{10,
                          4},{14,-4},{20,-4},{20,-14},{14,-14},{10,-22},{16,-26},{10,-32},
                          {4,-28},{-2,-32},{-2,-38},{-10,-38},{-10,-32},{-16,-32},{-18,
                          -38},{-26,-34},{-24,-28},{-28,-26},{-32,-28},{-38,-24},{-32,-20},
                          {-34,-14},{-40,-14},{-40,-4},{-36,-6},{-34,2},{-38,4},{-32,12},
                          {-28,8},{-24,12},{-28,16},{-22,20},{-18,14},{-12,14}},
                      color={0,0,0},
                      thickness=1)}), Documentation(info="<html>
<h4>Objective </h4>
<p>The model describes the electrical power consumed by auxiliary equipment and the thermal power generated by it for a certain zone.</p>
<p>The model can be thus used to calculate both the thermal and the electrical load / energy consumption of a building caused by auxiliary equipment (help energy)</p>
<p>The input is a schedule for the equipment and can vary between 0 and 1.</p>
<p>The assumptions as well as exemplary values for the parameters are listed below. </p>
<h4>Assumptions</h4>
<p>The surface of the lamps is assumed as 1/10 of the zone area. The emissivity of the machines is assumed to be 0.9. Both these values are needed for the calculation of the radiative heat exchange.</p>
<h4>Heat loads by type of zone</h4>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><h4>Type of zone</h4></td>
<td><h4>Heat Load in W/m2</h4></td>
<td><h4>Source</h4></td>
</tr>
<tr>
<td><p>Supermarket Non-Food</p></td>
<td><p>1 / 2 / 3 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A6)</p></td>
</tr>
<tr>
<td><p>Supermarket Food (cooling)</p></td>
<td><p>-12 / -10 / -8 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A7) if heat from cooling taken outside</p></td>
</tr>
<tr>
<td><p>Office</p></td>
<td><p>2.8 / 7.1 / 15 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A2)</p></td>
</tr>
<tr>
<td><p>Kitchen (preparation, storage)</p></td>
<td><p>20 / 30 / 40 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A15)</p></td>
</tr>
<tr>
<td><p>Storage</p></td>
<td><p>0 / 0 / 0 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A18)</p></td>
</tr>
<tr>
<td><p>....</p></td>
<td></td>
<td></td>
</tr>
</table>
<p><br><br><h4>Relationship thermal - electrical load and convective - radiant thermal load</h4></p>
<p><span style=\"font-family: Arial;\">(Source ASHRAE Handbook of Fundamentals, 2001) </span></p>
<ul>
<li><span style=\"font-family: Arial;\">Cooking appliances (page 28.9) -&gt; used for type of zone kitchen</span></li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Arial;\">Heat gain 50&percnt; of rated hourly input - 66 &percnt; sensible (100&percnt; radiant as convective is exhausted) </span></p>
<ul>
<li><span style=\"font-family: Arial;\">Sales food (table 5) &ndash;&gt; used for type of zone sales </span></li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Arial;\">Display case refigerated / freezer / refrigerator : heat gain 40&percnt; of rated hourly input  (100&percnt; sensible and as radiant as convective is exhausted) </span></p>
<ul>
<li><span style=\"font-family: Arial;\">Office (page 29.9 + Table 13) &ndash;&gt; used for type of zone office </span></li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Arial;\">Heat gain 50&percnt; of rated hourly input - 100 &percnt; sensible (22&percnt; radiant, 78 &percnt; convective as a mean between equipment with fans and without fans) </span></p>
</html>",           revisions="<html>
<ul>
<li><i>September, 2017&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
            end ElAppliancesForZone;
          end ElAppliances;

          package Lights

            model LightingForZone
              "Model for lighting in a zone, considering electrical and thermal effects "
              extends
              PlugNHarvest.Components.InternalGains.BaseClasses.PartialElectricalEquipment;

              parameter Modelica.SIunits.Area zoneArea = 100 "zone area";
              parameter Real spPelSurface(unit = "W/m2") =  22 "specific Pel per surface area for type of light source";
              parameter Real coeffThermal = 0.9 "coeff = Pth/Pel";
              parameter Real coeffRadThermal = 0.89 "coeff = Pth,rad/Pth";
              parameter Real emissivityLamp =  0.98 "emissivity of lamp";
              Modelica.Blocks.Sources.Constant AreaofZone(k=zoneArea)
                annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
              Modelica.Blocks.Sources.Constant SpecificElectricalPower(k=spPelSurface)
                "in W/m2 for area"
                annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
              Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
                annotation (Placement(transformation(extent={{-16,-8},{-4,4}})));
              Modelica.Blocks.Math.Gain coeffPthermal(k=coeffThermal)
                annotation (Placement(transformation(extent={{12,14},{24,26}})));
              Modelica.Blocks.Math.Gain coefPth_conv(k=1 - coeffRadThermal)
                annotation (Placement(transformation(extent={{30,34},{38,42}})));
              Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat             annotation(Placement(transformation(extent={{46,28},
                        {66,48}})));
              Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat
                "convective heat connector"                                                            annotation(Placement(transformation(extent={{80,60},
                        {100,80}}),                                                                                                                                         iconTransformation(extent={{80,60},
                        {100,80}})));
              Modelica.Blocks.Math.Gain coeffOth_rad(k=coeffRadThermal)
                annotation (Placement(transformation(extent={{30,-4},{38,4}})));
              Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow RadiativeHeat                    annotation(Placement(transformation(extent={{46,-10},
                        {66,10}})));
              AixLib.Utilities.HeatTransfer.HeatToStar
                                              RadiationConvertor(  A=max(1e-4, zoneArea/30.0), eps=
                    emissivityLamp)
                annotation (Placement(transformation(extent={{70,-8},{90,12}})));
              AixLib.Utilities.Interfaces.Star
                                        RadHeat "radiative heat connector" annotation(Placement(transformation(extent={{100,-8},
                        {120,12}}),                                                                                                               iconTransformation(extent={{80,2},{
                        100,22}})));
            equation
              connect(Schedule, multiProduct.u[1])
                annotation (Line(points={{-100,0},{-16,0},{-16,0.8}}, color={0,0,127}));
              connect(AreaofZone.y, multiProduct.u[2]) annotation (Line(points={{-39,30},{-28,
                      30},{-28,-2},{-16,-2}}, color={0,0,127}));
              connect(SpecificElectricalPower.y, multiProduct.u[3]) annotation (Line(points=
                     {{-39,-30},{-28,-30},{-28,-4.8},{-16,-4.8}}, color={0,0,127}));
              connect(multiProduct.y, Pel) annotation (Line(points={{-2.98,-2},{0,-2},{0,-50},
                      {100,-50}}, color={0,0,127}));
              connect(multiProduct.y, coeffPthermal.u) annotation (Line(points={{-2.98,-2},{
                      0,-2},{0,20},{10.8,20}}, color={0,0,127}));
              connect(coefPth_conv.y, ConvectiveHeat.Q_flow)
                annotation (Line(points={{38.4,38},{46,38}}, color={0,0,127}));
              connect(ConvectiveHeat.port,ConvHeat)  annotation(Line(points={{66,38},{74,38},
                      {74,70},{90,70}},                                                                                 color = {191, 0, 0}, pattern = LinePattern.Solid));
              connect(coeffOth_rad.y, RadiativeHeat.Q_flow)
                annotation (Line(points={{38.4,0},{46,0}}, color={0,0,127}));
              connect(RadiationConvertor.Star,RadHeat)  annotation (Line(
                  points={{89.1,2},{110,2}},
                  color={95,95,95},
                  pattern=LinePattern.Solid));
              connect(coeffPthermal.y, coefPth_conv.u) annotation (Line(points={{24.6,20},{26,
                      20},{26,38},{29.2,38}}, color={0,0,127}));
              connect(coeffPthermal.y, coeffOth_rad.u) annotation (Line(points={{24.6,20},{26,
                      20},{26,0},{29.2,0}}, color={0,0,127}));
              connect(RadiativeHeat.port, RadiationConvertor.Therm)
                annotation (Line(points={{66,0},{70,0},{70,2},{70.8,2}}, color={191,0,0}));
              annotation (Documentation(info="<html>
<h4>Objective</h4>
<p>The model describes the electrical power consumed by lighting and the thermal power generated by lighting for a certain zone.</p>
<p>The model can be thus used to calculate both the thermal and the electrical load / energy consumption of a building caused by lighting.</p>
<p>The input is a schedule for the lighting and can vary between 0 and 1.</p>
<p>The assumptions as well as exemplary values for the parameters are listed below. </p>
<h4>Assumptions</h4>
<p>The surface of the lamps is assumed as 1/30 of the zone area. The emissivity of the lamps is assumed to be 0.98. Both these values are needed for the calculation of the radiative heat exchange.</p>
<h4>Illuminance requirements according to zone use</h4>
<p>(Source DIN V 18599-10:2016-10, Tables A 1-41)</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><h4>Type of zone</h4></td>
<td><p>Illuminace in lux</p></td>
</tr>
<tr>
<td><p>Office (however many occupants)</p></td>
<td><p>500</p></td>
</tr>
<tr>
<td><p>Meeting room</p></td>
<td><p>500</p></td>
</tr>
<tr>
<td><p>Service hall</p></td>
<td><p>200</p></td>
</tr>
<tr>
<td><p>Retail Food and Non-Food</p></td>
<td><p>300</p></td>
</tr>
<tr>
<td><p>Classroom</p></td>
<td><p>300</p></td>
</tr>
<tr>
<td><p>Auditorium</p></td>
<td><p>500</p></td>
</tr>
<tr>
<td><p>Dormitory</p></td>
<td><p>300</p></td>
</tr>
<tr>
<td><p>Hotel room</p></td>
<td><p>200</p></td>
</tr>
<tr>
<td><p>Canteen</p></td>
<td><p>200</p></td>
</tr>
<tr>
<td><p>Restaurant</p></td>
<td><p>200</p></td>
</tr>
<tr>
<td><p>Kitchen non-residential</p></td>
<td><p>500</p></td>
</tr>
<tr>
<td><p>Kitchen - food preparation, storage</p></td>
<td><p>300</p></td>
</tr>
<tr>
<td><p>Restroom</p></td>
<td><p>200</p></td>
</tr>
<tr>
<td><p>Common room - break room, waiting room</p></td>
<td><p>300</p></td>
</tr>
<tr>
<td><p>Secondary area - cloackroom, storage, archive</p></td>
<td><p>100</p></td>
</tr>
<tr>
<td><p>Corridor</p></td>
<td><p>100</p></td>
</tr>
<tr>
<td><p>Storage</p></td>
<td><p>100</p></td>
</tr>
<tr>
<td><p>Server room</p></td>
<td><p>500</p></td>
</tr>
<tr>
<td><p>Industrial hall - heavy labor standing up</p></td>
<td><p>300</p></td>
</tr>
<tr>
<td><p>Industrial hall - middle labour mainly standing up</p></td>
<td><p>400</p></td>
</tr>
<tr>
<td><p>Industrial hall - simple labour sitting down</p></td>
<td><p>500</p></td>
</tr>
<tr>
<td><p>Spectator area</p></td>
<td><p>200</p></td>
</tr>
<tr>
<td><p>Foyer theater</p></td>
<td><p>300</p></td>
</tr>
<tr>
<td><p>Stage theater</p></td>
<td><p>1000</p></td>
</tr>
<tr>
<td><p>......</p></td>
<td></td>
</tr>
</table>
<p><br><h4>Luminous efficacy for different light sources</h4></p>
<p>(Source: Deliverable 2.2 Shopping malls ineffciencies from Project CommONEnergy: Re-conceptualize shopping malls from consumerism to energy conservation; 2015, page 64 Figure 38)</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><h4>Light source</h4></td>
<td><h4>Luminous efficacy in lm/W</h4></td>
</tr>
<tr>
<td><p>Incandescent lamp</p></td>
<td><p>10-13</p></td>
</tr>
<tr>
<td><p>Halogen lamp</p></td>
<td><p>15-25</p></td>
</tr>
<tr>
<td><p>Compact flourescent lamp</p></td>
<td><p>50-70</p></td>
</tr>
<tr>
<td><p>Flourescent lamp</p></td>
<td><p>70-95 </p></td>
</tr>
<tr>
<td><p>Metal halide lamp</p></td>
<td><p>70-100</p></td>
</tr>
<tr>
<td><p>High pressure sodium vapour lamp</p></td>
<td><p>90-140</p></td>
</tr>
<tr>
<td><p>(O)LED</p></td>
<td><p>80-120</p></td>
</tr>
</table>
<p><br><h4>Conversion from lux to W/m2</h4></p>
<p><br>1 lux = 1 lm / m2</p>
<p>1 W/m2 = 1 lux / (1 lm / W) = Illuminace / Luminous efficacy</p>
<h4>Heat generated by a lighting source</h4>
<p>A lighting source generates optical power and thermal power using electrical power.</p>
<p>The thermal power is split in convective and radiative power.</p>
<p>(Source: http://bigladdersoftware.com/epx/docs/8-0/engineering-reference/page-089.html -&gt; Heat gain from lights)</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><h4>Light source</h4></td>
<td><h4>optical power</h4></td>
<td><h4>thermal convective power</h4></td>
<td><h4>thermal radaitive power</h4></td>
</tr>
<tr>
<td><p>Incandescent lamp</p></td>
<td><p>10&percnt;</p></td>
<td><p>10&percnt;</p></td>
<td><p>80&percnt;</p></td>
</tr>
<tr>
<td><p>Flourescent lamp</p></td>
<td><p>20&percnt;</p></td>
<td><p>20&percnt;</p></td>
<td><p>60&percnt;</p></td>
</tr>
</table>
</html>",           revisions="<html>
<ul>
<li><i>September, 2017&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"),             Icon(graphics={
                    Ellipse(
                      extent={{-52,72},{50,-40}},
                      lineColor={255,255,0},
                      fillColor={255,255,0},
                      fillPattern=FillPattern.Solid),
                    Line(
                      points={{-24,-56},{22,-56}},
                      thickness=1),
                    Line(
                      points={{-26,-48},{22,-48}},
                      thickness=1),
                    Line(
                      points={{-24,-64},{22,-64}},
                      thickness=1),
                    Line(
                      points={{-24,-72},{22,-72}},
                      thickness=1),
                    Line(
                      points={{-28,-42},{-28,-80},{26,-80},{26,-42}},
                      thickness=1),
                    Ellipse(
                      extent={{-52,72},{50,-40}},
                      lineColor={255,255,0},
                      fillColor={255,255,0},
                      fillPattern=FillPattern.Solid),
                    Line(
                      points={{-24,-56},{22,-56}},
                      thickness=1),
                    Line(
                      points={{-26,-48},{22,-48}},
                      thickness=1),
                    Line(
                      points={{-24,-64},{22,-64}},
                      thickness=1),
                    Line(
                      points={{-24,-72},{22,-72}},
                      thickness=1),
                    Line(
                      points={{-28,-42},{-28,-80},{26,-80},{26,-42}},
                      thickness=1)}));
            end LightingForZone;
          end Lights;

          model Facilities
            parameter Modelica.SIunits.Area zoneArea = 100 "zone floor area" annotation(Dialog(descriptionLabel = true));
            parameter Real spPelSurface_elApp(unit = "W/m2") =  22 "specific Pel/m2 for type of el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));
            parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));
            parameter Real coeffRadThermal_elApp = 0.75 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));
            parameter Real emissivity_elApp =  0.9 "emissivity of el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));

            parameter Real spPelSurface_lights(unit = "W/m2") =  22 "specific Pel/m2 for type of light source" annotation(Dialog(group = "Lights",descriptionLabel = true));
            parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(group = "Lights",descriptionLabel = true));
            parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(group = "Lights",descriptionLabel = true));
            parameter Real emissivity_lights =  0.98 "emissivity lights" annotation(Dialog(group = "Lights",descriptionLabel = true));

            ElAppliances.ElAppliancesForZone machinesForZone(
              zoneArea=zoneArea,
              spPelSurface=spPelSurface_elApp,
              coeffThermal=coeffThermal_elApp,
              coeffRadThermal=coeffRadThermal_elApp,
              emissivityMachine=emissivity_elApp)
              annotation (Placement(transformation(extent={{-24,30},{20,68}})));
            Lights.LightingForZone lightingForZone(
              zoneArea=zoneArea,
              spPelSurface=spPelSurface_lights,
              coeffThermal=coeffThermal_lights,
              coeffRadThermal=coeffRadThermal_lights,
              emissivityLamp=emissivity_lights)
              annotation (Placement(transformation(extent={{-20,-20},{18,12}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat[2]
              "1- machines; 2 - lights" annotation (Placement(transformation(extent={{76,56},
                      {102,82}}), iconTransformation(extent={{80,60},{100,80}})));
            AixLib.Utilities.Interfaces.Star RadHeat[2] "1- machines; 2 - lights"
              annotation (Placement(transformation(extent={{80,20},{100,40}}),
                  iconTransformation(extent={{80,20},{100,40}})));
            Modelica.Blocks.Interfaces.RealOutput Pel_elApp
              "electrical load in W for electrical appliances" annotation (Placement(
                  transformation(extent={{80,-40},{100,-20}}), iconTransformation(extent={
                      {80,-40},{100,-20}})));
            Modelica.Blocks.Interfaces.RealOutput Pel_lights
              "electrical load in W for lighting" annotation (Placement(transformation(
                    extent={{80,-80},{100,-60}}), iconTransformation(extent={{80,-80},{100,
                      -60}})));
            Modelica.Blocks.Interfaces.RealInput Schedule_elAppliances "from 0 to 1"
              annotation (Placement(transformation(extent={{-120,28},{-80,68}}),
                  iconTransformation(extent={{-100,0},{-80,20}})));
            Modelica.Blocks.Interfaces.RealInput Schedule_lights "from 0 to 1"
              annotation (Placement(transformation(extent={{-120,-24},{-80,16}}),
                  iconTransformation(extent={{-100,-40},{-80,-20}})));
          equation
            connect(machinesForZone.RadHeat, RadHeat[1]) annotation (Line(points={{17.8,51.28},
                    {36,51.28},{36,25},{90,25}}, color={95,95,95}));
            connect(lightingForZone.RadHeat, RadHeat[2]) annotation (Line(points={{16.1,-2.08},
                    {36,-2.08},{36,35},{90,35}}, color={95,95,95}));
            connect(machinesForZone.Pel, Pel_elApp) annotation (Line(points={{17.8,39.5},{
                    36,39.5},{36,-30},{90,-30}}, color={0,0,127}));
            connect(lightingForZone.Pel, Pel_lights) annotation (Line(points={{16.1,-12},{
                    36,-12},{36,-70},{90,-70}}, color={0,0,127}));
            connect(machinesForZone.Schedule, Schedule_elAppliances) annotation (Line(
                  points={{-21.8,49},{-22,49},{-22,48},{-100,48}}, color={0,0,127}));
            connect(lightingForZone.Schedule, Schedule_lights)
              annotation (Line(points={{-18.1,-4},{-100,-4}}, color={0,0,127}));
            connect(machinesForZone.ConvHeat, ConvHeat[1]) annotation (Line(points={{17.8,
                    62.3},{84,62.3},{84,62.5},{89,62.5}}, color={191,0,0}));
            connect(lightingForZone.ConvHeat, ConvHeat[2]) annotation (Line(points={{16.1,
                    7.2},{36,7.2},{36,75.5},{89,75.5}}, color={191,0,0}));
            annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                    Rectangle(
                    extent={{-80,80},{80,-80}},
                    lineColor={28,108,200},
                    fillColor={28,108,200},
                    fillPattern=FillPattern.Solid), Text(
                    extent={{-80,66},{76,-72}},
                    lineColor={255,255,255},
                    fillColor={255,255,170},
                    fillPattern=FillPattern.None,
                    textString="Facilities Zone
 - El. Appliances
 - Lights")}),        Diagram(coordinateSystem(preserveAspectRatio=false)),
              Documentation(revisions="<html>
<ul>
<li><i>September, 2017&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>",         info="<html>
<p>Aggregated model for electrical appliances and lights for a zone.</p>
</html>"));
          end Facilities;
        end Facilities;

        package Occupants "Occupant model for different types of usage"

          model Occupants
            "Model for sensible heat output for ocuupants of a zone"
            // Number of Persons
            parameter Modelica.SIunits.Area ZoneArea = 10 "Area of zone" annotation(Dialog(descriptionLabel = true));
            parameter Modelica.SIunits.Power heatLoadForActivity = 80 "Sensible heat load for activity type at 20°C" annotation(Dialog(group = "Occupants", descriptionLabel = true));
            parameter Real occupationDensity = 0.2 "Density of occupants in persons/m2" annotation(Dialog(group = "Occupants", descriptionLabel = true));
            parameter Real RatioConvectiveHeat = 0.5
              "Ratio of convective heat from overall heat output"                                        annotation(Dialog(group = "Occupants", descriptionLabel = true));
            parameter Modelica.SIunits.Temperature T0 = 295.15
              "Start temperature" annotation(Dialog(group = "Occupants", descriptionLabel = true));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat annotation(Placement(transformation(extent = {{80, 40}, {100, 60}})));
            AixLib.Utilities.HeatTransfer.HeatToStar_Avar RadiationConvertor(eps=
                  Emissivity_Human)
              annotation (Placement(transformation(extent={{48,-22},{72,2}})));
            AixLib.Utilities.Interfaces.Star RadHeat
              annotation (Placement(transformation(extent={{80,-20},{100,0}})));
            Modelica.Blocks.Math.MultiProduct productHeatOutput(nu=2)   annotation(Placement(transformation(extent = {{-24, 10}, {-4, 30}})));
            Modelica.Blocks.Math.UnitConversions.To_degC to_degC annotation(Placement(transformation(extent = {{-82, 46}, {-72, 56}})));
            Modelica.Blocks.Interfaces.RealInput Schedule "from 0 to 1"
                                                          annotation(Placement(transformation(extent={{-120,
                      -40},{-80,0}}),                                                                                            iconTransformation(extent={{-102,
                      -22},{-80,0}})));
            Modelica.Blocks.Math.Gain Nr_People(k = NrPeople) annotation(Placement(transformation(extent = {{-66, -26}, {-54, -14}})));
            Modelica.Blocks.Math.Gain SurfaceArea_People(k = SurfaceArea_Human) annotation(Placement(transformation(extent={{16,-54},
                      {28,-42}})));

            Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1e+23, uMin=1)      annotation(Placement(transformation(extent={{-18,-58},
                      {2,-38}})));
            Modelica.Blocks.Math.Gain gain(k = RatioConvectiveHeat) annotation(Placement(transformation(extent = {{6, 28}, {14, 36}})));
            Modelica.Blocks.Math.Gain gain1(k = 1 - RatioConvectiveHeat) annotation(Placement(transformation(extent = {{6, -12}, {14, -4}})));
        protected
            parameter Modelica.SIunits.Area SurfaceArea_Human = 2;
            parameter Real Emissivity_Human = 0.98;
            parameter Real NrPeople = ZoneArea * occupationDensity "Number of people in the room";
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat(T_ref = T0) annotation(Placement(transformation(extent = {{18, 20}, {42, 44}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow RadiativeHeat(T_ref = T0) annotation(Placement(transformation(extent = {{18, -20}, {42, 4}})));
            Modelica.Blocks.Tables.CombiTable2D HeatOutput(table = [10, 100, 125, 155; 18, 100, 125, 155; 20, 95, 115, 140; 22, 90, 105, 120; 23, 85, 100, 115; 24, 75, 95, 110; 25, 75, 85, 105; 26, 70, 85, 95; 35, 70, 85, 95], smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, tableOnFile = false)                           annotation(Placement(transformation(extent={{-60,38},
                      {-40,58}})));
        public
            Modelica.Blocks.Sources.RealExpression heatLoadActivity(y=heatLoadForActivity)
              annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
            Modelica.Blocks.Interfaces.RealInput TAirZone "air temperature of zone"
              annotation (Placement(transformation(extent={{-120,70},{-80,110}}),
                  iconTransformation(extent={{-100,60},{-80,80}})));
          equation
            connect(ConvectiveHeat.port, ConvHeat) annotation(Line(points = {{42, 32}, {42, 50}, {90, 50}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
            connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation(Line(points = {{42, -8}, {44, -8}, {44, -12}, {48, -12}, {48, -10}, {48.96, -10}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
            connect(RadiationConvertor.Star, RadHeat) annotation(Line(points = {{70.92, -10}, {90, -10}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
            connect(Schedule, Nr_People.u) annotation(Line(points={{-100,-20},{-67.2,-20}},      color = {0, 0, 127}));
            connect(gain.y, ConvectiveHeat.Q_flow) annotation(Line(points = {{14.4, 32}, {18, 32}}, color = {0, 0, 127}));
            connect(gain1.y, RadiativeHeat.Q_flow) annotation(Line(points = {{14.4, -8}, {18, -8}}, color = {0, 0, 127}));
            connect(productHeatOutput.y, gain.u) annotation(Line(points = {{-2.3, 20}, {2, 20}, {2, 32}, {5.2, 32}}, color = {0, 0, 127}));
            connect(productHeatOutput.y, gain1.u) annotation(Line(points = {{-2.3, 20}, {2, 20}, {2, -8}, {5.2, -8}}, color = {0, 0, 127}));
            connect(Nr_People.y, limiter.u) annotation (Line(
                points={{-53.4,-20},{-30,-20},{-30,-48},{-20,-48}},
                color={0,0,127}));
            connect(limiter.y, SurfaceArea_People.u) annotation (Line(
                points={{3,-48},{14.8,-48}},
                color={0,0,127}));
            connect(SurfaceArea_People.y, RadiationConvertor.A) annotation (Line(
                points={{28.6,-48},{40,-48},{40,20},{60,20},{60,0.8}},
                color={0,0,127}));
            connect(Nr_People.y, productHeatOutput.u[1]) annotation (Line(
                points={{-53.4,-20},{-36,-20},{-36,23.5},{-24,23.5}},
                color={0,0,127}));
            connect(to_degC.y, HeatOutput.u1) annotation (Line(points={{-71.5,51},{-68,51},
                    {-68,54},{-62,54}}, color={0,0,127}));
            connect(heatLoadActivity.y, HeatOutput.u2) annotation (Line(points={{-79,30},{
                    -72,30},{-72,42},{-62,42}}, color={0,0,127}));
            connect(to_degC.u, TAirZone)
              annotation (Line(points={{-83,51},{-100,51},{-100,90}}, color={0,0,127}));
            connect(HeatOutput.y, productHeatOutput.u[2]) annotation (Line(points={{-39,
                    48},{-34,48},{-34,16.5},{-24,16.5}}, color={0,0,127}));
            annotation(Icon(graphics={  Ellipse(extent = {{-36, 98}, {36, 26}}, lineColor = {255, 213, 170}, fillColor = {255, 213, 170},
                      fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-48, 20}, {54, -94}}, fillColor = {255, 0, 0},
                      fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None), Text(extent = {{-40, -2}, {44, -44}}, lineColor=
                        {255,255,255},                                                                                                                                                                                                        fillColor=
                        {255,0,0},
                      fillPattern=FillPattern.Solid,
                    textString="%name"),                                                                                                                                      Ellipse(extent = {{-24, 80}, {-14, 70}}, fillColor = {0, 0, 0},
                      fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0}), Ellipse(extent = {{10, 80}, {20, 70}}, fillColor = {0, 0, 0},
                      fillPattern =                                                                                                   FillPattern.Solid, pattern = LinePattern.None, lineColor = {0, 0, 0}), Line(points = {{-18, 54}, {-16, 48}, {-10, 44}, {-4, 42}, {2, 42}, {10, 44}, {16, 48}, {18, 54}}, color = {0, 0, 0}, thickness = 1)}), Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>Model for heat output of a human according to VDI 2078 (Table A.1). The model only considers the dry heat emission and divides it into convective and radiative heat transmission. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>It is possible to choose between several types of physical activity. </p>
<p>The heat output depends on the air temperature in the room where the activity takes place. </p>
<p>A schedule of the activity is also required as constant presence of people in a room is not realistic. The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p>The surface for radiation exchange is computed from the number of persons in the room, which leads to a surface area of zero, when no one is present. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero.For this reason a limitiation for the surface has been intoduced: as a minimum the surface area of one human and as a maximum a value of 1e+23 m2 (only needed for a complete parametrization of the model). </p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>VDI 2078: Calculation of cooling load and room temperatures of rooms and buildings (VDI Cooling Load Code of Practice) - March 2012 </p>
<p><b><font style=\"color: #008000; \">Example Results</font></b> </p>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.Humans\">AixLib.Building.Components.Examples.Sources.InternalGains.Humans</a> </p>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice\">AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice</a> </p>
</html>",            revisions="<html>
 <ul>
 <li><i>March 23, 2015&nbsp;</i> by Ana Constantin:<br/>Set minimal surface to surface of one person</li>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>April 10, 2014&nbsp;</i> by Ana Constantin:<br/>Added a lower positive limit to the surface area, so it won&apos;t lead to a division by zero</li>
 <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>August 10, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>"));
          end Occupants;
        end Occupants;

        package BaseClasses
        extends Modelica.Icons.BasesPackage;

          model PartialElectricalEquipment
            Modelica.Blocks.Interfaces.RealInput Schedule "from 0 to 1"
                                                          annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}), iconTransformation(extent = {{-100, -10}, {-80, 10}})));
            Modelica.Blocks.Interfaces.RealOutput Pel "electrical load in W" annotation (
                Placement(transformation(extent={{80,-70},{120,-30}}), iconTransformation(
                    extent={{80,-60},{100,-40}})));
            annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                  coordinateSystem(preserveAspectRatio=false)),
              Documentation(revisions="<html>
<ul>
<li><i>September, 2072&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>"));
          end PartialElectricalEquipment;
        annotation (Documentation(info="<html>
<h4>Objective</h4>
<p>The model describes the electrical power consumed by machines and the thermal power generated by machines for a certain zone.</p>
<p>The model can be thus used to calculate both the thermal and the electrical load / energy consumption of a building.</p>
<p>The input is a schedule for the lighting and can vary between 0 and 1.</p>
<p>The assumptions as well as exemplary values for the parameters are listed below. </p>
<h4>Assumptions</h4>
<p>The surface of the machines is assumed as 1/10 of the zone area. The emissivity of the machines is assumed to be 0.9. Both these values are needed for the calculation of the radiative heat exchange.</p>
</html>"));
        end BaseClasses;
      end InternalGains;

      record Parameters "Record for parametrisation of simulation model"
          //  * * * * * * * * * * * * G  E  N  E  R  A  L * * * * * * * * * * * *
       replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);
       parameter String weatherFileName = Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/TRY2010_12_Jahr_Modelica-Library.txt");
          //**************************E N V E L O P E ************************
          // room geometry
        parameter Modelica.SIunits.Length room_length=5 "room length"
          annotation (Dialog(group="Envelope", descriptionLabel=true));
        parameter Modelica.SIunits.Length room_width=3 "room width"
          annotation (Dialog(group="Envelope", descriptionLabel=true));
        parameter Modelica.SIunits.Height room_height=3 "room height"
          annotation (Dialog(group="Envelope", descriptionLabel=true));

        //wall types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_OW1= AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() "wall type OW1"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW1=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW1"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW2=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() "wall type IW2"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW3=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW3"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_CE=AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() "wall type Ceiling"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_FL=AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() "wall type Floor"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));

        // window
        parameter Modelica.SIunits.Area windowarea_OW1=6 "Window area " annotation (
            Dialog(
            group="Envelope",
            descriptionLabel=true,
            enable=withWindow1));
        parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "window type"
            annotation (Dialog(group="Envelope"));

        //**************************S M A R T   F A C A D E ************************
        // smart facade
        parameter Boolean withSmartFacade = false annotation (Dialog( group = "Smart Facade", enable = outside), choices(checkBox=true));
        // Mechanical ventilation
        parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        // PV
        parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        //solar air heater
        parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(group = "Smart Facade", enable = withPV));
        parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                       "PV data set" annotation(Dialog(group = "Smart Facade", enable = withPV));
        parameter Modelica.SIunits.Power PelPV_max = 4000
          "Maximum output power for inverter" annotation(Dialog(group = "Smart Facade", enable = withPV));


        //**************************I N T E R N A L  G A I N S ************************
        // persons
        parameter Modelica.SIunits.Power heatLoadForActivity = 80 "Sensible heat output occupants for activity at 20°C" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
        parameter Real occupationDensity = 0.07 "Density of occupants in persons/m2" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
        // lights
        parameter Real spPelSurface_lights(unit = "W/m2") =  10 "specific Pel/m2 for type of light source" annotation(Dialog(group = "Internal gains",descriptionLabel = true));
        //electrical appliances
        parameter Real spPelSurface_elApp(unit = "W/m2") =  14 "specific Pel/m2 for type of el. appliances" annotation(Dialog(group = "Internal gains",descriptionLabel = true));

          //**************************E N E R G Y   S Y S T E M ************************
        parameter Modelica.SIunits.Power Pmax_heater = 1000 "maximal power output heater" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature Tset_heater = 294.15 "set temperature for heating" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature Tout_isHeatOn = 288.15 "Touside under which heating is on" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature Tset_chiller = 297.15 "set temperature for cooling" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Power Pmax_chiller = 1000 "maximal power output chiller" annotation(Dialog(group = "Energy system", descriptionLabel = true));

        //**************************P R O F I L E S ************************
        parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition schedulePersons =  AixLib.DataBase.Profiles.NineToFive() "Schedule for persons"  annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
        parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleLights =  AixLib.DataBase.Profiles.NineToFive() "Schedule for lights" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
        parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleElAppliances =  AixLib.DataBase.Profiles.NineToFive() "Schedule for electrical appliances" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
        parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleHVAC_heating =  AixLib.DataBase.Profiles.NineToFive() "Schedule for HVAC heating" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
        parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleHVAC_cooling =  AixLib.DataBase.Profiles.NineToFive() "Schedule for HVAC cooling" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
        parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleMechVent =  AixLib.DataBase.Profiles.NineToFive() "Schedule for mechanical ventilation" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));





        //  * * * * * * * * * * A  D  V  A  N  C  E  D * * * * * * * * * * * *
        //**************************E N V E L O P E ************************
        // Outer walls properties
        parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
          annotation (Dialog(tab = "Advanced", group="Envelope", descriptionLabel=true));

        parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
            tab = "Advanced", group="Envelope",
            compact=true,
            descriptionLabel=true), choices(
            choice=1 "DIN 6946",
            choice=2 "ASHRAE Fundamentals",
            choice=3 "Custom alpha",
            radioButtons=true));

        // Infiltration rate
        parameter Real n50(unit="h-1") = 3 "Air exchange rate at 50 Pa pressure differencefor infiltration "
          annotation (Dialog(tab = "Advanced", group="Envelope"));
        parameter Real e=0.02 "Coefficient of windshield for infiltration"
          annotation (Dialog(tab = "Advanced", group="Envelope"));
        parameter Real eps=1.0 "Coefficient of height for infiltration"
          annotation (Dialog(tab = "Advanced", group="Envelope"));
          // Sunblind
        parameter Boolean use_sunblind = false
          "Will sunblind become active automatically?"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
          "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
          "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
          "Temperature at which sunblind closes (see also solIrrThreshold)"
          annotation(Dialog(tab = "Advanced", group="Envelope"));

               // Heat bridge
        parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(tab = "Advanced", group = "Envelope", enable= outside, compact = false));
        parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));
        parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));

        //**************************I N T E R N A L  G A I N S ************************
        // persons
        parameter Real RatioConvectiveHeat_persons = 0.5
        "Ratio of convective heat from overall heat output for persons"                                        annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
        //lights
        parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        //electrical appliances
        parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        parameter Real coeffRadThermal_elApp = 0.78 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));

          //**************************E N E R G Y   S Y S T E M ************************
        parameter Boolean isEl_heater = true "is heater electrical? (heat pump)" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
        parameter Boolean isEl_cooler = true "is chiller electrical (chiller)"  annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
        parameter Real etaEl_heater = 2.5 "electrical efficiency of heater" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
        parameter Real etaEl_cooler = 3.0 "electrical efficiency of chiller" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
      end Parameters;

      package Rooms

        model Room
          "Room 1 vertical outer wall (facade) and the rest towards the building."
          ///////// construction parameters
          // Outer wall type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=
           AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
            annotation (Dialog(tab="Types"), choicesAllMatching = true);
          //Inner wall Types
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW1=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW1"
            annotation (Dialog(tab="Types", descriptionLabel=true));
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW2=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() "wall type IW2"
            annotation (Dialog(tab="Types", descriptionLabel=true));
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW3=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW3"
            annotation (Dialog(tab="Types", descriptionLabel=true));
          // Floor to ground type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=
          AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML()
            annotation (Dialog(tab="Types"), choicesAllMatching = true);
          // Ceiling to upper floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
            annotation (Dialog(tab="Types"), choicesAllMatching = true);
          //Window type
          parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
              annotation (Dialog(tab="Types"));
          parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          parameter Modelica.SIunits.Temperature T0_IW2a=295.15 "IW2a"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          parameter Modelica.SIunits.Temperature T0_IW2b=295.15 "IW2b"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          parameter Modelica.SIunits.Temperature T0_IW3=295.15 "IW3"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          parameter Modelica.SIunits.Temperature T0_CE=295.13 "Ceiling"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          parameter Modelica.SIunits.Temperature T0_FL=295.13 "Floor"
            annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
          //////////room geometry
          parameter Modelica.SIunits.Length room_length=2 "length"
            annotation (Dialog(group="Dimensions", descriptionLabel=true));
          parameter Modelica.SIunits.Length room_width=2 "width "
            annotation (Dialog(group="Dimensions", descriptionLabel=true));
          parameter Modelica.SIunits.Height room_height=2 "height "
            annotation (Dialog(group="Dimensions", descriptionLabel=true));
          // Outer walls properties
          parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
            annotation (Dialog(group="Outer wall properties", descriptionLabel=true));

          parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
              group="Outer wall properties",
              compact=true,
              descriptionLabel=true), choices(
              choice=1 "DIN 6946",
              choice=2 "ASHRAE Fundamentals",
              choice=3 "Custom alpha",
              radioButtons=true));
          // Windows and Doors
          parameter Boolean withWindow1=true "Window 1" annotation (Dialog(
              group="Windows and Doors",
              joinNext=true,
              descriptionLabel=true), choices(checkBox=true));
          parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (
              Dialog(
              group="Windows and Doors",
              descriptionLabel=true,
              enable=withWindow1));
          // Sunblind
          parameter Boolean use_sunblind = false
            "Will sunblind become active automatically?"
            annotation(Dialog(group = "Sunblind"));
          parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
            "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
            annotation(Dialog(group = "Sunblind", enable=use_sunblind));
          parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
            "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
            annotation(Dialog(group = "Sunblind", enable=use_sunblind));
          parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
            "Temperature at which sunblind closes (see also solIrrThreshold)"
            annotation(Dialog(group = "Sunblind", enable=use_sunblind));

           // heat bridge parameters
          parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(group = "Heat bridges", enable= outside, compact = false));
          parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(group = "Heat bridges", enable = withHeatBridge));
          parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(group = "Heat bridges", enable = withHeatBridge));
         replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);

           // smart facade
          parameter Boolean withSmartFacade = false annotation (Dialog( tab = "Smart Facade", enable = outside), choices(checkBox=true));
          // Mechanical ventilation
          parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
          // PV
          parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
          //solar air heater
          parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
          parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(tab = "Smart Facade", enable = withPV));
          parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                         "PV data set" annotation(Dialog(tab = "Smart Facade", enable = withPV));
          parameter Modelica.SIunits.Power PelPV_max = 4000
            "Maximum output power for inverter" annotation(Dialog(tab = "Smart Facade", enable = withPV));

          Walls.Wall                                          outside_wall1(
            solar_absorptance=solar_absorptance_OW,
            windowarea=windowarea_OW1,
            T0=T0_OW1,
            wall_length=room_length,
            wall_height=room_height,
            withWindow=withWindow1,
            WallType=Type_OW,
            WindowType=Type_Win,
            final withSunblind=use_sunblind,
            final Blinding=1-ratioSunblind,
            redeclare package AirModel = AirModel,
            withDoor=false,
            roomV=room_V,
            n50=n50,
            e=e,
            eps=eps,
            withPV=withPV,
            withSolAirHeat=withSolAirHeat,
            NrPVpanels=NrPVpanels,
            dataPV=dataPV,
            PelPV_max=PelPV_max,
            withHeatBridge=withHeatBridge,
            psiHor=psiHor,
            psiVer=psiVer,
            redeclare model HeatBridge = Walls.HeatBridgeLinear,
            withSmartFacade=withSmartFacade,
            withMechVent=withMechVent,
            redeclare model Window =
                ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple)
            annotation (Placement(transformation(extent={{-64,-14},{-54,42}})));
          AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall1(
            T0=T0_IW1,
            outside=false,
            wall_length=room_width,
            wall_height=room_height,
            withWindow=false,
            final withSunblind=use_sunblind,
            final Blinding=1-ratioSunblind,
            final LimitSolIrr=solIrrThreshold,
            final TOutAirLimit=TOutAirLimit,
            withDoor=false,
            WallType=wallType_IW1)
                            annotation (Placement(transformation(
                origin={23,59},
                extent={{-5.00018,-29},{5.00003,29}},
                rotation=270)));
          AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall3(
            T0=T0_IW3,
            outside=false,
            wall_length=room_width,
            wall_height=room_height,
            withWindow=false,
            final withSunblind=use_sunblind,
            final Blinding=1-ratioSunblind,
            final LimitSolIrr=solIrrThreshold,
            final TOutAirLimit=TOutAirLimit,
            withDoor=false,
            WallType=wallType_IW3)
                            annotation (Placement(transformation(
                origin={25,-59},
                extent={{-5.00002,-29},{5.00001,29}},
                rotation=90)));
          AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir         airload(V=room_V,
            redeclare package Medium = AirModel,
            nPorts=4,
            m_flow_nominal=room_V*0.2*1.2/3600)
            annotation (Placement(transformation(extent={{0,-20},{20,0}})));
          AixLib.ThermalZones.HighOrder.Components.Walls.Wall Ceiling(
            T0=T0_CE,
            outside=false,
            WallType=Type_CE,
            wall_length=room_length,
            wall_height=room_width,
            withWindow=false,
            final withSunblind=use_sunblind,
            final Blinding=1-ratioSunblind,
            final LimitSolIrr=solIrrThreshold,
            final TOutAirLimit=TOutAirLimit,
            withDoor=false,
            ISOrientation=3) annotation (Placement(transformation(
                origin={-31,60},
                extent={{2,-9},{-2,9}},
                rotation=90)));
          AixLib.ThermalZones.HighOrder.Components.Walls.Wall floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=room_length,
            wall_height=room_width,
            withWindow=false,
            final withSunblind=use_sunblind,
            final Blinding=1-ratioSunblind,
            final LimitSolIrr=solIrrThreshold,
            final TOutAirLimit=TOutAirLimit,
            withDoor=false,
            ISOrientation=2)  annotation (Placement(
                transformation(
                origin={-27,-60},
                extent={{-2.00002,-11},{2.00001,11}},
                rotation=90)));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
            annotation (Placement(transformation(extent={{34,-104},{54,-84}})));
          AixLib.Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1
            annotation (Placement(transformation(extent={{-109.5,50},{-89.5,70}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
            annotation (Placement(transformation(extent={{80,60},{100,80}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
            annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
          AixLib.Utilities.Interfaces.Star starRoom
            annotation (Placement(transformation(extent={{10,10},{30,30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground
            annotation (Placement(transformation(extent={{-16,-104},{4,-84}})));
          AixLib.ThermalZones.HighOrder.Components.Walls.Wall inside_wall2(
            T0=T0_IW2b,
            outside=false,
            wall_height=room_height,
            withWindow=false,
            final withSunblind=use_sunblind,
            final Blinding=1 - ratioSunblind,
            final LimitSolIrr=solIrrThreshold,
            final TOutAirLimit=TOutAirLimit,
            withDoor=false,
            wall_length=room_length,
            WallType=wallType_IW2)   annotation (Placement(transformation(
                origin={64,6},
                extent={{-4,-24},{4,24}},
                rotation=180)));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
            annotation (Placement(transformation(extent={{80,-20},{100,0}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
            annotation (Placement(transformation(extent={{20,80},{40,100}})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
            annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
          AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=90,
                origin={-20,-26})));

          // Infiltration rate
          parameter Real n50(unit="h-1") = 3 "Air exchange rate at 50 Pa pressure difference"
            annotation (Dialog(tab="Infiltration"));
          parameter Real e=0.02 "Coefficient of windshield"
            annotation (Dialog(tab="Infiltration"));
          parameter Real eps=1.0 "Coefficient of height"
            annotation (Dialog(tab="Infiltration"));
      protected
          parameter Modelica.SIunits.Volume room_V=room_length*room_width*room_height;
          Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[1](redeclare
            package Medium =   AirModel) "Fluid inlets and outlets"
            annotation (Placement(transformation(extent={{-70,-104},{-12,-84}})));
      public
          AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
            annotation (Placement(transformation(extent={{-108,-10},{-88,10}})));
          Modelica.Blocks.Interfaces.RealInput mWat_flow
            "Water flow rate added into the medium" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={86,-104}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={76,-94})));
          Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
            "schedule mechanical ventilation" annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-100,-72}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-90,-70})));
        equation
          connect(thermInsideWall3, thermInsideWall3)
            annotation (Line(points={{44,-94},{44,-94}}, color={191,0,0}));
          connect(starRoom, thermStar_Demux.star) annotation (Line(
              points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
              color={95,95,95},
              pattern=LinePattern.Solid));
          connect(inside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{60,6},{40,6},{40,-40},{-20.1,-40},{-20.1,-35.4}},
                color={191,0,0}));
          connect(inside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{23,54},{23,54},{23,40},{-40,40},{-40,-40},{-20.1,
                  -40},{-20.1,-35.4}}, color={191,0,0}));
          connect(inside_wall3.port_outside, thermInsideWall3) annotation (Line(points={{25,
                  -64.25},{25,-77.375},{44,-77.375},{44,-94}},      color={191,0,0}));
          connect(inside_wall2.port_outside, thermInsideWall2b) annotation (Line(points=
                 {{68.2,6},{77.225,6},{77.225,-10},{90,-10}}, color={191,0,0}));
          connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(points={{23,
                  64.2502},{23,76.3751},{30,76.3751},{30,90}},      color={191,0,0}));
          connect(Ceiling.port_outside, thermCeiling)
            annotation (Line(points={{-31,62.1},{-31,70},{90,70}}, color={191,0,0}));
          connect(thermStar_Demux.therm, thermRoom) annotation (Line(points={{-25.1,-15.9},
                  {-25.1,0.05},{-20,0.05},{-20,20}}, color={191,0,0}));
          connect(inside_wall3.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{25,-54},{25,-40},{-20.1,-40},{-20.1,-35.4}},
                color={191,0,0}));
          connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-54,14},{-40,14},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
                color={191,0,0}));
          connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(points={{-31,58},{-31,40},{-40,40},{-40,-40},{-20.1,-40},{
                  -20.1,-35.4}}, color={191,0,0}));
          connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort) annotation (
             Line(points={{-99.5,60},{-80,60},{-80,39.6667},{-65.5,39.6667}}, color={
                  255,128,0}));
          connect(thermCeiling, thermCeiling) annotation (Line(points={{90,70},{85,70},
                  {85,70},{90,70}}, color={191,0,0}));
          connect(ground, floor.port_outside) annotation (Line(
              points={{-6,-94},{-6,-74},{-24,-74},{-24,-62.1},{-27,-62.1}},
              color={191,0,0}));
          connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-27,-58},{-27,-40},{-20.1,-40},{-20.1,-35.4}},
              color={191,0,0}));
          connect(airload.heatPort, Tair.port) annotation (Line(points={{0,-10},{-4,-10},
                  {-4,-40},{40,-40},{40,-13},{24,-13}}, color={191,0,0}));
          connect(airload.heatPort, thermRoom) annotation (Line(points={{0,-10},{-4,-10},
                  {-4,-40},{-40,-40},{-40,40},{-20,40},{-20,20}}, color={191,0,0}));
          connect(airload.ports[1:1], ports) annotation (Line(points={{7,-20},{7,-30},{8,
                  -30},{8,-40},{-41,-40},{-41,-94}}, color={0,127,255}));
          connect(outside_wall1.weaBus, weaBus) annotation (Line(
              points={{-67,14},{-67,0},{-98,0}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
          connect(airload.mWat_flow, mWat_flow) annotation (Line(points={{-2,-2},{-14,-2},
                  {-14,-40},{86,-40},{86,-104}}, color={0,0,127}));
          connect(outside_wall1.port_b, airload.ports[3]) annotation (Line(points={{-52.3125,
                  -4.84167},{-40,-4.84167},{-40,-40},{12,-40},{12,-40},{12,-20},{11,-20}},
                color={0,127,255}));
          connect(outside_wall1.port_a, airload.ports[4]) annotation (Line(points={{-52.3125,
                  -10.325},{-46,-10.325},{-46,-10},{-40,-10},{-40,-40},{12,-40},{12,-20},
                  {13,-20}}, color={0,127,255}));
          if withMechVent then
            connect(Schedule_mechVent, outside_wall1.Schedule_mechVent) annotation (Line(
                points={{-100,-72},{-80,-72},{-80,-5.95},{-66.375,-5.95}}, color={0,0,127}));
          end if;
          annotation (Icon(graphics={
                Rectangle(
                  extent={{6,65},{-6,-65}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  origin={74,-3},
                  rotation=180),
                Rectangle(
                  extent={{-60,68},{68,-68}},
                  lineColor={0,0,0},
                  fillColor={47,102,173},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-80,68},{-60,-80}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-60,-68},{80,-80}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-80,0},{-60,-50}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid,
                  visible=withWindow1),
                Rectangle(
                  extent={{80,80},{-80,68}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Line(points={{-46,68},{-46,38}}, color={255,255,255}),
                Line(points={{-60,54},{-30,54}}, color={255,255,255}),
                Text(
                  extent={{-56,60},{62,48}},
                  lineColor={255,255,255},
                  fillColor={255,170,170},
                  fillPattern=FillPattern.Solid,
                  textString="width"),
                Line(points={{38,54},{68,54}}, color={255,255,255}),
                Text(
                  extent={{-126,6},{0,-6}},
                  lineColor={255,255,255},
                  fillColor={255,170,170},
                  fillPattern=FillPattern.Solid,
                  origin={-46,64},
                  rotation=90,
                  textString="length"),
                Line(points={{-46,-38},{-46,-68}}, color={255,255,255}),
                Text(
                  extent={{-25,6},{25,-6}},
                  lineColor={255,255,255},
                  fillColor={255,170,170},
                  fillPattern=FillPattern.Solid,
                  origin={-70,-25},
                  rotation=90,
                  textString="Win1",
                  visible=withWindow1)}),                              Documentation(
                revisions="<html>
 <ul>
 <li><i>Mai 7, 2015</i> by Ana Constantin:<br/>Grount temperature depends on TRY</li>
 <li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
 <li><i>July 7, 2011</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",         info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Model for a room with 1&nbsp;outer&nbsp;wall,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;ground,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;upper&nbsp;floor. </p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>The following figure presents the room&apos;s layout: </p>
<p><img src=\"modelica://AixLib/Resources/Images/PnH/RoomEnvelope.png\" alt=\"Room layout\"/> </p>
<p><b><span style=\"color: #008000;\">Ground temperature</span></b> </p>
<p>The ground temperature can be coupled to any desired prescriped temperature. </p>
</html>"));
        end Room;
      end Rooms;

      package SmartFacade

        model SmartFacade
          extends BaseClasses.PartialSmartFassade;
          // Mechanical ventilation
          parameter Boolean withMechVent = false "with mechanical ventilation" annotation (choices(checkBox=true));
          // PV
          parameter Boolean withPV = false "with photovoltaics" annotation (choices(checkBox=true));
          //solar air heater
          parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (choices(checkBox=true));
          parameter Modelica.SIunits.Volume room_V=50 "Volume of the room" annotation(Dialog(tab = "Mechanical ventilation", enable = withMechVent));
          parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(tab = "PV", enable = withPV));
          parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181() "PV data set" annotation(Dialog(tab = "PV", enable = withPV));
          parameter Modelica.SIunits.Power PelPV_max = 4000
            "Maximum output power for inverter" annotation(Dialog(tab = "PV", enable = withPV));
          Ventilation.MechVent_schedule mechVent(
              room_V=room_V, redeclare package AirModel = AirModel) if
                                                    withMechVent
            annotation (Placement(transformation(extent={{-22,-14},{12,20}})));
          AixLib.Electrical.PVSystem.PVSystem pVSystem(
            data=dataPV,
            MaxOutputPower=PelPV_max,
            NumberOfPanels=NrPVpanels) if                 withPV
            annotation (Placement(transformation(extent={{-20,60},{0,80}})));
          Modelica.Blocks.Interfaces.RealOutput Pel_PV if withPV
            "Output electrical power of the PV system including the inverter"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-32,-100}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-28,-94})));
          Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
            "schedule mechanical ventilation in x1/h over time"
            annotation (Placement(transformation(extent={{-120,-80},{-80,-40}}),
                iconTransformation(extent={{-100,-60},{-80,-40}})));

          sahaix                                     solarAirHeater if withSolAirHeat annotation (Placement(transformation(
                extent={{-21,-21},{21,21}},
                rotation=180,
                origin={-9,-55})));
          AixLib.Utilities.Interfaces.SolarRad_in solRadPort
            annotation (Placement(transformation(extent={{-106,59},{-86,79}}),
                iconTransformation(extent={{-100,40},{-80,60}})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium
            =   AirModel) if withMechVent
            annotation (Placement(transformation(extent={{86,-62},{106,-42}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium
            =   AirModel) if
                            withMechVent
            annotation (Placement(transformation(extent={{86,-22},{106,-2}})));
          Modelica.Blocks.Interfaces.RealOutput heatOutput_SAH if withSolAirHeat
            "Connector of Real output signal" annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={6,-100})));
        equation
          if withMechVent then
            connect(weaBus, mechVent.weaBus) annotation (Line(
              points={{-90,6},{-40,6},{-40,14},{-30,14},{-30,14.22},{-21.32,14.22}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
            connect(mechVent.Schedule_mechVent, Schedule_mechVent) annotation (Line(
                points={{-20.3,-8.9},{-40,-8.9},{-40,-60},{-100,-60}}, color={0,0,127}));
            connect(mechVent.port_b, port_b) annotation (Line(points={{11.32,7.42},{20,7.42},
                    {20,-12},{96,-12}},
                                      color={0,127,255}));
            connect(port_a, mechVent.port_a) annotation (Line(points={{96,-52},{20,-52},
                    {20,0.62},{11.32,0.62}},
                                       color={0,127,255}));
          end if;

          if withPV then
            connect(solRadPort, pVSystem.IcTotalRad) annotation (Line(points={{-96,69},{
                    -40,69},{-40,70},{-20,70},{-20,69.5},{-21.8,69.5}},
                color={255,128,0}));
            connect(pVSystem.TOutside, weaBus.TDryBul) annotation (Line(points={{-22,
                  77.6},{-40,77.6},{-40,6},{-90,6}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
            connect(pVSystem.PVPowerW, Pel_PV)
            annotation (Line(points={{1,70},{20,70},{20,-76},{-32,-76},{-32,-100}},
                                                      color={0,0,127}));
          end if;

          if withSolAirHeat then
            connect(solarAirHeater.solarRad_in, solRadPort) annotation (Line(points={{-24.54,
                    -55},{-40,-55},{-40,69},{-96,69}},
                                                     color={255,128,0}));
            connect(solarAirHeater.T_in, weaBus.TDryBul) annotation (Line(points={{-17.4,-69.28},
                  {-17.4,-70},{-40,-70},{-40,6},{-90,6}}, color={0,0,127}), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
            connect(solarAirHeater.heatOutput, heatOutput_SAH) annotation (Line(points={{-29.16,
                  -39.6},{-40,-39.6},{-40,-76},{6,-76},{6,-100}}, color={0,0,127}));
          end if;

          annotation (Icon(graphics={Rectangle(
                  extent={{-80,80},{80,-80}},
                  lineColor={28,108,200},
                  fillColor={58,200,184},
                  fillPattern=FillPattern.Sphere), Text(
                  extent={{-58,46},{58,-42}},
                  lineColor={255,255,255},
                  fillPattern=FillPattern.Sphere,
                  fillColor={58,200,184},
                  textString="Fancy 
Facade")}),         Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
        end SmartFacade;

        package BaseClasses
        extends Modelica.Icons.BasesPackage;

          partial model PartialSmartFassade
            replaceable package AirModel = AixLib.Media.Air
                                      "Air model" annotation ( choicesAllMatching = true);

            AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
                  transformation(extent={{-110,-14},{-70,26}}), iconTransformation(extent=
                     {{-100,-10},{-80,10}})));
            annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                  coordinateSystem(preserveAspectRatio=false)),
              Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
          end PartialSmartFassade;
        end BaseClasses;

        model sahaix

          parameter Modelica.SIunits.MassFlowRate MassFlowSetPoint = 0.0306 "Mass Flow Set Point" annotation (Dialog(group = "Operational Parameters", descriptionLabel = true));
          parameter Modelica.SIunits.Area CoverArea = 1.2634 "Cover Area" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
          parameter Modelica.SIunits.Area InnerCrossSection = 0.01181 "Channel Cross Section" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
          parameter Modelica.SIunits.Length Perimeter = 1.348  "Perimeter" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
          parameter Modelica.SIunits.Length SAHLength1 = 1.8 "Channel Length 1" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
          parameter Modelica.SIunits.Length SAHLength2 = 1.5 "Channel Length 2" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
          parameter Modelica.SIunits.HeatCapacity   AbsorberHeatCapacity = 3950 "Absorber Heat Capacity" annotation (Dialog(group = "Other Parameters", descriptionLabel = true));
          parameter Modelica.SIunits.TransmissionCoefficient CoverTransmitance = 0.84 "Cover Transmitance" annotation (Dialog(group = "Other Parameters", descriptionLabel = true));
          parameter Modelica.SIunits.ThermalConductance CoverConductance=3.2 "Cover Conductance" annotation (Dialog(group = "Other Parameters", descriptionLabel = true));

          Modelica.Thermal.HeatTransfer.Components.Convection convection
            annotation (Placement(transformation(extent={{-12,0},{8,20}})));

          Modelica.Thermal.HeatTransfer.Components.HeatCapacitor absorber(C=
                AbsorberHeatCapacity, T(fixed=true, start=295.15))
            annotation (Placement(transformation(extent={{-98,10},{-78,30}})));
          Modelica.Blocks.Sources.RealExpression convenction_coefficient(y=25)
            annotation (Placement(transformation(extent={{32,24},{12,44}})));
          Modelica.Fluid.Sources.Boundary_pT environment_flow(
            redeclare package Medium =
                Modelica.Media.Air.DryAirNasa,
            use_T_in=true,
            nPorts=1,
            p=101300)
            annotation (Placement(transformation(extent={{90,42},{70,62}})));
          Modelica.Fluid.Pipes.DynamicPipe air_heater_f(
            isCircular=false,
            use_HeatTransfer=true,
            redeclare model HeatTransfer =

              Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
            diameter=1,
            m_flow_start=0.02,
            redeclare package Medium =
                Modelica.Media.Air.DryAirNasa,
            height_ab=0.45,
            redeclare model FlowModel =
                Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow
              (   dp_nominal(displayUnit="Pa") = 32, m_flow_nominal=0.028),
            crossArea=InnerCrossSection,
            perimeter=Perimeter,
            length=SAHLength1,
            T_start=295.15)
            annotation (Placement(transformation(extent={{-58,62},{-78,42}})));

          Modelica.Fluid.Pipes.DynamicPipe air_heater_b(
            isCircular=false,
            use_HeatTransfer=true,
            redeclare model HeatTransfer =

              Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
            diameter=1,
            m_flow_start=0.02,
            redeclare package Medium =
                Modelica.Media.Air.DryAirNasa,
            redeclare model FlowModel =
                Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow
              (   dp_nominal(displayUnit="Pa") = 32, m_flow_nominal=0.028),
            height_ab=-0.45,
            crossArea=InnerCrossSection,
            perimeter=Perimeter,
            length=SAHLength2,
            T_start=295.15)
            annotation (Placement(transformation(extent={{-92,62},{-112,42}})));

          Modelica.Fluid.Sensors.VolumeFlowRate volumeFlowRate(redeclare
            package Medium =
                Modelica.Media.Air.DryAirNasa)
            annotation (Placement(transformation(extent={{-20,-14},{-4,-30}})));
          Modelica.Fluid.Machines.PrescribedPump fan(
            use_N_in=true,
            redeclare package Medium =
                Modelica.Media.Air.DryAirNasa,
            redeclare function flowCharacteristic =

              Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearFlow
              (   V_flow_nominal={0,0.04377}, head_nominal={12.626,0}),
            N_nominal=1500)
            annotation (Placement(transformation(extent={{-66,-12},{-46,-32}})));
          Modelica.Blocks.Sources.RealExpression flow_set_point(y=MassFlowSetPoint)
            annotation (Placement(transformation(extent={{-118,-66},{-98,-46}})));
          Modelica.Blocks.Continuous.LimPID Controller(
            limitsAtInit=false,
            Ti=0.01,
            k=15,
            Td=0.2,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=2500,
            yMin=1200)
            annotation (Placement(transformation(extent={{-78,-62},{-66,-50}})));
          Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package
            Medium =
                Modelica.Media.Air.DryAirNasa)
            annotation (Placement(transformation(extent={{20,-14},{36,-30}})));
          AixLib.Utilities.HeatTransfer.SolarRadToHeat solarRadToHeat(coeff=
                CoverTransmitance, A=CoverArea)
            annotation (Placement(transformation(extent={{-26,18},{-46,38}})));
          Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpy(redeclare
            package Medium =
                Modelica.Media.Air.DryAirNasa)
            annotation (Placement(transformation(extent={{50,-12},{70,-32}})));
          Modelica.Fluid.Sources.Boundary_pT house(
            use_T_in=false,
            redeclare package Medium =
                Modelica.Media.Air.DryAirNasa,
            nPorts=1,
            p=101300)
            annotation (Placement(transformation(extent={{132,-32},{112,-12}})));
          Modelica.Blocks.Math.Product product
            annotation (Placement(transformation(extent={{62,-120},{82,-100}})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedAmbTemperature1
            annotation (Placement(transformation(extent={{46,4},{34,16}})));
          Modelica.Blocks.Interfaces.RealInput T_in annotation (Placement(
                transformation(rotation=90,extent={{-20,-20},{20,20}},
                origin={100,128}),
                iconTransformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={60,102})));
          AixLib.Utilities.Interfaces.SolarRad_in solarRad_in annotation (Placement(
                transformation(
                rotation=90,
                extent={{-13,-16},{13,16}},
                origin={-18,133}),  iconTransformation(
                extent={{-13,-14},{13,14}},
                rotation=180,
                origin={111,0})));

          Modelica.Thermal.HeatTransfer.Components.ThermalConductor cover(G=
                CoverConductance)
            annotation (Placement(transformation(extent={{-62,-4},{-42,16}})));
          Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpyEnv(redeclare
            package Medium =   Modelica.Media.Air.DryAirNasa)
            annotation (Placement(transformation(extent={{40,62},{60,42}})));
          Modelica.Blocks.Math.Add add(k1=-1)
            annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
          Modelica.Blocks.Interfaces.RealOutput heatOutput
            "Connector of Real output signal"
            annotation (Placement(transformation(extent={{134,-120},{154,-100}})));
        equation
          connect(convenction_coefficient.y,convection. Gc)
            annotation (Line(points={{11,34},{-2,34},{-2,20}},
                                                           color={0,0,127}));
          connect(air_heater_b.port_a,air_heater_f. port_b)
            annotation (Line(points={{-92,52},{-78,52}}, color={0,127,255}));
          connect(air_heater_b.port_b,fan. port_a) annotation (Line(points={{-112,52},{
                  -122,52},{-122,-22},{-66,-22}},
                                                color={0,127,255}));
          connect(fan.port_b,volumeFlowRate. port_a) annotation (Line(points={{-46,-22},
                  {-20,-22}},                     color={0,127,255}));
          connect(flow_set_point.y,Controller. u_s) annotation (Line(points={{-97,-56},
                  {-79.2,-56}},                       color={0,0,127}));
          connect(volumeFlowRate.port_b,massFlowRate. port_a) annotation (Line(points={{-4,-22},
                  {20,-22}},                         color={0,127,255}));
          connect(massFlowRate.m_flow,Controller. u_m) annotation (Line(points={{28,
                  -30.8},{28,-68},{-72,-68},{-72,-63.2}},            color={0,0,127}));
          connect(absorber.port,air_heater_b. heatPorts[1]) annotation (Line(points={{-88,10},
                  {-102.1,10},{-102.1,47.6}},         color={191,0,0}));
          connect(massFlowRate.port_b,specificEnthalpy. port_a)
            annotation (Line(points={{36,-22},{50,-22}}, color={0,127,255}));
          connect(house.ports[1],specificEnthalpy. port_b) annotation (Line(points={{112,-22},
                  {70,-22}},                              color={0,127,255}));
          connect(massFlowRate.m_flow, product.u2) annotation (Line(points={{28,-30.8},{
                  28,-116},{60,-116}},      color={0,0,127}));
          connect(prescribedAmbTemperature1.port, convection.fluid)
            annotation (Line(points={{34,10},{8,10}},      color={191,0,0}));
          connect(T_in, environment_flow.T_in) annotation (Line(points={{100,128},{100,
                  56},{92,56}},          color={0,0,127}));
          connect(T_in, prescribedAmbTemperature1.T)
            annotation (Line(points={{100,128},{100,10},{47.2,10}}, color={0,0,127}));
          connect(solarRad_in, solarRadToHeat.solarRad_in) annotation (Line(points={{-18,133},
                  {-18,26},{-25.9,26}},                      color={255,128,0}));
          connect(air_heater_f.heatPorts[1], absorber.port) annotation (Line(points={{-68.1,
                  47.6},{-68.1,28},{-68,28},{-68,10},{-88,10}},
                                                              color={127,0,0}));
          connect(Controller.y, fan.N_in) annotation (Line(points={{-65.4,-56},{-56,-56},
                  {-56,-32}},           color={0,0,127}));
          connect(cover.port_b, convection.solid)
            annotation (Line(points={{-42,6},{-28,6},{-28,10},{-12,10}},
                                                         color={191,0,0}));
          connect(cover.port_a, absorber.port)
            annotation (Line(points={{-62,6},{-76,6},{-76,10},{-88,10}},
                                                         color={191,0,0}));
          connect(solarRadToHeat.heatPort, absorber.port) annotation (Line(points={{-45,
                  26},{-68,26},{-68,10},{-88,10}}, color={191,0,0}));
          connect(environment_flow.ports[1], specificEnthalpyEnv.port_b)
            annotation (Line(points={{70,52},{60,52}}, color={0,127,255}));
          connect(specificEnthalpyEnv.port_a, air_heater_f.port_a)
            annotation (Line(points={{40,52},{-58,52}}, color={0,127,255}));
          connect(specificEnthalpyEnv.h_out, add.u1) annotation (Line(points={{50,41},{
                  88,41},{88,-54},{94,-54}}, color={0,0,127}));
          connect(specificEnthalpy.h_out, add.u2) annotation (Line(points={{60,-33},{76,
                  -33},{76,-66},{94,-66}}, color={0,0,127}));
          connect(add.y, product.u1) annotation (Line(points={{117,-60},{117,-88},{56,
                  -88},{56,-104},{60,-104}}, color={0,0,127}));

          connect(product.y, heatOutput)
            annotation (Line(points={{83,-110},{144,-110}}, color={0,0,127}));
              annotation (Documentation(info="<html> 
      <p>The Solar Air Heater Model was developed by CPERI/CERTH in the framework of the European Union’s Horizon 2020 research and innovation programme under grant agreement No 768735 (PLUG-N-HARVEST)</p>

      
 </html>",         Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)),
                            Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)),
              revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>Changed heat output of SAH to a normal real output</li>
</ul>
</html>"),                     Dialog(group = "Dimensions", descriptionLabel = true),
            uses(Modelica(version="3.2.2"), AixLib(version="0.7.3")),
            Diagram(coordinateSystem(initialScale=0.1, extent={{-150,-150},{150,150}})),
            Icon(coordinateSystem(initialScale=0.1, extent={{-150,-150},{150,150}}),
                graphics={
                Rectangle(
                  extent={{-34,80},{-16,-56}},
                  lineColor={28,108,200},
                  fillColor={255,186,189},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Rectangle(
                  extent={{-16,80},{-6,-56}},
                  lineColor={28,108,200},
                  fillColor={217,211,244},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Rectangle(
                  extent={{10,70},{12,-88}},
                  lineColor={28,108,200},
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Rectangle(
                  extent={{-34,-76},{-16,-88}},
                  lineColor={28,108,200},
                  fillColor={255,186,189},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Rectangle(
                  extent={{-16,-76},{-6,-88}},
                  lineColor={28,108,200},
                  fillColor={217,211,244},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Rectangle(
                  extent={{30,80},{36,-78}},
                  lineColor={28,108,200},
                  fillColor={129,216,223},
                  fillPattern=FillPattern.Solid,
                  lineThickness=0.5),
                Line(
                  points={{-6,-88},{10,-88}},
                  color={28,108,200},
                  thickness=0.5),
                Line(points={{12,-88},{34,-88}}, color={28,108,200}),
                Line(
                  points={{36,-78},{46,-78}},
                  color={28,108,200},
                  thickness=0.5),
                Line(
                  points={{46,-78},{46,-96}},
                  color={28,108,200},
                  thickness=0.5),
                Line(
                  points={{12,-88},{34,-88}},
                  color={28,108,200},
                  thickness=0.5),
                Line(
                  points={{34,-88},{34,-96}},
                  color={28,108,200},
                  thickness=0.5),
                Line(
                  points={{-6,80},{30,80}},
                  color={28,108,200},
                  thickness=0.5),
                Ellipse(
                  extent={{-12,-56},{-10,-66}},
                  lineColor={28,108,200},
                  fillColor={152,152,152},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-12,-66},{-10,-76}},
                  lineColor={28,108,200},
                  fillColor={152,152,152},
                  fillPattern=FillPattern.Solid),
            Text(lineColor={0,0,255},
              extent={{0,66},{0,124}},
                  fontSize=12,
                  textString="%name")}));
        end sahaix;
      end SmartFacade;

      package Ventilation "Ventilation models"
        extends Modelica.Icons.Package;

        model MechVent_schedule "Mechanical ventilation using a schedule"
          extends
          PlugNHarvest.Components.Ventilation.BaseClasses.PartialVentFreshAir;

          parameter Modelica.SIunits.Volume room_V = 50 "Volume of the room";

      public
          Modelica.Blocks.Sources.RealExpression realExpression(y=-(Schedule_mechVent*
                room_V*senDen.d)/3600)
            annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
      public
          Modelica.Blocks.Interfaces.RealInput Schedule_mechVent(unit="m3/s")
            "schedule for mechanical ventilation" annotation (Placement(transformation(
                  extent={{-120,-80},{-80,-40}}), iconTransformation(extent={{-100,-80},
                    {-80,-60}})));
        equation

          connect(realExpression.y, boundary.m_flow_in)
            annotation (Line(points={{-39,-24},{-22,-24}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                  extent={{-90,90},{90,80}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-38,70},{-2,42},{0,0},{-54,54},{-38,70}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Polygon(
                  points={{36,-8},{36,14},{-40,14},{-10,-14},{36,-8}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  origin={14,40},
                  rotation=90,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Polygon(
                  points={{0,0},{42,2},{70,38},{54,54},{0,0}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Polygon(
                  points={{76,-22},{76,0},{0,0},{30,-28},{76,-22}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Polygon(
                  points={{38,-70},{2,-42},{0,0},{54,-54},{38,-70}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Polygon(
                  points={{-36,8},{-36,-14},{40,-14},{10,14},{-36,8}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  origin={-14,-40},
                  rotation=90,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Polygon(
                  points={{0,0},{-42,-2},{-70,-38},{-54,-54},{0,0}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Polygon(
                  points={{-76,22},{-76,0},{0,0},{-30,28},{-76,22}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier),
                Ellipse(
                  extent={{-16,16},{16,-16}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-90,-80},{90,-90}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid)}),                      Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
        end MechVent_schedule;

        model InfiltrationNew "Simple infiltration"
          extends
          PlugNHarvest.Components.Ventilation.BaseClasses.PartialVentFreshAir;

          parameter Modelica.SIunits.Volume room_V = 50 "Volume of the room";
          parameter Real n50(unit = "h-1") = 4
            "Air exchange rate at 50 Pa pressure difference";
          parameter Real e = 0.03 "Coefficient of windshield";
          parameter Real eps = 1.0 "Coefficient of height";

      protected
          parameter Real InfiltrationRate = 2 * n50 * e * eps;

      public
          Modelica.Blocks.Sources.RealExpression realExpression(y=-(InfiltrationRate*
                room_V*senDen.d)/3600)
            annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
        equation

          connect(realExpression.y, boundary.m_flow_in)
            annotation (Line(points={{-39,-24},{-22,-24}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                  extent={{-36,100},{36,-100}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-60,26},{-20,46},{20,26},{60,46},{60,36},{20,16},{-20,36},{-60,
                      16},{-60,26}},
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier,
                  fillColor={28,108,200},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-60,-34},{-20,-14},{20,-34},{60,-14},{60,-24},{20,-44},{-20,-24},
                      {-60,-44},{-60,-34}},
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier,
                  fillColor={28,108,200},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-60,-4},{-20,16},{20,-4},{60,16},{60,6},{20,-14},{-20,6},{-60,
                      -14},{-60,-4}},
                  lineColor={0,0,0},
                  smooth=Smooth.Bezier,
                  fillColor={28,108,200},
                  fillPattern=FillPattern.Solid)}),                      Diagram(
                coordinateSystem(preserveAspectRatio=false)),
            Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
        end InfiltrationNew;

        package BaseClasses
          extends Modelica.Icons.BasesPackage;

          model PartialVentFreshAir
            "Partial model for ventilation with fresh air"

             replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);
            AixLib.Fluid.Sources.MassFlowSource_T boundary(
              redeclare package Medium = AirModel,
              use_m_flow_in=true,
              nPorts=1) annotation (Placement(transformation(extent={{-20,-42},{0,-22}})));
            AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
              annotation (Placement(transformation(extent={{-106,56},{-86,76}})));
            AixLib.Fluid.Sources.Outside freshAir(redeclare package Medium = AirModel,
                nPorts=1) annotation (Placement(transformation(extent={{-20,24},{0,44}})));
            Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package
              Medium =
                  AirModel)
              annotation (Placement(transformation(extent={{86,-24},{106,-4}})));
            Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package
              Medium =
                  AirModel)
              annotation (Placement(transformation(extent={{86,16},{106,36}})));
            AixLib.Fluid.Sensors.Density senDen(redeclare package Medium = AirModel)
              annotation (Placement(transformation(extent={{-22,-72},{-2,-52}})));
          equation
            connect(weaBus, freshAir.weaBus) annotation (Line(
                points={{-96,66},{-80,66},{-80,34.2},{-20,34.2}},
                color={255,204,51},
                thickness=0.5), Text(
                string="%first",
                index=-1,
                extent={{-6,3},{-6,3}}));
            connect(freshAir.ports[1], port_b) annotation (Line(points={{0,34},{40,34},{
                    40,26},{96,26},{96,26}}, color={0,127,255}));
            connect(boundary.ports[1], port_a) annotation (Line(points={{0,-32},{40,-32},
                    {40,-14},{96,-14}}, color={0,127,255}));
            connect(senDen.port, port_a) annotation (Line(points={{-12,-72},{-14,-72},{
                    -14,-74},{40,-74},{40,-14},{96,-14}}, color={0,127,255}));
            annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                  coordinateSystem(preserveAspectRatio=false)));
          end PartialVentFreshAir;
        end BaseClasses;
      end Ventilation;

      package Walls

        model Wall
          "Simple wall model for outside and inside walls with windows and doors"


          //Type parameter
          parameter Boolean outside = true "Choose if the wall is an outside or an inside wall" annotation(Dialog(group = "General Wall Type Parameter", compact = true), choices(choice = true "Outside Wall", choice = false "Inside Wall", radioButtons = true));

          // general wall parameters
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition WallType=
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
            "Choose an outside wall type from the database"
            annotation (Dialog(group="Room Geometry"), choicesAllMatching=true);
          parameter Modelica.SIunits.Length wall_length = 2 "Length of wall" annotation(Dialog(group = "Room Geometry"));
          parameter Modelica.SIunits.Height wall_height = 2 "Height of wall" annotation(Dialog(group = "Room Geometry"));
          parameter Modelica.SIunits.Angle compass = 0 "compass direction of wall (N=0deg, E=90deg, S=180deg, W=270deg)" annotation(Dialog(group = "Room Geometry", enable = outside));

          // Surface parameters
          parameter Real solar_absorptance = 0.25 "Solar absorptance coefficient of outside wall surface" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside));
          parameter Integer Model = 1 "Choose the model for calculation of heat convection at outside surface" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = outside, compact = true), choices(choice = 1 "DIN 6946", choice = 2 "ASHRAE Fundamentals", choice = 3 "Custom alpha", radioButtons = true));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom = 25 "Custom alpha for convection (just for manual selection, not recommended)" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 3 and outside));
          parameter AixLib.DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook surfaceType = AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster() "Surface type of outside wall" annotation(Dialog(tab = "Surface Parameters", group = "Outside surface", enable = Model == 2 and outside), choicesAllMatching = true);
          parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1 "vertical wall", choice = 2 "floor", choice = 3 "ceiling", radioButtons = true));
          parameter Integer calculationMethod = 1 "Choose the model for calculation of heat convection at inside surface" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", compact = true, descriptionLabel = true), choices(choice = 1 "EN ISO 6946 Appendix A >>Flat Surfaces<<", choice=2 "By Bernd Glueck", choice=3 "Constant alpha", radioButtons = true));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_constant = 2.5 "Constant alpha for convection (just for manual selection, not recommended)" annotation(Dialog(tab = "Surface Parameters", group = "Inside surface", enable = calculationMethod == 3));

          // window parameters
          parameter Boolean withWindow = false "Choose if the wall has got a window (only outside walls)" annotation(Dialog(tab = "Window", enable = outside));
          replaceable model Window =

            AixLib.ThermalZones.HighOrder.Components.WindowsDoors.WindowSimple
          constrainedby
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                          "Model for window" annotation(Dialog( tab="Window",  enable = withWindow and outside), choicesAllMatching=true);
          parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType = AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "Choose a window type from the database" annotation(Dialog(tab = "Window", enable = withWindow and outside), choicesAllMatching = true);
          parameter Modelica.SIunits.Area windowarea = 2 "Area of window" annotation(Dialog(tab = "Window", enable = withWindow and outside));
          parameter Boolean withSunblind = false "enable support of sunblinding?" annotation(Dialog(tab = "Window", enable = outside and withWindow));
          parameter Real Blinding = 0 "blinding factor <=1" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));
          parameter Real Limit = 180 "minimum specific total solar radiation in W/m2 for blinding becoming active" annotation(Dialog(tab = "Window", enable = withWindow and outside and withSunblind));

          // door parameters
          parameter Boolean withDoor = false "Choose if the wall has got a door" annotation(Dialog(tab = "Door"));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer U_door = 1.8 "Thermal transmission coefficient of door" annotation(Dialog(tab = "Door", enable = withDoor));
          parameter Modelica.SIunits.Emissivity eps_door = 0.9 "Solar emissivity of door material" annotation(Dialog(tab = "Door", enable = withDoor));
          parameter Modelica.SIunits.Length door_height = 2 annotation(Dialog(tab = "Door", enable = withDoor));
          parameter Modelica.SIunits.Length door_width = 1 annotation(Dialog(tab = "Door", enable = withDoor));

          // Calculation of clearance
          final parameter Modelica.SIunits.Area clearance = if not outside and withDoor then door_height * door_width else if outside and withDoor and withWindow then windowarea + door_height * door_width else if outside and withWindow then windowarea else if outside and withDoor then door_height * door_width else 0 "Wall clearance";

          // heat bridge parameters
          parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(tab = "Heat bridges", enable= outside, compact = false));
          parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Heat bridges", enable = withHeatBridge));
          parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Heat bridges", enable = withHeatBridge));

          // ventilation parameters
          parameter Modelica.SIunits.Volume roomV "room volume" annotation(Dialog(tab = "Infiltration", enable = outside));
          parameter Real n50(unit = "h-1") = 4
            "Air exchange rate at 50 Pa pressure difference" annotation(Dialog(tab = "Infiltration", enable = outside));
          parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration", enable = outside));
          parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration", enable = outside));
          replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);

          // Initial temperature
          parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20) "Initial temperature" annotation(Dialog(tab = "Advanced Parameters"));

          // smart facade
          parameter Boolean withSmartFacade = false annotation (Dialog( tab = "Smart Facade", enable = outside), choices(checkBox=true));
          // Mechanical ventilation
          parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
          // PV
          parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
          //solar air heater
          parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( tab = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
          parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(tab = "Smart Facade", enable = withPV));
          parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                         "PV data set" annotation(Dialog(tab = "Smart Facade", enable = withPV));
          parameter Modelica.SIunits.Power PelPV_max = 4000
            "Maximum output power for inverter" annotation(Dialog(tab = "Smart Facade", enable = withPV));
          // COMPONENT PART
            // Connectoren
          AixLib.Utilities.Interfaces.SolarRad_in
                                           SolarRadiationPort if outside annotation(Placement(transformation(extent={{-116,79},
                    {-96,99}}),                                                                                                                              iconTransformation(extent = {{-36, 100}, {-16, 120}})));
          AixLib.Utilities.Interfaces.HeatStarComb
                                            thermStarComb_inside  annotation(Placement(transformation(extent={{92,2},{
                    110,20}}),                                                                                                         iconTransformation(extent = {{10, -10}, {30, 10}})));

          AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.ConvNLayerClearanceStar
            Wall(
            h=wall_height,
            l=wall_length,
            T0=T0,
            clearance=clearance,
            selectable=true,
            eps=WallType.eps,
            wallType=WallType,
            surfaceOrientation=ISOrientation,
            calcMethod=calculationMethod,
            alpha_constant=alpha_constant) "Wall"
            annotation (Placement(transformation(extent={{-14,20},{8,40}})));
          AixLib.Utilities.HeatTransfer.SolarRadToHeat
                                                SolarAbsorption(coeff = solar_absorptance, A = wall_height * wall_length - clearance) if outside  annotation(Placement(transformation(origin={-42,90},    extent={{-10,-10},
                    {10,10}})));
          AixLib.ThermalZones.HighOrder.Components.Sunblinds.Sunblind Sunblind(
            final n=1,
            final gsunblind={Blinding},
            final Imax=LimitSolIrr,
            final TOutAirLimit=TOutAirLimit) if
                                 outside and withWindow and withSunblind
            annotation (Placement(transformation(extent={{-44,-21},{-21,5}})));
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.Door
                                                Door(
            T0=T0,
            door_area=door_height*door_width,
            eps=eps_door,
            U=if outside then U_door else U_door*2) if withDoor
            annotation (Placement(transformation(extent={{-15,-56},{17,-24}})));
          Window windowSimple(T0 = T0, windowarea = windowarea, WindowType = WindowType) if outside and withWindow  annotation(Placement(transformation(extent={{-13,-22},
                    {13,4}})));
          AixLib.Utilities.HeatTransfer.HeatConv_outside
                                                  heatTransfer_Outside(A = wall_length * wall_height - clearance, Model = Model, surfaceType = surfaceType, alpha_custom = alpha_custom) if outside  annotation(Placement(transformation(extent = {{-47, 48}, {-27, 68}})));
          AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb
                                                       heatStarToComb  annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 180, origin={69,11})));
            replaceable model HeatBridge =
              PlugNHarvest.Components.Walls.HeatBridgeLinear constrainedby
          PlugNHarvest.Components.Walls.BaseClasses.PartialHeatBridgeWalls
            "Heat Bridge Model" annotation (choicesAllMatching=
                true,Dialog(tab = "Heat bridges", enable = withHeatBridge));

              HeatBridge heatBridge(wallHeight=wall_height, wallLength=wall_length) if
                                       withHeatBridge  "Heat bridge model" annotation (Placement(transformation(extent={{0,48},{
                    20,68}},   rotation=0)));

          AixLib.BoundaryConditions.WeatherData.Bus weaBus if outside "Bus with weather data"
            annotation (Placement(transformation(extent={{-109,-19},{-89,1}}),
                iconTransformation(extent={{14,12},{-14,-12}},
                rotation=180,
                origin={-32,0})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            prescribedTemperature if outside
            annotation (Placement(transformation(extent={{-84,-48},{-68,-32}})));
          Ventilation.InfiltrationNew infiltrationNew(redeclare package
            AirModel =
                AirModel,
            room_V=roomV,
            n50=n50,
            e=e,
            eps=eps) if (outside and not withMechVent)
            annotation (Placement(transformation(extent={{-14,-84},{12,-60}})));

          SmartFacade.SmartFacade smartFacade(
            redeclare package AirModel = AirModel,
            withMechVent=withMechVent,
            withPV=withPV,
            withSolAirHeat=withSolAirHeat,
            room_V=roomV) if                     withSmartFacade
            annotation (Placement(transformation(extent={{-22,-130},{18,-92}})));

          Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if (withSmartFacade and withMechVent)
            "schedule for mechanical ventilation. NEEDS to include infiltration as well (0.2 1/h)"
            annotation (Placement(transformation(extent={{-121,-125},{-81,-85}}),
                iconTransformation(extent={{13.5,13.5},{-13.5,-13.5}},
                rotation=180,
                origin={-29.5,-85.5})));
          Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium
            =   AirModel) if outside
            annotation (Placement(transformation(extent={{85,-104},{105,-84}}),
                iconTransformation(extent={{15.5,-93.5},{38,-115}})));
          Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium
            =   AirModel) if outside
            annotation (Placement(transformation(extent={{85,-87},{105,-67}}),
                iconTransformation(extent={{14.5,-69.5},{39,-92}})));
        equation
          //******************************************************************
          // **********************standard connection************************
          //******************************************************************
          connect(Wall.Star, heatStarToComb.star) annotation(Line(points={{8,36.2},{48,36.2},
                    {48,16.8},{58.6,16.8}},                                                                               color = {95, 95, 95}, pattern = LinePattern.Solid));
          connect(Wall.port_b, heatStarToComb.therm) annotation(Line(points={{8,30},{48,
                    30},{48,5.9},{58.9,5.9}},                                                                                  color = {191, 0, 0}));
          connect(heatStarToComb.thermStarComb, thermStarComb_inside) annotation(Line(points={{78.4,
                  10.9},{101,11}},                                                                                                                    color = {191, 0, 0}));

          //******************************************************************
          // **********************standard connection for inside wall********
          //******************************************************************
          if not outside then
            connect(Wall.port_a, prescribedTemperature.port) annotation(Line(points={{-14,30},
                      {-56.45,30},{-56.45,-40},{-68,-40}},                                                                  color = {191, 0, 0}));
          end if;
          //******************************************************************
          // ********************standard connection for outside wall*********
          //******************************************************************
          if outside then
            connect(infiltrationNew.weaBus, weaBus) annotation (Line(
              points={{-13.48,-64.08},{-56,-64.08},{-56,-9},{-99,-9}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
            connect(SolarRadiationPort, SolarAbsorption.solarRad_in) annotation(Line(points={{-106,89},
                      {-77,89},{-77,88},{-52.1,88}},                                                                                           color = {255, 128, 0}));
            if (not withMechVent) then
              connect(infiltrationNew.port_b, port_b) annotation (Line(points={{11.48,-68.88},
                    {48,-68.88},{48,-77},{95,-77}},
                                                  color={0,127,255}));
              connect(infiltrationNew.port_a, port_a) annotation (Line(points={{11.48,-73.68},
                    {48,-73.68},{48,-94},{95,-94}}, color={0,127,255}));
            end if;
            if Model == 1 or Model == 2 then
            end if;
            connect(heatTransfer_Outside.port_b, Wall.port_a) annotation(Line(points={{-27,58},
                      {-22,58},{-22,30},{-14,30}},                                                                                     color = {191, 0, 0}));
            connect(SolarAbsorption.heatPort, Wall.port_a) annotation(Line(points={{-33,88},
                      {-22,88},{-22,30},{-14,30}},                                                                                               color = {191, 0, 0}));
          end if;
          //******************************************************************
          // *******standard connections for wall with door************
          //******************************************************************
          if withDoor then
            connect(Door.port_a, prescribedTemperature.port) annotation(Line(points={{-13.4,
                      -40},{-68,-40}},                                                                                                        color = {191, 0, 0}));
            connect(Door.port_b, heatStarToComb.therm) annotation(Line(points={{15.4,-40},
                    {48,-40},{48,5.9},{58.9,5.9}},                                                                                 color = {191, 0, 0}));
            connect(Door.Star, heatStarToComb.star) annotation(Line(points={{15.4,-30.4},
                    {48,-30.4},{48,16.8},{58.6,16.8}},                                                                            color = {95, 95, 95}, pattern = LinePattern.Solid));
          end if;
          //******************************************************************
          // ****standard connections for outside wall with window***********
          //******************************************************************
          if outside and withWindow then
            connect(windowSimple.Star, heatStarToComb.star) annotation(Line(points={{11.7,
                    -1.2},{48,-1.2},{48,16.8},{58.6,16.8}},                                                                               color = {95, 95, 95}, pattern = LinePattern.Solid));
            connect(windowSimple.port_inside, heatStarToComb.therm) annotation(Line(points={{11.7,
                    -10.3},{48,-10.3},{48,5.9},{58.9,5.9}},                                                                                         color = {191, 0, 0}));
            connect(windowSimple.port_outside, prescribedTemperature.port) annotation(Line(points={{-11.7,
                      -10.3},{-56,-10.3},{-56,-40},{-68,-40}},                                                                            color = {191, 0, 0}));
          end if;
          //******************************************************************
          // **** connections for outside wall with window without sunblind****
          //******************************************************************
          if outside and withWindow and not withSunblind then
            connect(windowSimple.solarRad_in, SolarRadiationPort) annotation(Line(points={{-11.7,
                      -1.2},{-81,-1.2},{-81,89},{-106,89}},                                                                                       color = {255, 128, 0}));
          end if;
          //******************************************************************
          // **** connections for outside wall with window and sunblind****
          //******************************************************************
          if outside and withWindow and withSunblind then
            connect(Sunblind.Rad_Out[1], windowSimple.solarRad_in) annotation(Line(points={{-22.15,
                      -6.7},{-18,-6.7},{-18,-1.2},{-11.7,-1.2}},                                                                                 color = {255, 128, 0}));
            connect(Sunblind.Rad_In[1], SolarRadiationPort) annotation(Line(points={{-42.85,
                      -6.7},{-81,-6.7},{-81,89},{-106,89}},                                                                        color = {255, 128, 0}));
          end if;

          if withHeatBridge then
            connect(heatBridge.port_b, heatStarToComb.therm) annotation (Line(points={{19.4,
                  58.6},{48,58.6},{48,5.9},{58.9,5.9}}, color={191,0,0}));
            connect(heatBridge.port_b, heatStarToComb.therm) annotation (Line(points={{19.4,
                  58.6},{48,58.6},{48,5.9},{58.9,5.9}}, color={191,0,0}));
          connect(heatBridge.port_a, prescribedTemperature.port) annotation (Line(points={{0.4,
                      58.6},{-18,58.6},{-18,30},{-56,30},{-56,-40},{-68,-40}},
                                                                   color={191,0,0}));
          end if;

          connect(weaBus.winSpe, heatTransfer_Outside.WindSpeedPort) annotation (Line(
              points={{-99,-9},{-56,-9},{-56,50.8},{-46.2,50.8}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(weaBus.TDryBul, Sunblind.TOutAir) annotation (Line(
              points={{-99,-9},{-56,-9},{-56,-14},{-50,-14},{-50,-13.2},{-45.84,-13.2}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));

          connect(weaBus.TDryBul, prescribedTemperature.T) annotation (Line(
              points={{-99,-9},{-99,-40},{-85.6,-40}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%first",
              index=-1,
              extent={{-6,3},{-6,3}}));
          connect(prescribedTemperature.port, heatTransfer_Outside.port_a) annotation (
              Line(points={{-68,-40},{-56,-40},{-56,58},{-47,58}}, color={191,0,0}));

          //******************************************************************
          // ******* connections for smart facade ****************************
          //******************************************************************

          if withSmartFacade then
            connect(smartFacade.solRadPort, SolarRadiationPort) annotation (Line(points={{
                  -20,-101.5},{-32,-101.5},{-32,-102},{-56,-102},{-56,40},{-80,40},{-80,
                  89},{-106,89}}, color={255,128,0}));
            connect(smartFacade.weaBus, weaBus) annotation (Line(
              points={{-20,-111},{-56,-111},{-56,-9},{-99,-9}},
              color={255,204,51},
              thickness=0.5), Text(
              string="%second",
              index=1,
              extent={{6,3},{6,3}}));
              if withMechVent then
                connect(smartFacade.Schedule_mechVent, Schedule_mechVent) annotation (Line(
                points={{-20,-120.5},{-56,-120.5},{-56,-105},{-101,-105}}, color={0,0,127}));
                connect(smartFacade.port_b, port_b) annotation (Line(points={{17.2,-113.28},{48,
                  -113.28},{48,-77},{95,-77}}, color={0,127,255}));
                connect(smartFacade.port_a, port_a) annotation (Line(points={{17.2,-120.88},{48,
                  -120.88},{48,-94},{95,-94}}, color={0,127,255}));
              end if;
          end if;

          annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-20, -120}, {20, 120}}, grid = {1, 1}), graphics={  Rectangle(extent = {{-16, 120}, {15, -60}}, fillColor = {215, 215, 215},
                    fillPattern = FillPattern.Backward,  pattern=LinePattern.None, lineColor = {0, 0, 0}), Rectangle(extent = {{-16, -90}, {15, -120}},  pattern=LinePattern.None, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                    fillPattern = FillPattern.Backward), Rectangle(extent = {{-16, -51}, {15, -92}}, lineColor = {0, 0, 0},  pattern=LinePattern.None, fillColor = {215, 215, 215},
                    fillPattern = FillPattern.Backward, visible = not withDoor), Rectangle(extent = {{-16, 80}, {15, 20}}, fillColor = {255, 255, 255},
                    fillPattern = FillPattern.Solid, visible = outside and withWindow, lineColor = {255, 255, 255}), Line(points = {{-2, 80}, {-2, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 80}, {1, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 77}, {-2, 77}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{1, 23}, {-2, 23}}, color = {0, 0, 0}, visible = outside and withWindow), Ellipse(extent = {{-16, -60}, {44, -120}}, lineColor = {0, 0, 0}, startAngle = 359, endAngle = 450, visible = withDoor), Rectangle(extent = {{-16, -60}, {15, -90}}, visible = withDoor, lineColor = {255, 255, 255}, fillColor = {255, 255, 255},
                    fillPattern = FillPattern.Solid), Line(points = {{1, 50}, {-2, 50}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{15, 80}, {15, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, 80}, {-16, 20}}, color = {0, 0, 0}, visible = outside and withWindow), Line(points = {{-16, -60}, {-16, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{15, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -90}, {15, -60}}, color = {0, 0, 0}, visible = withDoor), Line(points = {{-16, -60}, {15, -90}}, color = {0, 0, 0}, visible = withDoor)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Flexible Model for Inside Walls and Outside Walls. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The<b> WallSimple</b> model models </p>
 <ul>
 <li>Conduction and convection for a wall (different on the inside surface depending on the surface orientation: vertical wall, floor or ceiling)</li>
 <li>Outside walls may have a window and/ or a door</li>
 <li>Inside walls may have a door</li>
 </ul>
 <p>This model uses a <a href=\"AixLib.Utilities.Interfaces.HeatStarComb\">HeatStarComb</a> Connector for an easier connection of temperature and radiance inputs.</p>
 <p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
 <ul>
 <li>Outside walls are represented as complete walls</li>
 <li>Inside walls are modeled as a half of a wall, you need to connect a corresponding second half with the same values</li>
 <li>Door and window got a constant U-value</li>
 <li>No heat storage in doors or window </li>
 </ul>
 <p>Have a closer look at the used models to get more information about the assumptions. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">AixLib.Building.Components.Examples.Walls.InsideWall</a> </p>
 </html>",         revisions="<html>
 <ul>
 <li><i>April 17, 2019&nbsp;</i> by Ana Constantin:<br/>Added smart facade and infiltration and heat bridge</li>
 <li><i>October 12, 2016&nbsp;</i> by Tobias Blacha:<br/>Algorithm for HeatConv_inside is now selectable via parameters on upper model level. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/215\">issue 215</a></li>
 <li><i>August 22, 2014&nbsp;</i> by Ana Constantin:<br/>Corrected implementation of door also for outside walls. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/13\">issue 13</a></li>
 <li><i>May 19, 2014&nbsp;</i> by Ana Constantin:<br/>Formatted documentation appropriately</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>June 22, 2012&nbsp;</i> by Lukas Mencher:<br/>Outside wall may have a door now, icon adjusted</li>
 <li><i>Mai 24, 2012&nbsp;</i> by Ana Constantin:<br/>Added inside surface orientation</li>
 <li><i>April, 2012&nbsp;</i> by Mark Wesseling:<br/>Implemented.</li>
 </ul>
 </html>"), Diagram(coordinateSystem(extent={{-100,-140},{100,100}})));
        end Wall;

        model HeatBridgeLinear "Heat transfer due to a heat bridge (linear model)"
          extends
          PlugNHarvest.Components.Walls.BaseClasses.PartialHeatBridgeWalls;

           parameter Real psiVer(unit="W/(m.K)") = 0.1;
           parameter Real psiHor(unit="W/(m.K)") = 0.1;
           parameter Modelica.SIunits.Length wallHeight = 0.1;
           parameter Modelica.SIunits.Length wallLength = 0.1;
           Modelica.SIunits.TemperatureDifference dT;
        equation
          dT=port_a.T-port_b.T;
          qFlow=psiVer*wallHeight*dT+psiHor*wallLength*dT;
          port_a.Q_flow=qFlow;
          port_b.Q_flow=-qFlow;

          annotation (Diagram(graphics), Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Model for linear heat bridge. </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>Models linear heat bridge in both horizontal and vertical direction.</p>
</html>",  revisions="<html>
<ul>
<li><i>January 29, 2018&nbsp;</i> by Sebastian Stinner:<br/>Implemented</li>

</ul>
</html>"));
        end HeatBridgeLinear;

        package BaseClasses
          extends Modelica.Icons.BasesPackage;

          partial model PartialHeatBridgeWalls
            "Partial for heat bridge consideration in walls"

            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (
                Placement(transformation(extent={{84,-4},{104,16}}, rotation=0)));

            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a   annotation (
                Placement(transformation(extent={{-106,-4},{-86,16}},
                                                                  rotation=0)));

            Modelica.SIunits.HeatFlowRate qFlow;

            annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                      -100,-100},{100,100}})),
                                 Icon(coordinateSystem(preserveAspectRatio=false,
                    extent={{-100,-100},{100,100}}), graphics={
                  Rectangle(
                    extent={{-40,70},{40,-50}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    fillColor={85,170,255},
                    fillPattern=FillPattern.Solid),
                  Polygon(
                    points={{-40,-10},{-30,2},{-16,16},{-6,20},{4,16},{14,4},{22,-16},
                        {34,-24},{40,-26},{40,-50},{-40,-50},{-40,-10}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    smooth=Smooth.None,
                    fillColor={170,213,255},
                    fillPattern=FillPattern.Solid),
                  Polygon(
                    points={{-40,-30},{-34,-16},{-16,2},{-6,2},{4,-6},{16,-24},{22,-40},
                        {38,-50},{-40,-50},{-40,-30}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    smooth=Smooth.None,
                    fillColor={255,170,170},
                    fillPattern=FillPattern.Solid),
                  Polygon(
                    points={{-40,-50},{-32,-30},{-20,-12},{-8,-10},{8,-28},{14,-42},{
                        24,-50},{-40,-50}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    smooth=Smooth.None,
                    fillColor={255,62,62},
                    fillPattern=FillPattern.Solid),
                  Polygon(
                    points={{-40,0},{-16,38},{-2,40},{6,34},{14,16},{26,-6},{40,-12},
                        {40,70},{-40,70},{-40,0}},
                    lineColor={0,0,255},
                    pattern=LinePattern.None,
                    smooth=Smooth.None,
                    fillColor={0,0,255},
                    fillPattern=FillPattern.Solid)}),
              Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Partial model for consideration of heat bridges.</p>
</html>",       revisions="<html>
<ul>
<li><i>January 29, 2018&nbsp;</i> by Sebastian Stinner:<br/>Implemented</li>

</ul>
</html>
"));
          end PartialHeatBridgeWalls;
        end BaseClasses;
      end Walls;
    end Components;

    package Aggregation

      model Room_EnergySyst "Room and energy system"
            //  * * * * * * * * * * * * G  E  N  E  R  A  L * * * * * * * * * * * *
       replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);
          //**************************E N V E L O P E ************************
          // room geometry
        parameter Modelica.SIunits.Length room_length=5 "room length"
          annotation (Dialog(group="Envelope", descriptionLabel=true));
        parameter Modelica.SIunits.Length room_width=3 "room width"
          annotation (Dialog(group="Envelope", descriptionLabel=true));
        parameter Modelica.SIunits.Height room_height=3 "room height"
          annotation (Dialog(group="Envelope", descriptionLabel=true));

        //wall types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_OW1= AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() "wall type OW1"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW1=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW1"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW2=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() "wall type IW2"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW3=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW3"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_CE=AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() "wall type Ceiling"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_FL=AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() "wall type Floor"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));

        // window
        parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (
            Dialog(
            group="Envelope",
            descriptionLabel=true,
            enable=withWindow1));
        parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "window type"
            annotation (Dialog(group="Envelope"));

        //**************************S M A R T   F A C A D E ************************
        // smart facade
        parameter Boolean withSmartFacade = false annotation (Dialog( group = "Smart Facade", enable = outside), choices(checkBox=true));
        // Mechanical ventilation
        parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        // PV
        parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        //solar air heater
        parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(group = "Smart Facade", enable = withPV));
        parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                       "PV data set" annotation(Dialog(group = "Smart Facade", enable = withPV));
        parameter Modelica.SIunits.Power PelPV_max = 4000
          "Maximum output power for inverter" annotation(Dialog(group = "Smart Facade", enable = withPV));


        //**************************I N T E R N A L  G A I N S ************************
        // persons
        parameter Modelica.SIunits.Power heatLoadForActivity = 80 "Sensible heat output occupants for activity at 20°C" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
        parameter Real occupationDensity = 0.2 "Density of occupants in persons/m2" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
        // lights
        parameter Real spPelSurface_lights(unit = "W/m2") =  22 "specific Pel/m2 for type of light source" annotation(Dialog(group = "Internal gains",descriptionLabel = true));
        //electrical appliances
        parameter Real spPelSurface_elApp(unit = "W/m2") =  22 "specific Pel/m2 for type of el. appliances" annotation(Dialog(group = "Internal gains",descriptionLabel = true));

          //**************************E N E R G Y   S Y S T E M ************************
        parameter Modelica.SIunits.Power Pmax_heater = 1000 "maximal power output heater" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature Tset_heater = 293.12 "set temperature for heating" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature Tout_isHeatOn = 288.12 "Touside under which heating is on" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature Tset_chiller = 296.12 "set temperature for cooling" annotation(Dialog(group = "Energy system", descriptionLabel = true));
        parameter Modelica.SIunits.Power Pmax_chiller = 1000 "maximal power output chiller" annotation(Dialog(group = "Energy system", descriptionLabel = true));


        //  * * * * * * * * * * A  D  V  A  N  C  E  D * * * * * * * * * * * *
        //**************************E N V E L O P E ************************
        // Outer walls properties
        parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
          annotation (Dialog(tab = "Advanced", group="Envelope", descriptionLabel=true));

        parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
            tab = "Advanced", group="Envelope",
            compact=true,
            descriptionLabel=true), choices(
            choice=1 "DIN 6946",
            choice=2 "ASHRAE Fundamentals",
            choice=3 "Custom alpha",
            radioButtons=true));

        // Infiltration rate
        parameter Real n50(unit="h-1") = 3 "Air exchange rate at 50 Pa pressure differencefor infiltration "
          annotation (Dialog(tab = "Advanced", group="Envelope"));
        parameter Real e=0.02 "Coefficient of windshield for infiltration"
          annotation (Dialog(tab = "Advanced", group="Envelope"));
        parameter Real eps=1.0 "Coefficient of height for infiltration"
          annotation (Dialog(tab = "Advanced", group="Envelope"));
          // Sunblind
        parameter Boolean use_sunblind = false
          "Will sunblind become active automatically?"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
          "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
          "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
          "Temperature at which sunblind closes (see also solIrrThreshold)"
          annotation(Dialog(tab = "Advanced", group="Envelope"));

               // Heat bridge
        parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(tab = "Advanced", group = "Envelope", enable= outside, compact = false));
        parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));
        parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));

        //**************************I N T E R N A L  G A I N S ************************
        // persons
        parameter Real RatioConvectiveHeat_persons = 0.5
        "Ratio of convective heat from overall heat output for persons"                                        annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
        //lights
        parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        //electrical appliances
        parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        parameter Real coeffRadThermal_elApp = 0.75 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));

          //**************************E N E R G Y   S Y S T E M ************************
        parameter Boolean isEl_heater = true "is heater electrical? (heat pump)" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
        parameter Boolean isEl_cooler = true "is chiller electrical (chiller)"  annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
        parameter Real etaEl_heater = 2.5 "electrical efficiency of heater" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
        parameter Real etaEl_cooler = 3.0 "electrical efficiency of chiller" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
        Room_intGain room_intGain(
          redeclare package AirModel = AirModel,
          room_length=room_length,
          room_width=room_width,
          room_height=room_height,
          wallType_OW1=wallType_OW1,
          wallType_IW1=wallType_IW1,
          wallType_IW2=wallType_IW2,
          wallType_IW3=wallType_IW3,
          wallType_CE=wallType_CE,
          wallType_FL=wallType_FL,
          windowarea_OW1=windowarea_OW1,
          Type_Win=Type_Win,
          withSmartFacade=withSmartFacade,
          withMechVent=withMechVent,
          withPV=withPV,
          withSolAirHeat=withSolAirHeat,
          NrPVpanels=NrPVpanels,
          dataPV=dataPV,
          PelPV_max=PelPV_max,
          heatLoadForActivity=heatLoadForActivity,
          occupationDensity=occupationDensity,
          spPelSurface_lights=spPelSurface_lights,
          spPelSurface_elApp=spPelSurface_elApp,
          solar_absorptance_OW=solar_absorptance_OW,
          ModelConvOW=ModelConvOW,
          n50=n50,
          e=e,
          eps=eps,
          use_sunblind=use_sunblind,
          ratioSunblind=ratioSunblind,
          solIrrThreshold=solIrrThreshold,
          TOutAirLimit=TOutAirLimit,
          withHeatBridge=withHeatBridge,
          psiHor=psiHor,
          psiVer=psiVer,
          RatioConvectiveHeat_Persons=RatioConvectiveHeat_persons,
          coeffThermal_lights=coeffThermal_lights,
          coeffRadThermal_lights=coeffRadThermal_lights,
          coeffThermal_elApp=coeffThermal_elApp,
          coeffRadThermal_elApp=coeffRadThermal_elApp)
          annotation (Placement(transformation(extent={{-30,14},{32,72}})));
        Components.EnergySystem.IdealHeaterCooler.HeaterCoolerPI_withPel
          heaterCoolerPI_withPel(
          h_heater=Pmax_heater,
          isEl_heater=isEl_heater,
          isEl_cooler=isEl_cooler,
          etaEl_heater=etaEl_heater,
          etaEl_cooler=etaEl_cooler,
          h_cooler=0,
          l_cooler=-Pmax_chiller)
          annotation (Placement(transformation(extent={{-36,-42},{10,2}})));
        Components.Controls.Cooler cooler(T_room_Threshold=Tset_chiller)
          annotation (Placement(transformation(extent={{-52,-88},{-24,-62}})));
        Components.Controls.Heater heater(Toutside_Threshold=Tout_isHeatOn, Tset=
              Tset_heater)
          annotation (Placement(transformation(extent={{-6,-90},{22,-62}})));
        AixLib.Utilities.Interfaces.SolarRad_in solRadPort_Facade1
          annotation (Placement(transformation(extent={{-104,78},{-84,98}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_lights "from 0 to 1"
          annotation (Placement(transformation(extent={{-120,-66},{-80,-26}}),
              iconTransformation(extent={{-100,-24},{-80,-4}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_Occupants "from 0 to 1"
          annotation (Placement(transformation(extent={{-120,-108},{-80,-68}}),
              iconTransformation(extent={{-100,-50},{-80,-30}})));
        Modelica.Blocks.Interfaces.BooleanInput isChillerOn
          "On/Off switch for the chiller" annotation (Placement(transformation(
              extent={{-15,-15},{15,15}},
              rotation=90,
              origin={-45,-101}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-50,-96})));
        Modelica.Blocks.Interfaces.BooleanInput isHeaterOn
          "On/Off switch for the heater" annotation (Placement(transformation(
              extent={{-15,-15},{15,15}},
              rotation=90,
              origin={3,-99}),    iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-6,-94})));
        Modelica.Blocks.Interfaces.RealOutput Troom
          "Absolute temperature as output signal" annotation (Placement(
              transformation(extent={{78,-2},{98,18}}), iconTransformation(extent={{
                  78,-2},{98,18}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_elAppliances "from 0 to 1"
          annotation (Placement(transformation(extent={{-120,-86},{-80,-46}}),
              iconTransformation(extent={{-100,-66},{-80,-46}})));
        BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
          annotation (Placement(transformation(extent={{-104,50},{-84,70}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
          "schedule mechanical ventilation"
          annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
              iconTransformation(extent={{-100,0},{-80,20}})));
        Modelica.Blocks.Sources.BooleanExpression switchToNight
          annotation (Placement(transformation(extent={{-54,-62},{-34,-42}})));
      equation
        connect(heaterCoolerPI_withPel.heatCoolRoom, room_intGain.thermRoom)
          annotation (Line(points={{7.7,-28.8},{16,-28.8},{16,-36},{22,-36},{22,10},{
                -0.24,10},{-0.24,15.74}}, color={191,0,0}));
        connect(room_intGain.solRadPort_Facade, solRadPort_Facade1) annotation (Line(
              points={{-28.14,66.2},{-60,66.2},{-60,88},{-94,88}}, color={255,128,0}));
        connect(room_intGain.Schedule_lights, Schedule_lights) annotation (Line(
              points={{-26.59,34.01},{-60,34.01},{-60,-46},{-100,-46}}, color={0,0,
                127}));
        connect(room_intGain.Schedule_Occupants, Schedule_Occupants) annotation (Line(
              points={{-26.59,26.47},{-60,26.47},{-60,-88},{-100,-88}}, color={0,0,
                127}));
        connect(cooler.isOn, isChillerOn) annotation (Line(points={{-51.44,-63.69},{
                -60,-63.69},{-60,-101},{-45,-101}}, color={255,0,255}));
        connect(heater.isOn, isHeaterOn) annotation (Line(points={{-5.44,-63.82},{-10,
                -63.82},{-10,-99},{3,-99}},     color={255,0,255}));
        connect(room_intGain.Troom, Troom) annotation (Line(points={{31.38,43},{38,43},
                {38,8},{88,8}}, color={0,0,127}));
        connect(room_intGain.Schedule_elAppliances, Schedule_elAppliances)
          annotation (Line(points={{-26.59,18.35},{-60,18.35},{-60,-66},{-100,-66}},
              color={0,0,127}));
        connect(room_intGain.weaBus, weaBus) annotation (Line(
            points={{-28.76,59.82},{-86,59.82},{-86,60},{-94,60}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(cooler.Toutside, weaBus.TDryBul) annotation (Line(points={{-51.615,-75.585},
                {-60,-75.585},{-60,60},{-94,60}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(heater.Toutside, weaBus.TDryBul) annotation (Line(points={{-5.615,-76.63},
                {-10,-76.63},{-10,-100},{-60,-100},{-60,60},{-94,60}}, color={0,0,127}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        if withMechVent then
          connect(room_intGain.Schedule_mechVent, Schedule_mechVent) annotation (Line(
              points={{-26.9,42.42},{-60,42.42},{-60,0},{-100,0}},     color={0,0,127}));
        end if;
        connect(switchToNight.y, heater.switchToNightMode) annotation (Line(points={{
                -33,-52},{-24,-52},{-24,-68.125},{-5.93,-68.125}}, color={255,0,255}));
        connect(switchToNight.y, cooler.switchToNightMode) annotation (Line(points={{
                -33,-52},{-24,-52},{-24,-67.6875},{-51.93,-67.6875}}, color={255,0,
                255}));
        connect(cooler.ControlBus, heaterCoolerPI_withPel.ControlBus_idealCooler)
          annotation (Line(
            points={{-24.035,-72.075},{-16,-72.075},{-16,-50},{-7.71,-50},{-7.71,
                -39.8}},
            color={255,204,51},
            thickness=0.5));
        connect(heater.ControlBus, heaterCoolerPI_withPel.ControlBus_idealHeater)
          annotation (Line(
            points={{21.965,-72.85},{28,-72.85},{28,-50},{-23.35,-50},{-23.35,-40.24}},
            color={255,204,51},
            thickness=0.5));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Bitmap(extent={{-76,-86},{82,84}}, fileName=
                    "modelica://AixLib/Resources/Images/PnH/PnH_Logo.png")}),    Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
      end Room_EnergySyst;

      model Room_intGain "Room with internal gains"
            //  * * * * * * * * * * * * G  E  N  E  R  A  L * * * * * * * * * * * *
        replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);
          //**************************E N V E L O P E ************************
          // room geometry
        parameter Modelica.SIunits.Length room_length=5 "room length"
          annotation (Dialog(group="Envelope", descriptionLabel=true));
        parameter Modelica.SIunits.Length room_width=3 "room width"
          annotation (Dialog(group="Envelope", descriptionLabel=true));
        parameter Modelica.SIunits.Height room_height=3 "room height"
          annotation (Dialog(group="Envelope", descriptionLabel=true));

        //wall types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_OW1= AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() "wall type OW1"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW1=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW1"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW2=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() "wall type IW2"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW3=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW3"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_CE=AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() "wall type Ceiling"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_FL=AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() "wall type Floor"
          annotation (Dialog(group= "Envelope", descriptionLabel=true));

        // window
        parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (
            Dialog(
            group="Envelope",
            descriptionLabel=true,
            enable=withWindow1));
        parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "window type"
            annotation (Dialog(group="Envelope"));

       //**************************S M A R T   F A C A D E ************************
        // smart facade
        parameter Boolean withSmartFacade = false annotation (Dialog( group = "Smart Facade", enable = outside), choices(checkBox=true));
        // Mechanical ventilation
        parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        // PV
        parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        //solar air heater
        parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
        parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(group = "Smart Facade", enable = withPV));
        parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                       "PV data set" annotation(Dialog(group = "Smart Facade", enable = withPV));
        parameter Modelica.SIunits.Power PelPV_max = 4000
          "Maximum output power for inverter" annotation(Dialog(group = "Smart Facade", enable = withPV));

        //**************************I N T E R N A L  G A I N S ************************
        // persons
        parameter Modelica.SIunits.Power heatLoadForActivity = 80 "Sensible heat output occupants for activity at 20°C" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
        parameter Real occupationDensity = 0.2 "Density of occupants in persons/m2" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
        // lights
        parameter Real spPelSurface_lights(unit = "W/m2") =  22 "specific Pel/m2 for type of light source" annotation(Dialog(group = "Internal gains",descriptionLabel = true));
        //electrical appliances
        parameter Real spPelSurface_elApp(unit = "W/m2") =  22 "specific Pel/m2 for type of el. appliances" annotation(Dialog(group = "Internal gains",descriptionLabel = true));

        //  * * * * * * * * * * A  D  V  A  N  C  E  D * * * * * * * * * * * *
        //**************************E N V E L O P E ************************
        // Outer walls properties
        parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
          annotation (Dialog(tab = "Advanced", group="Envelope", descriptionLabel=true));

        parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
            tab = "Advanced", group="Envelope",
            compact=true,
            descriptionLabel=true), choices(
            choice=1 "DIN 6946",
            choice=2 "ASHRAE Fundamentals",
            choice=3 "Custom alpha",
            radioButtons=true));
          // Infiltration rate
        parameter Real n50(unit="h-1") = 3 "Air exchange rate at 50 Pa pressure differencefor infiltration "
          annotation (Dialog(tab = "Advanced", group="Envelope"));
        parameter Real e=0.02 "Coefficient of windshield for infiltration"
          annotation (Dialog(tab = "Advanced", group="Envelope"));
        parameter Real eps=1.0 "Coefficient of height for infiltration"
          annotation (Dialog(tab = "Advanced", group="Envelope"));
          // Sunblind
        parameter Boolean use_sunblind = false
          "Will sunblind become active automatically?"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
          "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
          "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
          annotation(Dialog(tab = "Advanced", group="Envelope"));
        parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
          "Temperature at which sunblind closes (see also solIrrThreshold)"
          annotation(Dialog(tab = "Advanced", group="Envelope"));

         // Heat bridge
        parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(tab = "Advanced", group = "Envelope", enable= outside, compact = false));
        parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));
        parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));

        //**************************I N T E R N A L  G A I N S ************************
        // persons
        parameter Real RatioConvectiveHeat_Persons = 0.5
        "Ratio of convective heat from overall heat output for persons"                                        annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
        //lights
        parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        //electrical appliances
        parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
        parameter Real coeffRadThermal_elApp = 0.75 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
        Components.Rooms.Room room(
          room_length=room_length,
          room_width=room_width,
          room_height=room_height,
          solar_absorptance_OW=solar_absorptance_OW,
          ModelConvOW=ModelConvOW,
          redeclare package AirModel = AirModel,
          windowarea_OW1=windowarea_OW1,
          use_sunblind=use_sunblind,
          ratioSunblind=ratioSunblind,
          solIrrThreshold=solIrrThreshold,
          TOutAirLimit=TOutAirLimit,
          Type_OW=wallType_OW1,
          wallType_IW1=wallType_IW1,
          wallType_IW2=wallType_IW2,
          wallType_IW3=wallType_IW3,
          Type_FL=wallType_FL,
          Type_CE=wallType_CE,
          Type_Win=Type_Win,
          n50=n50,
          e=e,
          eps=eps,
          withHeatBridge=withHeatBridge,
          psiHor=psiHor,
          psiVer=psiVer,
          withSolAirHeat=withSolAirHeat,
          NrPVpanels=NrPVpanels,
          dataPV=dataPV,
          PelPV_max=PelPV_max,
          withPV=true,
          withSmartFacade=withSmartFacade,
          withMechVent=withMechVent)
          annotation (Placement(transformation(extent={{-24,16},{26,66}})));
        Components.InternalGains.Facilities.Facilities facilities(
          zoneArea=room_length*room_width,
          spPelSurface_elApp=spPelSurface_elApp,
          coeffThermal_elApp=coeffThermal_elApp,
          coeffRadThermal_elApp=coeffRadThermal_elApp,
          spPelSurface_lights=spPelSurface_lights,
          coeffThermal_lights=coeffThermal_lights,
          coeffRadThermal_lights=coeffRadThermal_lights)
          annotation (Placement(transformation(extent={{-60,-44},{-20,-8}})));
        Components.InternalGains.Occupants.Occupants occupants(ZoneArea=room.room_width
              *room.room_length,
          heatLoadForActivity=heatLoadForActivity,
          occupationDensity=occupationDensity,
          RatioConvectiveHeat=RatioConvectiveHeat_Persons)
          annotation (Placement(transformation(extent={{14,-42},{46,-10}})));
        AixLib.Utilities.Interfaces.SolarRad_in solRadPort_Facade
          annotation (Placement(transformation(extent={{-104,70},{-84,90}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[5](
          Q_flow=fill(0, 5),
          T_ref=fill(20, 5),
          alpha=fill(0, 5))
          annotation (Placement(transformation(extent={{68,32},{46,54}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_Occupants "from 0 to 1"
          annotation (Placement(transformation(extent={{-120,-112},{-80,-72}}),
              iconTransformation(extent={{-100,-68},{-78,-46}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_lights "from 0 to 1"
          annotation (Placement(transformation(extent={{-120,-56},{-80,-16}}),
              iconTransformation(extent={{-100,-42},{-78,-20}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
          annotation (Placement(transformation(extent={{62,-10},{82,10}})));
        Modelica.Blocks.Interfaces.RealOutput Troom
          "Absolute temperature as output signal"
          annotation (Placement(transformation(extent={{88,-10},{108,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
          annotation (Placement(transformation(extent={{-14,-104},{6,-84}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_elAppliances "from 0 to 1"
          annotation (Placement(transformation(extent={{-120,-84},{-80,-44}}),
              iconTransformation(extent={{-100,-96},{-78,-74}})));
        AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
          annotation (Placement(transformation(extent={{-106,48},{-86,68}})));
        Modelica.Blocks.Sources.Constant source_personsHumidity(k=0)
          "temporary model for humidity output of persons"
          annotation (Placement(transformation(extent={{20,-66},{40,-46}})));
        Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
          "schedule mechanical ventilation" annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=0,
              origin={-100,-4}),  iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-90,-2})));
      equation
        connect(room.SolarRadiationPort_OW1, solRadPort_Facade) annotation (Line(
              points={{-23.875,56},{-24,56},{-24,54},{-40,54},{-40,80},{-94,80}},
              color={255,128,0}));
        connect(room.thermInsideWall1, fixedHeatFlow[1].port) annotation (Line(points=
               {{8.5,63.5},{8.5,80},{40,80},{40,43},{46,43}}, color={191,0,0}));
        connect(room.thermCeiling, fixedHeatFlow[2].port) annotation (Line(points={{
                23.5,58.5},{40,58.5},{40,43},{46,43}}, color={191,0,0}));
        connect(room.thermInsideWall2b, fixedHeatFlow[3].port) annotation (Line(
              points={{23.5,38.5},{40,38.5},{40,43},{46,43}}, color={191,0,0}));
        connect(room.thermInsideWall3, fixedHeatFlow[4].port) annotation (Line(points=
               {{12,17.5},{12,10},{40,10},{40,43},{46,43}}, color={191,0,0}));
        connect(room.ground, fixedHeatFlow[5].port) annotation (Line(points={{-0.5,
                17.5},{-0.5,10},{40,10},{40,43},{46,43}}, color={191,0,0}));
        connect(occupants.ConvHeat, room.thermRoom) annotation (Line(points={{44.4,
                -18},{50,-18},{50,0},{-4,0},{-4,46}}, color={191,0,0}));
        connect(occupants.RadHeat, room.starRoom) annotation (Line(points={{44.4,
                -27.6},{50,-27.6},{50,0},{-4,0},{-4,38},{6,38},{6,46}}, color={95,95,
                95}));
        connect(occupants.Schedule, Schedule_Occupants) annotation (Line(points={{
                15.44,-27.76},{0,-27.76},{0,-92},{-100,-92}}, color={0,0,127}));
        connect(facilities.Schedule_lights, Schedule_lights) annotation (Line(points=
                {{-58,-31.4},{-76,-31.4},{-76,-36},{-100,-36}}, color={0,0,127}));
        connect(facilities.ConvHeat[1], room.thermRoom) annotation (Line(points={{-22,
                -14.3},{-14,-14.3},{-14,-14},{-4,-14},{-4,46}}, color={191,0,0}));
        connect(facilities.ConvHeat[2], room.thermRoom) annotation (Line(points={{-22,
                -12.5},{-14,-12.5},{-14,-14},{-4,-14},{-4,46}}, color={191,0,0}));
        connect(facilities.RadHeat[1], room.starRoom) annotation (Line(points={{-22,
                -21.5},{-14,-21.5},{-14,-20},{-4,-20},{-4,38},{6,38},{6,46}}, color={
                95,95,95}));
        connect(facilities.RadHeat[2], room.starRoom) annotation (Line(points={{-22,
                -19.7},{-4,-19.7},{-4,38},{6,38},{6,46}}, color={95,95,95}));
        connect(room.thermRoom, temperatureSensor.port)
          annotation (Line(points={{-4,46},{-4,0},{62,0}}, color={191,0,0}));
        connect(temperatureSensor.T, Troom)
          annotation (Line(points={{82,0},{98,0}}, color={0,0,127}));
        connect(Troom, occupants.TAirZone) annotation (Line(points={{98,0},{100,0},{
                100,-100},{0,-100},{0,-28},{8,-28},{8,-14.8},{15.6,-14.8}}, color={0,
                0,127}));
        connect(room.thermRoom, thermRoom)
          annotation (Line(points={{-4,46},{-4,-94}}, color={191,0,0}));
        connect(facilities.Schedule_elAppliances, Schedule_elAppliances) annotation (
            Line(points={{-58,-24.2},{-76,-24.2},{-76,-64},{-100,-64},{-100,-64}},
              color={0,0,127}));
        connect(room.weaBus, weaBus) annotation (Line(
            points={{-23.5,41},{-40,41},{-40,80},{-72,80},{-72,58},{-96,58}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(source_personsHumidity.y, room.mWat_flow) annotation (Line(points={{
                41,-56},{50,-56},{50,0},{20,0},{20,17.5}}, color={0,0,127}));
        if withMechVent then
          connect(Schedule_mechVent, room.Schedule_mechVent) annotation (Line(points={{-100,
                -4},{-40,-4},{-40,23.5},{-21.5,23.5}}, color={0,0,127}));
        end if;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                extent={{-80,82},{80,-78}},
                lineColor={12,176,191},
                fillColor={170,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-72,54},{70,-54}},
                lineColor={12,176,191},
                fillColor={170,255,255},
                fillPattern=FillPattern.None,
                textString="Room Envelope
+
Internal Gains")}),                                                    Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
      end Room_intGain;
    end Aggregation;

    package Examples
    extends Modelica.Icons.ExamplesPackage;

      model Test
        extends Modelica.Icons.Example;
        Aggregation.Room_EnergySyst room_EnergySyst(
          room_length=parameters.room_length,
          room_width=parameters.room_width,
          room_height=parameters.room_height,
          wallType_OW1=parameters.wallType_OW1,
          wallType_IW1=parameters.wallType_IW1,
          wallType_IW2=parameters.wallType_IW2,
          wallType_IW3=parameters.wallType_IW3,
          wallType_CE=parameters.wallType_CE,
          wallType_FL=parameters.wallType_FL,
          windowarea_OW1=parameters.windowarea_OW1,
          Type_Win=parameters.Type_Win,
          withSmartFacade=parameters.withSmartFacade,
          withMechVent=parameters.withMechVent,
          withPV=parameters.withPV,
          withSolAirHeat=parameters.withSolAirHeat,
          NrPVpanels=parameters.NrPVpanels,
          dataPV=parameters.dataPV,
          PelPV_max=parameters.PelPV_max,
          heatLoadForActivity=parameters.heatLoadForActivity,
          occupationDensity=parameters.occupationDensity,
          spPelSurface_lights=parameters.spPelSurface_lights,
          spPelSurface_elApp=parameters.spPelSurface_elApp,
          Pmax_heater=parameters.Pmax_heater,
          Tset_heater=parameters.Tset_heater,
          Tout_isHeatOn=parameters.Tout_isHeatOn,
          Tset_chiller=parameters.Tset_chiller,
          Pmax_chiller=parameters.Pmax_chiller,
          solar_absorptance_OW=parameters.solar_absorptance_OW,
          ModelConvOW=parameters.ModelConvOW,
          n50=parameters.n50,
          e=parameters.e,
          eps=parameters.eps,
          use_sunblind=parameters.use_sunblind,
          ratioSunblind=parameters.ratioSunblind,
          solIrrThreshold=parameters.solIrrThreshold,
          TOutAirLimit=parameters.TOutAirLimit,
          withHeatBridge=parameters.withHeatBridge,
          psiHor=parameters.psiHor,
          psiVer=parameters.psiVer,
          RatioConvectiveHeat_persons=parameters.RatioConvectiveHeat_persons,
          coeffThermal_lights=parameters.coeffThermal_lights,
          coeffRadThermal_lights=parameters.coeffRadThermal_lights,
          coeffThermal_elApp=parameters.coeffThermal_elApp,
          coeffRadThermal_elApp=parameters.coeffRadThermal_elApp,
          isEl_heater=parameters.isEl_heater,
          isEl_cooler=parameters.isEl_cooler,
          etaEl_heater=parameters.etaEl_heater,
          etaEl_cooler=parameters.etaEl_cooler,
          redeclare package AirModel = Media.Air)
          annotation (Placement(transformation(extent={{10,4},{66,58}})));
        AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather weather(
          Wind_speed=true,
          Air_temp=true,
          Rel_hum=true,
          Wind_dir=true,
          Air_press=true,
          Mass_frac=false,
          fileName=parameters.weatherFileName)
          annotation (Placement(transformation(extent={{-100,28},{-48,62}})));
        Modelica.Blocks.Sources.CombiTimeTable schedule_occupants(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=parameters.schedulePersons.Profile)               "0...1"
          annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
        Modelica.Blocks.Sources.CombiTimeTable schedule_lights(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=parameters.scheduleLights.Profile)             "0...1"
          annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
        Modelica.Blocks.Sources.CombiTimeTable schedule_elAppliances(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=parameters.scheduleElAppliances.Profile,
          tableOnFile=false)                                         "0...1"
          annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
        Components.Parameters parameters(
          withSmartFacade=true,
          withMechVent=true,
          withPV=true,
          withSolAirHeat=true,
          Tset_heater=294.15,
          Tset_chiller=297.15)
          annotation (Placement(transformation(extent={{80,80},{100,100}})));
        BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
          annotation (Placement(transformation(extent={{-38,38},{-18,58}})));
        Modelica.Blocks.Sources.CombiTimeTable schedule_ventilation(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=parameters.scheduleMechVent.Profile)                "0...1 in 1/h"
          annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
        Modelica.Blocks.Sources.CombiTimeTable schedule_cooling(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=parameters.scheduleHVAC_cooling.Profile)        "0(off) or 1 (on)"
          annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
        Modelica.Blocks.Sources.CombiTimeTable schedule_heating(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=parameters.scheduleHVAC_heating.Profile)        "0(off) or 1 (on)"
          annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
        Modelica.Blocks.Math.RealToBoolean realToBoolean
          annotation (Placement(transformation(extent={{68,-56},{80,-44}})));
        Modelica.Blocks.Math.RealToBoolean realToBoolean1
          annotation (Placement(transformation(extent={{50,-76},{62,-64}})));
        Modelica.Blocks.Math.Gain gain(k=0.1)
          annotation (Placement(transformation(extent={{28,-94},{36,-86}})));
      equation
        connect(weather.SolarRadiation_OrientedSurfaces[1], room_EnergySyst.solRadPort_Facade1)
          annotation (Line(points={{-87.52,26.3},{-87.52,20},{-18,20},{-18,54.76},{
                11.68,54.76}},color={255,128,0}));
        connect(schedule_occupants.y[1], room_EnergySyst.Schedule_lights) annotation (
           Line(points={{-39,-50},{-18,-50},{-18,27.22},{12.8,27.22}},
              color={0,0,127}));
        connect(room_EnergySyst.weaBus, weaBus) annotation (Line(
            points={{11.68,47.2},{-13.16,47.2},{-13.16,48},{-28,48}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(weather.WindSpeed, weaBus.winSpe) annotation (Line(points={{
              -46.2667,55.2},{-40.1334,55.2},{-40.1334,48},{-28,48}},
                                                               color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(weather.AirTemp, weaBus.TDryBul) annotation (Line(points={{
              -46.2667,50.1},{-44,50.1},{-44,50},{-40,50},{-40,48},{-28,48}},
                                                                       color={0,0,127}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(weather.WindDirection, weaBus.winDir) annotation (Line(points={{
              -46.2667,60.3},{-44,60.3},{-44,60},{-40,60},{-40,54},{-28,54},{
              -28,48}},
              color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(weather.RelHumidity, weaBus.relHum) annotation (Line(points={{
              -46.2667,34.8},{-44,34.8},{-44,34},{-40,34},{-40,48},{-28,48},{
              -28,48}},
              color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(weather.AirPressure, weaBus.pAtm) annotation (Line(points={{
              -46.2667,45},{-44,45},{-44,46},{-40,46},{-40,48},{-28,48}},
                                                                   color={0,0,127}),
            Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(schedule_heating.y[1], realToBoolean.u)
          annotation (Line(points={{61,-50},{66.8,-50}}, color={0,0,127}));
        connect(realToBoolean.y, room_EnergySyst.isHeaterOn) annotation (Line(points=
                {{80.6,-50},{100,-50},{100,0},{36.32,0},{36.32,5.62}}, color={255,0,
                255}));
        connect(schedule_cooling.y[1], realToBoolean1.u)
          annotation (Line(points={{41,-70},{48.8,-70}}, color={0,0,127}));
        connect(realToBoolean1.y, room_EnergySyst.isChillerOn) annotation (Line(
              points={{62.6,-70},{100,-70},{100,0},{24,0},{24,5.08}}, color={255,0,
                255}));
        connect(schedule_lights.y[1], room_EnergySyst.Schedule_Occupants) annotation (
           Line(points={{-59,-70},{-18,-70},{-18,20.2},{12.8,20.2}}, color={0,0,127}));
        connect(schedule_elAppliances.y[1], room_EnergySyst.Schedule_elAppliances)
          annotation (Line(points={{-79,-90},{-18,-90},{-18,15.88},{12.8,15.88}},
              color={0,0,127}));
        connect(schedule_ventilation.y[1], gain.u)
          annotation (Line(points={{21,-90},{27.2,-90}}, color={0,0,127}));
        connect(gain.y, room_EnergySyst.Schedule_mechVent) annotation (Line(points={{
                36.4,-90},{100,-90},{100,0},{-18,0},{-18,33.7},{12.8,33.7}}, color={0,
                0,127}));
        annotation (experiment(StopTime=31536000, Interval=60),
                                                              Documentation(revisions=
               "<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
      end Test;
    end Examples;
  end PlugNHarvest;
  annotation (
  uses(
    Modelica(version="3.2.2"),
    Modelica_DeviceDrivers(version="1.4.4"),
    Modelica_Synchronous(version="0.92.1"),
    NcDataReader2(version="2.4.0"),
    SDF(version="0.4.0")),
  version = "0.7.4",
  conversion(from(
    version="0.3.2", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.3.2_to_0.4.mos",
    version="0.5.0", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.0_to_0.5.1.mos",
    version="0.5.2", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.2_to_0.5.3.mos",
    version="0.5.3", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.3_to_0.5.4.mos",
    version="0.5.4", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.5.4_to_0.5.5.mos",
    version="0.6.0", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.6.0_to_0.7.0.mos",
    version="0.7.3", script="modelica://AixLib/Resources/Scripts/ConvertAixLib_from_0.7.3_to_0.7.4.mos")),
  Documentation(info = "<html>
    <p>The free open-source <code>AixLib</code> library is being developed for research and teaching purposes. It aims at dynamic simulations of thermal and hydraulic systems to develop control strategies for HVAC systems and analyse interactions in complex systems. It is used for simulations on component, building and city district level. As this library is developed mainly for academic purposes, user-friendliness and model robustness is not a main task. This research focus thus influences the layout and philosophy of the library. </p>
    <p>Various connectors of the Modelica Standard Library are used, e.g. <code>Modelica.Fluid</code> and <code>Modelica.HeatTransfer</code>. These are accompanied by own connectors for simplified hydraulics (no <code>fluid.media</code>, incompressible, one phase) , shortwave radiation (intensity), longwave radiation (heat flow combined with a virtual temperature) and combined longwave radiation and thermal. The pressure in the connectors is the total pressure. The used media models are simplified from the <code>Modelica.Media</code> library. If possible and necessary, components use continuously differentiable equations. In general, zero mass flow rate and reverse flow are supported.</p>
    <p>Most models have been analytically verified. In addition, hydraulic components are compared to empirical data such as performance curves. High and low order building models have been validated using a standard test suite provided by the ANSI/ASHRAE Standard 140 and VDI 6007 Guideline. The library has only been tested with Dymola.</p>
    <p>The web page for this library is <a href=\"https://www.github.com/RWTH-EBC/AixLib\">https://www.github.com/RWTH-EBC/AixLib</a>. We welcome contributions from different users to further advance this library, whether it is through collaborative model development, through model use and testing or through requirements definition or by providing feedback regarding the model applicability to solve specific problems. </p>
    </html>"),
  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={Bitmap(extent={{-106,-100},{106,100}}, fileName = "modelica://AixLib/Resources/Images/Icon_Modelica_AixLib.png")}));
end AixLib;
model AixLib_PlugNHarvest_Examples_Test
 extends AixLib.PlugNHarvest.Examples.Test;
  annotation(experiment(StopTime=31536000, Interval=60),uses(AixLib(version="0.7.4")));
end AixLib_PlugNHarvest_Examples_Test;
