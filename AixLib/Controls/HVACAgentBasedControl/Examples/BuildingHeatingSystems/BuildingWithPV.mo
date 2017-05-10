within AixLib.Controls.HVACAgentBasedControl.Examples.BuildingHeatingSystems;
model BuildingWithPV
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water;

  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    Q_flow_nominal=1,
    dp_nominal(displayUnit="bar") = 1000)
    annotation (Placement(transformation(extent={{-38,-132},{-18,-112}})));
  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal(displayUnit="bar") = 1000,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{22,-132},{42,-112}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
      redeclare package Medium = Medium, m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-12,-132},{8,-112}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    m_flow(start=1),
    addPowerToMedium=false)                   annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={72,-96})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol(nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1)
    annotation (Placement(transformation(extent={{-18,10},{2,30}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=1)
    annotation (Placement(transformation(extent={{38,10},{18,30}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dpValve_nominal(displayUnit="bar") = 10000)
    annotation (Placement(transformation(extent={{56,-28},{36,-8}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dpValve_nominal(displayUnit="bar") = 10000)
    annotation (Placement(transformation(extent={{20,-28},{0,-8}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance1(
    redeclare package Medium = Medium,
    zeta=10,
    m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-30,-50},{-50,-30}})));
  AixLib.Building.LowOrder.ThermalZone.ThermalZoneEquipped thermalZone(zoneParam=
       AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting(), redeclare
      AixLib.Building.LowOrder.BaseClasses.BuildingPhysics.BuildingPhysicsVDI
      buildingPhysics)
    annotation (Placement(transformation(extent={{-40,112},{-20,132}})));
  HVACAgentBasedControl.Agents.Broker broker(name=20001)
    annotation (Placement(transformation(extent={{100,120},{120,140}})));
  HVACAgentBasedControl.Agents.HeatProducerAgent heatProducerAgent(
    name=30001,
    costCurrent(start=0),
    setCapacity(start=0),
    currentCapacityDiscrete(start=0),
    maxCapacity=3000)
    annotation (Placement(transformation(extent={{-48,-106},{-28,-86}})));
  HVACAgentBasedControl.CostFunctions.Economic.ConstantFactor constantFactor(p=0.067)
    annotation (Placement(transformation(extent={{-48,-84},{-28,-64}})));
  HVACAgentBasedControl.CostFunctions.Economic.PV_varCost constantFactor1(
    rad_treshold=310,
    p=0.29,
    eta=1) annotation (Placement(transformation(extent={{32,-84},{52,-64}})));
  HVACAgentBasedControl.Agents.HeatProducerAgent heatProducerAgent1(
    name=30002,
    costCurrent(start=0),
    setCapacity(start=0),
    currentCapacityDiscrete(start=0),
    maxCapacity=10000)
    annotation (Placement(transformation(extent={{32,-106},{52,-86}})));
  AixLib.Building.LowOrder.ThermalZone.ThermalZoneEquipped thermalZone1(
                                                                     redeclare
      AixLib.Building.LowOrder.BaseClasses.BuildingPhysics.BuildingPhysicsVDI
      buildingPhysics, zoneParam=
        AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting())
    annotation (Placement(transformation(extent={{60,112},{80,132}})));
  AixLib.Building.Components.Weather.Weather
                                      weather(
    Air_temp=true,
    Sky_rad=true,
    Ter_rad=true,
    Air_press=true,
    Rel_hum=true,
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt"))
    annotation (Placement(transformation(extent={{-98,79},{-64,101}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-88,110})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=0)
    annotation (Placement(transformation(extent={{-98,118},{-78,138}})));
  HVACAgentBasedControl.Agents.RoomAgent roomAgent(
    broker=20001,
    threshold=0.5,
    sampleRate=1,
    sampleTriggerTime=120,
    G=2) annotation (Placement(transformation(extent={{-124,12},{-104,32}})));
  HVACAgentBasedControl.Agents.RoomAgent roomAgent1(
    name=10002,
    broker=20001,
    startTime=5,
    threshold=0.5,
    sampleRate=1,
    sampleTriggerTime=120,
    G=2) annotation (Placement(transformation(extent={{100,14},{120,34}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-124,38},{-104,58}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{76,38},{96,58}})));
  Modelica.Blocks.Continuous.LimPID PID(
    yMax=1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    k=0.1,
    Ti=1,
    Td=0.01,
    yMin=0.2,
    y_start=0.2)
    annotation (Placement(transformation(extent={{-66,28},{-46,48}})));
  Modelica.Blocks.Continuous.LimPID PID1(
    yMax=1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    k=0.1,
    Ti=1,
    Td=0.01,
    yMin=0.2,
    y_start=0.2)
    annotation (Placement(transformation(extent={{140,28},{160,48}})));
  Modelica.Blocks.Sources.RealExpression zero1(y=273.15 + 20)
                                                   annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-86,54})));
  Modelica.Blocks.Sources.RealExpression zero2(y=1)
                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-96})));
  AixLib.Fluid.Sources.FixedBoundary bou(nPorts=1, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{100,-140},{80,-120}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{130,120},{150,140}})));
  Modelica.Blocks.Interfaces.RealOutput cap1
    annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
  Modelica.Blocks.Interfaces.RealOutput cap2
    annotation (Placement(transformation(extent={{140,-140},{160,-120}})));
  Modelica.Blocks.Interfaces.RealOutput valve1
    annotation (Placement(transformation(extent={{162,-42},{182,-22}})));
  Modelica.Blocks.Interfaces.RealOutput valve2
    annotation (Placement(transformation(extent={{164,-62},{184,-42}})));
  Modelica.Blocks.Interfaces.RealOutput T1
    annotation (Placement(transformation(extent={{-152,-46},{-172,-26}})));
  Modelica.Blocks.Interfaces.RealOutput T2
    annotation (Placement(transformation(extent={{-152,-14},{-172,6}})));
  AixLib.Fluid.Sensors.Temperature senTem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-98,-92},{-118,-72}})));
  Modelica.Blocks.Interfaces.RealOutput T_return
    annotation (Placement(transformation(extent={{-150,-92},{-170,-72}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=273.15 + 60)
    annotation (Placement(transformation(extent={{-114,-64},{-94,-44}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC
    annotation (Placement(transformation(extent={{-122,-92},{-142,-72}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC1
    annotation (Placement(transformation(extent={{-122,-14},{-142,6}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC2
    annotation (Placement(transformation(extent={{-122,-46},{-142,-26}})));
  Modelica.Blocks.Interfaces.RealOutput T_air
    annotation (Placement(transformation(extent={{-148,98},{-168,118}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC3
    annotation (Placement(transformation(extent={{-118,98},{-138,118}})));
  Modelica.Blocks.Interfaces.BooleanOutput electricity_free
    annotation (Placement(transformation(extent={{164,-80},{184,-60}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-10,-74},{10,-54}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{4,-84},{24,-104}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       2999) annotation (Placement(transformation(extent={{-22,-104},{-2,-84}})));
  inner HVACAgentBasedControl.Agents.MessageNotification messageNotification
    annotation (Placement(transformation(extent={{130,80},{150,100}})));

equation
  connect(hydraulicResistance.port_a, hea.port_b) annotation (Line(points={{-12,
          -122},{-12,-122},{-18,-122}},
                                     color={0,127,255}));
  connect(hydraulicResistance.port_b, hea1.port_a)
    annotation (Line(points={{8,-122},{22,-122}},
                                                color={0,127,255}));
  connect(fan.port_a, hea1.port_b)
    annotation (Line(points={{72,-106},{72,-122},{42,-122}},
                                                          color={0,127,255}));
  connect(fan.port_b, val.port_a)
    annotation (Line(points={{72,-86},{72,-18},{56,-18}},
                                                        color={0,127,255}));
  connect(val.port_b, vol1.ports[1]) annotation (Line(points={{36,-18},{30,-18},
          {30,10}},                        color={0,127,255}));
  connect(val1.port_b, vol.ports[1]) annotation (Line(points={{0,-18},{-6,-18},
          {-6,10},{-10,10}},       color={0,127,255}));
  connect(fan.port_b, val1.port_a) annotation (Line(points={{72,-86},{72,-40},{24,
          -40},{24,-18},{20,-18}},
                              color={0,127,255}));
  connect(hydraulicResistance1.port_a, fan.port_b)
    annotation (Line(points={{-30,-40},{72,-40},{72,-86}},
                                                       color={0,127,255}));
  connect(hydraulicResistance1.port_b, hea.port_a) annotation (Line(points={{-50,-40},
          {-80,-40},{-80,-122},{-38,-122}},    color={0,127,255}));
  connect(vol.ports[2], hea.port_a) annotation (Line(points={{-6,10},{-10,10},{
          -10,2},{-80,2},{-80,-122},{-38,-122}},  color={0,127,255}));
  connect(vol1.ports[2], hea.port_a) annotation (Line(points={{26,10},{26,10},{26,
          2},{-80,2},{-80,-122},{-38,-122}},    color={0,127,255}));
  connect(heatProducerAgent.calcCapacity, constantFactor.capacity) annotation (
      Line(points={{-44,-87},{-44,-82}},             color={0,0,127}));
  connect(heatProducerAgent.calcCost, constantFactor.cost) annotation (Line(
        points={{-32,-88},{-32,-83}},             color={0,0,127}));
  connect(heatProducerAgent.setCapacityOut, hea.u) annotation (Line(points={{-30,
          -105},{-30,-110},{-50,-110},{-50,-116},{-40,-116}},
                                                         color={0,0,127}));
  connect(hea.Q_flow, heatProducerAgent.currentCapacity) annotation (Line(
        points={{-17,-116},{-16,-116},{-16,-108},{-46,-108},{-46,-104}},
                                                                    color={0,0,127}));
  connect(hea1.u, heatProducerAgent1.setCapacityOut) annotation (Line(points={{20,-116},
          {20,-110},{50,-110},{50,-105}},   color={0,0,127}));
  connect(hea1.Q_flow, heatProducerAgent1.currentCapacity) annotation (Line(
        points={{43,-116},{44,-116},{44,-108},{34,-108},{34,-104}},
                                                               color={0,0,127}));
  connect(heatProducerAgent1.calcCapacity, constantFactor1.capacity)
    annotation (Line(points={{36,-87},{36,-82}},            color={0,0,127}));
  connect(constantFactor1.cost, heatProducerAgent1.calcCost) annotation (Line(
        points={{48,-83},{48,-85.5},{48,-88}},                color={0,0,127}));
  connect(thermalZone.internalGainsConv, vol.heatPort) annotation (Line(points={{-30,
          116.2},{-30,20},{-26,20},{-18,20}},                     color={191,0,0}));
  connect(vol1.heatPort, thermalZone1.internalGainsConv) annotation (Line(
        points={{38,20},{70,20},{70,116.2}},              color={191,0,0}));
  connect(weather.SolarRadiation_OrientedSurfaces, thermalZone1.solarRad_in)
    annotation (Line(points={{-89.84,77.9},{-89.84,72},{52,72},{52,126.6},{62,126.6}},
        color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces, thermalZone.solarRad_in)
    annotation (Line(points={{-89.84,77.9},{-89.84,72},{-52,72},{-52,126.6},{-38,
          126.6}},
        color={255,128,0}));
  connect(thermalZone.weather[1], weather.AirTemp) annotation (Line(points={{-37.4,
          121.2},{-50,121.2},{-50,93.3},{-62.8667,93.3}}, color={0,0,127}));
  connect(thermalZone1.weather[1], weather.AirTemp) annotation (Line(points={{62.6,
          121.2},{60,121.2},{54,121.2},{54,93.3},{-62.8667,93.3}}, color={0,0,127}));
  connect(thermalZone.weather[2], weather.SkyRadiation) annotation (Line(points={{-37.4,
          122},{-48,122},{-48,80.1},{-62.8667,80.1}},        color={0,0,127}));
  connect(thermalZone1.weather[2], weather.SkyRadiation) annotation (Line(
        points={{62.6,122},{56,122},{56,80.1},{-62.8667,80.1}}, color={0,0,127}));
  connect(thermalZone1.weather[3], weather.TerrestrialRadiation) annotation (
      Line(points={{62.6,122.8},{58,122.8},{58,76.8},{-62.8667,76.8}}, color={0,
          0,127}));
  connect(thermalZone.weather[3], weather.TerrestrialRadiation) annotation (
      Line(points={{-37.4,122.8},{-42,122.8},{-42,122},{-46,122},{-46,76.8},{
          -62.8667,76.8}},
                  color={0,0,127}));

  connect(thermalZone1.internalGains[1], zero.y)
    annotation (Line(points={{78,115.2},{78,110},{-77,110}}, color={0,0,127}));
  connect(thermalZone1.internalGains[2], zero.y)
    annotation (Line(points={{78,116},{78,110},{-77,110}},   color={0,0,127}));
  connect(thermalZone1.internalGains[3], zero.y)
    annotation (Line(points={{78,116.8},{78,110},{-77,110}},
                                                           color={0,0,127}));
  connect(thermalZone.internalGains[1], zero.y) annotation (Line(points={{-22,115.2},
          {-22,115.2},{-22,110},{-77,110}},           color={0,0,127}));
  connect(thermalZone.internalGains[2], zero.y) annotation (Line(points={{-22,116},
          {-22,110},{-77,110}}, color={0,0,127}));
  connect(thermalZone.internalGains[3], zero.y)
    annotation (Line(points={{-22,116.8},{-22,110},{-77,110}},
                                                             color={0,0,127}));
  connect(fixedHeatFlow.port, thermalZone.internalGainsRad) annotation (Line(
        points={{-78,128},{-68,128},{-68,100},{-26,100},{-26,116.2}},
                                                                    color={191,0,
          0}));
  connect(fixedHeatFlow.port, thermalZone1.internalGainsRad) annotation (Line(
        points={{-78,128},{-68,128},{-68,100},{74,100},{74,116.2}},
                                                                  color={191,0,0}));
  connect(temperatureSensor.port, thermalZone.internalGainsConv) annotation (
      Line(points={{-124,48},{-130,48},{-136,48},{-136,64},{-30,64},{-30,116.2}},
        color={191,0,0}));
  connect(temperatureSensor1.port, thermalZone1.internalGainsConv)
    annotation (Line(points={{76,48},{70,48},{70,116.2}},
                                                        color={191,0,0}));
  connect(temperatureSensor.T, roomAgent.T) annotation (Line(points={{-104,48},{
          -96,48},{-96,34},{-116,34},{-116,30}}, color={0,0,127}));
  connect(temperatureSensor1.T, roomAgent1.T)
    annotation (Line(points={{96,48},{108,48},{108,32}}, color={0,0,127}));
  connect(PID.u_m, temperatureSensor.T) annotation (Line(points={{-56,26},{-56,26},
          {-56,20},{-96,20},{-96,48},{-104,48}}, color={0,0,127}));
  connect(PID1.u_m, roomAgent1.T) annotation (Line(points={{150,26},{150,20},{122,
          20},{122,48},{108,48},{108,32}}, color={0,0,127}));
  connect(PID.u_s, zero1.y) annotation (Line(points={{-68,38},{-70,38},{-70,54},
          {-75,54}}, color={0,0,127}));
  connect(PID1.u_s, zero1.y) annotation (Line(points={{138,38},{128,38},{128,62},
          {-70,62},{-70,54},{-75,54}},  color={0,0,127}));
  connect(PID.y, val1.y) annotation (Line(points={{-45,38},{-38,38},{-38,-6},{10,
          -6}}, color={0,0,127}));
  connect(PID1.y, val.y) annotation (Line(points={{161,38},{170,38},{170,-6},{46,
          -6}}, color={0,0,127}));
  connect(fan.m_flow_in, zero2.y) annotation (Line(points={{84,-96.2},{92,-96.2},
          {92,-96},{99,-96}}, color={0,0,127}));
  connect(fixedHeatFlow.port, fan.heatPort) annotation (Line(points={{-78,128},{
          -74,128},{-68,128},{-68,100},{60,100},{60,-96},{65.2,-96}},
        color={191,0,0}));
  connect(bou.ports[1], fan.port_a)
    annotation (Line(points={{80,-130},{72,-130},{72,-106}},
                                                          color={0,127,255}));
  connect(hea1.Q_flow, cap2) annotation (Line(points={{43,-116},{120,-116},{120,
          -130},{150,-130}},
                           color={0,0,127}));
  connect(hea.Q_flow, cap1) annotation (Line(points={{-17,-116},{-4,-116},{-4,-110},
          {150,-110}},color={0,0,127}));
  connect(val.y_actual, valve1) annotation (Line(points={{41,-11},{38,-11},{38,
          4},{96,4},{96,-32},{172,-32}},
                                   color={0,0,127}));
  connect(valve2, val1.y_actual) annotation (Line(points={{174,-52},{174,-54},{
          -10,-54},{-10,-11},{5,-11}},        color={0,0,127}));
  connect(senTem.port, hea.port_a) annotation (Line(points={{-108,-92},{-108,-92},
          {-108,-122},{-38,-122}},    color={0,127,255}));
  connect(senTem.T, lessThreshold.u) annotation (Line(points={{-115,-82},{-114,-82},
          {-114,-76},{-114,-72},{-130,-72},{-130,-54},{-116,-54}},      color={
          0,0,127}));
  connect(lessThreshold.y, heatProducerAgent.OnOff_external) annotation (Line(
        points={{-93,-54},{-93,-54},{-70,-54},{-70,-99.4},{-46,-99.4}}, color={
          255,0,255}));
  connect(T_return, to_degC.y)
    annotation (Line(points={{-160,-82},{-143,-82}}, color={0,0,127}));
  connect(senTem.T, to_degC.u)
    annotation (Line(points={{-115,-82},{-120,-82}}, color={0,0,127}));
  connect(T2, to_degC1.y)
    annotation (Line(points={{-162,-4},{-152,-4},{-143,-4}}, color={0,0,127}));
  connect(T1, to_degC2.y)
    annotation (Line(points={{-162,-36},{-152,-36},{-143,-36}},
                                                          color={0,0,127}));
  connect(to_degC1.u, temperatureSensor.T) annotation (Line(points={{-120,-4},{-94,
          -4},{-94,48},{-104,48}},     color={0,0,127}));
  connect(to_degC2.u, temperatureSensor1.T) annotation (Line(points={{-120,-36},
          {-74,-36},{84,-36},{84,24},{96,24},{96,48}},
                                                  color={0,0,127}));
  connect(to_degC3.y, T_air) annotation (Line(points={{-139,108},{-158,108}},
                      color={0,0,127}));
  connect(weather.AirTemp, to_degC3.u) annotation (Line(points={{-62.8667,93.3},
          {-62.8667,116},{-108,116},{-108,108},{-116,108}}, color={0,0,127}));
  connect(weather.SkyRadiation, constantFactor1.rad) annotation (Line(points={{
          -62.8667,80.1},{76,80.1},{76,8},{102,8},{102,-74.2},{50,-74.2}},
        color={0,0,127}));
  connect(constantFactor1.electricity_free, electricity_free) annotation (Line(
        points={{51,-68.8},{92,-68.8},{92,-80},{104,-80},{104,-70},{174,-70}},
        color={255,0,255}));
  connect(and1.u1, lessThreshold.y) annotation (Line(points={{-12,-64},{-22,-64},
          {-22,-54},{-93,-54}}, color={255,0,255}));
  connect(electricity_free, and1.u2) annotation (Line(points={{174,-70},{102,
          -70},{102,-62},{18,-62},{18,-48},{-18,-48},{-18,-72},{-12,-72}},
                                                                         color=
          {255,0,255}));
  connect(greaterEqualThreshold.y, or1.u1)
    annotation (Line(points={{-1,-94},{2,-94}}, color={255,0,255}));
  connect(heatProducerAgent.setCapacityOut, greaterEqualThreshold.u)
    annotation (Line(points={{-30,-105},{-28,-105},{-28,-104},{-24,-104},{-24,-94}},
        color={0,0,127}));
  connect(or1.u2, and1.y) annotation (Line(points={{2,-86},{2,-80},{14,-80},{14,
          -64},{11,-64}}, color={255,0,255}));
  connect(or1.y, heatProducerAgent1.OnOff_external) annotation (Line(points={{25,-94},
          {28,-94},{28,-99.4},{34,-99.4}},         color={255,0,255}));
  connect(thermalZone.ventilationRate, zero.y)
    annotation (Line(points={{-34,116},{-34,110},{-77,110}}, color={0,0,127}));
  connect(thermalZone1.ventilationRate, zero.y)
    annotation (Line(points={{66,116},{66,110},{-77,110}}, color={0,0,127}));
  connect(weather.AirTemp, thermalZone.ventilationTemperature) annotation (Line(
        points={{-62.8667,93.3},{-42,93.3},{-42,118.1},{-37.5,118.1}}, color={0,
          0,127}));
  connect(thermalZone1.ventilationTemperature, weather.AirTemp) annotation (
      Line(points={{62.5,118.1},{44,118.1},{44,93.3},{-62.8667,93.3}}, color={0,
          0,127}));
  annotation (                                                          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-150,-150},{150,150}},
        initialScale=0.1)),
    experiment(StopTime=1.21e+006),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      inputs=false,
      auxiliaries=false),
    Documentation(revisions="<html>
<p>
<ul>
<li>November 2016, by Felix Bünning: Updated to use AixLib 0.3.2, included in HVACAgentBasedControl library</li>
<li>February 2016, by Felix Bünning: Developed and implemented</li>
</ul>
</p>
</html>", info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<ul>
<li>This model is a an example to show agent-based control with the provided library for a simple heating system</li>
<li>The system consists of two thermal zones, a boiler and a heating rod</li>
<li>With the help of a flexible cost function, the system prefers the heating rod when electricity comes from a PV panel for free and the boiler in all other cases</li>
<li>The agents used are two RoomAgents, two HeatProducerAgents, one Broker and one MessageNotification</li>
</ul>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>The system has two heat sources, which are a boiler and a heating rod. The heating rod is connected to a PV system. During the times the PV panel is able to provide electricity, the cost function of the heating rod considers the electricity free. During all other times the boiler is more cost efficient than the heating rod and is selected for heat generation first.</p>
<p>This model was used to present the HVACAgentBasedControl library in [Roozbeh Sangi, Felix B&uuml;nning, Marc Baranski, Johannes F&uuml;tterer, Dirk M&uuml;ller. A Platform for the Agent-based Control of HVAC Systems. Modelica Conference, 2017, Prague, Czech Republic]. For detailed information please refer to this source. </p>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p>The results generated by this model differ from the results presented in [Roozbeh Sangi, Felix B&uuml;nning, Marc Baranski, Johannes F&uuml;tterer, Dirk M&uuml;ller. A Platform for the Agent-based Control of HVAC Systems. Modelica Conference, 2017, Prague, Czech Republic] because an older version of the AixLib library was used. The model presented here was adapted to the use of the most recent AixLib library, which has a different physical model for the thermal zones than the version used originally. The result image below (generated with this model) however gives an impression on how the system behaves depneding on the price of electricity.</p>
<p><img src=\"modelica://HVACAgentBasedControl/Resources/Images/ExamplePV.PNG\"/> </p>
</html>"));
end BuildingWithPV;
