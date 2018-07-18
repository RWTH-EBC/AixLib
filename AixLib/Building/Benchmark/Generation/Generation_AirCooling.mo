within AixLib.Building.Benchmark.Generation;
model Generation_AirCooling
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-46,-52},{-26,-32}})));
  Fluid.Sources.Boundary_pT bou(
    use_p_in=false,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    nPorts=1)                                                 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,-42})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{-116,-32},{-92,-8}})));
  Modelica.Blocks.Interfaces.RealInput T_in1
    "Prescribed fluid temperature"
    annotation (Placement(transformation(extent={{-120,-92},{-96,-68}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Fluid.Movers.FlowControlled_dp fan2(
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per,
    m_flow_nominal=5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={16,8})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=20000)
    annotation (Placement(transformation(extent={{28,50},{48,70}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium2 = Modelica.Media.Air.DryAirNasa,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    m1_flow_nominal=10,
    m2_flow_nominal=100,
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{8,-46},{-12,-26}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Air.DryAirNasa,
    m_flow_nominal=200,
    V=1) annotation (Placement(transformation(extent={{16,-42},{26,-32}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve1(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-16,30})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=1,
    m2_flow_nominal=10,
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-12,72},{8,92}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex2(
    m1_flow_nominal=1,
    m2_flow_nominal=10,
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={76,4})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cool_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cool_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Blocks.Interfaces.RealInput ValvePosition
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-116,18},{-92,42}})));
  Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    p=300000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-32,-8})));
equation
  connect(boundary.m_flow_in, m_flow_in) annotation (Line(points={{-46,-34},{
          -74,-34},{-74,-20},{-104,-20}},
                                  color={0,0,127}));
  connect(boundary.T_in, T_in1) annotation (Line(points={{-48,-38},{-74,-38},{
          -74,-80},{-108,-80}},
                            color={0,0,127}));
  connect(bou.T_in, T_in1) annotation (Line(points={{56,-38},{56,-80},{-108,-80}},
                      color={0,0,127}));
  connect(realExpression5.y, fan2.dp_in) annotation (Line(points={{49,60},{56,
          60},{56,8},{28,8}},       color={0,0,127}));
  connect(vol.ports[1], bou.ports[1])
    annotation (Line(points={{20,-42},{34,-42}}, color={0,127,255}));
  connect(Fluid_in_cool_airCooler, hex1.port_a1)
    annotation (Line(points={{-60,100},{-60,88},{-12,88}}, color={0,127,255}));
  connect(hex1.port_b1, Fluid_out_cool_airCooler)
    annotation (Line(points={{8,88},{60,88},{60,100}}, color={0,127,255}));
  connect(Fluid_in_warm_airCooler, hex2.port_a1)
    annotation (Line(points={{100,60},{82,60},{82,14}}, color={0,127,255}));
  connect(hex2.port_b1, Fluid_out_warm_airCooler) annotation (Line(points={{82,
          -6},{82,-6},{82,-60},{100,-60}}, color={0,127,255}));
  connect(Valve1.y, ValvePosition)
    annotation (Line(points={{-28,30},{-104,30}}, color={0,0,127}));
  connect(boundary.ports[1], hex.port_a2)
    annotation (Line(points={{-26,-42},{-12,-42}}, color={0,127,255}));
  connect(hex.port_b2, vol.ports[2])
    annotation (Line(points={{8,-42},{22,-42}}, color={0,127,255}));
  connect(hex.port_a1, fan2.port_b)
    annotation (Line(points={{8,-30},{16,-30},{16,-2}}, color={0,127,255}));
  connect(bou1.ports[1], fan2.port_b)
    annotation (Line(points={{-32,-12},{16,-12},{16,-2}}, color={0,127,255}));
  connect(hex.port_b1, Valve1.port_2) annotation (Line(points={{-12,-30},{-16,
          -30},{-16,20}}, color={0,127,255}));
  connect(fan2.port_a, hex1.port_b2) annotation (Line(points={{16,18},{18,18},{
          18,64},{-22,64},{-22,76},{-12,76}}, color={0,127,255}));
  connect(Valve1.port_1, hex1.port_a2) annotation (Line(points={{-16,40},{-16,
          50},{8,50},{8,76}}, color={0,127,255}));
  connect(Valve1.port_3, hex2.port_a2) annotation (Line(points={{-6,30},{52,30},
          {52,-6},{70,-6}}, color={0,127,255}));
  connect(hex2.port_b2, hex1.port_b2) annotation (Line(points={{70,14},{70,42},
          {18,42},{18,64},{-22,64},{-22,76},{-12,76}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_AirCooling;
