within AixLib.Building.Benchmark.Generation;
model Generation_heatPump
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    T_start=293.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{30,-20},{44,-6}})));
  Fluid.Movers.FlowControlled_dp fan(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{34,4},{54,24}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,4},{110,24}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Fluid.HeatPumps.HeatPumpDetailed heatPumpDetailed(
    HPctrlType=true,
    capCalcType=2,
    redeclare package Medium_con =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium_eva =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    dataTable=DataBase.HeatPump.EN14511.Ochsner_GMLW_19(),
    redeclare function data_poly =
        Fluid.HeatPumps.BaseClasses.Functions.Characteristics.constantQualityGrade,

    T_startEva=283.15,
    CorrFlowCo=true,
    CorrFlowEv=true)
    annotation (Placement(transformation(extent={{-14,-10},{16,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid input port"
    annotation (Placement(transformation(extent={{-110,16},{-90,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Evaporator fluid output port"
    annotation (Placement(transformation(extent={{-110,-26},{-90,-6}})));
  Fluid.Movers.FlowControlled_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{-58,-2},{-38,18}})));
  Modelica.Fluid.Vessels.OpenTank tank2(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    T_start=293.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-60,-28},{-46,-14}})));
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
equation
  connect(fan.port_b, Fluid_out_warm)
    annotation (Line(points={{54,14},{100,14}}, color={0,127,255}));
  connect(fan.port_a, heatPumpDetailed.port_conOut) annotation (Line(points={{
          34,14},{24,14},{24,7},{14,7}}, color={0,127,255}));
  connect(heatPumpDetailed.port_conIn, tank1.ports[1]) annotation (Line(points=
          {{14,-7},{26,-7},{26,-20},{35.6,-20}}, color={0,127,255}));
  connect(fan1.port_b, heatPumpDetailed.port_evaIn) annotation (Line(points={{
          -38,8},{-26,8},{-26,7},{-12,7}}, color={0,127,255}));
  connect(fan1.port_a, Fluid_in_cold) annotation (Line(points={{-58,8},{-78,8},
          {-78,26},{-100,26}}, color={0,127,255}));
  connect(tank2.ports[1], heatPumpDetailed.port_evaOut) annotation (Line(points
        ={{-54.4,-28},{-32,-28},{-32,-7},{-12,-7}}, color={0,127,255}));
  connect(tank2.ports[2], Fluid_out_cold) annotation (Line(points={{-51.6,-28},
          {-76,-28},{-76,-16},{-100,-16}}, color={0,127,255}));
  connect(tank1.ports[2], Fluid_in_warm)
    annotation (Line(points={{38.4,-20},{100,-20}}, color={0,127,255}));
  connect(heatPumpDetailed.onOff_in, onOff_in1)
    annotation (Line(points={{-4,9},{-4,100}}, color={255,0,255}));
  connect(fan.dp_in, dp_in1)
    annotation (Line(points={{44,26},{44,100}}, color={0,0,127}));
  connect(fan1.dp_in, dp_in2)
    annotation (Line(points={{-48,20},{-48,100}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-30,58},{32,38}},
          lineColor={28,108,200},
          textString="Parameter passen nicht")}));
end Generation_heatPump;
