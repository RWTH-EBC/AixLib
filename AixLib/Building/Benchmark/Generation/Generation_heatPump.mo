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
    annotation (Placement(transformation(extent={{90,-22},{110,-2}})));

  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid input port"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid output port"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Blocks.Interfaces.BooleanInput onOff_in1
    "Enable or disable heat pump" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-4,100})));
  Modelica.Blocks.Interfaces.RealInput dp_in1
    "Prescribed pressure rise" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={44,100})));
  Modelica.Blocks.Interfaces.RealInput dp_in2
    "Prescribed pressure rise" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-48,100})));
  Fluid.HeatPumps.HeatPumpDetailed        heatPumpDetailed(
    capCalcType=2,
    dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(),
    P_eleOutput=true,
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_conNominal=10000,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dp_evaNominal=10000,
    T_startEva=283.15,
    T_startCon=313.15)
    annotation (Placement(transformation(extent={{-14,-10},{16,10}})));
  Fluid.Movers.FlowControlled_dp fan(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{42,8},{62,28}})));
  Fluid.Movers.FlowControlled_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{-72,6},{-52,26}})));
  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    T_start=293.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{44,-18},{58,-4}})));
equation
  connect(heatPumpDetailed.port_conOut, fan.port_a) annotation (Line(points={{
          14,7},{28,7},{28,18},{42,18}}, color={0,127,255}));
  connect(fan.port_b, Fluid_out_warm) annotation (Line(points={{62,18},{80,18},
          {80,60},{100,60}}, color={0,127,255}));
  connect(dp_in1, fan.dp_in) annotation (Line(points={{44,100},{48,100},{48,30},
          {52,30}}, color={0,0,127}));
  connect(Fluid_in_cold, fan1.port_a) annotation (Line(points={{-100,20},{-86,
          20},{-86,16},{-72,16}}, color={0,127,255}));
  connect(fan1.port_b, heatPumpDetailed.port_evaIn) annotation (Line(points={{
          -52,16},{-32,16},{-32,7},{-12,7}}, color={0,127,255}));
  connect(onOff_in1, heatPumpDetailed.onOff_in)
    annotation (Line(points={{-4,100},{-4,9}}, color={255,0,255}));
  connect(dp_in2, fan1.dp_in) annotation (Line(points={{-48,100},{-56,100},{-56,
          28},{-62,28}}, color={0,0,127}));
  connect(heatPumpDetailed.port_evaOut, Fluid_out_cold) annotation (Line(points=
         {{-12,-7},{-36,-7},{-36,-6},{-52,-6},{-52,-20},{-100,-20}}, color={0,
          127,255}));
  connect(heatPumpDetailed.port_conIn, tank1.ports[1]) annotation (Line(points=
          {{14,-7},{49.6,-7},{49.6,-18}}, color={0,127,255}));
  connect(tank1.ports[2], Fluid_in_warm) annotation (Line(points={{52.4,-18},{
          74,-18},{74,-12},{100,-12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
