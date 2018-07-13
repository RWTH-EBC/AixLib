within AixLib.Building.Benchmark.Generation;
model Generation_Hot

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_Hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,28},{110,48}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_Hot(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealInput TSet_boiler annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,100})));
  Modelica.Blocks.Interfaces.BooleanInput isOn_boiler
    "Switches Controler on and off" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput dp_in1
    "Prescribed pressure rise" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,100})));

  Modelica.Fluid.Vessels.OpenTank tank1(
    use_portsData=false,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    height=0.1,
    crossArea=0.1,
    T_start=293.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{30,-20},{44,-6}})));

  Test.Boiler_Benchmark boiler_Benchmark(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_11kW())
    annotation (Placement(transformation(extent={{10,46},{30,66}})));

  Fluid.Movers.FlowControlled_dp fan(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)
    annotation (Placement(transformation(extent={{-40,6},{-20,26}})));

  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{36,6},{56,26}})));
  Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.2,
    dpValve_nominal=2,
    y_start=1) annotation (Placement(transformation(extent={{8,26},{-12,6}})));

  Fluid.BoilerCHP.CHP cHP(
    electricityDriven=true,
    TSetIn=true,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.2,
    param=DataBase.CHP.CHP_FMB_31_GSK(),
    m_flow_small=0.01,
    minCapacity=50)
    annotation (Placement(transformation(extent={{-86,6},{-66,26}})));

  Modelica.Blocks.Interfaces.RealInput TSet_chp annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.BooleanInput isOn_chp
    "Switches Controler on and off" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,100})));
  Modelica.Blocks.Interfaces.RealInput ElSet_chp "in kW" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,100})));
  Modelica.Blocks.Interfaces.RealInput Valve_boiler annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-40})));
equation
  connect(dp_in1, fan.dp_in) annotation (Line(points={{-20,100},{-20,63},{-30,
          63},{-30,28}}, color={0,0,127}));
  connect(val.port_1, teeJunctionIdeal.port_1)
    annotation (Line(points={{8,16},{36,16}}, color={0,127,255}));
  connect(val.port_3, boiler_Benchmark.port_a)
    annotation (Line(points={{-2,26},{-2,56},{10,56}}, color={0,127,255}));
  connect(fan.port_b, val.port_2)
    annotation (Line(points={{-20,16},{-12,16}}, color={0,127,255}));
  connect(cHP.port_b, fan.port_a)
    annotation (Line(points={{-66,16},{-40,16}}, color={0,127,255}));
  connect(cHP.port_a, tank1.ports[1]) annotation (Line(points={{-86,16},{-86,
          -20},{35.6,-20}}, color={0,127,255}));
  connect(isOn_chp, cHP.on) annotation (Line(points={{-60,100},{-60,0},{-72,0},
          {-72,7},{-73,7}}, color={255,0,255}));
  connect(isOn_boiler, boiler_Benchmark.isOn) annotation (Line(points={{-40,100},
          {-40,40},{25,40},{25,47}}, color={255,0,255}));
  connect(TSet_chp, cHP.TSet) annotation (Line(points={{0,100},{0,100},{0,80},{
          -90,80},{-90,10},{-83,10}}, color={0,0,127}));
  connect(TSet_boiler, boiler_Benchmark.TSet) annotation (Line(points={{20,100},
          {20,74},{2,74},{2,63},{13,63}}, color={0,0,127}));
  connect(cHP.elSet, ElSet_chp) annotation (Line(points={{-83,22},{-90,22},{-90,
          80},{-80,80},{-80,100}}, color={0,0,127}));
  connect(val.y, Valve_boiler)
    annotation (Line(points={{-2,4},{-2,-40},{-100,-40}}, color={0,0,127}));
  connect(boiler_Benchmark.port_b, teeJunctionIdeal.port_3)
    annotation (Line(points={{30,56},{46,56},{46,26}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_2, Fluid_out_Hot) annotation (Line(points={{56,16},
          {80,16},{80,38},{100,38}},     color={0,127,255}));
  connect(tank1.ports[2], Fluid_in_Hot)
    annotation (Line(points={{38.4,-20},{100,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{28,80},{90,60}},
          lineColor={28,108,200},
          textString="Parameter passen nicht")}));
end Generation_Hot;
