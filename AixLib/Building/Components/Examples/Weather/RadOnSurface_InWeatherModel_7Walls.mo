within AixLib.Building.Components.Examples.Weather;
model RadOnSurface_InWeatherModel_7Walls
  import AixLib;
  extends Modelica.Icons.Example;
  AixLib.Building.Components.Weather.Weather weather(
    Wind_speed=true,
    Air_temp=true,
    Latitude=40,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationBaseDataDefinition(
        nSurfaces=1,
        name={"S"},
        Azimut={0},
        Tilt={90}),
    fileName=
        "D:/Git/AixLib/AixLib/AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt")
    annotation (Placement(transformation(extent={{-80,18},{-34,48}})));
  AixLib.Building.Components.Walls.Wall wall(
    wall_length=4,
    wall_height=3,
    solar_absorptance=0.6,
    withWindow=true,
    withDoor=false,
    T0=566.3) annotation (Placement(transformation(extent={{26,40},{30,64}})));
  AixLib.Building.Components.Walls.Wall wall1(
    wall_height=3,
    withWindow=true,
    wall_length=2,
    solar_absorptance=0.4)
    annotation (Placement(transformation(extent={{26,2},{30,26}})));
  AixLib.Building.Components.Walls.Wall wall2(
    wall_height=3,
    withWindow=false,
    wall_length=5)
    annotation (Placement(transformation(extent={{26,-38},{30,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-24,24},{-14,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{68,48},{56,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
    annotation (Placement(transformation(extent={{68,14},{56,26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature3
    annotation (Placement(transformation(extent={{68,-24},{56,-12}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb
    annotation (Placement(transformation(extent={{36,46},{48,56}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb1
    annotation (Placement(transformation(extent={{36,14},{48,24}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb2
    annotation (Placement(transformation(extent={{36,-28},{48,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=293.15)
    annotation (Placement(transformation(extent={{96,44},{78,64}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=294.15)
    annotation (Placement(transformation(extent={{98,10},{80,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=295.15)
    annotation (Placement(transformation(extent={{98,-30},{80,-10}})));
  AixLib.Building.Components.Walls.Wall wall3(
    wall_height=3,
    withWindow=false,
    wall_length=5)
    annotation (Placement(transformation(extent={{26,-68},{30,-44}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb3
    annotation (Placement(transformation(extent={{36,-58},{48,-48}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature4
    annotation (Placement(transformation(extent={{68,-54},{56,-42}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=296.15)
    annotation (Placement(transformation(extent={{98,-60},{80,-40}})));
  AixLib.Building.Components.Walls.Wall wall4(
    wall_height=3,
    withWindow=false,
    wall_length=5)
    annotation (Placement(transformation(extent={{26,-100},{30,-76}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb4
    annotation (Placement(transformation(extent={{36,-90},{48,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature5
    annotation (Placement(transformation(extent={{68,-86},{56,-74}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=297.15)
    annotation (Placement(transformation(extent={{98,-92},{80,-72}})));
  AixLib.Building.Components.Walls.Wall wall5(
    wall_length=4,
    wall_height=3,
    solar_absorptance=0.6,
    withWindow=true,
    withDoor=false,
    T0=566.3) annotation (Placement(transformation(extent={{26,66},{30,90}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb5
    annotation (Placement(transformation(extent={{36,72},{48,82}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature6
    annotation (Placement(transformation(extent={{68,74},{56,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=292.15)
    annotation (Placement(transformation(extent={{96,70},{78,90}})));
  AixLib.Building.Components.Walls.Wall wall6(
    wall_length=4,
    wall_height=3,
    solar_absorptance=0.6,
    withWindow=true,
    withDoor=false,
    T0=566.3) annotation (Placement(transformation(extent={{26,96},{30,120}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb6
    annotation (Placement(transformation(extent={{36,102},{48,112}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature7
    annotation (Placement(transformation(extent={{68,104},{56,116}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=291.15)
    annotation (Placement(transformation(extent={{96,100},{78,120}})));
equation
  connect(weather.WindSpeed, wall.WindSpeedPort) annotation (Line(points={{
          -32.4667,42},{0,42},{0,60.8},{25.9,60.8}}, color={0,0,127}));
  connect(weather.WindSpeed, wall1.WindSpeedPort) annotation (Line(points={{
          -32.4667,42},{-32.4667,42},{0,42},{0,22.8},{25.9,22.8}}, color={0,0,
          127}));
  connect(weather.WindSpeed, wall2.WindSpeedPort) annotation (Line(points={{
          -32.4667,42},{0,42},{0,-17.2},{25.9,-17.2}}, color={0,0,127}));
  connect(weather.AirTemp, prescribedTemperature.T) annotation (Line(points={{
          -32.4667,37.5},{-30,37.5},{-30,29},{-25,29}}, color={0,0,127}));
  connect(prescribedTemperature.port, wall.port_outside) annotation (Line(
        points={{-14,29},{0,29},{0,28},{0,52},{25.9,52}}, color={191,0,0}));
  connect(prescribedTemperature.port, wall1.port_outside) annotation (Line(
        points={{-14,29},{0,29},{0,26},{0,14},{25.9,14}}, color={191,0,0}));
  connect(prescribedTemperature.port, wall2.port_outside) annotation (Line(
        points={{-14,29},{0,29},{0,28},{0,-26},{25.9,-26}}, color={191,0,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], wall.SolarRadiationPort)
    annotation (Line(points={{-68.96,16.5},{-68.96,0},{0,0},{0,63},{25.4,63}},
        color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], wall1.SolarRadiationPort)
    annotation (Line(points={{-68.96,16.5},{-68.96,0},{0,0},{0,25},{25.4,25}},
        color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], wall2.SolarRadiationPort)
    annotation (Line(points={{-68.96,16.5},{-68.96,0},{0,0},{0,-15},{25.4,-15}},
        color={255,128,0}));
  connect(wall.thermStarComb_inside, heatStarToComb.thermStarComb) annotation (
      Line(points={{30,52},{34,52},{34,50.9375},{36.36,50.9375}}, color={191,0,
          0}));
  connect(heatStarToComb.therm, prescribedTemperature1.port) annotation (Line(
        points={{48.06,47.8125},{52.03,47.8125},{52.03,54},{56,54}}, color={191,
          0,0}));
  connect(wall1.thermStarComb_inside, heatStarToComb1.thermStarComb)
    annotation (Line(points={{30,14},{34,14},{34,18.9375},{36.36,18.9375}},
        color={191,0,0}));
  connect(heatStarToComb1.therm, prescribedTemperature2.port) annotation (Line(
        points={{48.06,15.8125},{52.03,15.8125},{52.03,20},{56,20}}, color={191,
          0,0}));
  connect(wall2.thermStarComb_inside, heatStarToComb2.thermStarComb)
    annotation (Line(points={{30,-26},{36,-26},{36,-23.0625},{36.36,-23.0625}},
        color={191,0,0}));
  connect(heatStarToComb2.therm, prescribedTemperature3.port) annotation (Line(
        points={{48.06,-26.1875},{48.06,-24.0938},{56,-24.0938},{56,-18}},
        color={191,0,0}));
  connect(prescribedTemperature1.T, realExpression.y)
    annotation (Line(points={{69.2,54},{77.1,54}}, color={0,0,127}));
  connect(prescribedTemperature2.T, realExpression1.y)
    annotation (Line(points={{69.2,20},{79.1,20}}, color={0,0,127}));
  connect(prescribedTemperature3.T, realExpression2.y) annotation (Line(points=
          {{69.2,-18},{74,-18},{74,-20},{79.1,-20}}, color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], wall3.SolarRadiationPort)
    annotation (Line(points={{-68.96,16.5},{-68.96,-30},{0,-30},{0,-45},{25.4,
          -45}}, color={255,128,0}));
  connect(weather.WindSpeed, wall3.WindSpeedPort) annotation (Line(points={{
          -32.4667,42},{0,42},{0,-47.2},{25.9,-47.2}}, color={0,0,127}));
  connect(prescribedTemperature.port, wall3.port_outside) annotation (Line(
        points={{-14,29},{0,29},{0,-2},{0,-56},{25.9,-56}}, color={191,0,0}));
  connect(wall3.thermStarComb_inside, heatStarToComb3.thermStarComb)
    annotation (Line(points={{30,-56},{36,-56},{36,-53.0625},{36.36,-53.0625}},
        color={191,0,0}));
  connect(heatStarToComb3.therm, prescribedTemperature4.port) annotation (Line(
        points={{48.06,-56.1875},{48.06,-54.0938},{56,-54.0938},{56,-48}},
        color={191,0,0}));
  connect(prescribedTemperature4.T, realExpression3.y) annotation (Line(points=
          {{69.2,-48},{74,-48},{74,-50},{79.1,-50}}, color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], wall4.SolarRadiationPort)
    annotation (Line(points={{-68.96,16.5},{-68.96,-62},{0,-62},{0,-77},{25.4,
          -77}}, color={255,128,0}));
  connect(weather.WindSpeed, wall4.WindSpeedPort) annotation (Line(points={{
          -32.4667,42},{0,42},{0,-79.2},{25.9,-79.2}}, color={0,0,127}));
  connect(prescribedTemperature.port, wall4.port_outside) annotation (Line(
        points={{-14,29},{0,29},{0,-34},{0,-88},{25.9,-88}}, color={191,0,0}));
  connect(wall4.thermStarComb_inside, heatStarToComb4.thermStarComb)
    annotation (Line(points={{30,-88},{36,-88},{36,-85.0625},{36.36,-85.0625}},
        color={191,0,0}));
  connect(heatStarToComb4.therm, prescribedTemperature5.port) annotation (Line(
        points={{48.06,-88.1875},{48.06,-86.0938},{56,-86.0938},{56,-80}},
        color={191,0,0}));
  connect(prescribedTemperature5.T, realExpression4.y) annotation (Line(points=
          {{69.2,-80},{74,-80},{74,-82},{79.1,-82}}, color={0,0,127}));
  connect(weather.WindSpeed, wall5.WindSpeedPort) annotation (Line(points={{
          -32.4667,42},{0,42},{0,86.8},{25.9,86.8}}, color={0,0,127}));
  connect(prescribedTemperature.port, wall5.port_outside) annotation (Line(
        points={{-14,29},{0,29},{0,54},{0,78},{25.9,78}}, color={191,0,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], wall5.SolarRadiationPort)
    annotation (Line(points={{-68.96,16.5},{-68.96,10},{-68,10},{-68,2},{0,2},{
          0,89},{25.4,89}}, color={255,128,0}));
  connect(wall5.thermStarComb_inside, heatStarToComb5.thermStarComb)
    annotation (Line(points={{30,78},{34,78},{34,76.9375},{36.36,76.9375}},
        color={191,0,0}));
  connect(heatStarToComb5.therm, prescribedTemperature6.port) annotation (Line(
        points={{48.06,73.8125},{52.03,73.8125},{52.03,80},{56,80}}, color={191,
          0,0}));
  connect(prescribedTemperature6.T, realExpression5.y)
    annotation (Line(points={{69.2,80},{77.1,80}}, color={0,0,127}));
  connect(weather.WindSpeed, wall6.WindSpeedPort) annotation (Line(points={{
          -32.4667,42},{0,42},{0,116.8},{25.9,116.8}}, color={0,0,127}));
  connect(prescribedTemperature.port, wall6.port_outside) annotation (Line(
        points={{-14,29},{0,29},{0,84},{0,108},{25.9,108}}, color={191,0,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], wall6.SolarRadiationPort)
    annotation (Line(points={{-68.96,16.5},{-68.96,12},{-68,12},{-68,6},{0,6},{
          0,119},{25.4,119}}, color={255,128,0}));
  connect(wall6.thermStarComb_inside, heatStarToComb6.thermStarComb)
    annotation (Line(points={{30,108},{34,108},{34,106.938},{36.36,106.938}},
        color={191,0,0}));
  connect(heatStarToComb6.therm, prescribedTemperature7.port) annotation (Line(
        points={{48.06,103.813},{52.03,103.813},{52.03,110},{56,110}}, color={
          191,0,0}));
  connect(prescribedTemperature7.T, realExpression6.y)
    annotation (Line(points={{69.2,110},{77.1,110}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=3.1536e+007,
      Interval=1800,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=false,
      OutputFlatModelica=false),
    Diagram(coordinateSystem(extent={{-100,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-100,-100},{140,120}})));
end RadOnSurface_InWeatherModel_7Walls;
