within AixLib.Building.Benchmark.Generation;
model Generation_Hot
  Fluid.BoilerCHP.Boiler boiler(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    allowFlowReversal=false,
    m_flow_nominal=1,
    m_flow_small=0.01,
    show_T=true,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_11kW())
    annotation (Placement(transformation(extent={{12,4},{34,26}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    length=1,
    diameter=0.05)
    annotation (Placement(transformation(extent={{-12,8},{2,22}})));
  Fluid.Movers.FlowControlled_dp fan(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    allowFlowReversal=false,
    m_flow_nominal=5,
    m_flow_small=0.01,
    dp_nominal=1000)
    annotation (Placement(transformation(extent={{-44,4},{-22,26}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_Hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,4},{110,24}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_Hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Fluid.Sources.Boundary_ph bou(nPorts=2, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  Modelica.Blocks.Interfaces.RealInput TAmbient1
    "Ambient air temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={20,100})));
  Modelica.Blocks.Interfaces.BooleanInput switchToNightMode1
     "Connector of Boolean input signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-18,100})));
  Modelica.Blocks.Interfaces.BooleanInput isOn1
    "Switches Controler on and off" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-56,100})));
  Modelica.Blocks.Interfaces.RealInput dp_in1
    "Prescribed pressure rise" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-88,100})));
equation
  connect(pipe.port_b, boiler.port_a)
    annotation (Line(points={{2,15},{12,15}}, color={0,127,255}));
  connect(pipe.port_a, fan.port_b)
    annotation (Line(points={{-12,15},{-22,15}}, color={0,127,255}));
  connect(boiler.port_b, Fluid_out_Hot) annotation (Line(points={{34,15},{68,15},
          {68,16},{100,16},{100,14}}, color={0,127,255}));
  connect(Fluid_in_Hot, bou.ports[1])
    annotation (Line(points={{100,-20},{-74,-20},{-74,2}}, color={0,127,255}));
  connect(fan.port_a, bou.ports[2]) annotation (Line(points={{-44,15},{-60,15},
          {-60,14},{-74,14},{-74,-2}}, color={0,127,255}));
  connect(boiler.TAmbient, TAmbient1) annotation (Line(points={{15.3,22.7},{20,
          22.7},{20,100}}, color={0,0,127}));
  connect(boiler.switchToNightMode, switchToNightMode1) annotation (Line(points
        ={{15.3,19.4},{-18,19.4},{-18,100}}, color={255,0,255}));
  connect(boiler.isOn, isOn1) annotation (Line(points={{28.5,5.1},{28.5,-14},{
          -56,-14},{-56,100}}, color={255,0,255}));
  connect(fan.dp_in, dp_in1) annotation (Line(points={{-33,28.2},{-33,50},{-88,
          50},{-88,100}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{12,54},{74,34}},
          lineColor={28,108,200},
          textString="Parameter passen nicht")}));
end Generation_Hot;
