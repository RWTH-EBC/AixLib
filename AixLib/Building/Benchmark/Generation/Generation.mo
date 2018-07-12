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
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-106,84},{-86,104}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=363)
    annotation (Placement(transformation(extent={{-106,66},{-86,86}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
    annotation (Placement(transformation(extent={{74,86},{54,106}})));
  Fluid.Movers.Pump pump(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    MinMaxCharacteristics=DataBase.Pumps.Pump1(),
    m_flow_small=0.01)
    annotation (Placement(transformation(extent={{54,60},{74,80}})));

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
    annotation (Placement(transformation(extent={{-112,46},{-92,66}})));
  Modelica.Fluid.Sources.FixedBoundary boundary(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=1000,
    T=293.15) annotation (Placement(transformation(extent={{10,82},{30,102}})));

  Generation_heatPump generation_heatPump1
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(
                                                              y=true)
    annotation (Placement(transformation(extent={{-100,-8},{-80,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=20000)
    annotation (Placement(transformation(extent={{-108,-22},{-88,-2}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(
    use_p=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    p=1000,
    T=283.15)
    annotation (Placement(transformation(extent={{-114,-84},{-94,-64}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    p=10000)
    annotation (Placement(transformation(extent={{-116,-46},{-96,-26}})));
  Modelica.Blocks.Sources.Constant const3(k=280)
    annotation (Placement(transformation(extent={{-154,-42},{-134,-22}})));
equation
  connect(generation_Hot.Fluid_out_Hot, HotWater.portHC1In) annotation (Line(
        points={{-60,61.4},{-32,61.4},{-32,62.69},{-4.35,62.69}}, color={0,127,
          255}));
  connect(generation_Hot.Fluid_in_Hot, HotWater.portHC1Out) annotation (Line(
        points={{-60,58},{-32,58},{-32,57.42},{-4.175,57.42}}, color={0,127,255}));
  connect(pump.port_b, Fluid_out_hot) annotation (Line(points={{74,70},{88,70},
          {88,60},{100,60}}, color={0,127,255}));
  connect(fixedTemperature.port, HotWater.heatportOutside) annotation (Line(
        points={{44,26},{46,26},{46,54.02},{23.65,54.02}}, color={191,0,0}));
  connect(pump.IsNight, booleanExpression1.y) annotation (Line(points={{64,80.2},
          {64,88},{48,88},{48,96},{53,96}},    color={255,0,255}));
  connect(realExpression2.y, generation_Hot.ElSet_chp)
    annotation (Line(points={{-45,82},{-78,82},{-78,70}}, color={0,0,127}));
  connect(realExpression3.y, generation_Hot.dp_in1)
    annotation (Line(points={{-85,118},{-72,118},{-72,70}}, color={0,0,127}));
  connect(step.y, generation_Hot.Valve_boiler) annotation (Line(points={{-91,28},
          {-86,28},{-86,56},{-80,56}}, color={0,0,127}));
  connect(booleanExpression.y, generation_Hot.isOn_chp)
    annotation (Line(points={{-85,94},{-76,94},{-76,70}}, color={255,0,255}));
  connect(booleanStep.y, generation_Hot.isOn_boiler) annotation (Line(points={{
          -91,56},{-88,56},{-88,86},{-74,86},{-74,70}}, color={255,0,255}));
  connect(HotWater.fluidportBottom2, Fluid_in_hot) annotation (Line(points={{
          14.025,35.83},{14.025,26},{102,26}}, color={0,127,255}));
  connect(boundary.ports[1], HotWater.fluidportTop2) annotation (Line(points={{
          30,94},{22,94},{22,70.17},{14.375,70.17}}, color={0,127,255}));
  connect(boundary.ports[2], pump.port_a) annotation (Line(points={{30,90},{42,
          90},{42,70},{54,70}}, color={0,127,255}));
  connect(generation_Hot.TSet_chp, realExpression1.y)
    annotation (Line(points={{-70,70},{-70,76},{-85,76}}, color={0,0,127}));
  connect(generation_Hot.TSet_boiler, realExpression1.y) annotation (Line(
        points={{-68,70},{-70,70},{-70,76},{-85,76}}, color={0,0,127}));
  connect(generation_heatPump1.onOff_in1, booleanExpression2.y) annotation (
      Line(points={{-70.4,-20},{-70,-20},{-70,2},{-79,2}}, color={255,0,255}));
  connect(generation_heatPump1.dp_in1, realExpression4.y) annotation (Line(
        points={{-65.6,-20},{-66,-20},{-66,-12},{-87,-12}}, color={0,0,127}));
  connect(generation_heatPump1.dp_in2, realExpression4.y) annotation (Line(
        points={{-74.8,-20},{-76,-12},{-87,-12}}, color={0,0,127}));
  connect(const3.y, boundary2.T_in)
    annotation (Line(points={{-133,-32},{-118,-32}}, color={0,0,127}));
  connect(boundary2.ports[1], generation_heatPump1.Fluid_in_cold) annotation (
      Line(points={{-96,-36},{-88,-36},{-88,-28},{-80,-28}}, color={0,127,255}));
  connect(boundary1.ports[1], generation_heatPump1.Fluid_out_cold) annotation (
      Line(points={{-94,-74},{-88,-74},{-88,-32},{-80,-32}}, color={0,127,255}));
  connect(generation_heatPump1.Fluid_out_warm, HotWater.portHC2In) annotation (
      Line(points={{-60,-24},{-32,-24},{-32,48.75},{-4.175,48.75}}, color={0,
          127,255}));
  connect(HotWater.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation (
      Line(points={{-4.175,43.31},{-26,43.31},{-26,-31.2},{-60,-31.2}}, color={
          0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-60,32},{2,12}},
          lineColor={28,108,200},
          textString="Parameter müssen angepasst werden
")}));
end Generation;
