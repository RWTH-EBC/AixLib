within AixLib.Building.Benchmark.Generation;
model Generation
  Generation_Hot generation_Hot
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Fluid.Sources.Boundary_ph bou(nPorts=2, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-8,52},{12,72}})));
  Fluid.Storage.BufferStorage HotWater(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package MediumHC2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    useHeatingRod=false,
    data=DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil2=false,
    n=5,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff)
    annotation (Placement(transformation(extent={{-4,6},{24,40}})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-24},{110,-4}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=14000)
    annotation (Placement(transformation(extent={{-82,88},{-62,108}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-106,54},{-86,74}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=363)
    annotation (Placement(transformation(extent={{-106,36},{-86,56}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1
    annotation (Placement(transformation(extent={{-34,54},{-54,74}})));
  Fluid.Movers.Pump pump(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    MinMaxCharacteristics=DataBase.Pumps.Pump1(),
    m_flow_small=0.01)
    annotation (Placement(transformation(extent={{54,30},{74,50}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{36,-8},
            {44,0}})));
equation
  connect(HotWater.fluidportTop2, bou.ports[1]) annotation (Line(points={{
          14.375,40.17},{14.375,64},{12,64}}, color={0,127,255}));
  connect(HotWater.fluidportBottom2, Fluid_in_hot) annotation (Line(points={{
          14.025,5.83},{14.025,-14},{100,-14}}, color={0,127,255}));
  connect(generation_Hot.Fluid_out_Hot, HotWater.portHC1In) annotation (Line(
        points={{-60,31.4},{-32,31.4},{-32,32.69},{-4.35,32.69}}, color={0,127,
          255}));
  connect(generation_Hot.Fluid_in_Hot, HotWater.portHC1Out) annotation (Line(
        points={{-60,28},{-32,28},{-32,27.42},{-4.175,27.42}}, color={0,127,255}));
  connect(realExpression1.y, generation_Hot.TSet)
    annotation (Line(points={{-85,46},{-68,46},{-68,40}}, color={0,0,127}));
  connect(booleanExpression.y, generation_Hot.isOn1) annotation (Line(points={{
          -85,64},{-75.6,64},{-75.6,40}}, color={255,0,255}));
  connect(pump.port_b, Fluid_out_hot) annotation (Line(points={{74,40},{86,40},
          {86,60},{100,60}}, color={0,127,255}));
  connect(bou.ports[2], pump.port_a) annotation (Line(points={{12,60},{26,60},{
          26,66},{54,66},{54,40}}, color={0,127,255}));
  connect(fixedTemperature.port, HotWater.heatportOutside) annotation (Line(
        points={{44,-4},{46,-4},{46,24.02},{23.65,24.02}}, color={191,0,0}));
  connect(pump.IsNight, booleanExpression1.y) annotation (Line(points={{64,50.2},
          {64,86},{-64,86},{-64,64},{-55,64}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-60,2},{2,-18}},
          lineColor={28,108,200},
          textString="Pumpen müssen angepasst werden
")}));
end Generation;
