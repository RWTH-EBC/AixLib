within AixLib.Building.Benchmark;
model FullModel
  Weather weather
    annotation (Placement(transformation(extent={{50,82},{70,102}})));
  Buildings.Office office
    annotation (Placement(transformation(extent={{30,0},{92,60}})));
  Generation.Generation generation
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Transfer.Transfer_TBA.Full_Transfer_TBA full_Transfer_TBA
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Transfer.Transfer_RLT.Full_Transfer_RLT full_Transfer_RLT
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
equation
  connect(weather.solarRad_out_North, office.SolarRadiationPort_North)
    annotation (Line(points={{49.4,100},{24,100},{24,54},{30,54}},  color={255,
          128,0}));
  connect(weather.solarRad_out_East, office.SolarRadiationPort_East)
    annotation (Line(points={{49.4,96},{24,96},{24,45},{30,45}},    color={255,
          128,0}));
  connect(weather.solarRad_out_South, office.SolarRadiationPort_South)
    annotation (Line(points={{49.4,92},{24,92},{24,36},{30,36}},    color={255,
          128,0}));
  connect(weather.solarRad_out_West, office.SolarRadiationPort_West)
    annotation (Line(points={{49.4,88},{24,88},{24,27},{30,27}},    color={255,
          128,0}));
  connect(weather.AirTemp, office.HeatPort_OutdoorTemp) annotation (Line(points={{60,82},
          {60,60},{61,60}},                   color={191,0,0}));
  connect(weather.WindSpeed_North, office.WindSpeedPort_North) annotation (Line(
        points={{70,100},{100,100},{100,54},{92,54}},
                                                    color={0,0,127}));
  connect(weather.WindSpeed_East, office.WindSpeedPort_East) annotation (Line(
        points={{70,96},{100,96},{100,45},{92,45}}, color={0,0,127}));
  connect(weather.WindSpeed_South, office.WindSpeedPort_South) annotation (Line(
        points={{70,92},{100,92},{100,36},{92,36}}, color={0,0,127}));
  connect(weather.WindSpeed_West, office.WindSpeedPort_West) annotation (Line(
        points={{70,88},{100,88},{100,27},{92,27}}, color={0,0,127}));
  connect(office.SolarRadiationPort_Hor, weather.solarRad_out_Hor) annotation (
      Line(points={{40.54,60},{40,60},{40,84},{49.4,84}}, color={255,128,0}));
  connect(office.WindSpeedPort_Hor, weather.WindSpeed_Hor) annotation (Line(
        points={{85.8,60},{86,60},{86,84},{70,84}}, color={0,0,127}));
  connect(generation.Fluid_out_hot,full_Transfer_TBA.Fluid_in_warm)
    annotation (Line(points={{-60,-42},{-40,-42},{-40,-80},{40,-80},{40,-47.4},
          {60,-47.4}},                                                 color={0,
          127,255}));
  connect(generation.Fluid_in_hot,full_Transfer_TBA.Fluid_out_warm)
    annotation (Line(points={{-60,-46},{-40,-46},{-40,-80},{40,-80},{40,-51.4},
          {60,-51.4}},
        color={0,127,255}));
  connect(generation.Fluid_out_cold, full_Transfer_TBA.Fluid_in_cold)
    annotation (Line(points={{-60,-54},{-40,-54},{-40,-80},{40,-80},{40,-80},{
          40,-54},{60,-54}},
        color={0,127,255}));
  connect(generation.Fluid_in_cold, full_Transfer_TBA.Fluid_out_cold)
    annotation (Line(points={{-60,-58},{-40,-58},{-40,-80},{40,-80},{40,-58},{
          60,-58}},
        color={0,127,255}));
  connect(full_Transfer_TBA.HeatPort_TBA, office.Heatport_TBA) annotation (Line(
        points={{70,-40},{70,-20},{85.8,-20},{85.8,0}}, color={191,0,0}));
  connect(office.Air_out, full_Transfer_RLT.Air_in) annotation (Line(points={{
          36.2,0},{36,0},{36,-20},{6,-20},{6,-40}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out, office.Air_in) annotation (Line(points={{
          14,-40},{14,-20},{48.6,-20},{48.6,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5000, Interval=1));
end FullModel;
