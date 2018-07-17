within AixLib.Building.Benchmark.Generation;
model Generation_heatPump
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));

  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid input port"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid output port"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.BooleanInput onOff_in1
    "Enable or disable heat pump" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-4,100})));
  Modelica.Blocks.Interfaces.RealInput dp_in1
    "Prescribed pressure rise" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealInput dp_in2
    "Prescribed pressure rise" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-48,100})));
  Fluid.HeatPumps.HeatPumpDetailed        heatPumpDetailed(
    capCalcType=2,
    P_eleOutput=true,
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dataTable=DataBase.HeatPump.EN14511.Vaillant_VWL_101(),
    dp_conNominal=100,
    dp_evaNominal=100,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,-10},{16,10}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    V=0.001) annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));

  Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, redeclare
      Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per)
    annotation (Placement(transformation(extent={{42,38},{62,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-128,74},{-108,94}})));
  Fluid.Sources.Boundary_pT bou(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-78,4})));
  Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, redeclare
      Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{-72,38},{-52,58}})));
equation
  connect(onOff_in1, heatPumpDetailed.onOff_in)
    annotation (Line(points={{-4,100},{-4,9}}, color={255,0,255}));
  connect(vol.ports[1], heatPumpDetailed.port_evaOut) annotation (Line(points={{-52,-20},
          {-32,-20},{-32,-7},{-12,-7}},           color={0,127,255}));
  connect(fan2.port_b, Fluid_out_warm) annotation (Line(points={{62,48},{82,48},
          {82,60},{100,60}}, color={0,127,255}));
  connect(fan2.port_a, heatPumpDetailed.port_conOut) annotation (Line(points={{
          42,48},{28,48},{28,7},{14,7}}, color={0,127,255}));
  connect(dp_in1, fan2.y) annotation (Line(points={{40,100},{40,80},{52,80},{52,
          60}}, color={0,0,127}));
  connect(Fluid_out_cold, vol.ports[2]) annotation (Line(points={{-100,-60},{
          -76,-60},{-76,-20},{-48,-20}}, color={0,127,255}));
  connect(bou.ports[1], Fluid_out_cold) annotation (Line(points={{-78,-6},{-78,
          -20},{-76,-20},{-76,-60},{-100,-60}}, color={0,127,255}));
  connect(heatPumpDetailed.port_conIn, Fluid_in_warm) annotation (Line(points={
          {14,-7},{58,-7},{58,-60},{100,-60}}, color={0,127,255}));
  connect(Fluid_in_cold, fan1.port_a) annotation (Line(points={{-100,60},{-88,
          60},{-88,48},{-72,48}}, color={0,127,255}));
  connect(realExpression.y, fan1.y) annotation (Line(points={{-107,84},{-82,84},
          {-82,82},{-62,82},{-62,60}}, color={0,0,127}));
  connect(fan1.port_b, heatPumpDetailed.port_evaIn) annotation (Line(points={{
          -52,48},{-44,48},{-44,50},{-24,50},{-24,7},{-12,7}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
