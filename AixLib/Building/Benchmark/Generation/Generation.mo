within AixLib.Building.Benchmark.Generation;
model Generation
  Generation_Hot generation_Hot
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
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
    annotation (Placement(transformation(extent={{-4,36},{24,70}})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{92,16},{112,36}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=false)
    annotation (Placement(transformation(extent={{-106,84},{-86,104}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=363)
    annotation (Placement(transformation(extent={{-106,66},{-86,86}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{36,22},
            {44,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=30)
    annotation (Placement(transformation(extent={{-24,72},{-44,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=20000)
    annotation (Placement(transformation(extent={{-106,108},{-86,128}})));
  Modelica.Blocks.Sources.Step step(
    startTime=250,
    height=-0.5,
    offset=1)
    annotation (Placement(transformation(extent={{-112,18},{-92,38}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=750)
    annotation (Placement(transformation(extent={{-150,-8},{-130,12}})));

  Generation_heatPump generation_heatPump1
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=50000)
    annotation (Placement(transformation(extent={{-108,-22},{-88,-2}})));

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
    annotation (Placement(transformation(extent={{-4,-84},{24,-50}})));
  Modelica.Fluid.Vessels.OpenTank tank2(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    nPorts=2,
    level_start=0.07,
    T_start=293.15)
    annotation (Placement(transformation(extent={{26,76},{40,90}})));
  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    nPorts=2,
    level_start=0.07,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=293.15)
    annotation (Placement(transformation(extent={{14,-24},{28,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-34},{110,-14}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-104},{110,-84}})));
  Fluid.Movers.FlowControlled_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{52,66},{72,86}})));
  Fluid.Movers.FlowControlled_dp fan2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{46,-34},{66,-14}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=20000)
    annotation (Placement(transformation(extent={{22,-2},{42,18}})));
equation
  connect(generation_Hot.Fluid_out_Hot, HotWater.portHC1In) annotation (Line(
        points={{-60,61.4},{-32,61.4},{-32,62.69},{-4.35,62.69}}, color={0,127,
          255}));
  connect(generation_Hot.Fluid_in_Hot, HotWater.portHC1Out) annotation (Line(
        points={{-60,58},{-32,58},{-32,57.42},{-4.175,57.42}}, color={0,127,255}));
  connect(fixedTemperature.port, HotWater.heatportOutside) annotation (Line(
        points={{44,26},{46,26},{46,54.02},{23.65,54.02}}, color={191,0,0}));
  connect(realExpression2.y, generation_Hot.ElSet_chp)
    annotation (Line(points={{-45,82},{-78,82},{-78,70}}, color={0,0,127}));
  connect(realExpression3.y, generation_Hot.dp_in1)
    annotation (Line(points={{-85,118},{-72,118},{-72,70}}, color={0,0,127}));
  connect(step.y, generation_Hot.Valve_boiler) annotation (Line(points={{-91,28},
          {-86,28},{-86,56},{-80,56}}, color={0,0,127}));
  connect(booleanExpression.y, generation_Hot.isOn_chp)
    annotation (Line(points={{-85,94},{-76,94},{-76,70}}, color={255,0,255}));
  connect(HotWater.fluidportBottom2, Fluid_in_hot) annotation (Line(points={{
          14.025,35.83},{14.025,26},{102,26}}, color={0,127,255}));
  connect(generation_Hot.TSet_chp, realExpression1.y)
    annotation (Line(points={{-70,70},{-70,76},{-85,76}}, color={0,0,127}));
  connect(generation_Hot.TSet_boiler, realExpression1.y) annotation (Line(
        points={{-68,70},{-70,70},{-70,76},{-85,76}}, color={0,0,127}));
  connect(generation_heatPump1.dp_in1, realExpression4.y) annotation (Line(
        points={{-65.6,-20},{-66,-20},{-66,-12},{-87,-12}}, color={0,0,127}));
  connect(generation_heatPump1.dp_in2, realExpression4.y) annotation (Line(
        points={{-74.8,-20},{-74.8,-12},{-87,-12}},
                                                  color={0,0,127}));
  connect(generation_heatPump1.Fluid_out_warm, HotWater.portHC2In) annotation (
      Line(points={{-60,-24},{-32,-24},{-32,48.75},{-4.175,48.75}}, color={0,
          127,255}));
  connect(HotWater.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation (
      Line(points={{-4.175,43.31},{-26,43.31},{-26,-31.2},{-60,-31.2}}, color={
          0,127,255}));
  connect(ColdWater.heatportOutside, fixedTemperature.port) annotation (Line(
        points={{23.65,-65.98},{62,-65.98},{62,26},{44,26}}, color={191,0,0}));
  connect(generation_heatPump1.Fluid_out_cold, ColdWater.portHC1In) annotation (
     Line(points={{-80,-32},{-88,-32},{-88,-57.31},{-4.35,-57.31}}, color={0,
          127,255}));
  connect(ColdWater.portHC1Out, generation_heatPump1.Fluid_in_cold) annotation (
     Line(points={{-4.175,-62.58},{-94,-62.58},{-94,-28},{-80,-28}}, color={0,
          127,255}));
  connect(tank2.ports[1], HotWater.fluidportTop2) annotation (Line(points={{31.6,76},
          {14.375,76},{14.375,70.17}},          color={0,127,255}));
  connect(tank1.ports[1], ColdWater.fluidportTop2) annotation (Line(points={{19.6,
          -24},{14.375,-24},{14.375,-49.83}},      color={0,127,255}));
  connect(ColdWater.fluidportBottom2, Fluid_in_cold) annotation (Line(points={{
          14.025,-84.17},{14.025,-94},{100,-94}}, color={0,127,255}));
  connect(tank2.ports[2], fan1.port_a)
    annotation (Line(points={{34.4,76},{52,76}}, color={0,127,255}));
  connect(fan1.port_b, Fluid_out_hot) annotation (Line(points={{72,76},{80,76},
          {80,60},{100,60}}, color={0,127,255}));
  connect(fan2.port_b, Fluid_out_cold)
    annotation (Line(points={{66,-24},{100,-24}}, color={0,127,255}));
  connect(tank1.ports[2], fan2.port_a)
    annotation (Line(points={{22.4,-24},{46,-24}}, color={0,127,255}));
  connect(realExpression5.y, fan2.dp_in)
    annotation (Line(points={{43,8},{56,8},{56,-12}}, color={0,0,127}));
  connect(fan1.dp_in, fan2.dp_in) annotation (Line(points={{62,88},{62,96},{50,
          96},{50,8},{56,8},{56,-12}}, color={0,0,127}));
  connect(booleanStep.y, generation_heatPump1.onOff_in1) annotation (Line(
        points={{-129,2},{-70.4,2},{-70.4,-20}}, color={255,0,255}));
  connect(generation_Hot.isOn_boiler, generation_Hot.isOn_chp) annotation (Line(
        points={{-74,70},{-74,94},{-76,94},{-76,70}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-60,32},{2,12}},
          lineColor={28,108,200},
          textString="Parameter müssen angepasst werden
")}));
end Generation;
