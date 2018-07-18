within AixLib.Building.Benchmark.Generation;
model Generation_heatPump
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));

  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid input port"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
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
  Fluid.HeatPumps.HeatPumpDetailed        heatPumpDetailed(
    capCalcType=2,
    P_eleOutput=true,
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dataTable=DataBase.HeatPump.EN14511.Vaillant_VWL_101(),
    dp_conNominal=20000,
    dp_evaNominal=100,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,-10},{16,10}})));

  Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, redeclare
      Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per)
    annotation (Placement(transformation(extent={{42,38},{62,58}})));

  Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,8})));
equation
  connect(onOff_in1, heatPumpDetailed.onOff_in)
    annotation (Line(points={{-4,100},{-4,9}}, color={255,0,255}));
  connect(fan2.port_b, Fluid_out_warm) annotation (Line(points={{62,48},{82,48},
          {82,60},{100,60}}, color={0,127,255}));
  connect(fan2.port_a, heatPumpDetailed.port_conOut) annotation (Line(points={{
          42,48},{28,48},{28,7},{14,7}}, color={0,127,255}));
  connect(dp_in1, fan2.y) annotation (Line(points={{40,100},{40,80},{52,80},{52,
          60}}, color={0,0,127}));
  connect(heatPumpDetailed.port_conIn, Fluid_in_warm) annotation (Line(points={
          {14,-7},{58,-7},{58,-60},{100,-60}}, color={0,127,255}));
  connect(bou1.ports[1], Fluid_in_warm) annotation (Line(points={{84,-2},{84,
          -12},{58,-12},{58,-60},{100,-60}}, color={0,127,255}));
  connect(Fluid_out_cold, heatPumpDetailed.port_evaOut) annotation (Line(points
        ={{-100,-60},{-24,-60},{-24,-7},{-12,-7}}, color={0,127,255}));
  connect(Fluid_in_cold, heatPumpDetailed.port_evaIn) annotation (Line(points={
          {-100,60},{-24,60},{-24,7},{-12,7}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
