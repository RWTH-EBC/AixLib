within AixLib.Building.Benchmark.Test;
model Office_Test
replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
      replaceable package Medium_Air = AixLib.Media.Air
    "Medium in the component";
  Weather weather
    annotation (Placement(transformation(extent={{50,82},{70,102}})));
  Buildings.Office office
    annotation (Placement(transformation(extent={{30,0},{92,60}})));
  InternalLoads.InternalLoads internalLoads
    annotation (Placement(transformation(extent={{-48,50},{-8,10}})));
  Fluid.HeatExchangers.ConstantEffectiveness Ext_Warm(
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium1 = Medium_Air,
    m1_flow_nominal=100,
    m2_flow_nominal=100)
    annotation (Placement(transformation(extent={{-8,9},{8,-9}},
        rotation=90,
        origin={11,58})));
  Regelungsbenchmark.Testcontroller testcontroller
    annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1
                                                                         [5](T=293.15)
    annotation (Placement(transformation(extent={{-92,-34},{-72,-14}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-14,-72})));
  Transfer.Transfer_RLT.Full_Transfer_RLT full_Transfer_RLT(riseTime_valve=1)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Fluid.Sources.Boundary_pT bou4(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-36,-70})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2
                                                                         [5](T=293.15)
    annotation (Placement(transformation(extent={{-22,-28},{-2,-8}})));
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
    annotation (Placement(transformation(extent={{-78,-82},{-58,-62}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature3(T=293.15)
    annotation (Placement(transformation(extent={{-132,-64},{-112,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature4(T=293.15)
    annotation (Placement(transformation(extent={{-134,-94},{-114,-74}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={10,-42})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={2,-62})));
equation
  connect(weather.SolarRadiation_OrientedSurfaces1,office. SolarRadiationPort)
    annotation (Line(points={{51,99},{22,99},{22,54},{30,54}}, color={255,128,0}));
  connect(weather.Air_out,Ext_Warm. port_a2)
    annotation (Line(points={{50,90},{5.6,90},{5.6,66}},
                                                     color={0,127,255}));
  connect(weather.Air_in,Ext_Warm. port_b1)
    annotation (Line(points={{50,86},{16.4,86},{16.4,66}},
                                                       color={0,127,255}));
  connect(Ext_Warm.port_a1,office. Air_out) annotation (Line(points={{16.4,50},
          {16,50},{16,-10},{36.2,-10},{36.2,0}},
                                             color={0,127,255}));
  connect(internalLoads.AddPower,office. AddPower)
    annotation (Line(points={{-9.2,18},{30,18}}, color={191,0,0}));
  connect(internalLoads.internalBus, office.internalBus) annotation (Line(
      points={{-9.6,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(office.measureBus, weather.measureBus) annotation (Line(
      points={{30,30},{10,30},{10,76},{66,76},{66,82}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.internalBus, office.internalBus) annotation (Line(
      points={{70,92},{86,92},{86,70},{-2,70},{-2,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.controlBus, testcontroller.controlBus) annotation (Line(
      points={{54,82},{-78,82}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature1.port, full_Transfer_RLT.heatPort)
    annotation (Line(points={{-72,-24},{40,-24},{40,-50}}, color={191,0,0}));
  connect(full_Transfer_RLT.Air_out, office.Air_in) annotation (Line(points={{
          44,-50},{46,-50},{46,0},{48.6,0}}, color={0,127,255}));
  connect(Ext_Warm.port_b2, full_Transfer_RLT.Air_in) annotation (Line(points={
          {5.6,50},{4,50},{4,-36},{36,-36},{36,-50}}, color={0,127,255}));
  connect(full_Transfer_RLT.controlBus, testcontroller.controlBus) annotation (
      Line(
      points={{50.2,-57.2},{-78,-57.2},{-78,82}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.measureBus, weather.measureBus) annotation (Line(
      points={{50.2,-63},{50.2,9.5},{66,9.5},{66,82}},
      color={255,204,51},
      thickness=0.5));
  connect(testcontroller.measureBus, weather.measureBus) annotation (Line(
      points={{-78,86},{-50,86},{-50,88},{66,88},{66,82}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature2.port, office.Heatport_TBA)
    annotation (Line(points={{-2,-18},{79.6,-18},{79.6,0}}, color={191,0,0}));
  connect(generation.Fluid_out_warm, bou4.ports[1]) annotation (Line(points={{
          -58,-70},{-26,-70},{-26,-74},{-35.2,-74}}, color={0,127,255}));
  connect(bou4.ports[2], generation.Fluid_in_warm)
    annotation (Line(points={{-36.8,-74},{-58,-74}}, color={0,127,255}));
  connect(bou1.ports[1], generation.Fluid_out_cold) annotation (Line(points={{
          -13.2,-76},{-13.2,-80},{-58,-80}}, color={0,127,255}));
  connect(generation.controlBus, testcontroller.controlBus) annotation (Line(
      points={{-64,-62},{-64,82},{-78,82}},
      color={255,204,51},
      thickness=0.5));
  connect(generation.measureBus, weather.measureBus) annotation (Line(
      points={{-72,-62},{-74,-62},{-74,86},{-50,86},{-50,88},{66,88},{66,82}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature4.port, generation.heatPort_workshop) annotation (
      Line(points={{-114,-84},{-96,-84},{-96,-70},{-78,-70}}, color={191,0,0}));
  connect(generation.heatPort_Canteen, fixedTemperature3.port) annotation (Line(
        points={{-78,-66},{-96,-66},{-96,-54},{-112,-54}}, color={191,0,0}));
  connect(bou2.ports[1], full_Transfer_RLT.Fluid_in_hot) annotation (Line(
        points={{10.8,-46},{20,-46},{20,-52},{30,-52}}, color={0,127,255}));
  connect(full_Transfer_RLT.Fluid_out_hot, bou2.ports[2]) annotation (Line(
        points={{30,-56},{9.2,-56},{9.2,-46}}, color={0,127,255}));
  connect(generation.Fluid_in_cold, bou1.ports[2])
    annotation (Line(points={{-58,-76},{-14.8,-76}}, color={0,127,255}));
  connect(bou3.ports[1], full_Transfer_RLT.Fluid_in_cold) annotation (Line(
        points={{2.8,-66},{16,-66},{16,-64},{30,-64}}, color={0,127,255}));
  connect(bou3.ports[2], full_Transfer_RLT.Fluid_out_cold) annotation (Line(
        points={{1.2,-66},{1.2,-68},{30,-68}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office_Test;
