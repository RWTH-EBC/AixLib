within AixLib.Controls.HVACAgentBasedControl.Examples.BuildingHeatingSystems;
model BuildingHeating
  extends Modelica.Icons.Example;
  parameter AixLib.DataBase.Weather.TRYWeatherBaseDataDefinition weatherDataDay = AixLib.DataBase.Weather.TRYWinterDay();

  ThermalZones.ReducedOrder.ThermalZone.ThermalZone
              thermalZone(zoneParam=
        DataBase.ThermalZones.OfficePassiveHouse.OPH_1_OfficeNoHeaterCooler(),
                                                                 redeclare
      package                                                                      Medium =
                       Modelica.Media.Air.SimpleAir)                                                annotation(Placement(transformation(extent={{-60,58},
            {-34,84}})));
  ThermalZones.ReducedOrder.ThermalZone.ThermalZone
              thermalZone1(redeclare package Medium =
        Modelica.Media.Air.SimpleAir, zoneParam=
        DataBase.ThermalZones.OfficePassiveHouse.OPH_1_OfficeNoHeaterCooler())                      annotation(Placement(transformation(extent={{22,58},
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

  Fluid.Sources.Boundary_pT          bou(nPorts=1, redeclare package Medium =
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
  Modelica.Blocks.Sources.Constant roomSetPoint(k=273.15 + 22)
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
  CostFunctions.Economic.Constant_Economic_Cost constantFactor(eta=1)
    annotation (Placement(transformation(extent={{-100,-112},{-80,-92}})));
  CostFunctions.Economic.Constant_Economic_Cost constantFactor1(p=0.60, eta=1)
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
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.1,
    Ti=1,
    Td=0.01,
    y_start=0.3,
    yMin=0.1) annotation (Placement(transformation(extent={{98,24},{78,44}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    m_flow_nominal=1,
    dpValve_nominal(displayUnit="bar") = 10000,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
  Modelica.Blocks.Continuous.LimPID PID2(
    yMax=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    k=0.1,
    Ti=1,
    Td=0.01,
    y_start=0.3,
    yMin=0.1) annotation (Placement(transformation(extent={{-6,24},{-26,44}})));
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
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-122,92},{-102,112}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-150,130},{-130,150}})));
  Modelica.Blocks.Sources.CombiTimeTable InternalHeatGain(
    table=[0,0,0.1,0,0; 3540,0,0.1,0,0; 3600,0,0.1,0,0; 7140,0,0.1,0,0; 7200,0,
        0.1,0,0; 10740,0,0.1,0,0; 10800,0,0.1,0,0; 14340,0,0.1,0,0; 14400,0,0.1,
        0,0; 17940,0,0.1,0,0; 18000,0,0.1,0,0; 21540,0,0.1,0,0; 21600,0,0.1,0,0;
        25140,0,0.1,0,0; 25200,0,0.1,0,0; 28740,0,0.1,0,0; 28800,0,0.1,0,0;
        32340,0,0.1,0,0; 32400,0.6,0.6,1,1; 35940,0.6,0.6,1,1; 36000,1,1,1,1;
        39540,1,1,1,1; 39600,0.4,0.4,1,1; 43140,0.4,0.4,1,1; 43200,0,0.1,0,0;
        46740,0,0.1,0,0; 46800,0,0.1,0,0; 50340,0,0.1,0,0; 50400,0.6,0.6,1,1;
        53940,0.6,0.6,1,1; 54000,1,1,1,1; 57540,1,1,1,1; 57600,0.4,0.4,1,1;
        61140,0.4,0.4,1,1; 61200,0,0.1,0,0; 64740,0,0.1,0,0; 64800,0,0.1,0,0;
        68340,0,0.1,0,0; 68400,0,0.1,0,0; 71940,0,0.1,0,0; 72000,0,0.1,0,0;
        75540,0,0.1,0,0; 75600,0,0.1,0,0; 79140,0,0.1,0,0; 79200,0,0.1,0,0;
        82740,0,0.1,0,0; 82800,0,0.1,0,0; 86340,0,0.1,0,0; 86400,0,0.1,0,0;
        89940,0,0.1,0,0; 90000,0,0.1,0,0; 93540,0,0.1,0,0; 93600,0,0.1,0,0;
        97140,0,0.1,0,0; 97200,0,0.1,0,0; 100740,0,0.1,0,0; 100800,0,0.1,0,0;
        104340,0,0.1,0,0; 104400,0,0.1,0,0; 107940,0,0.1,0,0; 108000,0,0.1,0,0;
        111540,0,0.1,0,0; 111600,0,0.1,0,0; 115140,0,0.1,0,0; 115200,0,0.1,0,0;
        118740,0,0.1,0,0; 118800,0.6,0.6,1,1; 122340,0.6,0.6,1,1; 122400,1,1,1,
        1; 125940,1,1,1,1; 126000,0.4,0.4,1,1; 129540,0.4,0.4,1,1; 129600,0,0.1,
        0,0; 133140,0,0.1,0,0; 133200,0,0.1,0,0; 136740,0,0.1,0,0; 136800,0.6,
        0.6,1,1; 140340,0.6,0.6,1,1; 140400,1,1,1,1; 143940,1,1,1,1; 144000,0.4,
        0.4,1,1; 147540,0.4,0.4,1,1; 147600,0,0.1,0,0; 151140,0,0.1,0,0; 151200,
        0,0.1,0,0; 154740,0,0.1,0,0; 154800,0,0.1,0,0; 158340,0,0.1,0,0; 158400,
        0,0.1,0,0; 161940,0,0.1,0,0; 162000,0,0.1,0,0; 165540,0,0.1,0,0; 165600,
        0,0.1,0,0; 169140,0,0.1,0,0; 169200,0,0.1,0,0; 172740,0,0.1,0,0; 172800,
        0,0.1,0,0; 176340,0,0.1,0,0; 176400,0,0.1,0,0; 179940,0,0.1,0,0; 180000,
        0,0.1,0,0; 183540,0,0.1,0,0; 183600,0,0.1,0,0; 187140,0,0.1,0,0; 187200,
        0,0.1,0,0; 190740,0,0.1,0,0; 190800,0,0.1,0,0; 194340,0,0.1,0,0; 194400,
        0,0.1,0,0; 197940,0,0.1,0,0; 198000,0,0.1,0,0; 201540,0,0.1,0,0; 201600,
        0,0.1,0,0; 205140,0,0.1,0,0; 205200,0.6,0.6,1,1; 208740,0.6,0.6,1,1;
        208800,1,1,1,1; 212340,1,1,1,1; 212400,0.4,0.4,1,1; 215940,0.4,0.4,1,1;
        216000,0,0.1,0,0; 219540,0,0.1,0,0; 219600,0,0.1,0,0; 223140,0,0.1,0,0;
        223200,0.6,0.6,1,1; 226740,0.6,0.6,1,1; 226800,1,1,1,1; 230340,1,1,1,1;
        230400,0.4,0.4,1,1; 233940,0.4,0.4,1,1; 234000,0,0.1,0,0; 237540,0,0.1,
        0,0; 237600,0,0.1,0,0; 241140,0,0.1,0,0; 241200,0,0.1,0,0; 244740,0,0.1,
        0,0; 244800,0,0.1,0,0; 248340,0,0.1,0,0; 248400,0,0.1,0,0; 251940,0,0.1,
        0,0; 252000,0,0.1,0,0; 255540,0,0.1,0,0; 255600,0,0.1,0,0; 259140,0,0.1,
        0,0; 259200,0,0.1,0,0; 262740,0,0.1,0,0; 262800,0,0.1,0,0; 266340,0,0.1,
        0,0; 266400,0,0.1,0,0; 269940,0,0.1,0,0; 270000,0,0.1,0,0; 273540,0,0.1,
        0,0; 273600,0,0.1,0,0; 277140,0,0.1,0,0; 277200,0,0.1,0,0; 280740,0,0.1,
        0,0; 280800,0,0.1,0,0; 284340,0,0.1,0,0; 284400,0,0.1,0,0; 287940,0,0.1,
        0,0; 288000,0,0.1,0,0; 291540,0,0.1,0,0; 291600,0.6,0.6,1,1; 295140,0.6,
        0.6,1,1; 295200,1,1,1,1; 298740,1,1,1,1; 298800,0.4,0.4,1,1; 302340,0.4,
        0.4,1,1; 302400,0,0.1,0,0; 305940,0,0.1,0,0; 306000,0,0.1,0,0; 309540,0,
        0.1,0,0; 309600,0.6,0.6,1,1; 313140,0.6,0.6,1,1; 313200,1,1,1,1; 316740,
        1,1,1,1; 316800,0.4,0.4,1,1; 320340,0.4,0.4,1,1; 320400,0,0.1,0,0;
        323940,0,0.1,0,0; 324000,0,0.1,0,0; 327540,0,0.1,0,0; 327600,0,0.1,0,0;
        331140,0,0.1,0,0; 331200,0,0.1,0,0; 334740,0,0.1,0,0; 334800,0,0.1,0,0;
        338340,0,0.1,0,0; 338400,0,0.1,0,0; 341940,0,0.1,0,0; 342000,0,0.1,0,0;
        345540,0,0.1,0,0; 345600,0,0.1,0,0; 349140,0,0.1,0,0; 349200,0,0.1,0,0;
        352740,0,0.1,0,0; 352800,0,0.1,0,0; 356340,0,0.1,0,0; 356400,0,0.1,0,0;
        359940,0,0.1,0,0; 360000,0,0.1,0,0; 363540,0,0.1,0,0; 363600,0,0.1,0,0;
        367140,0,0.1,0,0; 367200,0,0.1,0,0; 370740,0,0.1,0,0; 370800,0,0.1,0,0;
        374340,0,0.1,0,0; 374400,0,0.1,0,0; 377940,0,0.1,0,0; 378000,0.6,0.6,1,
        1; 381540,0.6,0.6,1,1; 381600,1,1,1,1; 385140,1,1,1,1; 385200,0.4,0.4,1,
        1; 388740,0.4,0.4,1,1; 388800,0,0.1,0,0; 392340,0,0.1,0,0; 392400,0,0.1,
        0,0; 395940,0,0.1,0,0; 396000,0.6,0.6,1,1; 399540,0.6,0.6,1,1; 399600,1,
        1,1,1; 403140,1,1,1,1; 403200,0.4,0.4,1,1; 406740,0.4,0.4,1,1; 406800,0,
        0.1,0,0; 410340,0,0.1,0,0; 410400,0,0.1,0,0; 413940,0,0.1,0,0; 414000,0,
        0.1,0,0; 417540,0,0.1,0,0; 417600,0,0.1,0,0; 421140,0,0.1,0,0; 421200,0,
        0.1,0,0; 424740,0,0.1,0,0; 424800,0,0.1,0,0; 428340,0,0.1,0,0; 428400,0,
        0.1,0,0; 431940,0,0.1,0,0; 432000,0,0,0,0; 435540,0,0,0,0; 435600,0,0,0,
        0; 439140,0,0,0,0; 439200,0,0,0,0; 442740,0,0,0,0; 442800,0,0,0,0;
        446340,0,0,0,0; 446400,0,0,0,0; 449940,0,0,0,0; 450000,0,0,0,0; 453540,
        0,0,0,0; 453600,0,0,0,0; 457140,0,0,0,0; 457200,0,0,0,0; 460740,0,0,0,0;
        460800,0,0,0,0; 464340,0,0,0,0; 464400,0,0,0,0; 467940,0,0,0,0; 468000,
        0,0,0,0; 471540,0,0,0,0; 471600,0,0,0,0; 475140,0,0,0,0; 475200,0,0,0,0;
        478740,0,0,0,0; 478800,0,0,0,0; 482340,0,0,0,0; 482400,0,0,0,0; 485940,
        0,0,0,0; 486000,0,0,0,0; 489540,0,0,0,0; 489600,0,0,0,0; 493140,0,0,0,0;
        493200,0,0,0,0; 496740,0,0,0,0; 496800,0,0,0,0; 500340,0,0,0,0; 500400,
        0,0,0,0; 503940,0,0,0,0; 504000,0,0,0,0; 507540,0,0,0,0; 507600,0,0,0,0;
        511140,0,0,0,0; 511200,0,0,0,0; 514740,0,0,0,0; 514800,0,0,0,0; 518340,
        0,0,0,0; 518400,0,0,0,0; 521940,0,0,0,0; 522000,0,0,0,0; 525540,0,0,0,0;
        525600,0,0,0,0; 529140,0,0,0,0; 529200,0,0,0,0; 532740,0,0,0,0; 532800,
        0,0,0,0; 536340,0,0,0,0; 536400,0,0,0,0; 539940,0,0,0,0; 540000,0,0,0,0;
        543540,0,0,0,0; 543600,0,0,0,0; 547140,0,0,0,0; 547200,0,0,0,0; 550740,
        0,0,0,0; 550800,0,0,0,0; 554340,0,0,0,0; 554400,0,0,0,0; 557940,0,0,0,0;
        558000,0,0,0,0; 561540,0,0,0,0; 561600,0,0,0,0; 565140,0,0,0,0; 565200,
        0,0,0,0; 568740,0,0,0,0; 568800,0,0,0,0; 572340,0,0,0,0; 572400,0,0,0,0;
        575940,0,0,0,0; 576000,0,0,0,0; 579540,0,0,0,0; 579600,0,0,0,0; 583140,
        0,0,0,0; 583200,0,0,0,0; 586740,0,0,0,0; 586800,0,0,0,0; 590340,0,0,0,0;
        590400,0,0,0,0; 593940,0,0,0,0; 594000,0,0,0,0; 597540,0,0,0,0; 597600,
        0,0,0,0; 601140,0,0,0,0; 601200,0,0,0,0; 604740,0,0,0,0],
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-148,-34},{-128,-14}})));
  Modelica.Blocks.Math.Gain gain[3](k={0.8,0.8,0.8})
    annotation (Placement(transformation(extent={{-56,-28},{-46,-18}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.02,
    zeta=10,
    diameter=0.05)
    annotation (Placement(transformation(extent={{-66,-46},{-86,-26}})));

equation
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
          148,-21},{148,-50},{112,-50}},     color={0,0,127}));
  connect(volume.ports[1], hea.port_a) annotation (Line(points={{-72,-6},{-72,-6},
          {-72,-10},{-114,-10},{-114,-80},{-60,-80}}, color={0,127,255}));
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
  connect(InternalHeatGain.y, gain.u) annotation (Line(points={{-127,-24},{-92,
          -24},{-92,-23},{-57,-23}}, color={0,0,127}));
  connect(gain.y, thermalZone.intGains) annotation (Line(points={{-45.5,-23},{
          -36.6,-23},{-36.6,60.08}}, color={0,0,127}));
  connect(hydraulicResistance.port_a, fan.port_b) annotation (Line(points={{-66,
          -36},{100,-36},{100,-40}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, hea.port_a) annotation (Line(points={{-86,
          -36},{-86,-36},{-114,-36},{-114,-80},{-60,-80}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1)), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-150,-150},{150,150}},
        initialScale=0.1)),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model is a an example to show agent-based control with the
  provided library for a simple heating system
  </li>
  <li>The system consists of two thermal zones and two heat sources
  </li>
  <li>The agents used are two RoomAgents, two HeatProducerAgents, one
  Broker and one MessageNotification
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The two thermal zones are connected to a weather model, which results
  in different thermal loads depending on the boundary conditions. Each
  zone is equipped with a thermostatic valve, which allows to control
  the temperature in the zones to a limited degree. When the
  temperature in the zones goes above 20.5 or below 19.5 degC (and the
  valves are fully closed or opened) the RoomAgents become active and
  order an increase or decrease in heat supply from the broker. The
  broker calls for proposals from both heat suplliers. The suppliers
  use cost functions to determine the cost for the adjustments. The
  cheaper supplier is selcted by the broker and increases or decreases
  its heat supply.
</p>
<p>
  The trading procedure can be followed in the command line window of
  the dymosim.exe or found in the dslog.txt file after simulation. For
  one negotiation round it looks as follows.
</p>
<ul>
  <li>RoomAgent 10002 requests 25.1956 W of heat from Broker 10003.
  </li>
  <li>Broker 10003 collected the request of 25.1956 W of heat from
  Consumer 10002.
  </li>
  <li>Broker 10003 calls for proposal of 25.1956 W of heat from
  Producer 30001.
  </li>
  <li>HeatProducerAgent 30001 proposes adjustment of 25.1956 W for a
  price of 7.55868.
  </li>
  <li>Broker 10003 collects proposal of 25.1956 W of heat for the price
  of 7.55868 from Producer 30001.
  </li>
  <li>Broker 10003 calls for proposal of 25.1956 W of heat from
  Producer 30002.
  </li>
  <li>HeatProducerAgent 30002 proposes adjustment of 25.1956 W for a
  price of 15.1174.
  </li>
  <li>Broker 10003 collects proposal of 25.1956 W of heat for the price
  of 15.1174 from Producer 30002.
  </li>
  <li>Broker 10003 calculates an average price of 0.3 per W of heat.
  </li>
  <li>Broker 10003 asks for a confirmation of 25.1956 W of heat for the
  total price of 7.55868 from Consumer 10002.
  </li>
  <li>RoomAgent 10002 confirms the request of 25.1956 W of heat for a
  price of 7.55868.
  </li>
  <li>25.1956 W of heat were confirmed by consumers at broker 10003. Go
  on to final requests to producers.
  </li>
  <li>Broker 10003 accepts the proposal of 30001 and orders 25.1956 W
  of heat.
  </li>
  <li>HeatProducerAgent 30001 confirms the adjustment of 25.1956 W of
  heat. The setpoint is now 2251.37W.
  </li>
  <li>Broker 10003 rejects the proposal of 30002.
  </li>
</ul>
<ul>
  <li>July 2017, by Roozbeh Sangi: Documentation and modified
  </li>
  <li>November 2016, by Felix Bünning: Developed and implemented
  </li>
</ul>
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
