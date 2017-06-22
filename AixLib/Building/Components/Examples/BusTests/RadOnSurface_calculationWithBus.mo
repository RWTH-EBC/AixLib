within AixLib.Building.Components.Examples.BusTests;
model RadOnSurface_calculationWithBus
  import AixLib;
  AixLib.Building.Components.Weather.RadiationOnTiltedSurface.RadOnTiltedSurf_Liu_bus
    radOnTiltedSurf_Liu_bus[5](
    Latitude=0.86393797973719,
    Azimut=Modelica.SIunits.Conversions.from_deg(weather_NoSolarRad.SOD.Azimut),
    Tilt=Modelica.SIunits.Conversions.from_deg(weather_NoSolarRad.SOD.Tilt))
    annotation (Placement(transformation(extent={{-42,60},{-10,84}})));

  AixLib.Building.Components.Weather.Weather_NoSolarRad weather_NoSolarRad(
      fileName=
        "D:/Git/AixLib/AixLib/AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",
      SOD=
        AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor())
    annotation (Placement(transformation(extent={{-80,58},{-50,78}})));
equation
  connect(weather_NoSolarRad.solarRadiationBus, radOnTiltedSurf_Liu_bus[1].solarRadiationBus)
    annotation (Line(
      points={{-62.6,77.4},{-51.3,77.4},{-51.3,72.96},{-41.36,72.96}},
      color={255,204,51},
      thickness=0.5));
  connect(weather_NoSolarRad.solarRadiationBus, radOnTiltedSurf_Liu_bus[2].solarRadiationBus)
    annotation (Line(
      points={{-62.6,77.4},{-51.3,77.4},{-51.3,72.96},{-41.36,72.96}},
      color={255,204,51},
      thickness=0.5));
  connect(weather_NoSolarRad.solarRadiationBus, radOnTiltedSurf_Liu_bus[3].solarRadiationBus)
    annotation (Line(
      points={{-62.6,77.4},{-52.3,77.4},{-52.3,72.96},{-41.36,72.96}},
      color={255,204,51},
      thickness=0.5));
  connect(weather_NoSolarRad.solarRadiationBus, radOnTiltedSurf_Liu_bus[4].solarRadiationBus)
    annotation (Line(
      points={{-62.6,77.4},{-52.3,77.4},{-52.3,72.96},{-41.36,72.96}},
      color={255,204,51},
      thickness=0.5));
  connect(weather_NoSolarRad.solarRadiationBus, radOnTiltedSurf_Liu_bus[4].solarRadiationBus)
    annotation (Line(
      points={{-62.6,77.4},{-51.3,77.4},{-51.3,72.96},{-41.36,72.96}},
      color={255,204,51},
      thickness=0.5));
  connect(weather_NoSolarRad.solarRadiationBus, radOnTiltedSurf_Liu_bus[5].solarRadiationBus)
    annotation (Line(
      points={{-62.6,77.4},{-51.3,77.4},{-51.3,72.96},{-41.36,72.96}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3.1536e+007,
      Interval=1800,
      __Dymola_Algorithm="Lsodar"));
end RadOnSurface_calculationWithBus;
