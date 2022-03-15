within AixLib.ThermalZones.HighOrder.Examples;
model RoomGFOw2_DayNightMode
  "Room on groudn floor with 2 outer walls with day and night"

  extends Modelica.Icons.Example;

  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();

  replaceable package Medium =
    AixLib.Media.Water "Medium in the component"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

  Rooms.OFD.Ow2IwL1IwS1Gr1Uf1 room_GF_2OW(redeclare DataBase.Walls.Collections.OFD.EnEV2009Heavy wallTypes,
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
    TWalls_start=290.15,
    redeclare model WindowModel = Components.WindowsDoors.WindowSimple,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002 Type_Win,
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    use_infiltEN12831=true,
    n50=3,                                withDoor1 = false, withDoor2 = false, withWindow1 = true, solar_absorptance_OW = 0.6, room_length = 5.87, room_width = 3.84, room_height = 2.6, windowarea_OW1 = 8.4, withWindow2 = true, windowarea_OW2 = 1.73,
    T0_air=294.15)                                                                                                                                                                                                        annotation(Placement(transformation(extent = {{16, 8}, {52, 44}})));
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

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp annotation(Placement(transformation(extent={{-32,38},{-12,58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow adiabaticWalls[4](each Q_flow=0) annotation (Placement(transformation(extent={{100,34},{80,54}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage    heatValve_new(
    redeclare package Medium = Medium,
    m_flow_nominal=1.5*m_flow_nominal,
    dpValve_nominal=0.5*dp_nominal)                                               annotation(Placement(transformation(extent={{22,-36},{42,-16}})));
  AixLib.Obsolete.Year2021.Fluid.Movers.Pump Pump(
    redeclare package Medium = Medium,
    m_flow_small=0.0001,
    MinMaxCharacteristics=DataBase.Pumps.Pump1()) "Pump in heating system" annotation (Placement(transformation(extent={{-74,-36},{-54,-16}})));
  AixLib.Utilities.Sources.NightMode nightMode(dayEnd = 22, dayStart = 6) annotation(Placement(transformation(extent={{-86,0},{-66,20}})));
  AixLib.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    dp(start=100),
    m_flow_nominal=m_flow_nominal,
    dp_nominal=200) "Hydraulic resistance in supply"
    annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
  AixLib.Fluid.FixedResistances.PressureDrop res2(
    redeclare package Medium = Medium,
    dp(start=100),
    m_flow_nominal=m_flow_nominal,
    dp_nominal=200) "Hydraulic resistance in return"
    annotation (Placement(transformation(extent={{10,-78},{-10,-58}})));
  Modelica.Blocks.Sources.Constant Tset(k = 273.15 + 20) annotation(Placement(transformation(extent={{-18,-6},{-8,4}})));
  Modelica.Blocks.Sources.Constant AirExchange(k = 0.7) annotation(Placement(transformation(extent={{32,62},{22,72}})));
  AixLib.Fluid.Sources.Boundary_ph
                                 tank(nPorts=1, redeclare package Medium =
        Medium)                       annotation(Placement(transformation(extent={{-100,-34},{-84,-18}})));
  AixLib.Fluid.HeatExchangers.Radiators.Radiator radiator_ML_delta(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    selectable=true,
    radiatorType=AixLib.DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom(),
    initDynamicsWall=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)                                                       annotation(Placement(transformation(extent = {{54, -36}, {74, -16}})));
  Modelica.Blocks.Sources.Constant Tset_flowTemperature(k = 273.15 + 55) annotation(Placement(transformation(extent={{-56,-6},{-46,4}})));
  AixLib.Fluid.HeatExchangers.Heater_T       hea(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-38,-36},{-18,-16}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(extent = {{-5, -5}, {5, 5}}, rotation = 270, origin={23,3})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSenConv annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={58,-10})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSenRad annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={68,-2})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{80,-20},{92,-32}})));
  Modelica.Blocks.Interfaces.RealOutput TRoom(unit="K", displayUnit="degC")
    "Absolute temperature as output signal"                                           annotation(Placement(transformation(extent={{100,20},{120,40}}), iconTransformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowToRoomConv(unit="W") "Convective heat flow from radiator to room" annotation (Placement(transformation(extent={{100,-20},{120,0}}), iconTransformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowToRoomRad(unit="W") "Radiant heat flow from radiator to room" annotation (Placement(transformation(extent={{100,0},{120,20}}), iconTransformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput m_flowHC(unit="kg/s") "Mass flow rate in heating circuit (HC)" annotation (Placement(transformation(extent={{100,-40},{120,-20}}), iconTransformation(extent={{100,-40},{120,-20}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.5*max(Pump.m_flowsPump) "Nominal mass flow rate";
  parameter Modelica.SIunits.PressureDifference dp_nominal=0.5*max(Pump.dpsPump) "Nominal pressure difference";


  Modelica.Blocks.Continuous.LimPID controlPIThermostat(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=1/2,
    Ti=1800,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.SteadyState) annotation (Placement(transformation(extent={{0,-8},{10,-18}})));
  Utilities.Math.MovingAverage movingAverageTemp(aveTime=1800) "Slows down the measurement of the room temperature" annotation (Placement(transformation(extent={{14,-4},{8,0}})));
equation
  connect(varTemp.port, room_GF_2OW.thermOutside) annotation(Line(points={{-12,48},{16,48},{16,43.64}},           color = {191, 0, 0}));
  connect(res.port_b, heatValve_new.port_a)
    annotation (Line(points={{10,-26},{22,-26}}, color={0,127,255}));
  connect(hea.port_b, res.port_a)
    annotation (Line(points={{-18,-26},{-10,-26}},color={0,127,255}));
  connect(heatValve_new.port_b, radiator_ML_delta.port_a) annotation(Line(points={{42,-26},{54,-26}},        color = {0, 127, 255}));
  connect(room_GF_2OW.AirExchangePort, AirExchange.y) annotation(Line(points={{14.2,38.51},{14.2,38},{10,38},{10,67},{21.5,67}},
                                                                                                                          color = {0, 0, 127}));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[1], room_GF_2OW.SolarRadiationPort_OW2) annotation(Line(points = {{-90.88, 76.7}, {-90.88, 70}, {0, 70}, {0, 84}, {43.09, 84}, {43.09, 43.82}}, color = {255, 128, 0}));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[2], room_GF_2OW.SolarRadiationPort_OW1) annotation(Line(points = {{-90.88, 76.7}, {-90.88, 70}, {0, 70}, {0, 31.4}, {16.09, 31.4}}, color = {255, 128, 0}));
  connect(combinedWeather.WindSpeed, room_GF_2OW.WindSpeedPort) annotation(Line(points={{-60.7333,98.8},{-4,98.8},{-4,18.8},{16.09,18.8}},        color = {0, 0, 127}));
  connect(combinedWeather.AirTemp, varTemp.T) annotation(Line(points={{-60.7333,94.9},{-40,94.9},{-40,48},{-34,48}},                            color = {0, 0, 127}));
  connect(Pump.port_a, res2.port_b) annotation (Line(points={{-74,-26},{-80,-26},{-80,-68},{-10,-68}},
                               color={0,127,255}));
  connect(nightMode.SwitchToNightMode,Pump. IsNight) annotation(Line(points={{-67.15,10.3},{-64,10.3},{-64,-15.8}},        color = {255, 0, 255}));
  connect(temperatureSensor.port, room_GF_2OW.thermRoom) annotation(Line(points={{23,8},{23,25},{31.48,25},{31.48,26}},            color = {191, 0, 0}));
  connect(temperatureSensor.T, TRoom) annotation(Line(points={{23,-2},{40,-2},{40,0},{56,0},{56,30},{110,30}},
                                                                                        color = {0, 0, 127}));
  connect(tank.ports[1],Pump. port_a) annotation (Line(
      points={{-84,-26},{-74,-26}},
      color={0,127,255}));

  connect(Pump.port_b, hea.port_a) annotation (Line(points={{-54,-26},{-38,-26}},
                      color={0,127,255}));

  connect(Tset_flowTemperature.y, hea.TSet) annotation (Line(points={{-45.5,-1},{-44,-1},{-44,-18},{-40,-18}},
                                         color={0,0,127}));
  connect(adiabaticWalls[1].port, room_GF_2OW.thermCeiling) annotation (Line(points={{80,44},{66,44},{66,38},{58,38},{58,38.6},{50.2,38.6}}, color={191,0,0}));
  connect(adiabaticWalls[2].port, room_GF_2OW.thermInsideWall1) annotation (Line(points={{80,44},{68,44},{68,28},{60,28},{60,27.8},{50.2,27.8}}, color={191,0,0}));
  connect(adiabaticWalls[3].port, room_GF_2OW.thermInsideWall2) annotation (Line(points={{80,44},{70,44},{70,8},{39.4,8},{39.4,9.8}}, color={191,0,0}));
  connect(adiabaticWalls[4].port, room_GF_2OW.ground) annotation (Line(points={{80,44},{72,44},{72,6},{32.92,6},{32.92,9.08}}, color={191,0,0}));
  connect(radiator_ML_delta.port_b, senMasFlo.port_a) annotation (Line(points={{74,-26},{80,-26}}, color={0,127,255}));
  connect(senMasFlo.port_b, res2.port_a) annotation (Line(points={{92,-26},{98,-26},{98,-68},{10,-68}}, color={0,127,255}));
  connect(senMasFlo.m_flow, m_flowHC) annotation (Line(points={{86,-32.6},{86,-38},{94,-38},{94,-30},{110,-30}}, color={0,0,127}));
  connect(radiator_ML_delta.ConvectiveHeat, heatFlowSenConv.port_a) annotation (Line(points={{62,-24},{58,-24},{58,-16}}, color={191,0,0}));
  connect(heatFlowSenConv.port_b, room_GF_2OW.thermRoom) annotation (Line(points={{58,-4},{58,20},{32,20},{32,26},{31.48,26}}, color={191,0,0}));
  connect(radiator_ML_delta.RadiativeHeat, heatFlowSenRad.port_a) annotation (Line(points={{68,-24},{68,-8}}, color={0,0,0}));
  connect(heatFlowSenRad.port_b, room_GF_2OW.starRoom) annotation (Line(points={{68,4},{68,26},{36.88,26}}, color={191,0,0}));
  connect(heatFlowSenConv.Q_flow,Q_flowToRoomConv)  annotation (Line(points={{64,-10},{86,-10},{86,-10},{110,-10}}, color={0,0,127}));
  connect(heatFlowSenRad.Q_flow, Q_flowToRoomRad) annotation (Line(points={{74,-2},{90,-2},{90,10},{110,10}}, color={0,0,127}));
  connect(controlPIThermostat.y, heatValve_new.y) annotation (Line(points={{10.5,-13},{20,-13},{20,-10},{32,-10},{32,-14}}, color={0,0,127}));
  connect(Tset.y, controlPIThermostat.u_s) annotation (Line(points={{-7.5,-1},{-4,-1},{-4,-13},{-1,-13}},color={0,0,127}));
  connect(temperatureSensor.T, movingAverageTemp.u) annotation (Line(points={{23,-2},{14.6,-2}}, color={0,0,127}));
  connect(movingAverageTemp.y, controlPIThermostat.u_m) annotation (Line(points={{7.7,-2},{5,-2},{5,-7}}, color={0,0,127}));
  annotation(experiment(StopTime = 86400, Interval = 60, Tolerance=1e-6, Algorithm = "Dassl"),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/HighOrder/Examples/RoomGFOw2_DayNightMode.mos"
                      "Simulate and plot"),
  Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                           graphics={  Text(extent={{-82,-92},{90,-98}},       lineColor = {0, 0, 255}, textString = "Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
 ")}), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Example for setting up a simulation for a room.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Energy generation and delivery system consisting of boiler and pump.
</p>
<p>
  The example works for a day and shows how such a simulation can be
  set up. It is not guranteed that the model will work stable under
  sifferent conditions or for longer periods of time.
</p>
<ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Merged with AixLib and replaced boiler with idealHeater
  </li>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe by hydraulic resistance
  </li>
  <li>
    <i>June 19, 2014</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"));
end RoomGFOw2_DayNightMode;
