within AixLib.Building.Components.Examples.Weather;
model Perez_deg
  import AixLib;
  extends Modelica.Icons.Example;
  AixLib.Building.Components.Weather.BaseClasses.Sun sun(
    Latitude=49.5,
    Longitude=8.5,
    DiffWeatherDataTime=0)
    annotation (Placement(transformation(extent={{-64,0},{-36,26}})));
  AixLib.Building.Components.Weather.RadiationOnTiltedSurface.RadOnTiltedSurf_Perez
    radOnTiltedSurf_Perez(Tilt=90, Azimut=-90)
    annotation (Placement(transformation(extent={{-16,0},{8,24}})));
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
  connect(WeatherData.y,deMultiplex. u) annotation(Line(points={{-73,-56},{-62,
          -56}},                                                                           color = {0, 0, 127}));
  connect(deMultiplex.y2[1], radOnTiltedSurf_Perez.solarInput1) annotation (
      Line(points={{-39,-56},{-26,-56},{-26,38},{-11.32,38},{-11.32,20.76}},
        color={0,0,127}));
  connect(deMultiplex.y1[1], radOnTiltedSurf_Perez.solarInput2) annotation (
      Line(points={{-39,-49},{-26,-49},{-26,38},{0.44,38},{0.44,20.76}}, color=
          {0,0,127}));
  annotation (
    experiment(
      StopTime=315360000,
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
end Perez_deg;
