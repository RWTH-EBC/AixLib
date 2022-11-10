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
  HVACAgentBasedControl.Agents.Broker broker(name=20001)
    annotation (Placement(transformation(extent={{100,120},{120,140}})));
  HVACAgentBasedControl.Agents.HeatProducerAgent heatProducerAgent(
    name=30001,
    costCurrent(start=0),
    setCapacity(start=0),
    currentCapacityDiscrete(start=0),
    maxCapacity=3000)
    annotation (Placement(transformation(extent={{-48,-106},{-28,-86}})));
  AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic.Constant_Economic_Cost constantFactor(p=0.067)
    annotation (Placement(transformation(extent={{-48,-84},{-28,-64}})));
  AixLib.Controls.HVACAgentBasedControl.CostFunctions.Economic.PV_Variable_Economic_Cost variableFactorPV(
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
  Modelica.Blocks.Continuous.LimPID PID(
    yMax=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.1,
    Ti=1,
    Td=0.01,
    yMin=0.2,
    y_start=0.2)
    annotation (Placement(transformation(extent={{-66,28},{-46,48}})));
  Modelica.Blocks.Continuous.LimPID PID1(
    yMax=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
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
        origin={-84,8})));
  Modelica.Blocks.Sources.RealExpression zero2(y=1)
                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-96})));
  Fluid.Sources.Boundary_pT          bou(nPorts=1, redeclare package Medium =
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

  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-60,118},{-40,138}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone
              thermalZone(redeclare package Medium =
        Modelica.Media.Air.SimpleAir, zoneParam=
        DataBase.ThermalZones.OfficePassiveHouse.OPH_1_OfficeNoHeaterCooler())                      annotation(Placement(transformation(extent={{-18,70},
            {8,96}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone
              thermalZone1(redeclare package Medium =
        Modelica.Media.Air.SimpleAir, zoneParam=
        DataBase.ThermalZones.OfficePassiveHouse.OPH_1_OfficeNoHeaterCooler())                      annotation(Placement(transformation(extent={{64,70},
            {90,96}})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{18,112},{52,144}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Sources.Constant internalGains[3](k={0,0,0})
    annotation (Placement(transformation(extent={{-92,36},{-78,50}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.02,
    zeta=10,
    diameter=0.05)
    annotation (Placement(transformation(extent={{-40,-48},{-60,-28}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = Medium,
    m_flow_nominal=0.02,
    zeta=10,
    diameter=0.05)
    annotation (Placement(transformation(extent={{-10,-132},{10,-112}})));
equation
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
  connect(heatProducerAgent1.calcCapacity, variableFactorPV.capacity)
    annotation (Line(points={{36,-87},{36,-82}}, color={0,0,127}));
  connect(variableFactorPV.cost, heatProducerAgent1.calcCost)
    annotation (Line(points={{48,-83},{48,-85.5},{48,-88}}, color={0,0,127}));

  connect(PID1.u_m, roomAgent1.T) annotation (Line(points={{150,26},{150,20},{122,
          20},{122,48},{108,48},{108,32}}, color={0,0,127}));
  connect(PID.u_s, zero1.y) annotation (Line(points={{-68,38},{-70,38},{-70,8},
          {-73,8}},  color={0,0,127}));
  connect(PID1.u_s, zero1.y) annotation (Line(points={{138,38},{128,38},{128,62},
          {-70,62},{-70,8},{-73,8}},    color={0,0,127}));
  connect(PID.y, val1.y) annotation (Line(points={{-45,38},{-38,38},{-38,-6},{10,
          -6}}, color={0,0,127}));
  connect(PID1.y, val.y) annotation (Line(points={{161,38},{170,38},{170,-6},{46,
          -6}}, color={0,0,127}));
  connect(fan.m_flow_in, zero2.y) annotation (Line(points={{84,-96},{92,-96},{
          92,-96},{99,-96}},  color={0,0,127}));
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
  connect(to_degC3.y, T_air) annotation (Line(points={{-139,108},{-158,108}},
                      color={0,0,127}));
  connect(variableFactorPV.electricity_free, electricity_free) annotation (Line(
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
  connect(weaDat.weaBus, thermalZone1.weaBus) annotation (Line(
      points={{-40,128},{-40,128},{-6,128},{-6,104},{26,104},{26,83},{64,83}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,thermalZone. weaBus) annotation (Line(
      points={{-40,128},{-22,128},{-22,83},{-18,83}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-40,128},{-2,128},{-2,128},{35,128}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(variableFactorPV.rad, weaBus.HGloHor) annotation (Line(points={{50,-74.2},
          {66,-74.2},{66,-76},{120,-76},{120,108},{68,108},{68,128},{35,128}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vol.heatPort, thermalZone.intGainsConv) annotation (Line(points={{-18,
          20},{-24,20},{-24,38},{8,38},{8,76.5}}, color={191,0,0}));
  connect(vol.heatPort, thermalZone.intGainsRad) annotation (Line(points={{-18,
          20},{-22,20},{-22,18},{-24,18},{-24,38},{8,38},{8,81.7}}, color={191,
          0,0}));
  connect(vol1.heatPort, thermalZone1.intGainsConv) annotation (Line(points={{
          38,20},{50,20},{50,68},{96,68},{96,76.5},{90,76.5}}, color={191,0,0}));
  connect(vol1.heatPort, thermalZone1.intGainsRad) annotation (Line(points={{38,
          20},{50,20},{50,68},{98,68},{98,81.7},{90,81.7}}, color={191,0,0}));
  connect(thermalZone.intGains, internalGains.y) annotation (Line(points={{5.4,
          72.08},{5.4,68},{-40,68},{-40,58},{-70,58},{-70,43},{-77.3,43}},
        color={0,0,127}));
  connect(thermalZone1.intGains, internalGains.y) annotation (Line(points={{
          87.4,72.08},{87.4,68},{-18,68},{-40,68},{-40,58},{-70,58},{-70,43},{
          -77.3,43}}, color={0,0,127}));
  connect(roomAgent.T, PID.u_m) annotation (Line(points={{-116,30},{-116,38},{
          -100,38},{-100,18},{-56,18},{-56,26}}, color={0,0,127}));
  connect(thermalZone1.TAir, roomAgent1.T) annotation (Line(points={{91.3,90.8},
          {108,90.8},{108,32}}, color={0,0,127}));
  connect(thermalZone.TAir, roomAgent.T) annotation (Line(points={{9.3,90.8},{
          16,90.8},{16,56},{-116,56},{-116,30}}, color={0,0,127}));
  connect(to_degC3.u, weaBus.TDryBul) annotation (Line(points={{-116,108},{-108,
          108},{-108,142},{35,142},{35,128}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(to_degC1.u, roomAgent.T) annotation (Line(points={{-120,-4},{-112,-4},
          {-102,-4},{-102,36},{-116,36},{-116,30}}, color={0,0,127}));
  connect(to_degC2.u, roomAgent1.T) annotation (Line(points={{-120,-36},{-108,
          -36},{-108,-28},{80,-28},{80,40},{108,40},{108,32}}, color={0,0,127}));
  connect(fan.port_b, hydraulicResistance1.port_a) annotation (Line(points={{72,
          -86},{72,-86},{72,-38},{-40,-38}}, color={0,127,255}));
  connect(hydraulicResistance1.port_b, hea.port_a) annotation (Line(points={{
          -60,-38},{-60,-38},{-80,-38},{-80,-122},{-38,-122}}, color={0,127,255}));
  connect(hea.port_b, hydraulicResistance.port_a) annotation (Line(points={{-18,
          -122},{-14,-122},{-10,-122}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, hea1.port_a)
    annotation (Line(points={{10,-122},{22,-122}}, color={0,127,255}));
  annotation (                                                          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-150,-150},{150,150}},
        initialScale=0.1)),
    experiment(StopTime=1.21e+006),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      inputs=false,
      auxiliaries=false),
    Documentation(revisions="<html><ul>
  <li>July 2017, by Roozbeh Sangi: Documentation and model modified
  </li>
  <li>November 2016, by Felix Bünning: Updated to use AixLib 0.3.2,
  included in HVACAgentBasedControl library
  </li>
  <li>February 2016, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a an example to show agent-based control with the
  provided library for a simple heating system
  </li>
  <li>The system consists of two thermal zones, a boiler and a heating
  rod
  </li>
  <li>With the help of a flexible cost function, the system prefers the
  heating rod when electricity comes from a PV panel for free and the
  boiler in all other cases
  </li>
  <li>The agents used are two RoomAgents, two HeatProducerAgents, one
  Broker and one MessageNotification
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The system has two heat sources, which are a boiler and a heating
  rod. The heating rod is connected to a PV system. During the times
  the PV panel is able to provide electricity, the cost function of the
  heating rod considers the electricity free. During all other times
  the boiler is more cost efficient than the heating rod and is
  selected for heat generation first.
</p>
<p>
  This model was used to present the HVACAgentBasedControl library in
  [Roozbeh Sangi, Felix Bünning, Johannes Fütterer, Dirk Müller. A
  Platform for the Agent-based Control of HVAC Systems. Modelica
  Conference, 2017, Prague, Czech Republic]. For detailed information
  please refer to this source.
</p>
</html>"));
end BuildingWithPV;
