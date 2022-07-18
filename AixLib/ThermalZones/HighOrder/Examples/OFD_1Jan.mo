within AixLib.ThermalZones.HighOrder.Examples;
model OFD_1Jan "OFD with TMC, TIR and TRY"

  extends Modelica.Icons.Example;

  parameter Integer TIR=3 "Thermal Insulation Regulation" annotation (Dialog(
      group="Construction parameters",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EnEV_2009",
      choice=2 "EnEV_2002",
      choice=3 "WSchV_1995",
      choice=4 "WSchV_1984",
      radioButtons=true));

  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition VentilationProfile = AixLib.DataBase.Profiles.Ventilation2perDayMean05perH();
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition TSetProfile = AixLib.DataBase.Profiles.SetTemperaturesVentilation2perDay();
  Modelica.Blocks.Sources.CombiTimeTable NaturalVentilation(
    columns={2,3,4,5,7},                                                               extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = VentilationProfile.Profile) annotation(Placement(transformation(extent={{-53,59},{-73,79}})));
  Modelica.Blocks.Sources.CombiTimeTable TSet(columns = {2, 3, 4, 5, 6, 7}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = TSetProfile.Profile) annotation(Placement(transformation(extent={{-94,-2},{-114,18}})));
  Modelica.Blocks.Interfaces.RealOutput TAirRooms[10](unit = "degC") annotation(Placement(transformation(extent={{122,-57},{142,-37}}),    iconTransformation(extent={{101,-7},{117,9}})));
  Modelica.Blocks.Interfaces.RealOutput Toutside(unit = "degC") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={106,-77}),     iconTransformation(extent={{100,83},{116,99}})));
  Modelica.Blocks.Interfaces.RealOutput SolarRadiation[6](unit = "W/m2") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={127,-77}),     iconTransformation(extent={{100,63},{116,79}})));
  Modelica.Blocks.Interfaces.RealOutput VentilationSchedule[4] annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={64,-77}),      iconTransformation(extent={{101,-79},{117,-63}})));
  Modelica.Blocks.Interfaces.RealOutput TsetValvesSchedule[5](unit = "degC") annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={85,-77}),      iconTransformation(extent={{101,-99},{117,-83}})));
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

  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope OFD(
    redeclare DataBase.Walls.Collections.OFD.WSchV1995Heavy wallTypes,
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T0_air=294.15,
    TWalls_start=292.15,
    redeclare model WindowModel = Components.WindowsDoors.WindowSimple,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995 Type_Win,
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    use_infiltEN12831=true,
    n50=if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6,
    withDynamicVentilation=true,
    UValOutDoors=if TIR == 1 then 1.8 else 2.9) annotation (Placement(transformation(extent={{-35,-49},{60,46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside
    annotation (Placement(transformation(extent={{-4,53},{-16.5,66}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.EnergySystem.IdealHeaters.GroundFloor
    groundFloor
    annotation (Placement(transformation(extent={{-116,-94},{-76,-63}})));
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.EnergySystem.IdealHeaters.UpperFloor
    upperFloor
    annotation (Placement(transformation(extent={{-115,-58},{-75,-27}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToCombHeaters[9] annotation (Placement(transformation(extent={{-44,-23},{-58,-12}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tempGround[5](T=fill(273.15
         + 9, 5))
    annotation (Placement(transformation(extent={{-21.5,-84},{-9,-71}})));
equation
  // Romm Temperatures
  TAirRooms[1] =Modelica.Units.Conversions.to_degC(OFD.groundFloor_Building.Livingroom.airload.port.T);
  TAirRooms[2] =Modelica.Units.Conversions.to_degC(OFD.groundFloor_Building.Hobby.airload.port.T);
  TAirRooms[3] =Modelica.Units.Conversions.to_degC(OFD.groundFloor_Building.Corridor.airload.port.T);
  TAirRooms[4] =Modelica.Units.Conversions.to_degC(OFD.groundFloor_Building.WC_Storage.airload.port.T);
  TAirRooms[5] =Modelica.Units.Conversions.to_degC(OFD.groundFloor_Building.Kitchen.airload.port.T);
  TAirRooms[6] =Modelica.Units.Conversions.to_degC(OFD.upperFloor_Building.Bedroom.airload.port.T);
  TAirRooms[7] =Modelica.Units.Conversions.to_degC(OFD.upperFloor_Building.Children1.airload.port.T);
  TAirRooms[8] =Modelica.Units.Conversions.to_degC(OFD.upperFloor_Building.Corridor.airload.port.T);
  TAirRooms[9] =Modelica.Units.Conversions.to_degC(OFD.upperFloor_Building.Bath.airload.port.T);
  TAirRooms[10] =Modelica.Units.Conversions.to_degC(OFD.upperFloor_Building.Children2.airload.port.T);
  //SimulationData
  VentilationSchedule[1] = NaturalVentilation.y[1];
  VentilationSchedule[2] = NaturalVentilation.y[2];
  VentilationSchedule[3] = NaturalVentilation.y[3];
  VentilationSchedule[4] = NaturalVentilation.y[4];
  TsetValvesSchedule[1] =Modelica.Units.Conversions.to_degC(TSet.y[1]);
  TsetValvesSchedule[2] =Modelica.Units.Conversions.to_degC(TSet.y[2]);
  TsetValvesSchedule[3] =Modelica.Units.Conversions.to_degC(TSet.y[3]);
  TsetValvesSchedule[4] =Modelica.Units.Conversions.to_degC(TSet.y[4]);
  TsetValvesSchedule[5] =Modelica.Units.Conversions.to_degC(TSet.y[5]);
  Toutside =Modelica.Units.Conversions.to_degC(Weather.AirTemp);
  //SolarRadiation
  SolarRadiation[1] = Weather.SolarRadiation_OrientedSurfaces[1].I;
  SolarRadiation[2] = Weather.SolarRadiation_OrientedSurfaces[2].I;
  SolarRadiation[3] = Weather.SolarRadiation_OrientedSurfaces[3].I;
  SolarRadiation[4] = Weather.SolarRadiation_OrientedSurfaces[4].I;
  SolarRadiation[5] = Weather.SolarRadiation_OrientedSurfaces[5].I;
  SolarRadiation[6] = Weather.SolarRadiation_OrientedSurfaces[6].I;
  connect(Weather.WindSpeed, OFD.WindSpeedPort) annotation (Line(points={{75.4,80.6},{-48,80.6},{-48,32},{-39.75,32},{-39.75,31.75}},
                                                          color={0,0,127}));
  connect(tempOutside.port, OFD.thermOutside) annotation (Line(points={{-16.5,59.5},{-35,59.5},{-35,45.05}},
                                         color={191,0,0}));
  connect(tempOutside.T, Weather.AirTemp) annotation (Line(points={{-2.75,59.5},
          {22,59.5},{22,75.8},{75.4,75.8}}, color={0,0,127}));
  connect(Weather.SolarRadiation_OrientedSurfaces[1], OFD.North) annotation (
      Line(points={{113.48,53.4},{113.48,12.75},{62.85,12.75}},
                                                              color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[2], OFD.East) annotation (
      Line(points={{113.48,53.4},{113.48,-1.5},{62.85,-1.5}},   color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[3], OFD.South) annotation (
      Line(points={{113.48,53.4},{113.48,-15.75},{62.85,-15.75}},
                                                                color={255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[4], OFD.West) annotation (
      Line(points={{113.48,53.4},{113.48,-30},{62.85,-30}},       color={255,128,
          0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[5], OFD.SolarRadiationPort_RoofN)
    annotation (Line(points={{113.48,53.4},{113.48,41.25},{62.85,41.25}}, color=
         {255,128,0}));
  connect(Weather.SolarRadiation_OrientedSurfaces[6], OFD.SolarRadiationPort_RoofS)
    annotation (Line(points={{113.48,53.4},{113.48,27},{62.85,27}},       color=
         {255,128,0}));
  connect(NaturalVentilation.y[1], OFD.AirExchangePort[1]) annotation (Line(
        points={{-74,69},{-78,69},{-78,17.9318},{-39.75,17.9318}},   color={0,0,
          127}));
  connect(NaturalVentilation.y[1], OFD.AirExchangePort[6]) annotation (Line(
        points={{-74,69},{-78,69},{-78,22.25},{-39.75,22.25}},     color={0,0,127}));
  connect(NaturalVentilation.y[2], OFD.AirExchangePort[2]) annotation (Line(
        points={{-74,69},{-78,69},{-78,18.7955},{-39.75,18.7955}}, color={0,0,127}));
  connect(NaturalVentilation.y[2], OFD.AirExchangePort[7]) annotation (Line(
        points={{-74,69},{-78,69},{-78,23.1136},{-39.75,23.1136}}, color={0,0,127}));
  connect(NaturalVentilation.y[3], OFD.AirExchangePort[4]) annotation (Line(
        points={{-74,69},{-78,69},{-78,20.5227},{-39.75,20.5227}}, color={0,0,127}));
  connect(NaturalVentilation.y[3], OFD.AirExchangePort[9]) annotation (Line(
        points={{-74,69},{-78,69},{-78,24.8409},{-39.75,24.8409}}, color={0,0,127}));
  connect(NaturalVentilation.y[4], OFD.AirExchangePort[5]) annotation (Line(
        points={{-74,69},{-78,69},{-78,21.3864},{-39.75,21.3864}}, color={0,0,127}));
  connect(NaturalVentilation.y[4], OFD.AirExchangePort[10]) annotation (Line(
        points={{-74,69},{-78,69},{-78,25.7045},{-39.75,25.7045}}, color={0,0,127}));
  connect(NaturalVentilation.y[5], OFD.AirExchangePort[3]) annotation (Line(
        points={{-74,69},{-78,69},{-78,19.6591},{-39.75,19.6591}}, color={0,0,127}));
  connect(NaturalVentilation.y[5], OFD.AirExchangePort[8]) annotation (Line(
        points={{-74,69},{-78,69},{-78,23.9773},{-39.75,23.9773}}, color={0,0,127}));
  connect(NaturalVentilation.y[5], OFD.AirExchangePort[11]) annotation (Line(
        points={{-74,69},{-78,69},{-78,26.5682},{-39.75,26.5682}}, color={0,0,127}));
  connect(groundFloor.Con_Livingroom, heatStarToCombHeaters[1].portConv) annotation (Line(points={{-117,-67.5725},{-121,-67.5725},{-121,-67},{-124,-67},{-124,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(groundFloor.Rad_Livingroom, heatStarToCombHeaters[1].portRad) annotation (Line(points={{-117.077,-64.1625},{-121,-64.1625},{-121,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(groundFloor.Con_Hobby, heatStarToCombHeaters[2].portConv) annotation (Line(points={{-74.7692,-67.185},{-62,-67.185},{-62,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(groundFloor.Rad_Hobby, heatStarToCombHeaters[2].portRad) annotation (Line(points={{-74.9231,-63.155},{-66,-63.155},{-66,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(groundFloor.Con_Corridor, heatStarToCombHeaters[3].portConv) annotation (Line(points={{-74.8462,-76.0975},{-62,-76.0975},{-62,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(groundFloor.Rad_Corridor, heatStarToCombHeaters[3].portRad) annotation (Line(points={{-74.7692,-71.68},{-66,-71.68},{-66,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(groundFloor.Con_Storage, heatStarToCombHeaters[4].portConv) annotation (Line(points={{-74.3846,-85.01},{-62,-85.01},{-62,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(groundFloor.Rad_WC, heatStarToCombHeaters[4].portRad) annotation (Line(points={{-74.6154,-80.98},{-66,-80.98},{-66,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(groundFloor.Con_Kitchen, heatStarToCombHeaters[5].portConv) annotation (Line(points={{-117.231,-87.5675},{-124,-87.5675},{-124,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(groundFloor.Rad_Kitchen, heatStarToCombHeaters[5].portRad) annotation (Line(points={{-117.154,-83.15},{-121,-83.15},{-121,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(upperFloor.Con_Bedroom, heatStarToCombHeaters[6].portConv) annotation (Line(points={{-116.538,-33.355},{-124,-33.355},{-124,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(upperFloor.Rad_Bedroom, heatStarToCombHeaters[6].portRad) annotation (Line(points={{-116.385,-28.55},{-121,-28.55},{-121,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(upperFloor.Con_Chidlren1, heatStarToCombHeaters[7].portConv) annotation (Line(points={{-73.6154,-34.75},{-62,-34.75},{-62,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(upperFloor.Rad_Children1, heatStarToCombHeaters[7].portRad) annotation (Line(points={{-73.9231,-31.185},{-66,-31.185},{-66,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(upperFloor.Con_Bath, heatStarToCombHeaters[8].portConv) annotation (Line(points={{-73.6154,-53.04},{-62,-53.04},{-62,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(upperFloor.Rad_Bath, heatStarToCombHeaters[8].portRad) annotation (Line(points={{-73.4615,-48.7},{-66,-48.7},{-66,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(upperFloor.Con_Children2, heatStarToCombHeaters[9].portConv) annotation (Line(points={{-116.692,-50.405},{-124,-50.405},{-124,-20.9375},{-58,-20.9375}},    color={191,0,0}));
  connect(upperFloor.Rad_Children2, heatStarToCombHeaters[9].portRad) annotation (Line(points={{-116.385,-44.825},{-121,-44.825},{-121,-14.0625},{-58,-14.0625}},    color={95,95,95}));
  connect(tempGround.port, OFD.groundTemp) annotation (Line(points={{-9,-77.5},{12.5,-77.5},{12.5,-49}},
                              color={191,0,0}));
  connect(TSet.y[1], upperFloor.TSet_UF[1]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-5},{-136,-5},{-136,-28.1238},{-105.308,-28.1238}},
                                                                       color={0,
          0,127}));
  connect(TSet.y[1], groundFloor.TSet_GF[1]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-4},{-137,-4},{-137,-64.023},{-106.538,-64.023}},
                                                                         color={
          0,0,127}));
  connect(TSet.y[2], upperFloor.TSet_UF[2]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-5},{-136,-5},{-136,-27.2712},{-105.308,-27.2712}},
                                                                       color={0,
          0,127}));
  connect(TSet.y[2], groundFloor.TSet_GF[2]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-4},{-137,-4},{-137,-63.279},{-106.538,-63.279}},
                                                                         color={
          0,0,127}));
  connect(TSet.y[6], groundFloor.TSet_GF[3]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-4},{-137,-4},{-137,-62.535},{-106.538,-62.535}},
                                                                         color={
          0,0,127}));
  connect(TSet.y[4], upperFloor.TSet_UF[3]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-5},{-136,-5},{-136,-26.4187},{-105.308,-26.4187}},
                                                                       color={0,
          0,127}));
  connect(TSet.y[5], groundFloor.TSet_GF[4]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-4},{-137,-4},{-137,-61.791},{-106.538,-61.791}},
                                                                          color=
         {0,0,127}));
  connect(TSet.y[3], upperFloor.TSet_UF[4]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-5},{-136,-5},{-136,-25.5663},{-105.308,-25.5663}},
        color={0,0,127}));
  connect(TSet.y[3], groundFloor.TSet_GF[5]) annotation (Line(points={{-115,8},{-117,8},{-117,9},{-119,9},{-119,-4},{-137,-4},{-137,-61.047},{-106.538,-61.047}},
                                                                          color=
         {0,0,127}));
  connect(OFD.uppFloDown, OFD.groFloUp) annotation (Line(points={{-35,9.9},{-47,9.9},{-47,-1.5},{-35,-1.5}}, color={191,0,0}));
  connect(OFD.groFloDown, OFD.groPlateUp) annotation (Line(points={{-35,-28.1},{-41,-28.1},{-41,-28},{-47,-28},{-47,-39.5},{-35,-39.5}}, color={191,0,0}));
  connect(heatStarToCombHeaters[1].portConvRadComb, OFD.heatingToRooms[1]) annotation (Line(points={{-44,-17.5},{-40,-17.5},{-40,-19.1182},{-35,-19.1182}}, color={191,0,0}));
  connect(heatStarToCombHeaters[2].portConvRadComb, OFD.heatingToRooms[2]) annotation (Line(points={{-44,-17.5},{-40,-17.5},{-40,-18.2545},{-35,-18.2545}}, color={191,0,0}));
  connect(heatStarToCombHeaters[3].portConvRadComb, OFD.heatingToRooms[3]) annotation (Line(points={{-44,-17.5},{-41,-17.5},{-41,-17.3909},{-35,-17.3909}}, color={191,0,0}));
  connect(heatStarToCombHeaters[4].portConvRadComb, OFD.heatingToRooms[4]) annotation (Line(points={{-44,-17.5},{-41,-17.5},{-41,-16.5273},{-35,-16.5273}}, color={191,0,0}));
  connect(heatStarToCombHeaters[5].portConvRadComb, OFD.heatingToRooms[5]) annotation (Line(points={{-44,-17.5},{-40,-17.5},{-40,-15.6636},{-35,-15.6636}}, color={191,0,0}));
  connect(heatStarToCombHeaters[6].portConvRadComb, OFD.heatingToRooms[6]) annotation (Line(points={{-44,-17.5},{-40,-17.5},{-40,-14.8},{-35,-14.8}}, color={191,0,0}));
  connect(heatStarToCombHeaters[7].portConvRadComb, OFD.heatingToRooms[7]) annotation (Line(points={{-44,-17.5},{-40,-17.5},{-40,-13.9364},{-35,-13.9364}}, color={191,0,0}));
  connect(heatStarToCombHeaters[8].portConvRadComb, OFD.heatingToRooms[9]) annotation (Line(points={{-44,-17.5},{-41,-17.5},{-41,-12.2091},{-35,-12.2091}}, color={191,0,0}));
  connect(heatStarToCombHeaters[9].portConvRadComb, OFD.heatingToRooms[10]) annotation (Line(points={{-44,-17.5},{-41,-17.5},{-41,-11.3455},{-35,-11.3455}}, color={191,0,0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-170,-100},{170,100}},      grid = {1, 1}), graphics={              Rectangle(extent={{-123,86},{-84,26}},    lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{-120,72},{-84,34}},    lineColor={0,0,255},
          textString="1-Bedroom
2-Child1
3-Corridor
4-Bath
5-Child2",horizontalAlignment=TextAlignment.Left),                                                                                                                                                                                                        Text(extent={{-101,74},{-85,85}},
                                                                                                                                                                                                        lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "UF"), Rectangle(extent={{-166,86},{-124,26}},    lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{-141,74},{-125,85}},    lineColor = {0, 0, 255}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "GF"),                                                                                                                       Text(extent={{-163,72},{-124,35}},
                                                                                                                                                                                                        lineColor={0,0,255},
          textString="1-Livingroom
2-Hobby
3-Corridor
4-WC
5-Kitchen",
          horizontalAlignment=TextAlignment.Left)}),                                                                                                                                                                                                        Icon(coordinateSystem(preserveAspectRatio = true, extent={{-170,-100},{170,100}})),                               experiment(StopTime = 86400, Interval = 15, __Dymola_Algorithm = "Lsodar"), experimentSetupOutput(events = false), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Example for setting up a simulation for a one family dwelling.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Energy generation and delivery system consisting of boiler and pump.
</p>
<p>
  The example works for a day and shows how such a simulation can be
  set up. It is not guranteed that the model will work stable under
  sifferent conditions or for longer periods of time.
</p>
<ul>
  <li>
    <i>June 19, 2014</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"));
end OFD_1Jan;
