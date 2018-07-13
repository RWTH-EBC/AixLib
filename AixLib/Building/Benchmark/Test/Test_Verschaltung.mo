within AixLib.Building.Benchmark.Test;
model Test_Verschaltung
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120)
    annotation (Placement(transformation(extent={{0,2},{20,22}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120)
    annotation (Placement(transformation(extent={{60,42},{40,62}})));
  Fluid.Actuators.Valves.TwoWayLinear val3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120,
    y_start=0)
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  Fluid.Actuators.Valves.TwoWayLinear val4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.3,
    dpValve_nominal=2,
    riseTime=120,
    y_start=0)
    annotation (Placement(transformation(extent={{0,-84},{20,-64}})));
  Fluid.Movers.FlowControlled_dp fan(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{60,-84},{40,-64}})));
  Fluid.Movers.FlowControlled_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{60,2},{40,22}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=20000)
    annotation (Placement(transformation(extent={{-6,-24},{14,-4}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    offset=1,
    startTime=50,
    duration=0.1)
    annotation (Placement(transformation(extent={{-28,64},{-8,84}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    startTime=50,
    duration=0.1,
    height=1,
    offset=0) annotation (Placement(transformation(extent={{-38,-12},{-18,8}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    use_HeatTransfer=false,
    length=5,
    diameter=0.3,
    m_flow_start=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.TurbulentPipeFlow,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    T_start=293.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-88,28})));
  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    nPorts=2,
    level_start=0.07,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={95,39})));
  Modelica.Fluid.Vessels.OpenTank tank2(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    nPorts=2,
    level_start=0.07,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={101,-53})));
equation
  connect(fan1.port_b, val1.port_b)
    annotation (Line(points={{40,12},{20,12}}, color={0,127,255}));
  connect(fan.port_b, val4.port_b)
    annotation (Line(points={{40,-74},{20,-74}}, color={0,127,255}));
  connect(realExpression3.y, fan.dp_in) annotation (Line(points={{15,-14},{30,
          -14},{30,-56},{50,-56},{50,-62}}, color={0,0,127}));
  connect(fan1.dp_in, fan.dp_in) annotation (Line(points={{50,24},{50,32},{30,
          32},{30,-56},{50,-56},{50,-62}}, color={0,0,127}));
  connect(val2.y, val1.y) annotation (Line(points={{50,64},{50,74},{10,74},{10,
          24}}, color={0,0,127}));
  connect(ramp.y, val1.y)
    annotation (Line(points={{-7,74},{10,74},{10,24}}, color={0,0,127}));
  connect(ramp1.y, val3.y)
    annotation (Line(points={{-17,-2},{50,-2},{50,-18}}, color={0,0,127}));
  connect(val4.y, val3.y) annotation (Line(points={{10,-62},{10,-24},{-10,-24},
          {-10,-2},{50,-2},{50,-18}}, color={0,0,127}));
  connect(pipe.port_b, val2.port_b)
    annotation (Line(points={{-88,38},{-88,52},{40,52}}, color={0,127,255}));
  connect(val4.port_a, pipe.port_a)
    annotation (Line(points={{0,-74},{-88,-74},{-88,18}}, color={0,127,255}));
  connect(pipe.port_b, val3.port_b) annotation (Line(points={{-88,38},{-88,42},
          {-50,42},{-50,-30},{40,-30}}, color={0,127,255}));
  connect(val1.port_a, pipe.port_a)
    annotation (Line(points={{0,12},{-88,12},{-88,18}}, color={0,127,255}));
  connect(val2.port_a, tank1.ports[1])
    annotation (Line(points={{60,52},{88,52},{88,40.4}}, color={0,127,255}));
  connect(fan1.port_a, tank1.ports[2])
    annotation (Line(points={{60,12},{88,12},{88,37.6}}, color={0,127,255}));
  connect(val3.port_a, tank2.ports[1]) annotation (Line(points={{60,-30},{94,
          -30},{94,-51.6}}, color={0,127,255}));
  connect(tank2.ports[2], fan.port_a) annotation (Line(points={{94,-54.4},{94,
          -74},{60,-74}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Verschaltung;
