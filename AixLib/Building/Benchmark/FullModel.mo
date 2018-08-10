within AixLib.Building.Benchmark;
model FullModel
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Weather weather
    annotation (Placement(transformation(extent={{50,82},{70,102}})));
  Buildings.Office office
    annotation (Placement(transformation(extent={{30,0},{92,60}})));
  Generation.Generation generation(
    pump_model_hotwater=Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12(),
    v_nominal_hotwater=1.692,
    m_flow_nominal_hotwater=6.307,
    pump_model_warmwater=Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12(),
    v_nominal_warmwater=1.543,
    m_flow_nominal_warmwater=7.819,
    pump_model_coldwater=Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12(),
    v_nominal_coldwater=1.567,
    m_flow_nominal_coldwater=7.774,
    pump_model_generation_hot=Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12(),

    CHP_model_generation_hot=DataBase.CHP.CHP_FMB_31_GSK(),
    boiler_model_generation_hot=DataBase.Boiler.General.Boiler_Vitogas200F_60kW(),

    m_flow_nominal_generation_hot=3.805,
    heatpump_model_small=DataBase.HeatPump.EN14511.Ochsner_GMSW_15plus(),
    factor_heatpump_model_small=3,
    heatpump_model_big=DataBase.HeatPump.EN14511.Ochsner_GMSW_15plus(),
    factor_heatpump_model_big=6,
    vol_small=0.012,
    vol_big=0.024,
    pump_model_generation_warmwater=
        Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12(),
    m_flow_nominal_generation_warmwater=4.951,
    pump_model_generation_coldwater=
        Fluid.Movers.Data.Pumps.Wilo.Stratos50slash1to12(),
    m_flow_nominal_generation_coldwater=3.914,
    pump_model_generation_aircooler=
        Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12(),
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
    storage_model_hot=DataBase.Storage.Benchmark_7500l(),
    storage_model_warm=DataBase.Storage.Benchmark_7500l(),
    storage_model_cold=DataBase.Storage.Benchmark_12000l(),
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
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-120,60},{-80,100}}), iconTransformation(extent={{-116,34},{-96,54}})));
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
    annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
equation
  connect(weather.WindSpeed_North, office.WindSpeedPort_North) annotation (Line(
        points={{70,100},{100,100},{100,54},{92,54}},
                                                    color={0,0,127}));
  connect(weather.WindSpeed_East, office.WindSpeedPort_East) annotation (Line(
        points={{70,96},{100,96},{100,45},{92,45}}, color={0,0,127}));
  connect(weather.WindSpeed_South, office.WindSpeedPort_South) annotation (Line(
        points={{70,92},{100,92},{100,36},{92,36}}, color={0,0,127}));
  connect(weather.WindSpeed_West, office.WindSpeedPort_West) annotation (Line(
        points={{70,88},{100,88},{100,27},{92,27}}, color={0,0,127}));
  connect(office.WindSpeedPort_Hor, weather.WindSpeed_Hor) annotation (Line(
        points={{85.8,60},{86,60},{86,84},{70,84}}, color={0,0,127}));
  connect(generation.Fluid_out_cold, full_Transfer_TBA.Fluid_in_cold)
    annotation (Line(points={{-60,-58},{-40,-58},{-40,-80},{40,-80},{40,-80},{40,
          -54},{60,-54}},
        color={0,127,255}));
  connect(generation.Fluid_in_cold, full_Transfer_TBA.Fluid_out_cold)
    annotation (Line(points={{-60,-54},{-40,-54},{-40,-80},{40,-80},{40,-58},{60,
          -58}},
        color={0,127,255}));
  connect(full_Transfer_TBA.HeatPort_TBA, office.Heatport_TBA) annotation (Line(
        points={{74,-40},{74,-20},{79.6,-20},{79.6,0}}, color={191,0,0}));
  connect(generation.Fluid_out_hot, full_Transfer_RLT.Fluid_in_hot) annotation (
     Line(points={{-60,-42},{-6,-42},{-6,-42},{0,-42}}, color={0,127,255}));
  connect(generation.Fluid_in_hot, full_Transfer_RLT.Fluid_out_hot) annotation (
     Line(points={{-60,-46},{-8,-46},{-8,-46},{0,-46}}, color={0,127,255}));
  connect(full_Transfer_RLT.Fluid_in_cold, generation.Fluid_out_cold)
    annotation (Line(points={{0,-54},{-40,-54},{-40,-58},{-60,-58}},
                                                 color={0,127,255}));
  connect(full_Transfer_RLT.Fluid_out_cold, generation.Fluid_in_cold)
    annotation (Line(points={{0,-58},{-40,-58},{-40,-54},{-60,-54}},
                                                 color={0,127,255}));
  connect(generation.Fluid_in_hot, generation.Fluid_out_warm)
    annotation (Line(points={{-60,-46},{-60,-48}}, color={0,127,255}));
  connect(generation.Fluid_out_warm, full_Transfer_TBA.Fluid_in_warm)
    annotation (Line(points={{-60,-48},{-40,-48},{-40,-80},{40,-80},{40,-47.4},
          {60,-47.4}}, color={0,127,255}));
  connect(full_Transfer_TBA.Fluid_out_warm, generation.Fluid_in_warm)
    annotation (Line(points={{60,-51.4},{40,-51.4},{40,-80},{-40,-80},{-40,-52},
          {-60,-52}}, color={0,127,255}));
  connect(weather.SolarRadiation_OrientedSurfaces1, office.SolarRadiationPort_North)
    annotation (Line(points={{51,99},{22,99},{22,54},{30,54}}, color={255,128,0}));
  connect(office.Air_in, full_Transfer_RLT.Air_out) annotation (Line(points={{48.6,0},
          {48.6,-20},{14,-20},{14,-40}},         color={0,127,255}));
  connect(weather.Airtemp, office.AirTemp) annotation (Line(points={{60,82},{60,
          59.4},{60.38,59.4}}, color={0,0,127}));
  connect(weather.controlBus, controlBus) annotation (Line(
      points={{54,82},{54,82},{54,80},{-100,80}},
      color={255,204,51},
      thickness=0.5));
  connect(generation.controlBus, controlBus) annotation (Line(
      points={{-66,-40},{-66,80},{-100,80}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.controlBus, controlBus) annotation (Line(
      points={{20.2,-47.2},{28,-47.2},{28,-36},{-66,-36},{-66,80},{-100,80}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA.controlBus, controlBus) annotation (Line(
      points={{80,-46},{84,-46},{84,-36},{-66,-36},{-66,80},{-100,80}},
      color={255,204,51},
      thickness=0.5));
  connect(internalLoads.Water_Room, office.mWat)
    annotation (Line(points={{-8,42},{30,42}}, color={0,0,127}));
  connect(internalLoads.AddPower, office.AddPower)
    annotation (Line(points={{-9.2,18},{30,18}}, color={191,0,0}));
  connect(full_Transfer_RLT.heatPort, office.AddPower)
    annotation (Line(points={{10,-40},{10,18},{30,18}}, color={191,0,0}));
  connect(full_Transfer_TBA.HeatPort_pumpsAndPipes, office.AddPower)
    annotation (Line(points={{66,-40},{66,-20},{10,-20},{10,18},{30,18}}, color=
         {191,0,0}));
  connect(generation.HeatPort_pumpsAndPipes, office.AddPower) annotation (Line(
        points={{-60,-50},{-40,-50},{-40,-20},{10,-20},{10,18},{30,18},{30,18}},
        color={191,0,0}));
  connect(weather.Air_out, Ext_Warm.port_a2)
    annotation (Line(points={{50,90},{5.6,90},{5.6,66}},
                                                     color={0,127,255}));
  connect(Ext_Warm.port_b2, full_Transfer_RLT.Air_in)
    annotation (Line(points={{5.6,50},{6,50},{6,-40}},
                                              color={0,127,255}));
  connect(weather.Air_in, Ext_Warm.port_b1)
    annotation (Line(points={{50,86},{16.4,86},{16.4,66}},
                                                       color={0,127,255}));
  connect(Ext_Warm.port_a1, office.Air_out) annotation (Line(points={{16.4,50},
          {16,50},{16,-10},{36.2,-10},{36.2,0}},
                                             color={0,127,255}));
  connect(weather.measureBus, measureBus) annotation (Line(
      points={{66,82},{66,80},{-74,80},{-74,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(generation.measureBus, measureBus) annotation (Line(
      points={{-74,-40},{-74,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(office.measureBus, measureBus) annotation (Line(
      points={{30,30},{0,30},{0,32},{0,32},{0,80},{-74,80},{-74,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));

  connect(full_Transfer_RLT.measureBus, measureBus) annotation (Line(
      points={{20.2,-53},{28,-53},{28,-36},{-74,-36},{-74,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA.measureBus, measureBus) annotation (Line(
      points={{80,-54},{84,-54},{84,-36},{-74,-36},{-74,40},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5000, Interval=1));
end FullModel;
