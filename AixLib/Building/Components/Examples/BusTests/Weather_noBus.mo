within AixLib.Building.Components.Examples.BusTests;
model Weather_noBus
  import AixLib;
  AixLib.Building.Components.Weather.Weather weather(
    fileName=
        "D:/Git/AixLib/AixLib/AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",

    redeclare model RadOnTiltedSurface =
        AixLib.Building.Components.Weather.RadiationOnTiltedSurface.RadOnTiltedSurf_Liu,

    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor())
    annotation (Placement(transformation(extent={{-36,0},{-6,20}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3.1536e+007,
      Interval=1800,
      __Dymola_Algorithm="Lsodar"));
end Weather_noBus;
