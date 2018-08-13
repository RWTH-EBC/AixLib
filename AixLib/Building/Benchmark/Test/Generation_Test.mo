within AixLib.Building.Benchmark.Test;
model Generation_Test
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  Regelungsbenchmark.Testcontroller testcontroller
    annotation (Placement(transformation(extent={{-100,68},{-80,88}})));
  Generation.Generation generation(
    v_nominal_hotwater=1.692,
    m_flow_nominal_hotwater=6.307,
    v_nominal_warmwater=1.543,
    m_flow_nominal_warmwater=7.819,
    v_nominal_coldwater=1.567,
    m_flow_nominal_coldwater=7.774,
    m_flow_nominal_generation_hot=3.805,
    factor_heatpump_model_small=3,
    factor_heatpump_model_big=6,
    vol_small=0.012,
    vol_big=0.024,
    m_flow_nominal_generation_warmwater=4.951,
    m_flow_nominal_generation_coldwater=3.914,
    m_flow_nominal_generation_aircooler=4.951,
    Probe_depth=120,
    n_probes=1,
    pipe_length_hotwater=25,
    pipe_length_warmwater=25,
    pipe_length_coldwater=25,
    riseTime_valve=2,
    pipe_wall_thickness_hotwater=0.004,
    pipe_insulation_thickness_hotwater=0.02,
    pipe_insulation_conductivity_hotwater=0.05,
    pipe_wall_thickness_warmwater=0.004,
    pipe_insulation_thickness_warmwater=0.02,
    pipe_insulation_conductivity_warmwater=0.05,
    pipe_wall_thickness_coldwater=0.0036,
    pipe_insulation_thickness_coldwater=0.02,
    pipe_insulation_conductivity_coldwater=0.05,
    m_flow_nominal_generation_air_max=100,
    m_flow_nominal_generation_air_min=10,
    alphaHC1_warm=500,
    alphaHC2_warm=500,
    alphaHC1_cold=500,
    R_loss_small=50,
    R_loss_big=100,
    dpHeatexchanger_nominal=20000,
    dpValve_nominal_generation_hot=227000,
    T_conMax_big=328.15,
    T_conMax_small=328.15,
    dpValve_nominal_warmwater=285000,
    dpValve_nominal_coldwater=200000,
    dpValve_nominal_generation_aircooler=60000,
    Earthtemperature_start=283.15)
    annotation (Placement(transformation(extent={{-14,4},{6,24}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={32,-14})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=300)
    annotation (Placement(transformation(extent={{72,64},{92,84}})));
  BusSystem.measureBus measureBus1
    annotation (Placement(transformation(extent={{-4,54},{36,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0)
    annotation (Placement(transformation(extent={{84,38},{104,58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-76,14},{-56,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=
        293.15)
    annotation (Placement(transformation(extent={{-74,-16},{-54,4}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={46,16})));
equation
  connect(generation.measureBus, testcontroller.measureBus) annotation (Line(
      points={{-8,24},{-10,24},{-10,80},{-80,80}},
      color={255,204,51},
      thickness=0.5));
  connect(testcontroller.controlBus, generation.controlBus) annotation (Line(
      points={{-80,76},{0,76},{0,24}},
      color={255,204,51},
      thickness=0.5));
  connect(generation.measureBus, measureBus1) annotation (Line(
      points={{-8,24},{4,24},{4,74},{16,74}},
      color={255,204,51},
      thickness=0.5));
  connect(realExpression.y, measureBus1.AirTemp) annotation (Line(points={{93,74},
          {44,74},{44,68},{16.1,68},{16.1,74.1}}, color={0,0,127}));
  connect(realExpression1.y, measureBus1.WaterInAir) annotation (Line(points={{105,
          48},{108,48},{108,74.1},{16.1,74.1}}, color={0,0,127}));
  connect(generation.Fluid_out_hot, generation.Fluid_in_hot) annotation (Line(
        points={{6,22},{22,22},{22,18},{6,18}}, color={0,127,255}));
  connect(generation.Fluid_out_warm, generation.Fluid_in_warm) annotation (Line(
        points={{6,16},{22,16},{22,12},{6,12}}, color={0,127,255}));
  connect(generation.Fluid_in_cold, generation.Fluid_out_cold)
    annotation (Line(points={{6,10},{22,10},{22,6},{6,6}}, color={0,127,255}));
  connect(bou2.ports[1], generation.Fluid_out_cold) annotation (Line(points={{
          32,-18},{22,-18},{22,-14},{14,-14},{14,6},{6,6}}, color={0,127,255}));
  connect(fixedTemperature.port, generation.heatPort_Canteen) annotation (Line(
        points={{-56,24},{-36,24},{-36,20},{-14,20}}, color={191,0,0}));
  connect(fixedTemperature1.port, generation.heatPort_workshop) annotation (
      Line(points={{-54,-6},{-44,-6},{-44,12},{-14,12},{-14,16}}, color={191,0,
          0}));
  connect(bou1.ports[1], generation.Fluid_in_warm)
    annotation (Line(points={{46,12},{6,12}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_Test;
