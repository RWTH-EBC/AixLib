within AixLib.Building.Components.Examples.Weather;
model ComparisonPerez
  import AixLib;
  extends Modelica.Icons.Example;
  AixLib.Building.Components.Weather.BaseClasses.Sun_rad sun_rad(
    Latitude=49.5,
    Longitude=8.5,
    DiffWeatherDataTime=0)
    annotation (Placement(transformation(extent={{-70,40},{-44,66}})));
  AixLib.Building.Components.Weather.BaseClasses.Sun sun(
    Latitude=49.5,
    Longitude=8.5,
    DiffWeatherDataTime=0)
    annotation (Placement(transformation(extent={{-64,0},{-36,26}})));
  AixLib.Building.Components.Weather.RadiationOnTiltedSurface.RadOnTiltedSurf_Perez
    radOnTiltedSurf_Perez(Tilt=90, Azimut=-90)
    annotation (Placement(transformation(extent={{-16,0},{8,24}})));
  AixLib.Building.Components.Weather.RadiationOnTiltedSurface.RadOnTiltedSurf_Perez_bus
    radOnTiltedSurf_Perez_bus(
    Latitude=0.86393797973719,
    Azimut=-1.5707963267949,
    Tilt=1.5707963267949)
    annotation (Placement(transformation(extent={{14,40},{46,68}})));
  AixLib.Building.Components.Weather.SolarRadiationBus solarRadiationBus
    annotation (Placement(transformation(extent={{-46,52},{-6,92}}),
        iconTransformation(extent={{-132,30},{-112,50}})));
  Modelica.Blocks.Sources.CombiTimeTable WeatherData(                                                                                                table = [0, 0; 1, 1],
    columns={16,15,7,8,9,10,11,12,13,18,19},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    offset={0},
    startTime=0,
    tableOnFile=true,
    tableName="wetter",
    fileName=
        "D:/Git/AixLib/AixLib/AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt")
                                                                                                                                                                                                            annotation(Placement(transformation(extent={{-94,-66},
            {-74,-46}})));
  Modelica.Blocks.Routing.DeMultiplex3 deMultiplex(n3 = 9) annotation(Placement(transformation(extent={{-60,-66},
            {-40,-46}})));
equation
  connect(sun.OutDayAngleSun, radOnTiltedSurf_Perez.InDayAngleSun) annotation (
      Line(points={{-37.4,13.78},{-24.7,13.78},{-24.7,9.48},{-13.48,9.48}},
        color={0,0,127}));
  connect(sun.OutHourAngleSun, radOnTiltedSurf_Perez.InHourAngleSun)
    annotation (Line(points={{-37.4,9.62},{-25.7,9.62},{-25.7,7.08},{-13.48,
          7.08}}, color={0,0,127}));
  connect(sun.OutDeclinationSun, radOnTiltedSurf_Perez.InDeclinationSun)
    annotation (Line(points={{-37.4,5.72},{-26.7,5.72},{-26.7,4.68},{-13.48,
          4.68}}, color={0,0,127}));
  connect(sun_rad.OutHourAngleSun, solarRadiationBus.HourAngleSun) annotation (
      Line(points={{-45.3,49.62},{-35.65,49.62},{-35.65,72.1},{-25.9,72.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sun_rad.OutDeclinationSun, solarRadiationBus.DeclinationSun)
    annotation (Line(points={{-45.3,45.72},{-45.3,58.86},{-25.9,58.86},{-25.9,
          72.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sun_rad.OutDayAngleSun, solarRadiationBus.DayAngleSun) annotation (
      Line(points={{-45.3,53.78},{-34.65,53.78},{-34.65,72.1},{-25.9,72.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(WeatherData.y,deMultiplex. u) annotation(Line(points={{-73,-56},{-62,
          -56}},                                                                           color = {0, 0, 127}));
  connect(deMultiplex.y1[1], solarRadiationBus.DiffRadHor) annotation (Line(
        points={{-39,-49},{-25.9,-49},{-25.9,72.1}},
                                                  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(deMultiplex.y2[1], solarRadiationBus.BeamRadHor) annotation (Line(
        points={{-39,-56},{-25.9,-56},{-25.9,72.1}},
                                                  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(deMultiplex.y2[1], radOnTiltedSurf_Perez.solarInput1) annotation (
      Line(points={{-39,-56},{-26,-56},{-26,38},{-11.32,38},{-11.32,20.76}},
        color={0,0,127}));
  connect(deMultiplex.y1[1], radOnTiltedSurf_Perez.solarInput2) annotation (
      Line(points={{-39,-49},{-26,-49},{-26,38},{0.44,38},{0.44,20.76}}, color=
          {0,0,127}));
  connect(solarRadiationBus, radOnTiltedSurf_Perez_bus.solarRadiationBus)
    annotation (Line(
      points={{-26,72},{-6,72},{-6,55.12},{14.64,55.12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (
    experiment(
      StopTime=31536000,
      Interval=1800,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end ComparisonPerez;
