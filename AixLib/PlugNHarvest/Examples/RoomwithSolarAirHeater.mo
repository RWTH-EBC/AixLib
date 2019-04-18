within AixLib.PlugNHarvest.Examples;
model RoomwithSolarAirHeater

  AixLib.ThermalZones.HighOrder.Rooms.ASHRAE140.EastWestFacingWindows
    eastWestFacingWindows(
    ratioSunblind=1,
    solIrrThreshold=100,
    Room_Lenght=5,
    Room_Width=5,
    Win_Area=4,
    TOutAirLimit=283.15)
    annotation (Placement(transformation(extent={{26,6},{86,76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedAmbTemperature
    annotation (Placement(transformation(extent={{-28,0},{-16,12}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather weather(
    Air_temp=true,
    Wind_dir=false,
    Wind_speed=true,
    fileName=
        "C:/Users/makis/Documents/Dymola/PnH_Greek_Pilot/Resources/grevena_TRY.txt")
    annotation (Placement(transformation(extent={{-92,62},{-62,82}})));
  PlugNHarvest.Components.SmartFacade.sahaix sahaix1
    annotation (Placement(transformation(extent={{20,-78},{-46,-12}})));
equation
  connect(prescribedAmbTemperature.port, eastWestFacingWindows.Therm_outside)
    annotation (Line(points={{-16,6},{6,6},{6,74.95},{24.5,74.95}}, color={191,
          0,0}));
  connect(prescribedAmbTemperature.port, eastWestFacingWindows.Therm_ground)
    annotation (Line(points={{-16,6},{16,6},{16,7.4},{46.4,7.4}},   color={191,
          0,0}));
  connect(weather.WindSpeed, eastWestFacingWindows.WindSpeedPort) annotation (
      Line(points={{-61,78},{-22,78},{-22,51.5},{23,51.5}}, color={0,0,127}));
  connect(prescribedAmbTemperature.T, weather.AirTemp)
    annotation (Line(points={{-29.2,6},{-61,6},{-61,75}},  color={0,0,127}));
  connect(weather.WindSpeed, eastWestFacingWindows.AER) annotation (Line(points={{-61,78},
          {-22,78},{-22,23.5},{23,23.5}},          color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces, eastWestFacingWindows.SolarRadiationPort)
    annotation (Line(points={{-84.8,61},{-33.4,61},{-33.4,62},{23,62}}, color={
          255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], sahaix1.solarRad_in)
    annotation (Line(points={{-84.8,61},{-84.8,-45},{-37.42,-45}}, color={255,
          128,0}));
  connect(weather.AirTemp, sahaix1.T_in) annotation (Line(points={{-61,75},{-61,
          -22.56},{-26.2,-22.56}}, color={0,0,127}));
  connect(sahaix1.port, eastWestFacingWindows.thermRoom) annotation (Line(
        points={{8.78,-44.78},{47.3,-44.78},{47.3,49.05}}, color={191,0,0}));
  annotation (                                 experiment(StopTime=604800,
        __Dymola_NumberOfIntervals=604800),
    Diagram(coordinateSystem(initialScale=0.1)),
    Icon(coordinateSystem(initialScale=0.1)));
end RoomwithSolarAirHeater;
