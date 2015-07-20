within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Linear;
model TestCase_9
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 273.15 + 22) annotation(Placement(transformation(extent = {{12, 9}, {26, 23}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{28, -10}, {40, 2}})));
  Building.LowOrder.BaseClasses.SolarRadWeightedSum window_shortwave_rad_sum(n = 4, weightfactors = {0, 0, 7, 7}) annotation(Placement(transformation(extent={{32,62},
            {54,84}})));
  BaseClasses.EqAirTemp.EqAirTempSimple   eqAirTemp(aowo = 0.7,                                                                      alphaowo = 25,
    wf_wall={0,0,0.057968311,0.132498994},
    wf_win={0,0,0.404766351,0.404766351})                                                                                                     annotation(Placement(transformation(extent={{-20,2},
            {0,22}})));
  Components.Weather.Sunblind sunblind(Imax = 100, gsunblind = {1, 1, 0.15, 0.15}) annotation(Placement(transformation(extent = {{-20, 62}, {0, 82}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelVDI
                                                  reducedModel(Ao = 25.5, Aw = 14, Ai = 60.5, epsi = 1, epso = 1, epsw = 1, g = 1, splitfac = 0.09, T0all(displayUnit = "degC"),                                                                               alphaiwi = 2.1, alphaowi = 2.7,
    R1i=0.000668640,
    C1i=1.23912e+007,
    RRest=0.020705927,
    R1o=0.001736253,
    C1o=5.2599e+006)                                                                                                     annotation(Placement(transformation(extent = {{38, 8}, {80, 46}})));
  Utilities.Sources.PrescribedSolarRad varRad3(n = 4) annotation(Placement(transformation(extent = {{-58, 63}, {-38, 83}})));
  Utilities.Sources.PrescribedSolarRad varRad1(n = 4) annotation(Placement(transformation(extent={{-64,23},
            {-44,43}})));
  Modelica.Blocks.Sources.CombiTimeTable windowRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, table = [0, 0, 0, 0, 0; 3600, 0, 0, 0, 0; 10800, 0, 0, 0, 0; 14400, 0, 0, 0, 0; 14400, 0, 0, 17, 17; 18000, 0, 0, 17, 17; 18000, 0, 0, 38, 36; 21600, 0, 0, 38, 36; 21600, 0, 0, 59, 51; 25200, 0, 0, 59, 51; 25200, 0, 0, 98, 64; 28800, 0, 0, 98, 64; 28800, 0, 0, 186, 74; 32400, 0, 0, 186, 74; 32400, 0, 0, 287, 84; 36000, 0, 0, 287, 84; 36000, 0, 0, 359, 92; 39600, 0, 0, 359, 92; 39600, 0, 0, 385, 100; 43200, 0, 0, 385, 100; 43200, 0, 0, 359, 180; 46800, 0, 0, 359, 180; 46800, 0, 0, 287, 344; 50400, 0, 0, 287, 344; 50400, 0, 0, 186, 475; 54000, 0, 0, 186, 475; 54000, 0, 0, 98, 528; 57600, 0, 0, 98, 528; 57600, 0, 0, 59, 492; 61200, 0, 0, 59, 492; 61200, 0, 0, 38, 359; 64800, 0, 0, 38, 359; 64800, 0, 0, 17, 147; 68400, 0, 0, 17, 147; 68400, 0, 0, 0, 0; 72000, 0, 0, 0, 0; 82800, 0, 0, 0, 0; 86400, 0, 0, 0, 0], columns = {2, 3, 4, 5}) annotation(Placement(transformation(extent = {{-88, 66}, {-74, 80}})));
  Modelica.Blocks.Sources.CombiTimeTable wallRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2, 3, 4, 5}, table = [0, 0, 0, 0, 0; 3600, 0, 0, 0, 0; 10800, 0, 0, 0, 0; 14400, 0, 0, 0, 0; 14400, 0, 0, 24, 23; 18000, 0, 0, 24, 23; 18000, 0, 0, 58, 53; 21600, 0, 0, 58, 53; 21600, 0, 0, 91, 77; 25200, 0, 0, 91, 77; 25200, 0, 0, 203, 97; 28800, 0, 0, 203, 97; 28800, 0, 0, 348, 114; 32400, 0, 0, 348, 114; 32400, 0, 0, 472, 131; 36000, 0, 0, 472, 131; 36000, 0, 0, 553, 144; 39600, 0, 0, 553, 144; 39600, 0, 0, 581, 159; 43200, 0, 0, 581, 159; 43200, 0, 0, 553, 372; 46800, 0, 0, 553, 372; 46800, 0, 0, 472, 557; 50400, 0, 0, 472, 557; 50400, 0, 0, 348, 685; 54000, 0, 0, 348, 685; 54000, 0, 0, 203, 733; 57600, 0, 0, 203, 733; 57600, 0, 0, 91, 666; 61200, 0, 0, 91, 666; 61200, 0, 0, 58, 474; 64800, 0, 0, 58, 474; 64800, 0, 0, 24, 177; 68400, 0, 0, 24, 177; 68400, 0, 0, 0, 0; 72000, 0, 0, 0, 0; 82800, 0, 0, 0, 0; 86400, 0, 0, 0, 0]) annotation(Placement(transformation(extent={{-98,26},
            {-84,40}})));
  Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, table = [0, 0, 0, 0, 18.8, 0, 0, 0, 343, -382, 0; 0.36, 0, 0, 0, 18.8, 0, 0, 0, 343, -382, 0; 3600, 0, 0, 0, 17.1, 0, 0, 0, 344, -384, 0; 7200, 0, 0, 0, 17.1, 0, 0, 0, 344, -384, 0; 7200, 0, 0, 0, 16.5, 0, 0, 0, 345, -384, 0; 10800, 0, 0, 0, 16.5, 0, 0, 0, 345, -384, 0; 10800, 0, 0, 0, 16.1, 0, 0, 0, 347, -381, 0; 14400, 0, 0, 0, 16.1, 0, 0, 0, 347, -381, 0; 14400, 0, 0, 0, 16.5, 0, 0, 0, 355, -406, 0; 18000, 0, 0, 0, 16.5, 0, 0, 0, 355, -406, 0; 18000, 0, 0, 0, 17.8, 0, 0, 0, 359, -422, 0; 21600, 0, 0, 0, 17.8, 0, 0, 0, 359, -422, 0; 21600, 0, 0, 0, 20.3, 0, 0, 0, 353, -448, 0; 25200, 0, 0, 0, 20.3, 0, 0, 0, 353, -448, 0; 25200, 0, 0, 0, 22.8, 0, 0, 0, 356, -472, 0; 28800, 0, 0, 0, 22.8, 0, 0, 0, 356, -472, 0; 28800, 0, 0, 0, 24.8, 0, 0, 0, 356, -499, 0; 32400, 0, 0, 0, 24.8, 0, 0, 0, 356, -499, 0; 32400, 0, 0, 0, 26.7, 0, 0, 0, 359, -519, 0; 36000, 0, 0, 0, 26.7, 0, 0, 0, 359, -519, 0; 36000, 0, 0, 0, 28.1, 0, 0, 0, 360, -537, 0; 39600, 0, 0, 0, 28.1, 0, 0, 0, 360, -537, 0; 39600, 0, 0, 0, 29, 0, 0, 0, 361, -553, 0; 43200, 0, 0, 0, 29, 0, 0, 0, 361, -553, 0; 43200, 0, 0, 0, 29.7, 0, 0, 0, 367, -552, 0; 46800, 0, 0, 0, 29.7, 0, 0, 0, 367, -552, 0; 46800, 0, 0, 0, 30.4, 0, 0, 0, 370, -550, 0; 50400, 0, 0, 0, 30.4, 0, 0, 0, 370, -550, 0; 50400, 0, 0, 0, 30.9, 0, 0, 0, 371, -544, 0; 54000, 0, 0, 0, 30.9, 0, 0, 0, 371, -544, 0; 54000, 0, 0, 0, 31, 0, 0, 0, 372, -533, 0; 57600, 0, 0, 0, 31, 0, 0, 0, 372, -533, 0; 57600, 0, 0, 0, 30.8, 0, 0, 0, 371, -519, 0; 61200, 0, 0, 0, 30.8, 0, 0, 0, 371, -519, 0; 61200, 0, 0, 0, 30.1, 0, 0, 0, 382, -495, 0; 64800, 0, 0, 0, 30.1, 0, 0, 0, 382, -495, 0; 64800, 0, 0, 0, 28.9, 0, 0, 0, 400, -474, 0; 68400, 0, 0, 0, 28.9, 0, 0, 0, 400, -474, 0; 68400, 0, 0, 0, 27, 0, 0, 0, 395, -445, 0; 72000, 0, 0, 0, 27, 0, 0, 0, 395, -445, 0; 72000, 0, 0, 0, 24.7, 0, 0, 0, 389, -436, 0; 75600, 0, 0, 0, 24.7, 0, 0, 0, 389, -436, 0; 75600, 0, 0, 0, 22.9, 0, 0, 0, 383, -427, 0; 79200, 0, 0, 0, 22.9, 0, 0, 0, 383, -427, 0; 79200, 0, 0, 0, 21.9, 0, 0, 0, 377, -418, 0; 82800, 0, 0, 0, 21.9, 0, 0, 0, 377, -418, 0; 82800, 0, 0, 0, 20.9, 0, 0, 0, 372, -408, 0; 86400, 0, 0, 0, 20.9, 0, 0, 0, 372, -408, 0], columns = {5, 9, 10}) annotation(Placement(transformation(extent = {{-88, 3}, {-74, 17}})));
  Modelica.Blocks.Routing.DeMultiplex3 deMultiplex3_1 annotation(Placement(transformation(extent = {{-68, 4}, {-56, 16}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC annotation(Placement(transformation(extent = {{-50, 11}, {-44, 17}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1 annotation(Placement(transformation(extent = {{-37, 4}, {-25, 16}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [3600, 22; 7200, 21.9; 10800, 21.9; 14400, 21.8; 18000, 22; 21600, 22.3; 25200, 22.7; 28800, 24.8; 32400, 24.7; 36000, 25.2; 39600, 25.6; 43200, 26.1; 46800, 25.9; 50400, 26.3; 54000, 26.6; 57600, 27.5; 61200, 27.6; 64800, 26; 68400, 25.8; 72000, 25.6; 75600, 25.6; 79200, 25.5; 82800, 25.5; 86400, 25.5; 781200, 37.6; 784800, 37.4; 788400, 37.3; 792000, 37.1; 795600, 37.1; 799200, 37.3; 802800, 37.5; 806400, 39.6; 810000, 39.4; 813600, 39.7; 817200, 40; 820800, 40.3; 824400, 40; 828000, 40.3; 831600, 40.5; 835200, 41.3; 838800, 41.3; 842400, 39.6; 846000, 39.2; 849600, 38.9; 853200, 38.8; 856800, 38.7; 860400, 38.5; 864000, 38.4; 5101200, 40.8; 5104800, 40.6; 5108400, 40.4; 5112000, 40.2; 5115600, 40.2; 5119200, 40.4; 5122800, 40.5; 5126400, 42.6; 5130000, 42.3; 5133600, 42.6; 5137200, 42.9; 5140800, 43.2; 5144400, 42.9; 5148000, 43.2; 5151600, 43.4; 5155200, 44.1; 5158800, 44.1; 5162400, 42.3; 5166000, 42; 5169600, 41.6; 5173200, 41.5; 5176800, 41.3; 5180400, 41.2; 5184000, 41]) annotation(Placement(transformation(extent = {{80, 80}, {100, 99}})));
  Utilities.HeatTransfer.HeatToStar HeatTorStar(A = 2) annotation(Placement(transformation(extent = {{38, -96}, {58, -76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{2, -48}, {22, -28}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective annotation(Placement(transformation(extent = {{2, -68}, {22, -48}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative annotation(Placement(transformation(extent = {{2, -96}, {22, -76}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 80, 80, 200; 28800, 80, 80, 200; 32400, 80, 80, 200; 36000, 80, 80, 200; 39600, 80, 80, 200; 43200, 80, 80, 200; 46800, 80, 80, 200; 50400, 80, 80, 200; 54000, 80, 80, 200; 57600, 80, 80, 200; 61200, 80, 80, 200; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0], columns = {2, 3, 4}) annotation(Placement(transformation(extent = {{-66, -68}, {-46, -48}})));
  BaseClasses.SolarRadAdapter solarRadAdapter[4]
    annotation (Placement(transformation(extent={{8,62},{28,82}})));
  BaseClasses.SolarRadAdapter solarRadAdapter1[4]
    annotation (Placement(transformation(extent={{-44,24},{-24,44}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(sunblind.sunblindonoff, eqAirTemp.sunblindsig) annotation(Line(points={{-10,63},
          {-10,20}},                                                                                      color = {0, 0, 127}, smooth = Smooth.None));
  connect(outdoorTemp.y, deMultiplex3_1.u) annotation(Line(points = {{-73.3, 10}, {-69.2, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(deMultiplex3_1.y1[1], from_degC.u) annotation(Line(points = {{-55.4, 14.2}, {-52.7, 14.2}, {-52.7, 14}, {-50.6, 14}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(from_degC.y, multiplex3_1.u1[1]) annotation(Line(points = {{-43.7, 14}, {-39.95, 14}, {-39.95, 14.2}, {-38.2, 14.2}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(deMultiplex3_1.y2, multiplex3_1.u2) annotation(Line(points = {{-55.4, 10}, {-38.2, 10}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(deMultiplex3_1.y3, multiplex3_1.u3) annotation(Line(points = {{-55.4, 5.8}, {-38.2, 5.8}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(eqAirTemp.equalAirTemp, reducedModel.equalAirTemp) annotation(Line(points={{-0.2,
          6.4},{8,6.4},{8,27.76},{42.2,27.76}},                                                                                       color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points = {{26.7, 16}, {32, 16}, {32, 17.88}, {42.2, 17.88}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{40.6,-4},
          {48,-4},{48,9.9},{51.02,9.9}},                                                                                               color = {0, 0, 127}, smooth = Smooth.None));
  connect(multiplex3_1.y, eqAirTemp.weatherData) annotation(Line(points={{-24.4,
          10},{-22,10},{-22,12},{-18,12}},                                                          color = {0, 0, 127}, smooth = Smooth.None));
  connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation(Line(points={{57.1,
          -86},{74,-86},{74,9.9},{74.75,9.9}},                                                                                           color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(personsConvective.port, reducedModel.internalGainsConv) annotation(Line(points={{22,-58},
          {63.2,-58},{63.2,9.9}},                                                                                                  color = {191, 0, 0}, smooth = Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points={{22,-38},
          {63.2,-38},{63.2,9.9}},                                                                                                   color = {191, 0, 0}, smooth = Smooth.None));
  connect(innerLoads.y[3], machinesConvective.Q_flow) annotation(Line(points = {{-45, -58}, {-26, -58}, {-26, -38}, {2, -38}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[2], personsConvective.Q_flow) annotation(Line(points = {{-45, -58}, {2, -58}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[1], personsRadiative.Q_flow) annotation(Line(points = {{-45, -58}, {-26, -58}, {-26, -86}, {2, -86}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(personsRadiative.port, HeatTorStar.Therm) annotation(Line(points = {{22, -86}, {38.8, -86}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(windowRad.y, varRad3.I) annotation (Line(
      points={{-73.3,73},{-65.65,73},{-65.65,81.9},{-56.9,81.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, varRad3.I_dir) annotation (Line(
      points={{-73.3,73},{-65.65,73},{-65.65,78},{-57,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, varRad3.I_diff) annotation (Line(
      points={{-73.3,73},{-65.65,73},{-65.65,74},{-57,74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, varRad3.I_gr) annotation (Line(
      points={{-73.3,73},{-64.65,73},{-64.65,69.9},{-56.9,69.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, varRad3.AOI) annotation (Line(
      points={{-73.3,73},{-65.65,73},{-65.65,66},{-57,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, varRad1.I) annotation (Line(
      points={{-83.3,33},{-68.65,33},{-68.65,41.9},{-62.9,41.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, varRad1.I_dir) annotation (Line(
      points={{-83.3,33},{-67.65,33},{-67.65,38},{-63,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, varRad1.I_diff) annotation (Line(
      points={{-83.3,33},{-67.65,33},{-67.65,34},{-63,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, varRad1.I_gr) annotation (Line(
      points={{-83.3,33},{-68.65,33},{-68.65,29.9},{-62.9,29.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, varRad1.AOI) annotation (Line(
      points={{-83.3,33},{-68.65,33},{-68.65,26},{-63,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(window_shortwave_rad_sum.solarRad_in, solarRadAdapter.solarRad_out)
    annotation (Line(
      points={{33.1,73},{30,73},{30,72},{28,72}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varRad1.solarRad_out, solarRadAdapter1.solarRad_in) annotation (Line(
      points={{-45,33},{-45,34},{-43,34}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(solarRadAdapter1.solarRad_out, eqAirTemp.solarRad_in) annotation (
      Line(
      points={{-24,34},{-24,17.6},{-18.5,17.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varRad3.solarRad_out, sunblind.Rad_in) annotation (Line(
      points={{-39,73},{-28.5,73},{-28.5,73},{-19,73}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(sunblind.Rad_out, solarRadAdapter.solarRad_in) annotation (Line(
      points={{-1,73},{3.5,73},{3.5,72},{9,72}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(window_shortwave_rad_sum.solarRad_out, reducedModel.solarRad_in)
    annotation (Line(
      points={{52.9,73},{56,73},{56,58},{49.34,58},{49.34,44.86}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),
            graphics),
            Icon(graphics),
            experiment(StopTime = 5.184e+006, Interval = 3600),
            __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Linear/TestCase_9.mos"
        "Simulate and plot"),
            experimentSetupOutput(events = false),
            Documentation(revisions="<html>
<p><ul>
 <li><i>May 28, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul></p>
 <ul>
   <li><i>March, 2012&nbsp;</i>
          by Moritz Lauster:<br>
          Implemented</li>
 </ul>
 </html>", info = "<html>
 <p>Test Case 9 of the VDI6007:: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
 <p>Based on Test Case 8</p>
 <ul>
 <li>longwave radiation heat exchange is taken into account</li>
 </ul>
 <p><br>Reference: Room air temperature</p>
 <p>Variable path: <code>reducedModel.airload.T</code></p>
 <p><br><br>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"));
end TestCase_9;
