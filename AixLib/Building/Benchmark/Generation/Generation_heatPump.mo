within AixLib.Building.Benchmark.Generation;
model Generation_heatPump
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

  Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={84,8})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-20,80},{20,120}}), iconTransformation(extent={{-10,90},{10,110}})));
  Fluid.Movers.FlowControlled_dp Pump_Warmwater_heatpump(
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{32,44},{52,64}})));
equation
  connect(heatPumpDetailed.port_conIn, Fluid_in_warm) annotation (Line(points={
          {14,-7},{58,-7},{58,-60},{100,-60}}, color={0,127,255}));
  connect(bou1.ports[1], Fluid_in_warm) annotation (Line(points={{84,-2},{84,
          -12},{58,-12},{58,-60},{100,-60}}, color={0,127,255}));
  connect(Fluid_out_cold, heatPumpDetailed.port_evaOut) annotation (Line(points=
         {{-100,-60},{-24,-60},{-24,-7},{-12,-7}}, color={0,127,255}));
  connect(Fluid_in_cold, heatPumpDetailed.port_evaIn) annotation (Line(points={
          {-100,60},{-24,60},{-24,7},{-12,7}}, color={0,127,255}));
  connect(Pump_Warmwater_heatpump.port_b, Fluid_out_warm) annotation (Line(
        points={{52,54},{76,54},{76,60},{100,60}}, color={0,127,255}));
  connect(Pump_Warmwater_heatpump.port_a, heatPumpDetailed.port_conOut)
    annotation (Line(points={{32,54},{24,54},{24,7},{14,7}}, color={0,127,255}));
  connect(Pump_Warmwater_heatpump.dp_in, controlBus.Pump_Warmwater_heatpump_dp)
    annotation (Line(points={{42,66},{42,80},{0.1,80},{0.1,100.1}}, color={0,0,
          127}));
  connect(heatPumpDetailed.onOff_in, controlBus.OnOff_heatpump) annotation (
      Line(points={{-4,9},{-4,60},{0.1,60},{0.1,100.1}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_heatPump;
