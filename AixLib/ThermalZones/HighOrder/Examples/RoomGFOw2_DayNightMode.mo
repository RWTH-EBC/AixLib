within AixLib.ThermalZones.HighOrder.Examples;
model RoomGFOw2_DayNightMode
  "Room on groudn floor with 2 outer walls with day and night"
  import AixLib;
  extends Modelica.Icons.Example;
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the system"                                                                             annotation(choicesAllMatching = true);
  Rooms.OFD.Ow2IwL1IwS1Gr1Uf1 room_GF_2OW(withDoor1 = false, withDoor2 = false, withWindow1 = true, solar_absorptance_OW = 0.6, room_length = 5.87, room_width = 3.84, room_height = 2.6, windowarea_OW1 = 8.4, withWindow2 = true, windowarea_OW2 = 1.73, withFloorHeating = false, TIR = 1, T0_air = 294.15, T0_IW1 = 291.15, T0_IW2 = 291.15, T0_FL = 289.15) annotation(Placement(transformation(extent = {{16, 8}, {52, 44}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather combinedWeather(
    Latitude=49.5,
    Longitude=8.5,
    Cloud_cover=false,
    Wind_speed=true,
    Air_temp=true,
    fileName=
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",

    WeatherData(tableOnFile=false, table=weatherDataDay.weatherData))
    annotation (Placement(transformation(extent={{-100,78},{-62,104}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp annotation(Placement(transformation(extent = {{-58, 38}, {-38, 58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow thermCeiling(Q_flow = 0) annotation(Placement(transformation(extent = {{102, 58}, {82, 78}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow thermInsideWall1(Q_flow = 0) annotation(Placement(transformation(extent = {{102, 34}, {82, 54}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow thermInsideWall2(Q_flow = 0) annotation(Placement(transformation(extent = {{102, 10}, {82, 30}})));
  AixLib.Fluid.Actuators.Valves.ThermostaticValve heatValve_new(
    redeclare package Medium = Medium,
    m_flow_small=0.0001,
    dp(start=1000))                                                               annotation(Placement(transformation(extent = {{22, -36}, {42, -16}})));
  AixLib.Fluid.Movers.Pump Pump(redeclare package Medium = Medium, m_flow_small=
       0.0001) "Pump in heating system"
                                annotation(Placement(transformation(extent = {{-92, -36}, {-72, -16}})));
  AixLib.Utilities.Sources.NightMode nightMode(dayEnd = 22, dayStart = 6) annotation(Placement(transformation(extent = {{-104, 0}, {-84, 20}})));
  AixLib.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    dp(start=100),
    m_flow_nominal=0.3,
    dp_nominal=200) "Hydraulic resistance in supply"
    annotation (Placement(transformation(extent={{-6,-36},{14,-16}})));
  AixLib.Fluid.FixedResistances.PressureDrop res2(
    redeclare package Medium = Medium,
    dp(start=100),
    m_flow_nominal=0.3,
    dp_nominal=200) "Hydraulic resistance in return"
    annotation (Placement(transformation(extent={{28,-82},{8,-62}})));
  Modelica.Blocks.Sources.Constant Tset(k = 273.15 + 20) annotation(Placement(transformation(extent = {{-6, -4}, {4, 6}})));
  Modelica.Blocks.Sources.Constant AirExchange(k = 0.7) annotation(Placement(transformation(extent = {{8, 68}, {18, 78}})));
  AixLib.Fluid.Sources.Boundary_ph
                                 tank(nPorts=1, redeclare package Medium =
        Medium)                       annotation(Placement(transformation(extent = {{-120, -32}, {-106, -18}})));
  AixLib.Fluid.HeatExchangers.Radiators.Radiator radiator_ML_delta(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    selectable=true,
    radiatorType=
        AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom())                                annotation(Placement(transformation(extent = {{54, -36}, {74, -16}})));
  Modelica.Blocks.Sources.Constant Tset_flowTemperature(k = 273.15 + 55) annotation(Placement(transformation(extent = {{-72, -6}, {-62, 4}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(extent = {{-5, -5}, {5, 5}}, rotation = 270, origin = {23, -5})));
  Modelica.Blocks.Interfaces.RealOutput TRoom
    "Absolute temperature as output signal"                                           annotation(Placement(transformation(extent = {{90, -20}, {110, 0}})));
  AixLib.Fluid.HeatExchangers.Heater_T       hea(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-50,-36},{-30,-16}})));
equation
  connect(varTemp.port, room_GF_2OW.thermOutside) annotation(Line(points = {{-38, 48}, {17.8, 48}, {17.8, 42.2}}, color = {191, 0, 0}));
  connect(room_GF_2OW.thermCeiling, thermCeiling.port) annotation(Line(points = {{50.2, 38.6}, {80, 38.6}, {80, 68}, {82, 68}}, color = {191, 0, 0}));
  connect(room_GF_2OW.thermInsideWall1, thermInsideWall1.port) annotation(Line(points = {{50.2, 27.8}, {80, 27.8}, {80, 44}, {82, 44}}, color = {191, 0, 0}));
  connect(room_GF_2OW.thermInsideWall2, thermInsideWall2.port) annotation(Line(points = {{39.4, 9.8}, {39.4, 0}, {80, 0}, {80, 20}, {82, 20}}, color = {191, 0, 0}));
  connect(res.port_b, heatValve_new.port_a)
    annotation (Line(points={{14,-26},{22,-26}}, color={0,127,255}));
  connect(hea.port_b, res.port_a)
    annotation (Line(points={{-30,-26},{-6,-26}}, color={0,127,255}));
  connect(heatValve_new.port_b, radiator_ML_delta.port_a) annotation(Line(points={{42,-26},
          {54,-26}},                                                                                         color = {0, 127, 255}));
  connect(radiator_ML_delta.port_b, res2.port_a) annotation (Line(points={{74,-26},
          {100,-26},{100,-72},{28,-72}}, color={0,127,255}));
  connect(room_GF_2OW.AirExchangePort, AirExchange.y) annotation(Line(points = {{30.31, 43.73}, {30.31, 73}, {18.5, 73}}, color = {0, 0, 127}));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[1], room_GF_2OW.SolarRadiationPort_OW2) annotation(Line(points = {{-90.88, 76.7}, {-90.88, 70}, {0, 70}, {0, 84}, {43.09, 84}, {43.09, 43.82}}, color = {255, 128, 0}));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[2], room_GF_2OW.SolarRadiationPort_OW1) annotation(Line(points = {{-90.88, 76.7}, {-90.88, 70}, {0, 70}, {0, 31.4}, {16.09, 31.4}}, color = {255, 128, 0}));
  connect(combinedWeather.WindSpeed, room_GF_2OW.WindSpeedPort) annotation(Line(points={{
          -60.7333,98.8},{0,98.8},{0,18.8},{16.09,18.8}},                                                                                         color = {0, 0, 127}));
  connect(combinedWeather.AirTemp, varTemp.T) annotation(Line(points={{-60.7333,
          94.9},{0,94.9},{0,60},{-64,60},{-64,48},{-60,48}},                                                                                    color = {0, 0, 127}));
  connect(Pump.port_a, res2.port_b) annotation (Line(points={{-92,-26},{-100,-26},
          {-100,-72},{8,-72}}, color={0,127,255}));
  connect(nightMode.SwitchToNightMode,Pump. IsNight) annotation(Line(points = {{-85.15, 10.3}, {-82, 10.3}, {-82, -15.8}}, color = {255, 0, 255}));
  connect(Tset.y, heatValve_new.T_setRoom) annotation(Line(points = {{4.5, 1}, {37.6, 1}, {37.6, -16.2}}, color = {0, 0, 127}));
  connect(temperatureSensor.T, heatValve_new.T_room) annotation(Line(points = {{23, -10}, {22, -10}, {22, -16.2}, {25.6, -16.2}}, color = {0, 0, 127}));
  connect(temperatureSensor.port, room_GF_2OW.thermRoom) annotation(Line(points = {{23, 0}, {23, 29}, {30.04, 29}, {30.04, 29.6}}, color = {191, 0, 0}));
  connect(temperatureSensor.T, TRoom) annotation(Line(points = {{23, -10}, {100, -10}}, color = {0, 0, 127}));
  connect(tank.ports[1],Pump. port_a) annotation (Line(
      points={{-106,-25},{-100,-25},{-100,-26},{-92,-26}},
      color={0,127,255}));
  connect(radiator_ML_delta.ConvectiveHeat, room_GF_2OW.thermRoom) annotation (
      Line(points={{62,-24},{46,-24},{46,29.6},{30.04,29.6}}, color={191,0,0}));
  connect(radiator_ML_delta.RadiativeHeat, room_GF_2OW.starRoom) annotation (
      Line(points={{68,-24},{52,-24},{52,29.6},{37.6,29.6}}, color={95,95,95}));

  connect(Pump.port_b, hea.port_a) annotation (Line(points={{-72,-26},{-61,-26},
          {-50,-26}}, color={0,127,255}));

  connect(Tset_flowTemperature.y, hea.TSet) annotation (Line(points={{-61.5,-1},
          {-58,-1},{-58,-18},{-52,-18}}, color={0,0,127}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                           graphics={  Text(extent = {{-56, -44}, {82, -130}}, lineColor = {0, 0, 255}, textString = "Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
 ")}), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example for setting up a simulation for a room.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Energy generation and delivery system consisting of boiler and pump.</p>
 <p>The example works for a day and shows how such a simulation can be set up. It is not guranteed that the model will work stable under sifferent conditions or for longer periods of time.</p>
 </html>", revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with
AixLib and replaced boiler with idealHeater</li>
<li><i>October 11, 2016</i> by Marcus Fuchs:<br/>Replace pipe by hydraulic resistance</li>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul>
</html>"));
end RoomGFOw2_DayNightMode;
