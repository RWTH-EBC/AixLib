within AixLib.Building.Benchmark.Generation;
model Generation
  Generation_Hot generation_Hot
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Fluid.Storage.BufferStorage HotWater(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    useHeatingRod=false,
    data=DataBase.Storage.Generic_New_2000l(),
    n=5,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    useHeatingCoil2=true)
    annotation (Placement(transformation(extent={{18,44},{48,82}})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{-104,166},{-84,186}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=363)
    annotation (Placement(transformation(extent={{-104,148},{-84,168}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{154,60},
            {146,68}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=30)
    annotation (Placement(transformation(extent={{-22,154},{-42,174}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=20000)
    annotation (Placement(transformation(extent={{-104,190},{-84,210}})));
  Modelica.Blocks.Sources.Step step(
    startTime=250,
    height=-0.5,
    offset=1)
    annotation (Placement(transformation(extent={{-130,132},{-110,152}})));

  Generation_heatPump generation_heatPump1
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=50000)
    annotation (Placement(transformation(extent={{-246,68},{-226,88}})));

  Fluid.Storage.BufferStorage ColdWater(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    useHeatingRod=false,
    n=5,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    useHeatingCoil2=false,
    upToDownHC1=false,
    data=DataBase.Storage.Generic_New_2000l(lengthHC1=200))
    annotation (Placement(transformation(extent={{18,-88},{48,-50}})));
  Modelica.Fluid.Vessels.OpenTank tank2(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    nPorts=2,
    level_start=0.07,
    T_start=293.15)
    annotation (Placement(transformation(extent={{42,86},{56,100}})));
  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    nPorts=2,
    level_start=0.07,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=293.15)
    annotation (Placement(transformation(extent={{42,-46},{56,-32}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Fluid.Movers.FlowControlled_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{60,76},{80,96}})));
  Fluid.Movers.FlowControlled_dp fan2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{64,-56},{84,-36}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=0)
    annotation (Placement(transformation(extent={{168,-10},{148,10}})));
  Generation_AirCooling generation_AirCooling
    annotation (Placement(transformation(extent={{-88,-88},{-68,-68}})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{-246,84},{-226,104}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=0)
    annotation (Placement(transformation(extent={{-248,102},{-228,122}})));
  Generation_geothermalProbe generation_geothermalProbe
    annotation (Placement(transformation(extent={{20,-40},{0,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=1)
    annotation (Placement(transformation(extent={{-248,50},{-228,70}})));
  Fluid.Actuators.Valves.ThreeWayLinear val4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-28,8},{-44,24}})));
  Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-56,-32},{-72,-16}})));
  Fluid.Actuators.Valves.ThreeWayLinear val2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-20,-32},{-36,-16}})));
  Fluid.Actuators.Valves.ThreeWayLinear val3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-16,-80},{0,-64}})));
  Fluid.Actuators.Valves.ThreeWayLinear val5(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10)
    annotation (Placement(transformation(extent={{-26,-64},{-42,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=343.15)  annotation(Placement(transformation(extent={{154,-72},
            {146,-64}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      table=[1,0,0,0,0; 2,0,1,1,0; 3,0,0,1,0; 4,1,1,1,1])
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
equation
  connect(generation_Hot.Fluid_out_Hot, HotWater.portHC1In) annotation (Line(
        points={{-60,73.8},{-32,73.8},{-32,73.83},{17.625,73.83}},color={0,127,
          255}));
  connect(generation_Hot.Fluid_in_Hot, HotWater.portHC1Out) annotation (Line(
        points={{-60,68},{-32,68},{-32,67.94},{17.8125,67.94}},color={0,127,255}));
  connect(HotWater.fluidportBottom2, Fluid_in_hot) annotation (Line(points={{37.3125,
          43.81},{37.3125,40},{100,40}},       color={0,127,255}));
  connect(tank2.ports[1], HotWater.fluidportTop2) annotation (Line(points={{47.6,86},
          {37.6875,86},{37.6875,82.19}},        color={0,127,255}));
  connect(tank1.ports[1], ColdWater.fluidportTop2) annotation (Line(points={{47.6,
          -46},{37.6875,-46},{37.6875,-49.81}},    color={0,127,255}));
  connect(ColdWater.fluidportBottom2, Fluid_in_cold) annotation (Line(points={{37.3125,
          -88.19},{37.3125,-94},{80,-94},{90,-94},{90,-80},{100,-80}},
                                                  color={0,127,255}));
  connect(tank2.ports[2], fan1.port_a)
    annotation (Line(points={{50.4,86},{60,86}}, color={0,127,255}));
  connect(fan1.port_b, Fluid_out_hot) annotation (Line(points={{80,86},{80,80},
          {100,80}},         color={0,127,255}));
  connect(fan2.port_b, Fluid_out_cold)
    annotation (Line(points={{84,-46},{92,-46},{92,-40},{100,-40}},
                                                  color={0,127,255}));
  connect(tank1.ports[2], fan2.port_a)
    annotation (Line(points={{50.4,-46},{64,-46}}, color={0,127,255}));
  connect(generation_Hot.isOn_boiler, generation_Hot.isOn_chp) annotation (Line(
        points={{-74,80},{-76,80}},                   color={255,0,255}));
  connect(HotWater.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation (
      Line(points={{17.8125,52.17},{8,52.17},{8,4},{-60,4}},            color={
          0,127,255}));
  connect(generation_heatPump1.Fluid_out_warm, val4.port_2)
    annotation (Line(points={{-60,16},{-44,16}}, color={0,127,255}));
  connect(val4.port_1, HotWater.portHC2In) annotation (Line(points={{-28,16},{0,
          16},{0,58.25},{17.8125,58.25}}, color={0,127,255}));
  connect(val2.port_1, generation_geothermalProbe.Fulid_out_Geothermal)
    annotation (Line(points={{-20,-24},{0,-24}}, color={0,127,255}));
  connect(val1.port_1, val2.port_2)
    annotation (Line(points={{-56,-24},{-36,-24}}, color={0,127,255}));
  connect(val1.port_2, generation_heatPump1.Fluid_out_cold) annotation (Line(
        points={{-72,-24},{-86,-24},{-86,4},{-80,4}}, color={0,127,255}));
  connect(generation_geothermalProbe.Fluid_in_Geothermal, generation_heatPump1.Fluid_in_cold)
    annotation (Line(points={{0,-36},{-94,-36},{-94,16},{-80,16}}, color={0,127,
          255}));
  connect(val1.port_3, ColdWater.portHC1In) annotation (Line(points={{-64,-32},
          {-64,-58.17},{17.625,-58.17}}, color={0,127,255}));
  connect(ColdWater.portHC1Out, val3.port_2) annotation (Line(points={{17.8125,
          -64.06},{0.90625,-64.06},{0.90625,-72},{0,-72}}, color={0,127,255}));
  connect(val3.port_3, val2.port_2) annotation (Line(points={{-8,-80},{-8,-94},
          {-48,-94},{-48,-24},{-36,-24}}, color={0,127,255}));
  connect(val2.port_3, generation_heatPump1.Fluid_in_cold) annotation (Line(
        points={{-28,-32},{-28,-36},{-94,-36},{-94,16},{-80,16}}, color={0,127,
          255}));
  connect(val3.port_1, val5.port_1)
    annotation (Line(points={{-16,-72},{-26,-72}}, color={0,127,255}));
  connect(val5.port_2, generation_AirCooling.Fluid_in_airCooler)
    annotation (Line(points={{-42,-72},{-68,-72}}, color={0,127,255}));
  connect(val5.port_3, val4.port_3) annotation (Line(points={{-34,-64},{-34,-46},
          {-42,-46},{-42,-6},{-36,-6},{-36,8}}, color={0,127,255}));
  connect(generation_AirCooling.Fluid_out_airCooler, generation_heatPump1.Fluid_in_warm)
    annotation (Line(points={{-68,-84},{-52,-84},{-52,4},{-60,4}}, color={0,127,
          255}));
  connect(generation_AirCooling.Fluid_out_airCooler, ColdWater.portHC1In)
    annotation (Line(points={{-68,-84},{-52,-84},{-52,-58.17},{17.625,-58.17}},
        color={0,127,255}));
  connect(HotWater.heatportOutside, fixedTemperature.port) annotation (Line(
        points={{47.625,64.14},{138,64},{146,64}}, color={191,0,0}));
  connect(ColdWater.heatportOutside, fixedTemperature1.port) annotation (Line(
        points={{47.625,-67.86},{96.8125,-67.86},{96.8125,-68},{146,-68}},
        color={191,0,0}));
  connect(fan2.dp_in, realExpression5.y) annotation (Line(points={{74,-34},{74,
          -20},{140,-20},{140,0},{147,0}}, color={0,0,127}));
  connect(fan1.dp_in, realExpression5.y) annotation (Line(points={{70,98},{70,
          108},{140,108},{140,0},{147,0}}, color={0,0,127}));
  connect(val1.y, combiTable1D.y[2]) annotation (Line(points={{-64,-14.4},{-64,
          -2},{-8,-2},{-8,40},{-79,40}}, color={0,0,127}));
  connect(val2.y, combiTable1D.y[3]) annotation (Line(points={{-28,-14.4},{-28,
          -2},{-8,-2},{-8,40},{-79,40}}, color={0,0,127}));
  connect(val3.y, combiTable1D.y[4])
    annotation (Line(points={{-8,-62.4},{-8,40},{-79,40}}, color={0,0,127}));
  connect(val5.y, combiTable1D.y[1]) annotation (Line(points={{-34,-81.6},{-34,
          -96},{6,-96},{6,-52},{-8,-52},{-8,40},{-79,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-22,124},{40,104}},
          lineColor={28,108,200},
          textString="Parameter müssen angepasst werden
"),                                                            Text(
          extent={{-50,-78},{-36,-92}},
          lineColor={28,108,200},
          textString="1"),                                     Text(
          extent={{-78,-6},{-64,-20}},
          lineColor={28,108,200},
          textString="2"),                                     Text(
          extent={{-42,-6},{-28,-20}},
          lineColor={28,108,200},
          textString="3"),                                     Text(
          extent={{-20,-78},{-6,-92}},
          lineColor={28,108,200},
          textString="4")}));
end Generation;
