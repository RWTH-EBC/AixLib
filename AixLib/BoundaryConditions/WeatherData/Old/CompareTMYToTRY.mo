within AixLib.BoundaryConditions.WeatherData.Old;
model CompareTMYToTRY
  ReaderTMY3 weaDat
    annotation (Placement(transformation(extent={{-86,16},{-18,94}})));
  WeatherTRY.Weather weather(
    Cloud_cover=true,
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Air_press=true,
    Mass_frac=true,
    Rel_hum=true,
    Sky_rad=true,
    Ter_rad=true)
    annotation (Placement(transformation(extent={{-78,-86},{16,-24}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CompareTMYToTRY;
