within AixLib.PlugNHarvest.Examples;
model Test
  extends Modelica.Icons.Example;
  Aggregation.Room_EnergySyst room_EnergySyst
    annotation (Placement(transformation(extent={{0,4},{56,58}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather weather(
    Wind_speed=true,
    Air_temp=true,
    Mass_frac=true)
    annotation (Placement(transformation(extent={{-100,28},{-48,62}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-16,-32},{4,-12}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_occupants
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_lights
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_elAppliances
    annotation (Placement(transformation(extent={{-60,-74},{-40,-54}})));
  Components.Parameters parameters(withDoor1=false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
equation
  connect(weather.WindSpeed, room_EnergySyst.WindSpeedPort) annotation (Line(
        points={{-46.2667,55.2},{-18,55.2},{-18,36.13},{3.08,36.13}}, color={0,
          0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], room_EnergySyst.solRadPort_Facade1)
    annotation (Line(points={{-87.52,26.3},{-87.52,20},{-18,20},{-18,54.76},{
          1.68,54.76}}, color={255,128,0}));
  connect(booleanExpression.y, room_EnergySyst.isChillerOn) annotation (Line(
        points={{5,-22},{12,-22},{12,-10},{11.2,-10},{11.2,1.3}}, color={255,0,
          255}));
  connect(booleanExpression.y, room_EnergySyst.isHeaterOn) annotation (Line(
        points={{5,-22},{19.88,-22},{19.88,1.57}}, color={255,0,255}));
  connect(schedule_occupants.y[1], room_EnergySyst.Schedule_lights) annotation (
     Line(points={{-39,0},{-30,0},{-30,-2},{-18,-2},{-18,17.5},{2.8,17.5}},
        color={0,0,127}));
  connect(schedule_lights.y[2], room_EnergySyst.Schedule_Occupants) annotation (
     Line(points={{-39,-30},{-18,-30},{-18,12},{-8,12},{-8,11.02},{2.8,11.02}},
        color={0,0,127}));
  connect(schedule_elAppliances.y[3], room_EnergySyst.Schedule_elAppliances)
    annotation (Line(points={{-39,-64},{-18,-64},{-18,4},{-8,4},{-8,5.08},{2.8,
          5.08}}, color={0,0,127}));
end Test;
