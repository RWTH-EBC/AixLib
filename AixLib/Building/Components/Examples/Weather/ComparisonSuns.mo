within AixLib.Building.Components.Examples.Weather;
model ComparisonSuns
  import AixLib;
  extends Modelica.Icons.Example;
  AixLib.Building.Components.Weather.BaseClasses.Sun_rad sun_rad(
    Latitude=49.5,
    Longitude=8.5,
    DiffWeatherDataTime=0)
    annotation (Placement(transformation(extent={{-62,40},{-36,66}})));
  AixLib.Building.Components.Weather.BaseClasses.Sun sun(
    Latitude=49.5,
    Longitude=8.5,
    DiffWeatherDataTime=0)
    annotation (Placement(transformation(extent={{-64,0},{-36,26}})));
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
end ComparisonSuns;
