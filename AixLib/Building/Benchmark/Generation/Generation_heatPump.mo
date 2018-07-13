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
    P_eleOutput=true,
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dataTable=DataBase.HeatPump.EN14511.Vaillant_VWL_101(),
    dp_conNominal=1000,
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
    p_start=100000,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per)
    annotation (Placement(transformation(extent={{38,26},{58,46}})));
  Fluid.Movers.FlowControlled_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12 per)
    annotation (Placement(transformation(extent={{-72,6},{-52,26}})));
  Modelica.Fluid.Vessels.OpenTank tank2(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    T_start=293.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-80,-20},{-66,-6}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    V=0.001) annotation (Placement(transformation(extent={{-50,-22},{-30,-2}})));

  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    T_start=293.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{52,-10},{66,4}})));
equation
  connect(heatPumpDetailed.port_conOut, fan.port_a) annotation (Line(points={{14,7},{
          28,7},{28,36},{38,36}},        color={0,127,255}));
  connect(fan.port_b, Fluid_out_warm) annotation (Line(points={{58,36},{80,36},
          {80,60},{100,60}}, color={0,127,255}));
  connect(dp_in1, fan.dp_in) annotation (Line(points={{44,100},{48,100},{48,48}},
                    color={0,0,127}));
  connect(Fluid_in_cold, fan1.port_a) annotation (Line(points={{-100,20},{-86,
          20},{-86,16},{-72,16}}, color={0,127,255}));
  connect(fan1.port_b, heatPumpDetailed.port_evaIn) annotation (Line(points={{
          -52,16},{-32,16},{-32,7},{-12,7}}, color={0,127,255}));
  connect(onOff_in1, heatPumpDetailed.onOff_in)
    annotation (Line(points={{-4,100},{-4,9}}, color={255,0,255}));
  connect(dp_in2, fan1.dp_in) annotation (Line(points={{-48,100},{-56,100},{-56,
          28},{-62,28}}, color={0,0,127}));
  connect(tank2.ports[1], Fluid_out_cold)
    annotation (Line(points={{-74.4,-20},{-100,-20}}, color={0,127,255}));
  connect(vol.ports[1], heatPumpDetailed.port_evaOut) annotation (Line(points={
          {-42,-22},{-26,-22},{-26,-7},{-12,-7}}, color={0,127,255}));
  connect(vol.ports[2], tank2.ports[2]) annotation (Line(points={{-38,-22},{-58,
          -22},{-58,-20},{-71.6,-20}}, color={0,127,255}));
  connect(heatPumpDetailed.port_conIn, tank1.ports[1]) annotation (Line(points=
          {{14,-7},{36,-7},{36,-10},{57.6,-10}}, color={0,127,255}));
  connect(tank1.ports[2], Fluid_in_warm) annotation (Line(points={{60.4,-10},{
          80,-10},{80,-12},{100,-12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
