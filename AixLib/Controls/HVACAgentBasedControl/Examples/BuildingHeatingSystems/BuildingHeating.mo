within AixLib.Controls.HVACAgentBasedControl.Examples.BuildingHeatingSystems;
model BuildingHeating
  extends Modelica.Icons.Example;
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();

  ThermalZones.ReducedOrder.ThermalZone.ThermalZone
              thermalZone(zoneParam=
        DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(), redeclare
      package Medium = Modelica.Media.Air.SimpleAir)                                                annotation(Placement(transformation(extent={{-60,58},
            {-34,84}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k=0)   annotation(Placement(transformation(extent={{-138,40},
            {-124,54}})));
  Modelica.Blocks.Sources.Constant infiltrationTemperature(k = 288.15) annotation(Placement(transformation(extent={{-138,62},
            {-124,76}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone
              thermalZone1(redeclare package Medium =
        Modelica.Media.Air.SimpleAir, zoneParam=
        DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office())                                    annotation(Placement(transformation(extent={{22,58},
            {48,84}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=2)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={100,-50})));
  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=2,
    dp_nominal(displayUnit="bar") = 5000,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));

  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=2,
    dp_nominal(displayUnit="bar") = 5000,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));

  AixLib.Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
      redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_small=0.001,
    zeta=10)
    annotation (Placement(transformation(extent={{-80,-46},{-100,-26}})));
  AixLib.Fluid.Sources.FixedBoundary bou(nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{142,-80},{122,-60}})));
  Agents.RoomAgent roomAgent(              startTime=60,
    threshold=0.5,
    broker=10003,
    sampleRate=1,
    sampleTriggerTime=120,
    G=10)
    annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
  Agents.RoomAgent roomAgent1(
    name=10002,
    startTime=70,
    threshold=0.5,
    broker=10003,
    sampleRate=1,
    sampleTriggerTime=120,
    G=10)
    annotation (Placement(transformation(extent={{20,120},{40,140}})));
  Modelica.Blocks.Sources.Constant roomSetPoint(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-138,-6},{-124,8}})));
  inner Agents.MessageNotification messageNotification(n=5)
    annotation (Placement(transformation(extent={{120,120},{140,140}})));
  Agents.HeatProducerAgent heatProducerAgent(                  name=30001,
    maxCapacity=3000,
    sampleRate=1,
    setCapacity(start=1),
    currentCapacityDiscrete(start=1))
    annotation (Placement(transformation(extent={{-100,-138},{-80,-118}})));
  Agents.HeatProducerAgent heatProducerAgent1(name=30002,
    maxCapacity=10000,
    sampleRate=1,
    setCapacity(start=1),
    currentCapacityDiscrete(start=1))
    annotation (Placement(transformation(extent={{-20,-138},{0,-118}})));
  CostFunctions.Economic.ConstantFactor constantFactor(eta=1)
    annotation (Placement(transformation(extent={{-100,-112},{-80,-92}})));
  CostFunctions.Economic.ConstantFactor constantFactor1(p=0.60, eta=1)
    annotation (Placement(transformation(extent={{-20,-112},{0,-92}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-140,-142},{-120,-122}})));
  Modelica.Blocks.Sources.Constant massFlowRate(k=5)
    annotation (Placement(transformation(extent={{124,-28},{138,-14}})));
  Agents.Broker broker(name=10003, sampleRate=1)
    annotation (Placement(transformation(extent={{118,60},{138,80}})));
  Modelica.Fluid.Vessels.ClosedVolume volume(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_portsData=false,
    use_HeatTransfer=true,
    V=30*1E-3)
    annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));

  Modelica.Fluid.Vessels.ClosedVolume volume1(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_portsData=false,
    use_HeatTransfer=true,
    V=30*1E-3) annotation (Placement(transformation(extent={{12,-6},{32,14}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=2000)
    annotation (Placement(transformation(extent={{-78,24},{-58,44}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=
       2000) annotation (Placement(transformation(extent={{12,24},{32,44}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear val1(
    m_flow_nominal=1,
    dpValve_nominal(displayUnit="bar") = 10000,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{80,-22},{60,-2}})));
  Modelica.Blocks.Continuous.LimPID PID1(
    yMax=1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    k=0.1,
    Ti=1,
    Td=0.01,
    y_start=0.3,
    yMin=0.1)
    annotation (Placement(transformation(extent={{98,24},{78,44}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    m_flow_nominal=1,
    dpValve_nominal(displayUnit="bar") = 10000,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
  Modelica.Blocks.Continuous.LimPID PID2(
    yMax=1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    k=0.1,
    Ti=1,
    Td=0.01,
    y_start=0.3,
    yMin=0.1)
    annotation (Placement(transformation(extent={{-6,24},{-26,44}})));
  Modelica.Blocks.Sources.Constant internalGains[3](k={0,0,0})
    annotation (Placement(transformation(extent={{-138,16},{-124,30}})));
  Modelica.Blocks.Interfaces.RealOutput T_room(unit="K") "Temperature in room"
    annotation (Placement(transformation(extent={{140,96},{160,116}})));
  Modelica.Blocks.Interfaces.RealOutput T_room1(unit="K") "Temperature in room"
    annotation (Placement(transformation(extent={{140,78},{160,98}})));
  Modelica.Blocks.Interfaces.RealOutput Cap_device(unit="W")
    "Capacity of heating device"
    annotation (Placement(transformation(extent={{140,-110},{160,-90}})));
  Modelica.Blocks.Interfaces.RealOutput Cap_device1(unit="W")
    "Capacity of heating device"
    annotation (Placement(transformation(extent={{140,-136},{160,-116}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam="modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
    "Weather data reader"
    annotation (Placement(transformation(extent={{-122,92},{-102,112}})));
equation
  connect(hydraulicResistance.port_a, fan.port_b) annotation (Line(points={{-80,
          -36},{100,-36},{100,-40}}, color={0,127,255}));
  connect(hea.port_b, hea1.port_a) annotation (Line(points={{-40,-80},{-10,-80},
          {20,-80}}, color={0,127,255}));
  connect(hea1.port_b, fan.port_a) annotation (Line(points={{40,-80},{66,-80},{
          100,-80},{100,-60}}, color={0,127,255}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{122,-70},{100,-70},
          {100,-60}}, color={0,127,255}));
  connect(heatProducerAgent.calcCapacity, constantFactor.capacity)
    annotation (Line(points={{-96,-119},{-96,-110}}, color={0,0,127}));
  connect(heatProducerAgent.calcCost, constantFactor.cost) annotation (Line(
        points={{-84,-120},{-84,-118},{-84,-114},{-84,-111}}, color={0,0,127}));
  connect(heatProducerAgent1.calcCapacity, constantFactor1.capacity)
    annotation (Line(points={{-16,-119},{-16,-119},{-16,-110}},   color={0,0,
          127}));
  connect(heatProducerAgent1.calcCost, constantFactor1.cost)
    annotation (Line(points={{-4,-120},{-4,-111}}, color={0,0,127}));
  connect(heatProducerAgent.setCapacityOut, hea.u) annotation (Line(points={{
          -82,-137},{-82,-144},{-68,-144},{-68,-74},{-62,-74}}, color={0,0,127}));
  connect(heatProducerAgent1.setCapacityOut, hea1.u) annotation (Line(points={{-2,-137},
          {-2,-144},{8,-144},{8,-74},{18,-74}},          color={0,0,127}));
  connect(hea1.Q_flow, heatProducerAgent1.currentCapacity) annotation (Line(
        points={{41,-74},{44,-74},{44,-146},{-18,-146},{-18,-136}}, color={0,0,
          127}));
  connect(hea.Q_flow, heatProducerAgent.currentCapacity) annotation (Line(
        points={{-39,-74},{-36,-74},{-36,-144},{-98,-144},{-98,-136}}, color={0,
          0,127}));
  connect(booleanExpression.y, heatProducerAgent.OnOff_external) annotation (
      Line(points={{-119,-132},{-98,-132},{-98,-131.4}}, color={255,0,255}));
  connect(booleanExpression.y, heatProducerAgent1.OnOff_external) annotation (
      Line(points={{-119,-132},{-110,-132},{-110,-148},{-26,-148},{-26,-131.4},{
          -18,-131.4}},  color={255,0,255}));
  connect(massFlowRate.y, fan.m_flow_in) annotation (Line(points={{138.7,-21},{
          148,-21},{148,-50.2},{112,-50.2}}, color={0,0,127}));
  connect(volume.ports[1], hea.port_a) annotation (Line(points={{-72,-6},{-72,-6},
          {-72,-10},{-114,-10},{-114,-80},{-60,-80}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, hea.port_a) annotation (Line(points={{-100,
          -36},{-114,-36},{-114,-80},{-60,-80}}, color={0,127,255}));
  connect(volume1.ports[1], hea.port_a) annotation (Line(points={{20,-6},{20,-6},
          {20,-28},{-114,-28},{-114,-80},{-60,-80}}, color={0,127,255}));
  connect(volume.heatPort, thermalConductor.port_a) annotation (Line(points={{-80,
          4},{-88,4},{-88,34},{-78,34}}, color={191,0,0}));
  connect(thermalConductor1.port_a, volume1.heatPort)
    annotation (Line(points={{12,34},{6,34},{6,4},{12,4}}, color={191,0,0}));
  connect(PID1.y, val1.y)
    annotation (Line(points={{77,34},{70,34},{70,0}}, color={0,0,127}));
  connect(val1.port_b, volume1.ports[2])
    annotation (Line(points={{60,-12},{24,-12},{24,-6}}, color={0,127,255}));
  connect(val1.port_a, fan.port_b) annotation (Line(points={{80,-12},{100,-12},{
          100,-40}}, color={0,127,255}));
  connect(val.port_b, volume.ports[2]) annotation (Line(points={{-40,-10},{-40,-10},
          {-68,-10},{-68,-6}}, color={0,127,255}));
  connect(val.port_a, fan.port_b) annotation (Line(points={{-20,-10},{-6,-10},{-6,
          -20},{100,-20},{100,-40}}, color={0,127,255}));
  connect(PID2.y, val.y)
    annotation (Line(points={{-27,34},{-30,34},{-30,2}}, color={0,0,127}));
  connect(roomSetPoint.y, PID1.u_s) annotation (Line(points={{-123.3,1},{-106,1},
          {-106,20},{106,20},{106,34},{100,34}}, color={0,0,127}));
  connect(PID2.u_s, PID1.u_s) annotation (Line(points={{-4,34},{0,34},{0,20},{106,
          20},{106,34},{100,34}}, color={0,0,127}));
  connect(hea.Q_flow, Cap_device) annotation (Line(points={{-39,-74},{-32,-74},
          {-32,-62},{82,-62},{82,-100},{150,-100}}, color={0,0,127}));
  connect(hea1.Q_flow, Cap_device1) annotation (Line(points={{41,-74},{74,-74},
          {74,-126},{150,-126}}, color={0,0,127}));
  connect(thermalConductor.port_b, thermalZone.intGainsConv) annotation (Line(
        points={{-58,34},{-46,34},{-30,34},{-30,64.5},{-34,64.5}}, color={191,0,
          0}));
  connect(thermalZone.intGainsRad, thermalZone.intGainsConv) annotation (Line(
        points={{-34,69.7},{-32,69.7},{-32,70},{-30,70},{-30,64.5},{-34,64.5}},
        color={191,0,0}));
  connect(thermalConductor1.port_b, thermalZone1.intGainsConv) annotation (Line(
        points={{32,34},{54,34},{54,64.5},{48,64.5}}, color={191,0,0}));
  connect(thermalZone1.intGainsRad, thermalZone1.intGainsConv) annotation (Line(
        points={{48,69.7},{52,69.7},{52,70},{54,70},{54,64.5},{48,64.5}}, color=
         {191,0,0}));
  connect(thermalZone.ventTemp, infiltrationTemperature.y) annotation (Line(
        points={{-61.69,65.93},{-91.845,65.93},{-91.845,69},{-123.3,69}}, color=
         {0,0,127}));
  connect(thermalZone1.ventTemp, infiltrationTemperature.y) annotation (Line(
        points={{20.31,65.93},{-24,65.93},{-24,86},{-72,86},{-72,69},{-100,69},
          {-123.3,69}}, color={0,0,127}));
  connect(infiltrationRate.y, thermalZone.ventRate) annotation (Line(points={{
          -123.3,47},{-86,47},{-86,56},{-56.1,56},{-56.1,60.08}}, color={0,0,
          127}));
  connect(thermalZone1.ventRate, thermalZone.ventRate) annotation (Line(points=
          {{25.9,60.08},{25.9,56},{-56.1,56},{-56.1,60.08}}, color={0,0,127}));
  connect(thermalZone.intGains, internalGains.y) annotation (Line(points={{
          -36.6,60.08},{-36.6,48},{-84,48},{-84,38},{-114,38},{-114,23},{-123.3,
          23}}, color={0,0,127}));
  connect(thermalZone1.intGains, internalGains.y) annotation (Line(points={{
          45.4,60.08},{45.4,48},{-62,48},{-84,48},{-84,38},{-114,38},{-114,23},
          {-123.3,23}}, color={0,0,127}));
  connect(weaDat.weaBus, thermalZone.weaBus) annotation (Line(
      points={{-102,102},{-64,102},{-64,71},{-60,71}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-102,102},{-76,102},{-48,102},{-48,92},{-16,92},{-16,71},{22,71}},
      color={255,204,51},
      thickness=0.5));

  connect(thermalZone.TAir, roomAgent.T) annotation (Line(points={{-32.7,78.8},
          {-20,78.8},{-20,144},{-52,144},{-52,138}}, color={0,0,127}));
  connect(thermalZone1.TAir, roomAgent1.T) annotation (Line(points={{49.3,78.8},
          {62,78.8},{62,144},{28,144},{28,138}}, color={0,0,127}));
  connect(thermalZone1.TAir, T_room1) annotation (Line(points={{49.3,78.8},{80,
          78.8},{80,88},{150,88}}, color={0,0,127}));
  connect(thermalZone1.TAir, PID1.u_m) annotation (Line(points={{49.3,78.8},{
          112,78.8},{112,12},{88,12},{88,22}}, color={0,0,127}));
  connect(PID2.u_m, thermalZone.TAir) annotation (Line(points={{-16,22},{-16,12},
          {-2,12},{-2,78.8},{-32.7,78.8}}, color={0,0,127}));
  connect(thermalZone.TAir, T_room) annotation (Line(points={{-32.7,78.8},{4,
          78.8},{4,106},{150,106}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1)), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-150,-150},{150,150}},
        initialScale=0.1)),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<ul>
<li>This model is a an example to show agent-based control with the provided library for a simple heating system</li>
<li>The system consists of two thermal zones and two heat sources</li>
<li>The agents used are two RoomAgents, two HeatProducerAgents, one Broker and one MessageNotification</li>
</ul>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>The two thermal zones are connected to a weather model, which results in different thermal loads depending on the boundary conditions. Each zone is equipped with a thermostatic valve,
which allows to control the temperature in the zones to a limited degree. When the temperature in the zones goes above 20.5 or below 19.5 degC (and the valves are fully closed or opened) 
the RoomAgents become active and order an increase or decrease in heat supply from the broker. The broker calls for proposals from both heat suplliers. The suppliers use cost functions to 
determine the cost for the adjustments. The cheaper supplier is selcted by the broker and increases or decreases its heat supply.</p>

<h4><span style=\"color: #008000\">Example Results</span></h4>
<p>The results show that the agent-based control system keeps the room temperature between 19.2 and 20.8 degC most of the time.</p>
<p><img src=\"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/ExampleT.PNG\"/></p>
<p>The results for the capacity of the heat suppliers further show that for an increase in heat supply the cheaper supplier is always chosen first and for a decrease the more expensive one. In real-life systems this could be
a heat-pump and a heating rod for example.</p>
<p><img src=\"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/ExampleCap.PNG\"/></p>
<p>The trading procedure can be followed in the command line window of the dymosim.exe or found in the dslog.txt file after simulation. For one negotiation round it looks as follows.</p>

<ul>
<li>RoomAgent 10002 requests 25.1956 W of heat from Broker 10003.</li>
<li>Broker 10003 collected the request of 25.1956 W of heat from Consumer 10002.</li>
<li>Broker 10003 calls for proposal of 25.1956 W of heat from Producer 30001.</li>
<li>HeatProducerAgent 30001 proposes adjustment of 25.1956 W for a price of 7.55868.</li>
<li>Broker 10003 collects proposal of 25.1956 W of heat for the price of 7.55868 from Producer 30001.</li>
<li>Broker 10003 calls for proposal of 25.1956 W of heat from Producer 30002.</li>
<li>HeatProducerAgent 30002 proposes adjustment of 25.1956 W for a price of 15.1174.</li>
<li>Broker 10003 collects proposal of 25.1956 W of heat for the price of 15.1174 from Producer 30002.</li>
<li>Broker 10003 calculates an average price of 0.3 per W of heat.</li>
<li>Broker 10003 asks for a confirmation of 25.1956 W of heat for the total price of 7.55868 from Consumer 10002.</li>
<li>RoomAgent 10002 confirms the request of 25.1956 W of heat for a price of 7.55868.</li>
<li>25.1956 W of heat were confirmed by consumers at broker 10003. Go on to final requests to producers.</li>
<li>Broker 10003 accepts the proposal of 30001 and orders 25.1956 W of heat.</li>
<li>HeatProducerAgent 30001 confirms the adjustment of 25.1956 W of heat. The setpoint is now 2251.37W.</li>
<li>Broker 10003 rejects the proposal of 30002.</li>
</ul>
</html>", revisions="<html>
<p>
<ul>
<li>November 2016, by Felix Bünning: Developed and implemented</li>
</ul>
</p>
</html>"),
    experiment(StartTime=2.6784e+006, StopTime=3.2832e+006),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      inputs=false,
      auxiliaries=false),
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end BuildingHeating;
