within AixLib.Building.Benchmark;
model FullModel
  Weather weather
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Buildings.Office office
    annotation (Placement(transformation(extent={{0,-80},{62,-20}})));
equation
  connect(weather.solarRad_out_North, office.SolarRadiationPort_North)
    annotation (Line(points={{19.4,78},{-20,78},{-20,-26},{0,-26}}, color={255,
          128,0}));
  connect(weather.solarRad_out_East, office.SolarRadiationPort_East)
    annotation (Line(points={{19.4,74},{-20,74},{-20,-35},{0,-35}}, color={255,
          128,0}));
  connect(weather.solarRad_out_South, office.SolarRadiationPort_South)
    annotation (Line(points={{19.4,70},{-20,70},{-20,-44},{0,-44}}, color={255,
          128,0}));
  connect(weather.solarRad_out_West, office.SolarRadiationPort_West)
    annotation (Line(points={{19.4,66},{-20,66},{-20,-53},{0,-53}}, color={255,
          128,0}));
  connect(weather.AirTemp, office.HeatPort_OutdoorTemp) annotation (Line(points=
         {{30,60},{30,20},{30,-20},{31,-20}}, color={191,0,0}));
  connect(weather.WindSpeed_North, office.WindSpeedPort_North) annotation (Line(
        points={{40,76},{80,76},{80,-26},{62,-26}}, color={0,0,127}));
  connect(weather.WindSpeed_East, office.WindSpeedPort_East) annotation (Line(
        points={{40,72},{80,72},{80,-35},{62,-35}}, color={0,0,127}));
  connect(weather.WindSpeed_South, office.WindSpeedPort_South) annotation (Line(
        points={{40,68},{80,68},{80,-44},{62,-44}}, color={0,0,127}));
  connect(weather.WindSpeed_West, office.WindSpeedPort_West) annotation (Line(
        points={{40,64},{80,64},{80,-53},{62,-53}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FullModel;
