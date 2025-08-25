within AixLib.ThermalZones.HighOrder.Examples;
model Appartment_VoWo "Simulation of 1 apartment "
  extends Modelica.Icons.Example;
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the system"                                                                             annotation(Dialog(group = "Medium"), choicesAllMatching = true);
  AixLib.ThermalZones.HighOrder.House.MFD.BuildingAndEnergySystem.OneAppartment_Radiators
    VoWoWSchV1984(
    redeclare package Medium = Medium,
    redeclare model WindowModel = Components.WindowsDoors.WindowSimple,
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    fixedHeatFlow3(T_ref=288.15),
    fixedHeatFlow5(T_ref=283.15),
    fixedHeatFlow16(T_ref=288.15),
    ratioSunblind=0.8,
    solIrrThreshold=350,
    TOutAirLimit=290.15)
    annotation (Placement(transformation(extent={{-42,-4},{36,46}})));
  AixLib.Obsolete.Year2021.Fluid.Movers.Pump Pump(redeclare package Medium = Medium, m_flow_small=0.0001) "Pump in heating system" annotation (Placement(transformation(extent={{4,-82},{-16,-62}})));
  AixLib.Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium,
    dp_nominal=200,
    m_flow_nominal=0.3) "Hydraulic resistance of supply"
    annotation (Placement(transformation(extent={{-30,-48},{-18,-36}})));
  AixLib.Fluid.FixedResistances.PressureDrop res2(
    redeclare package Medium = Medium,
    dp_nominal=200,
    m_flow_nominal=0.3) "Hydraulic resistance of return"
    annotation (Placement(transformation(extent={{26,-50},{38,-38}})));
  Modelica.Blocks.Sources.Constant Source_TsetChildren(k = 273.15 + 22) annotation(Placement(transformation(extent = {{-100, 8}, {-86, 22}})));
  Modelica.Blocks.Sources.Constant Source_TsetLivingroom(k = 273.15 + 20) annotation(Placement(transformation(extent = {{-100, 52}, {-86, 66}})));
  Modelica.Blocks.Sources.Constant Source_TsetBedroom(k = 273.15 + 20) annotation(Placement(transformation(extent = {{-100, 30}, {-86, 44}})));
  Modelica.Blocks.Sources.Constant Source_TsetKitchen(k = 273.15 + 20) annotation(Placement(transformation(extent = {{-100, -36}, {-86, -22}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather combinedWeather(
    Latitude=49.5,
    Longitude=8.5,
    Wind_dir=false,
    Wind_speed=true,
    Air_temp=true,
    SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_NE_SE_SW_NW_Hor(),
    fileName=
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",
    WeatherData(tableOnFile=false, table=weatherDataDay.weatherData))
    annotation (Placement(transformation(extent={{-82,74},{-50,96}})));

  Modelica.Blocks.Sources.Constant Source_TsetBath(k = 273.15 + 24) annotation(Placement(transformation(extent = {{-100, -16}, {-86, -2}})));
  Modelica.Blocks.Sources.Constant AirExWindow[5](each k = 0.5) annotation(Placement(transformation(extent = {{-6, 74}, {0, 80}})));
  AixLib.Fluid.Sources.Boundary_ph
                                 tank(nPorts=2, redeclare package Medium =
        Medium)                       annotation(Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 270, origin = {28, -64})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(Placement(transformation(extent = {{-94, -56}, {-74, -36}})));
  inner AixLib.Utilities.Sources.BaseParameters baseParameters
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.Constant Source_TseBoiler(k = 273.15 + 55) annotation(Placement(transformation(extent={{-86,
            -112},{-72,-98}})));
  output Real Ta = combinedWeather.AirTemp;
  // Livingroom
  output Real airTLi = VoWoWSchV1984.Appartment.Livingroom.airload.T;
  output Real radPowerLiConv = -VoWoWSchV1984.Hydraulic.convLi.Q_flow;
  output Real radPowerLiRad = -VoWoWSchV1984.Hydraulic.radLi.Q_flow;
  output Real travelHVLi = VoWoWSchV1984.Hydraulic.valveLi.opening;
  output Real massFlowLi = VoWoWSchV1984.Hydraulic.valveLi.port_a.m_flow;
  // Bath
  output Real airTBa = VoWoWSchV1984.Appartment.Bathroom.airload.T;
  output Real radPowerBaConv = -VoWoWSchV1984.Hydraulic.convBa.Q_flow;
  output Real radPowerBaRad = -VoWoWSchV1984.Hydraulic.radBa.Q_flow;
  output Real travelHVBa = VoWoWSchV1984.Hydraulic.valveBa.opening;
  output Real massFlowBa = VoWoWSchV1984.Hydraulic.valveBa.port_a.m_flow;
  // Bedroom
  output Real airTBe = VoWoWSchV1984.Appartment.Bedroom.airload.T;
  output Real radPowerBeConv = -VoWoWSchV1984.Hydraulic.convBe.Q_flow;
  output Real radPowerBeRad = -VoWoWSchV1984.Hydraulic.radBe.Q_flow;
  output Real travelHVBe = VoWoWSchV1984.Hydraulic.valveBe.opening;
  output Real massFlowBe = VoWoWSchV1984.Hydraulic.valveBe.port_a.m_flow;
  // Children
  output Real airTCh = VoWoWSchV1984.Appartment.Children.airload.T;
  output Real radPowerChConv = -VoWoWSchV1984.Hydraulic.convCh.Q_flow;
  output Real radPowerChRad = -VoWoWSchV1984.Hydraulic.radCh.Q_flow;
  output Real travelHVCh = VoWoWSchV1984.Hydraulic.valveCh.opening;
  output Real massFlowCh = VoWoWSchV1984.Hydraulic.valveCh.port_a.m_flow;
  // Kitchen
  output Real airTKi = VoWoWSchV1984.Appartment.Kitchen.airload.T;
  output Real radPowerKiConv = -VoWoWSchV1984.Hydraulic.convKi.Q_flow;
  output Real radPowerKiRad = -VoWoWSchV1984.Hydraulic.radKi.Q_flow;
  output Real travelHVKi = VoWoWSchV1984.Hydraulic.valveKi.opening;
  output Real massFlowKi = VoWoWSchV1984.Hydraulic.valveKi.port_a.m_flow;
  Fluid.HeatExchangers.Heater_T              hea(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-38,-82},{-58,-62}})));
equation
  connect(Pump.port_b, hea.port_a) annotation (Line(points={{-16,-72},{-38,-72},
          {-38,-72},{-38,-72}},          color={0,127,255}));
  connect(hea.port_b,res1. port_a) annotation(Line(points={{-58,-72},{-74,-72},
          {-74,-42},{-30,-42}},                                                                               color = {0, 127, 255}));
  connect(res1.port_b, VoWoWSchV1984.Inflow) annotation(Line(points={{-18,-42},
          {-5.12727,-42},{-5.12727,-1.5}},                                                                             color = {0, 127, 255}));
  connect(VoWoWSchV1984.Returnflow, res2.port_a) annotation (Line(points={{3.38182,
          -1.5},{3.38182,-44},{26,-44}}, color={0,127,255}));
  // Here the relevant Variables for the simulation are set as output to limit the dimension of the result file
  connect(combinedWeather.WindSpeed, VoWoWSchV1984.WindSpeedPort) annotation(Line(points={{-48.9333,91.6},{-10.4455,91.6},{-10.4455,42.875}},        color = {0, 0, 127}));
  connect(AirExWindow.y, VoWoWSchV1984.AirExchangePort_Window) annotation(Line(points={{0.3,77},{6,77},{6,43.0833},{9.76364,43.0833}},          color = {0, 0, 127}));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[2], VoWoWSchV1984.SolarRadiation[1]) annotation(Line(points={{-74.32,72.9},{-74.32,60},{21.1091,60},{21.1091,44.5417}},
                                                                                                                                                                color = {255, 128, 0}));
  connect(combinedWeather.SolarRadiation_OrientedSurfaces[4], VoWoWSchV1984.SolarRadiation[2]) annotation(Line(points={{-74.32,72.9},{-74.32,60},{21.1091,60},{21.1091,42.4583}},
                                                                                                                                                                color = {255, 128, 0}));
  connect(combinedWeather.AirTemp, VoWoWSchV1984.air_temp) annotation(Line(points={{-48.9333,88.3},{-29.9455,88.3},{-29.9455,43.0833}},        color = {0, 0, 127}));
  connect(Source_TsetLivingroom.y, VoWoWSchV1984.TSet[1]) annotation(Line(points={{-85.3,59},{-60,59},{-60,18.7083},{-36.6818,18.7083}},          color = {0, 0, 127}));
  connect(Source_TsetBedroom.y, VoWoWSchV1984.TSet[2]) annotation(Line(points={{-85.3,37},{-60,37},{-60,19.9583},{-36.6818,19.9583}},          color = {0, 0, 127}));
  connect(Source_TsetChildren.y, VoWoWSchV1984.TSet[3]) annotation(Line(points={{-85.3,15},{-72,15},{-72,14},{-60,14},{-60,21.2083},{-36.6818,21.2083}},              color = {0, 0, 127}));
  connect(booleanExpression.y, Pump.IsNight) annotation (Line(points={{-73,-46},
          {-6,-46},{-6,-61.8}}, color={255,0,255}));
  connect(Source_TsetBath.y, VoWoWSchV1984.TSet[4]) annotation(Line(points={{-85.3,-9},{-60,-9},{-60,22.4583},{-36.6818,22.4583}},          color = {0, 0, 127}));
  connect(Source_TsetKitchen.y, VoWoWSchV1984.TSet[5]) annotation(Line(points={{-85.3,-29},{-60,-29},{-60,23.7083},{-36.6818,23.7083}},          color = {0, 0, 127}));
  connect(res2.port_b, tank.ports[1]) annotation (Line(points={{38,-44},{54,-44},
          {54,-86},{29.6,-86},{29.6,-72}}, color={0,127,255}));
  connect(Pump.port_a, tank.ports[2]) annotation (Line(points={{4,-72},{14,-72},
          {14,-84},{26.4,-84},{26.4,-72}}, color={0,127,255}));
  connect(Source_TseBoiler.y, hea.TSet) annotation (Line(points={{-71.3,-105},{
          -28,-105},{-28,-64},{-36,-64}}, color={0,0,127}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -140},{100,100}}),                                                                           graphics={  Text(extent = {{-48, -82}, {90, -168}}, lineColor = {0, 0, 255}, textString = "Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
 ")}), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), experimentSetupOutput(states = false, derivatives = false, auxiliaries = false, events = false), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Example for setting up a simulation for an appartment.
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
    <i>June 19, 2014</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"),  Icon(coordinateSystem(extent = {{-100, -140}, {100, 100}})));
end Appartment_VoWo;
