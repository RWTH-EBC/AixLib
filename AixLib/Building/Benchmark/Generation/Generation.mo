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
    useHeatingCoil2=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff)
    annotation (Placement(transformation(extent={{18,44},{48,82}})));

  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{-122,114},{-102,134}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=363)
    annotation (Placement(transformation(extent={{-122,96},{-102,116}})));

  Modelica.Blocks.Sources.RealExpression realExpression2(y=30)
    annotation (Placement(transformation(extent={{-24,128},{-44,148}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=0)
    annotation (Placement(transformation(extent={{-122,130},{-102,150}})));

  Generation_heatPump generation_heatPump1
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

  Fluid.Storage.BufferStorage ColdWater(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    useHeatingRod=false,
    n=5,
    useHeatingCoil2=false,
    upToDownHC1=false,
    data=DataBase.Storage.Generic_New_2000l(lengthHC1=200),
    useHeatingCoil1=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff)
    annotation (Placement(transformation(extent={{18,-88},{48,-50}})));
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
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
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
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

  Fluid.Actuators.Valves.ThreeWayLinear val4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10,
    y_start=0)
    annotation (Placement(transformation(extent={{-20,8},{-36,24}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=0)
    annotation (Placement(transformation(extent={{-134,12},{-114,32}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=false)
    annotation (Placement(transformation(extent={{-134,-4},{-114,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=200)
    annotation (Placement(transformation(extent={{-150,-44},{-130,-24}})));
  Modelica.Blocks.Sources.RealExpression realExpression11(y=273.15 + 5)
    annotation (Placement(transformation(extent={{-150,-60},{-130,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=1)
    annotation (Placement(transformation(extent={{-134,50},{-114,70}})));
  Generation_geothermalProbe generation_geothermalProbe annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-50,-90})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    dpValve_nominal=10) annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-85,-9})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    dpValve_nominal=10) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-85,-67})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    dpValve_nominal=10) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-85,-45})));

  Fluid.Movers.FlowControlled_dp fan3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-68,-56})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=0)
    annotation (Placement(transformation(extent={{-150,-28},{-130,-8}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=1)
    annotation (Placement(transformation(extent={{-150,-94},{-130,-74}})));
  Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-50,-56})));
  Fluid.Movers.FlowControlled_dp fan4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-68,-22})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=0)
    annotation (Placement(transformation(extent={{-150,-110},{-130,-90}})));
  Modelica.Blocks.Sources.Step step(
    height=-80000,
    offset=80000,
    startTime=10000)
    annotation (Placement(transformation(extent={{-178,-76},{-158,-56}})));
  Fluid.Storage.BufferStorage HotWater2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    useHeatingRod=false,
    data=DataBase.Storage.Generic_New_2000l(),
    n=5,
    useHeatingCoil2=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff)
    annotation (Placement(transformation(extent={{16,-18},{46,20}})));
  Fluid.Movers.FlowControlled_dp fan5(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{58,14},{78,34}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(
                                                      redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(
                                                     redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Fluid.Sources.Boundary_pT bou4(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={42,98})));
  Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10,
    y_start=0)
    annotation (Placement(transformation(extent={{-6,66},{-22,82}})));
  Fluid.Actuators.Valves.ThreeWayLinear val2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=3,
    dpValve_nominal=10,
    y_start=0)
    annotation (Placement(transformation(extent={{2,8},{-14,24}})));
equation
  connect(generation_Hot.Fluid_in_Hot, HotWater.portHC1Out) annotation (Line(
        points={{-60,68},{-32,68},{-32,67.94},{17.8125,67.94}},color={0,127,255}));
  connect(HotWater.fluidportBottom2, Fluid_in_hot) annotation (Line(points={{37.3125,
          43.81},{37.3125,40},{100,40}},       color={0,127,255}));
  connect(fan1.port_b, Fluid_out_hot) annotation (Line(points={{80,90},{80,80},
          {100,80}},         color={0,127,255}));
  connect(fan2.port_b, Fluid_out_cold)
    annotation (Line(points={{84,-46},{92,-46},{92,-40},{100,-40}},
                                                  color={0,127,255}));
  connect(generation_Hot.isOn_boiler, generation_Hot.isOn_chp) annotation (Line(
        points={{-74,80},{-76,80}},                   color={255,0,255}));
  connect(HotWater.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation (
      Line(points={{17.8125,52.17},{8,52.17},{8,4},{-40,4}},            color={
          0,127,255}));
  connect(generation_heatPump1.Fluid_out_warm, val4.port_2)
    annotation (Line(points={{-40,16},{-36,16}}, color={0,127,255}));
  connect(fan2.dp_in, realExpression5.y) annotation (Line(points={{74,-34},{74,
          0},{138,0},{138,0},{147,0}},     color={0,0,127}));
  connect(fan1.dp_in, realExpression5.y) annotation (Line(points={{70,102},{70,
          108},{140,108},{140,0},{147,0}}, color={0,0,127}));
  connect(booleanExpression.y, generation_Hot.isOn_chp) annotation (Line(points=
         {{-101,124},{-76,124},{-76,80}}, color={255,0,255}));
  connect(generation_Hot.isOn_boiler, booleanExpression.y) annotation (Line(
        points={{-74,80},{-74,124},{-101,124}}, color={255,0,255}));
  connect(generation_Hot.ElSet_chp, realExpression2.y)
    annotation (Line(points={{-78,80},{-78,138},{-45,138}}, color={0,0,127}));
  connect(generation_Hot.dp_in1, realExpression3.y)
    annotation (Line(points={{-72,80},{-72,140},{-101,140}}, color={0,0,127}));
  connect(generation_Hot.Valve_boiler, realExpression3.y) annotation (Line(
        points={{-80,66},{-90,66},{-90,140},{-101,140}}, color={0,0,127}));
  connect(booleanExpression2.y, generation_heatPump1.onOff_in1) annotation (
      Line(points={{-113,6},{-100,6},{-100,24},{-50.4,24},{-50.4,20}}, color={
          255,0,255}));
  connect(generation_Hot.TSet_chp, realExpression1.y)
    annotation (Line(points={{-70,80},{-70,106},{-101,106}}, color={0,0,127}));
  connect(generation_Hot.TSet_boiler, realExpression1.y)
    annotation (Line(points={{-68,80},{-68,106},{-101,106}}, color={0,0,127}));
  connect(realExpression4.y, val4.y) annotation (Line(points={{-113,60},{-86,60},
          {-86,54},{-28,54},{-28,25.6}}, color={0,0,127}));
  connect(generation_heatPump1.Fluid_out_cold, Valve1.port_1)
    annotation (Line(points={{-60,4},{-85,4},{-85,-2}}, color={0,127,255}));
  connect(Valve1.port_2, Valve2.port_2) annotation (Line(points={{-85,-16},{-85,
          -16},{-85,-38}}, color={0,127,255}));
  connect(Valve2.port_1, Valve3.port_2) annotation (Line(points={{-85,-52},{-85,
          -52},{-85,-60}}, color={0,127,255}));
  connect(Valve3.port_1, generation_geothermalProbe.Fluid_in_Geothermal)
    annotation (Line(points={{-85,-74},{-84,-74},{-84,-76},{-56,-76},{-56,-80}},
        color={0,127,255}));
  connect(Valve2.port_3, ColdWater.portHC1In) annotation (Line(points={{-78,-45},
          {-38,-45},{-38,-46},{4,-46},{4,-58.17},{17.625,-58.17}}, color={0,127,
          255}));
  connect(Valve1.port_3, generation_AirCooling.Fluid_in_cool_airCooler)
    annotation (Line(points={{-78,-9},{-56,-9},{-56,-10},{-56,-10},{-56,-20}},
        color={0,127,255}));
  connect(generation_AirCooling.Fluid_out_cool_airCooler, generation_heatPump1.Fluid_in_cold)
    annotation (Line(points={{-44,-20},{-44,-2},{-68,-2},{-68,16},{-60,16}},
        color={0,127,255}));
  connect(val4.port_3, generation_AirCooling.Fluid_in_warm_airCooler)
    annotation (Line(points={{-28,8},{-28,-24},{-40,-24}}, color={0,127,255}));
  connect(generation_AirCooling.Fluid_out_warm_airCooler, generation_heatPump1.Fluid_in_warm)
    annotation (Line(points={{-40,-36},{-12,-36},{-12,4},{-40,4}}, color={0,127,
          255}));
  connect(Valve3.port_3, fan3.port_a) annotation (Line(points={{-78,-67},{-74,
          -67},{-74,-68},{-68,-68},{-68,-62}}, color={0,127,255}));
  connect(generation_geothermalProbe.Fulid_out_Geothermal, fan3.port_a)
    annotation (Line(points={{-44,-80},{-44,-68},{-68,-68},{-68,-62}}, color={0,
          127,255}));
  connect(realExpression11.y, generation_AirCooling.T_in1) annotation (Line(
        points={{-129,-50},{-112,-50},{-112,-38},{-60.8,-38}}, color={0,0,127}));
  connect(realExpression10.y, generation_AirCooling.m_flow_in) annotation (Line(
        points={{-129,-34},{-116,-34},{-116,-32},{-60.4,-32}}, color={0,0,127}));
  connect(bou1.ports[1], fan3.port_a) annotation (Line(points={{-50,-60},{-50,
          -64},{-68,-64},{-68,-62}}, color={0,127,255}));
  connect(realExpression8.y, Valve1.y) annotation (Line(points={{-129,-18},{
          -108,-18},{-108,-9},{-93.4,-9}}, color={0,0,127}));
  connect(generation_AirCooling.ValvePosition, realExpression6.y) annotation (
      Line(points={{-60.4,-27},{-102,-27},{-102,-84},{-129,-84}}, color={0,0,
          127}));
  connect(fan4.port_b, generation_heatPump1.Fluid_in_cold)
    annotation (Line(points={{-68,-16},{-68,16},{-60,16}}, color={0,127,255}));
  connect(fan4.port_a, fan3.port_b)
    annotation (Line(points={{-68,-28},{-68,-50}}, color={0,127,255}));
  connect(fan4.dp_in, fan3.dp_in) annotation (Line(points={{-75.2,-22},{-112,
          -22},{-112,-56},{-75.2,-56}}, color={0,0,127}));
  connect(Valve2.y, realExpression12.y) annotation (Line(points={{-93.4,-45},{
          -98,-45},{-98,-100},{-129,-100}}, color={0,0,127}));
  connect(Valve3.y, Valve1.y) annotation (Line(points={{-93.4,-67},{-108,-67},{
          -108,-9},{-93.4,-9}}, color={0,0,127}));
  connect(ColdWater.portHC1Out, Valve3.port_2) annotation (Line(points={{
          17.8125,-64.06},{-16,-64.06},{-16,-104},{-104,-104},{-104,-58},{-85,
          -58},{-85,-60}}, color={0,127,255}));
  connect(generation_heatPump1.dp_in1, realExpression7.y)
    annotation (Line(points={{-46,20},{-46,22},{-113,22}}, color={0,0,127}));
  connect(step.y, fan3.dp_in) annotation (Line(points={{-157,-66},{-112,-66},{
          -112,-56},{-75.2,-56}}, color={0,0,127}));
  connect(Fluid_in_cold, ColdWater.fluidportTop1) annotation (Line(points={{100,
          -80},{50,-80},{50,-42},{27.75,-42},{27.75,-49.81}}, color={0,127,255}));
  connect(HotWater2.fluidportBottom2, Fluid_in_warm) annotation (Line(points={{
          35.3125,-18.19},{35.3125,-20},{100,-20}}, color={0,127,255}));
  connect(fan5.port_b, Fluid_out_warm) annotation (Line(points={{78,24},{90,24},
          {90,20},{100,20}}, color={0,127,255}));
  connect(fan5.dp_in, realExpression5.y) annotation (Line(points={{68,36},{140,
          36},{140,0},{147,0}},            color={0,0,127}));
  connect(HotWater.fluidportTop2, fan1.port_a) annotation (Line(points={{
          37.6875,82.19},{37.6875,90},{60,90}}, color={0,127,255}));
  connect(HotWater2.fluidportTop2, fan5.port_a) annotation (Line(points={{
          35.6875,20.19},{36,20.19},{36,24},{58,24}}, color={0,127,255}));
  connect(fan2.port_a, ColdWater.fluidportBottom1) annotation (Line(points={{64,
          -46},{58,-46},{58,-94},{27.9375,-94},{27.9375,-88.38}}, color={0,127,
          255}));
  connect(bou4.ports[1], fan1.port_a)
    annotation (Line(points={{42,94},{42,90},{60,90}}, color={0,127,255}));
  connect(generation_Hot.Fluid_out_Hot, val1.port_2) annotation (Line(points={{
          -60,73.8},{-42,73.8},{-42,74},{-22,74}}, color={0,127,255}));
  connect(val1.port_1, HotWater.portHC1In) annotation (Line(points={{-6,74},{6,
          74},{6,73.83},{17.625,73.83}}, color={0,127,255}));
  connect(val1.port_3, HotWater2.portHC1In) annotation (Line(points={{-14,66},{
          -14,30},{10,30},{10,11.83},{15.625,11.83}}, color={0,127,255}));
  connect(HotWater2.portHC1Out, HotWater.portHC1Out) annotation (Line(points={{
          15.8125,5.94},{-4,5.94},{-4,68},{17.8125,67.94}}, color={0,127,255}));
  connect(val4.port_1, val2.port_2)
    annotation (Line(points={{-20,16},{-14,16}}, color={0,127,255}));
  connect(val2.port_1, HotWater.portHC2In) annotation (Line(points={{2,16},{2,
          58.25},{17.8125,58.25}}, color={0,127,255}));
  connect(val2.port_3, HotWater2.portHC2In) annotation (Line(points={{-6,8},{-2,
          8},{-2,-3.75},{15.8125,-3.75}}, color={0,127,255}));
  connect(HotWater2.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation
    (Line(points={{15.8125,-9.83},{-12,-10},{-12,4},{-40,4}}, color={0,127,255}));
  connect(val1.y, val4.y) annotation (Line(points={{-14,83.6},{-14,90},{-28,90},
          {-28,25.6}}, color={0,0,127}));
  connect(val2.y, realExpression7.y) annotation (Line(points={{-6,25.6},{-8,
          25.6},{-8,38},{-106,38},{-106,22},{-113,22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-22,124},{40,104}},
          lineColor={28,108,200},
          textString="Parameter müssen angepasst werden
")}));
end Generation;
