within AixLib.ThermalZones.HighOrder.Examples;
model OFD_1Jan "OFD with TMC, TIR and TRY"
  import AixLib;
  extends Modelica.Icons.Example;
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition VentilationProfile = AixLib.DataBase.Profiles.Ventilation2perDayMean05perH();
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition TSetProfile = AixLib.DataBase.Profiles.SetTemperaturesVentilation2perDay();
  inner Modelica.Fluid.System system annotation(Placement(transformation(extent = {{181, 78.5}, {200.5, 99.5}})));
  Modelica.Blocks.Sources.CombiTimeTable NaturalVentilation(columns = {2, 3, 4, 5, 6}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = VentilationProfile.Profile) annotation(Placement(transformation(extent={{-114,61},
            {-94,81}})));
  Modelica.Blocks.Sources.CombiTimeTable TSet(columns = {2, 3, 4, 5, 6, 7}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = TSetProfile.Profile) annotation(Placement(transformation(extent={{-114,26},
            {-94,46}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRooms[10](unit = "degC") annotation(Placement(transformation(extent={{181,-75},
            {201,-55}}),                                                                                                                   iconTransformation(extent = {{171, -29}, {187, -13}})));
  Modelica.Blocks.Interfaces.RealOutput Toutside(unit = "degC") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={142,-94}),     iconTransformation(extent = {{172, -95}, {188, -79}})));
  Modelica.Blocks.Interfaces.RealOutput SolarRadiation[6](unit = "W/m2") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={186,-95}),     iconTransformation(extent = {{172, -95}, {188, -79}})));
  Modelica.Blocks.Interfaces.RealOutput VentilationSchedule[4] annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={100,-94}),     iconTransformation(extent = {{171, -29}, {187, -13}})));
  Modelica.Blocks.Interfaces.RealOutput TsetValvesSchedule[5](unit = "degC") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={121,-94}),     iconTransformation(extent = {{171, -29}, {187, -13}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather Weather(
    Latitude=49.5,
    Longitude=8.5,
    GroundReflection=0.2,
    tableName="wetter",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),

    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true,
    fileName=
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",

    WeatherData(tableOnFile=false, table=weatherDataDay.weatherData))
    annotation (Placement(transformation(extent={{125,55},{77,87}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope
    OFD(TIR=3, withDynamicVentilation=true)
    annotation (Placement(transformation(extent={{-35,-48},{60,47}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside
    annotation (Placement(transformation(extent={{-4,53},{-16.5,66}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.EnergySystem.IdealHeaters.GroundFloor
    groundFloor
    annotation (Placement(transformation(extent={{-116,-94},{-76,-63}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.EnergySystem.IdealHeaters.UpperFloor
    upperFloor
    annotation (Placement(transformation(extent={{-115,-58},{-75,-27}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToCombHeaters[9]
    annotation (Placement(transformation(extent={{-42,-23},{-56,-12}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tempGround[5](T=fill(273.15
         + 9, 5))
    annotation (Placement(transformation(extent={{-12.5,-52},{0,-39}})));
equation
  // Romm Temperatures
  TAirRooms[1] = Modelica.SIunits.Conversions.to_degC(OFD.groundFloor_Building.Livingroom.airload.port.T);
  TAirRooms[2] = Modelica.SIunits.Conversions.to_degC(OFD.groundFloor_Building.Hobby.airload.port.T);
  TAirRooms[3] = Modelica.SIunits.Conversions.to_degC(OFD.groundFloor_Building.Corridor.airload.port.T);
  TAirRooms[4] = Modelica.SIunits.Conversions.to_degC(OFD.groundFloor_Building.WC_Storage.airload.port.T);
  TAirRooms[5] = Modelica.SIunits.Conversions.to_degC(OFD.groundFloor_Building.Kitchen.airload.port.T);
  TAirRooms[6] = Modelica.SIunits.Conversions.to_degC(OFD.upperFloor_Building.Bedroom.airload.port.T);
  TAirRooms[7] = Modelica.SIunits.Conversions.to_degC(OFD.upperFloor_Building.Children1.airload.port.T);
  TAirRooms[8] = Modelica.SIunits.Conversions.to_degC(OFD.upperFloor_Building.Corridor.airload.port.T);
  TAirRooms[9] = Modelica.SIunits.Conversions.to_degC(OFD.upperFloor_Building.Bath.airload.port.T);
  TAirRooms[10] = Modelica.SIunits.Conversions.to_degC(OFD.upperFloor_Building.Children2.airload.port.T);
  //SimulationData
  VentilationSchedule[1] = NaturalVentilation.y[1];
  VentilationSchedule[2] = NaturalVentilation.y[2];
  VentilationSchedule[3] = NaturalVentilation.y[3];
  VentilationSchedule[4] = NaturalVentilation.y[4];
  TsetValvesSchedule[1] = Modelica.SIunits.Conversions.to_degC(TSet.y[1]);
  TsetValvesSchedule[2] = Modelica.SIunits.Conversions.to_degC(TSet.y[2]);
  TsetValvesSchedule[3] = Modelica.SIunits.Conversions.to_degC(TSet.y[3]);
  TsetValvesSchedule[4] = Modelica.SIunits.Conversions.to_degC(TSet.y[4]);
  TsetValvesSchedule[5] = Modelica.SIunits.Conversions.to_degC(TSet.y[5]);
  Toutside = Modelica.SIunits.Conversions.to_degC(Weather.AirTemp);
  //SolarRadiation
  SolarRadiation[1] = Weather.SolarRadiation_OrientedSurfaces[1].I;
  SolarRadiation[2] = Weather.SolarRadiation_OrientedSurfaces[2].I;
  SolarRadiation[3] = Weather.SolarRadiation_OrientedSurfaces[3].I;
  SolarRadiation[4] = Weather.SolarRadiation_OrientedSurfaces[4].I;
  SolarRadiation[5] = Weather.SolarRadiation_OrientedSurfaces[5].I;
  SolarRadiation[6] = Weather.SolarRadiation_OrientedSurfaces[6].I;
  connect(Weather.WindSpeed, OFD.WindSpeedPort) annotation (Line(points={{75.4,80.6},
          {-58,80.6},{-58,25},{-32.15,25},{-32.15,24.2}}, color={0,0,127}));
  connect(tempOutside.port, OFD.thermOutside) annotation (Line(points={{-16.5,59.5},
          {-30.25,59.5},{-30.25,42.25}}, color={191,0,0}));
  connect(tempOutside.T, Weather.AirTemp) annotation (Line(points={{-2.75,59.5},
          {22,59.5},{22,75.8},{75.4,75.8}}, color={0,0,127}));
  connect(Weather.SolarRadiation_OrientedSurfaces[1], OFD.North) annotation (
      Line(points={{113.48,53.4},{113.48,8.05},{55.25,8.05}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[2], OFD.East) annotation (
      Line(points={{113.48,53.4},{113.48,-9.05},{55.25,-9.05}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[3], OFD.South) annotation (
      Line(points={{113.48,53.4},{113.48,-27.1},{55.25,-27.1}}, color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[4], OFD.West) annotation (
      Line(points={{113.48,53.4},{113.48,-43.25},{55.25,-43.25}}, color={255,128,
          0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[5], OFD.SolarRadiationPort_RoofN)
    annotation (Line(points={{113.48,53.4},{113.48,42.25},{55.25,42.25}}, color=
         {255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[6], OFD.SolarRadiationPort_RoofS)
    annotation (Line(points={{113.48,53.4},{113.48,27.05},{55.25,27.05}}, color=
         {255,128,0}));
  connect(NaturalVentilation.y[1], OFD.AirExchangePort[1]) annotation (Line(
        points={{-93,71},{-78,71},{-78,-1.56875},{-32.15,-1.56875}}, color={0,0,
          127}));
  connect(NaturalVentilation.y[1], OFD.AirExchangePort[5]) annotation (Line(
        points={{-93,71},{-78,71},{-78,5.08125},{-32.15,5.08125}}, color={0,0,127}));
  connect(NaturalVentilation.y[2], OFD.AirExchangePort[2]) annotation (Line(
        points={{-93,71},{-78,71},{-78,0.09375},{-32.15,0.09375}}, color={0,0,127}));
  connect(NaturalVentilation.y[2], OFD.AirExchangePort[6]) annotation (Line(
        points={{-93,71},{-78,71},{-78,6.74375},{-32.15,6.74375}}, color={0,0,127}));
  connect(NaturalVentilation.y[3], OFD.AirExchangePort[3]) annotation (Line(
        points={{-93,71},{-78,71},{-78,1.75625},{-32.15,1.75625}}, color={0,0,127}));
  connect(NaturalVentilation.y[3], OFD.AirExchangePort[7]) annotation (Line(
        points={{-93,71},{-78,71},{-78,8.40625},{-32.15,8.40625}}, color={0,0,127}));
  connect(NaturalVentilation.y[4], OFD.AirExchangePort[4]) annotation (Line(
        points={{-93,71},{-78,71},{-78,3.41875},{-32.15,3.41875}}, color={0,0,127}));
  connect(NaturalVentilation.y[4], OFD.AirExchangePort[8]) annotation (Line(
        points={{-93,71},{-78,71},{-78,10.0687},{-32.15,10.0687}}, color={0,0,127}));
  connect(heatStarToCombHeaters.thermStarComb, OFD.heatingToRooms) annotation (
      Line(points={{-42.42,-17.5688},{-36.68,-17.5688},{-36.68,-17.6},{-30.25,
          -17.6}},
        color={191,0,0}));
  connect(groundFloor.Con_Livingroom, heatStarToCombHeaters[1].therm)
    annotation (Line(points={{-117,-67.5725},{-121,-67.5725},{-121,-67},{-124,
          -67},{-124,-21.0063},{-56.07,-21.0063}},
                                              color={191,0,0}));
  connect(groundFloor.Rad_Livingroom, heatStarToCombHeaters[1].star)
    annotation (Line(points={{-117.077,-64.1625},{-121,-64.1625},{-121,-13.5125},
          {-56.28,-13.5125}}, color={95,95,95}));
  connect(groundFloor.Con_Hobby, heatStarToCombHeaters[2].therm) annotation (
      Line(points={{-74.7692,-67.185},{-62,-67.185},{-62,-21.0063},{-56.07,
          -21.0063}},
        color={191,0,0}));
  connect(groundFloor.Rad_Hobby, heatStarToCombHeaters[2].star) annotation (
      Line(points={{-74.9231,-63.155},{-66,-63.155},{-66,-13.5125},{-56.28,
          -13.5125}},
        color={95,95,95}));
  connect(groundFloor.Con_Corridor, heatStarToCombHeaters[3].therm) annotation (
     Line(points={{-74.8462,-76.0975},{-62,-76.0975},{-62,-21.0063},{-56.07,
          -21.0063}},
        color={191,0,0}));
  connect(groundFloor.Rad_Corridor, heatStarToCombHeaters[3].star) annotation (
      Line(points={{-74.7692,-71.68},{-66,-71.68},{-66,-13.5125},{-56.28,
          -13.5125}},
        color={95,95,95}));
  connect(groundFloor.Con_Storage, heatStarToCombHeaters[4].therm) annotation (
      Line(points={{-74.3846,-85.01},{-62,-85.01},{-62,-21.0063},{-56.07,
          -21.0063}},
        color={191,0,0}));
  connect(groundFloor.Rad_WC, heatStarToCombHeaters[4].star) annotation (Line(
        points={{-74.6154,-80.98},{-66,-80.98},{-66,-13.5125},{-56.28,-13.5125}},
        color={95,95,95}));
  connect(groundFloor.Con_Kitchen, heatStarToCombHeaters[5].therm) annotation (
      Line(points={{-117.231,-87.5675},{-124,-87.5675},{-124,-21.0063},{-56.07,
          -21.0063}},
        color={191,0,0}));
  connect(groundFloor.Rad_Kitchen, heatStarToCombHeaters[5].star) annotation (
      Line(points={{-117.154,-83.15},{-121,-83.15},{-121,-13.5125},{-56.28,
          -13.5125}},
        color={95,95,95}));
  connect(upperFloor.Con_Bedroom, heatStarToCombHeaters[6].therm) annotation (
      Line(points={{-116.538,-33.355},{-124,-33.355},{-124,-21.0063},{-56.07,
          -21.0063}},
        color={191,0,0}));
  connect(upperFloor.Rad_Bedroom, heatStarToCombHeaters[6].star) annotation (
      Line(points={{-116.385,-28.55},{-121,-28.55},{-121,-13.5125},{-56.28,
          -13.5125}},
        color={95,95,95}));
  connect(upperFloor.Con_Chidlren1, heatStarToCombHeaters[7].therm) annotation (
     Line(points={{-73.6154,-34.75},{-62,-34.75},{-62,-21.0063},{-56.07,
          -21.0063}},
        color={191,0,0}));
  connect(upperFloor.Rad_Children1, heatStarToCombHeaters[7].star) annotation (
      Line(points={{-73.9231,-31.185},{-66,-31.185},{-66,-13.5125},{-56.28,
          -13.5125}},
        color={95,95,95}));
  connect(upperFloor.Con_Bath, heatStarToCombHeaters[8].therm) annotation (Line(
        points={{-73.6154,-53.04},{-62,-53.04},{-62,-21.0063},{-56.07,-21.0063}},
        color={191,0,0}));
  connect(upperFloor.Rad_Bath, heatStarToCombHeaters[8].star) annotation (Line(
        points={{-73.4615,-48.7},{-66,-48.7},{-66,-13.5125},{-56.28,-13.5125}},
        color={95,95,95}));
  connect(upperFloor.Con_Children2, heatStarToCombHeaters[9].therm) annotation (
     Line(points={{-116.692,-50.405},{-124,-50.405},{-124,-21.0063},{-56.07,
          -21.0063}},
        color={191,0,0}));
  connect(upperFloor.Rad_Children2, heatStarToCombHeaters[9].star) annotation (
      Line(points={{-116.385,-44.825},{-121,-44.825},{-121,-13.5125},{-56.28,
          -13.5125}},
        color={95,95,95}));
  connect(tempGround.port, OFD.groundTemp) annotation (Line(points={{0,-45.5},{12.5,
          -45.5},{12.5,-29}}, color={191,0,0}));
  connect(TSet.y[1], upperFloor.TSet_UF[1]) annotation (Line(points={{-93,36},{
          -88,36},{-88,-5},{-136,-5},{-136,-28.1238},{-105.308,-28.1238}},
                                                                       color={0,
          0,127}));
  connect(TSet.y[1], groundFloor.TSet_GF[1]) annotation (Line(points={{-93,36},
          {-89,36},{-89,-4},{-137,-4},{-137,-64.023},{-106.538,-64.023}},color={
          0,0,127}));
  connect(TSet.y[2], upperFloor.TSet_UF[2]) annotation (Line(points={{-93,36},{
          -88,36},{-88,-5},{-136,-5},{-136,-27.2712},{-105.308,-27.2712}},
                                                                       color={0,
          0,127}));
  connect(TSet.y[2], groundFloor.TSet_GF[2]) annotation (Line(points={{-93,36},
          {-89,36},{-89,-4},{-137,-4},{-137,-63.279},{-106.538,-63.279}},color={
          0,0,127}));
  connect(TSet.y[6], groundFloor.TSet_GF[3]) annotation (Line(points={{-93,36},
          {-89,36},{-89,-4},{-137,-4},{-137,-62.535},{-106.538,-62.535}},color={
          0,0,127}));
  connect(TSet.y[4], upperFloor.TSet_UF[3]) annotation (Line(points={{-93,36},{
          -88,36},{-88,-5},{-136,-5},{-136,-26.4187},{-105.308,-26.4187}},
                                                                       color={0,
          0,127}));
  connect(TSet.y[5], groundFloor.TSet_GF[4]) annotation (Line(points={{-93,36},
          {-89,36},{-89,-4},{-137,-4},{-137,-61.791},{-106.538,-61.791}}, color=
         {0,0,127}));
  connect(TSet.y[3], upperFloor.TSet_UF[4]) annotation (Line(points={{-93,36},{
          -88,36},{-88,-5},{-136,-5},{-136,-25.5663},{-105.308,-25.5663}},
        color={0,0,127}));
  connect(TSet.y[3], groundFloor.TSet_GF[5]) annotation (Line(points={{-93,36},
          {-89,36},{-89,-4},{-137,-4},{-137,-61.047},{-106.538,-61.047}}, color=
         {0,0,127}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -100}, {200, 100}}, grid = {1, 1}), graphics={  Rectangle(extent={{
              -195,51},{-160,23}},                                                                                                                                              lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
              -155,86},{-120,58}},                                                                                                                                                        lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -167,81},{-117,79}},                                                                                                                                                   lineColor = {0, 0, 255}, textString = "1-Bedroom"), Text(extent={{
              -167,75},{-117,73}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Children1"), Text(extent={{
              -167,69},{-117,67}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-Bath"), Text(extent={{
              -167,63},{-117,61}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-Children2"), Text(extent={{
              -208,49},{-158,47}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "1-Livingroom"), Text(extent={{
              -208,43},{-158,41}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Hobby"), Text(extent={{
              -208,37},{-158,35}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-Corridor"), Text(extent={{
              -208,31},{-158,29}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-WC"), Text(extent={{
              -208,25},{-158,23}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "5-Kitchen"), Text(extent={{
              -135,74},{-119,85}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Rectangle(extent={{
              -195,86},{-160,58}},                                                                                                                                                                            lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -175,74},{-159,85}},                                                                                                                                                    lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"), Text(extent={{
              -207,77},{-157,75}},                                                                                                                                                                       lineColor = {0, 0, 255}, textString = "1-Livingroom"), Text(extent={{
              -207,71},{-157,69}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Hobby"), Text(extent={{
              -207,65},{-157,63}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-WC"), Text(extent={{
              -208,61},{-158,59}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-Kitchen"), Rectangle(extent={{
              -155,51},{-120,23}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -175,39},{-159,50}},                                                                                                                                                   lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"), Text(extent={{
              -135,39},{-119,50}},                                                                                                                                                                    lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Text(extent={{
              -164,46},{-114,44}},                                                                                                                                                                     lineColor = {0, 0, 255}, textString = "1-Bedroom"), Text(extent={{
              -164,40},{-114,38}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "2-Children1"), Text(extent={{
              -164,34},{-114,32}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "3-Bath"), Text(extent={{
              -164,28},{-114,26}},                                                                                                                                                                                                        lineColor = {0, 0, 255}, textString = "4-Children2")}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-200, -100}, {200, 100}}, grid = {1, 1}), graphics), experiment(StopTime = 86400, Interval = 15, __Dymola_Algorithm = "Lsodar"), experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example for setting up a simulation for a one family dwelling.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Energy generation and delivery system consisting of boiler and pump.</p>
 <p>The example works for a day and shows how such a simulation can be set up. It is not guranteed that the model will work stable under sifferent conditions or for longer periods of time.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>"));
end OFD_1Jan;
