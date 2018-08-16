within AixLib.Building.Benchmark;
model FullModel
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Weather weather
    annotation (Placement(transformation(extent={{50,82},{70,102}})));
  Buildings.Office office
    annotation (Placement(transformation(extent={{30,0},{92,60}})));
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
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Transfer.Transfer_TBA.Full_Transfer_TBA full_Transfer_TBA(
    riseTime_valve=2,
    m_flow_nominal_openplanoffice=2.516,
    m_flow_nominal_conferenceroom=0.19,
    m_flow_nominal_multipersonoffice=0.378,
    m_flow_nominal_canteen=1.061,
    m_flow_nominal_workshop=1.061,
    dp_Valve_nominal_openplanoffice=10000,
    dp_Valve_nominal_conferenceroom=10000,
    dp_Valve_nominal_multipersonoffice=10000,
    dp_Valve_nominal_canteen=10000,
    dp_Valve_nominal_workshop=10000)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Transfer.Transfer_RLT.Full_Transfer_RLT full_Transfer_RLT(riseTime_valve=2)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
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
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=0.1) annotation (Placement(transformation(extent={{-4,-8},{6,2}})));
  Fluid.MixingVolumes.MixingVolume vol2(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=0.1) annotation (Placement(transformation(extent={{0,90},{10,100}})));
  Fluid.MixingVolumes.MixingVolume vol3(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=0.1) annotation (Placement(transformation(extent={{24,84},{34,94}})));
equation
  connect(generation.Fluid_out_hot, full_Transfer_RLT.Fluid_in_hot) annotation (
     Line(points={{-60,-42},{-6,-42},{-6,-42},{0,-42}}, color={0,127,255}));
  connect(generation.Fluid_in_hot, full_Transfer_RLT.Fluid_out_hot) annotation (
     Line(points={{-60,-46},{-8,-46},{-8,-46},{0,-46}}, color={0,127,255}));
  connect(generation.Fluid_in_hot, generation.Fluid_out_warm)
    annotation (Line(points={{-60,-46},{-60,-48}}, color={0,127,255}));
  connect(generation.Fluid_out_warm, full_Transfer_TBA.Fluid_in_warm)
    annotation (Line(points={{-60,-48},{-40,-48},{-40,-80},{40,-80},{40,-47.4},
          {60,-47.4}}, color={0,127,255}));
  connect(full_Transfer_TBA.Fluid_out_warm, generation.Fluid_in_warm)
    annotation (Line(points={{60,-51.4},{40,-51.4},{40,-80},{-40,-80},{-40,-52},
          {-60,-52}}, color={0,127,255}));
  connect(weather.SolarRadiation_OrientedSurfaces1, office.SolarRadiationPort)
    annotation (Line(points={{51,99},{22,99},{22,54},{30,54}}, color={255,128,0}));
  connect(office.Air_in, full_Transfer_RLT.Air_out) annotation (Line(points={{48.6,0},
          {48.6,-20},{14,-20},{14,-40}},         color={0,127,255}));
  connect(Ext_Warm.port_a1, office.Air_out) annotation (Line(points={{16.4,50},
          {16,50},{16,-10},{36.2,-10},{36.2,0}},
                                             color={0,127,255}));
  connect(weather.measureBus, measureBus) annotation (Line(
      points={{66,82},{66,80},{-74,80},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(generation.measureBus, measureBus) annotation (Line(
      points={{-74,-40},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(office.measureBus, measureBus) annotation (Line(
      points={{30,30},{0,30},{0,80},{-74,80},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));

  connect(full_Transfer_RLT.measureBus, measureBus) annotation (Line(
      points={{20.2,-53},{28,-53},{28,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA.measureBus, measureBus) annotation (Line(
      points={{80,-54},{92,-54},{92,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA.HeatPort_TBA, office.Heatport_TBA) annotation (Line(
        points={{74,-40},{74,-20},{79.6,-20},{79.6,0}}, color={191,0,0}));
  connect(internalLoads.AddPower, office.AddPower)
    annotation (Line(points={{-9.2,18},{30,18}}, color={191,0,0}));
  connect(full_Transfer_RLT.heatPort, office.AddPower)
    annotation (Line(points={{10,-40},{10,18},{30,18}}, color={191,0,0}));
  connect(full_Transfer_TBA.HeatPort_pumpsAndPipes, office.AddPower)
    annotation (Line(points={{66,-40},{66,-20},{10,-20},{10,18},{30,18}}, color=
         {191,0,0}));
  connect(internalLoads.internalBus, office.internalBus) annotation (Line(
      points={{-9.6,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.internalBus, office.internalBus) annotation (Line(
      points={{70,92},{80,92},{80,80},{0,80},{0,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(generation.heatPort_Canteen, office.AddPower[4]) annotation (Line(
        points={{-80,-44},{-84,-44},{-84,-20},{10,-20},{10,19.2},{30,19.2}},
        color={191,0,0}));
  connect(generation.heatPort_workshop, office.AddPower[5]) annotation (Line(
        points={{-80,-48},{-84,-48},{-84,-20},{10,-20},{10,20.4},{30,20.4}},
        color={191,0,0}));
  connect(generation.controlBus, controlBus) annotation (Line(
      points={{-66,-40},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.controlBus, controlBus) annotation (Line(
      points={{54,82},{54,74},{-66,74},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.controlBus, controlBus) annotation (Line(
      points={{20.2,-47.2},{24,-47.2},{24,-30},{-66,-30},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));

  connect(full_Transfer_TBA.controlBus, controlBus) annotation (Line(
      points={{80,-46},{80,-46},{86,-46},{86,-30},{-66,-30},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));

  connect(generation.Fluid_out_cold, full_Transfer_RLT.Fluid_in_cold)
    annotation (Line(points={{-60,-58},{-40,-58},{-40,-54},{0,-54}}, color={0,127,
          255}));
  connect(full_Transfer_RLT.Fluid_out_cold, generation.Fluid_in_cold)
    annotation (Line(points={{0,-58},{-40,-58},{-40,-54},{-60,-54}}, color={0,127,
          255}));
  connect(full_Transfer_TBA.Fluid_in_cold, generation.Fluid_out_cold)
    annotation (Line(points={{60,-54},{40,-54},{40,-74},{-40,-74},{-40,-58},{-60,
          -58}}, color={0,127,255}));
  connect(full_Transfer_TBA.Fluid_out_cold, generation.Fluid_in_cold)
    annotation (Line(points={{60,-58},{40,-58},{40,-80},{-40,-80},{-40,-54},{-60,
          -54}}, color={0,127,255}));
  connect(Ext_Warm.port_b1, vol3.ports[1]) annotation (Line(points={{16.4,66},{
          16,66},{16,84},{28,84}}, color={0,127,255}));
  connect(vol3.ports[2], weather.Air_in) annotation (Line(points={{30,84},{40,
          84},{40,86},{50,86}}, color={0,127,255}));
  connect(weather.Air_out, vol2.ports[1])
    annotation (Line(points={{50,90},{4,90}}, color={0,127,255}));
  connect(vol2.ports[2], Ext_Warm.port_a2)
    annotation (Line(points={{6,90},{6,66},{5.6,66}}, color={0,127,255}));
  connect(Ext_Warm.port_b2, vol1.ports[1]) annotation (Line(points={{5.6,50},{4,
          50},{4,-8},{0,-8}}, color={0,127,255}));
  connect(vol1.ports[2], full_Transfer_RLT.Air_in) annotation (Line(points={{2,
          -8},{4,-8},{4,-40},{6,-40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5000, Interval=1));
end FullModel;
