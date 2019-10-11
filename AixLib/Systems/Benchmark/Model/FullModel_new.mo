within AixLib.Systems.Benchmark.Model;
model FullModel_new
  Transfer.Transfer_RLT.Full_Transfer_RLT_v2 full_Transfer_RLT
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Evaluation.Evaluation                                evaluation
    annotation (Placement(transformation(extent={{-40,-16},{-20,4}})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium =AixLib.Media.Air)
    annotation (Placement(transformation(extent={{-34,46},{-22,58}})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = AixLib.Media.Air)
    annotation (Placement(transformation(extent={{62,50},{74,62}})));
  Transfer.Transfer_TBA.Full_Transfer_TBA_Heatexchanger_v2
    full_Transfer_TBA_Heatexchanger(
    m_flow_nominal_openplanoffice=2.394,
    m_flow_nominal_canteen=1.086,
    m_flow_nominal_conferenceroom=0.350,
    m_flow_nominal_multipersonoffice=0.319,
    m_flow_nominal_workshop=1.654,
    dp_Heatexchanger_nominal=20000,
    dp_Valve_nominal_openplanoffice=30000,
    dp_Valve_nominal_conferenceroom=30000,
    dp_Valve_nominal_multipersonoffice=30000,
    dp_Valve_nominal_canteen=30000,
    dp_Valve_nominal_workshop=30000)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  BusSystems.LogModel                                logModel
    annotation (Placement(transformation(extent={{100,-26},{120,-46}})));
  Generation.Generation_v2 generation_v2_1(
    m_flow_nominal_generation_hot=3.805,
    Probe_depth=120,
    pipe_length_hotwater=25,
    pipe_length_warmwater=25,
    pipe_length_coldwater=25,
    alphaHC1_warm=500,
    pipe_diameter_hotwater=0.0809,
    pipe_diameter_warmwater=0.0809,
    pipe_nodes=2,
    n_probes=60,
    m_flow_nominal_hotwater=7.953,
    m_flow_nominal_warmwater=7.999,
    vol_1=0.024,
    vol_2=0.024,
    R_loss_1=2.8,
    R_loss_2=2.8,
    m_flow_nominal_generation_warmwater=6.601,
    m_flow_nominal_generation_coldwater=5.218,
    alphaHC1_cold=700,
    alphaHC2_warm=500,
    m_flow_nominal_coldwater=5.628,
    pipe_diameter_coldwater=0.0689,
    Thermal_Conductance_Cold=97000/10,
    m_flow_nominal_generation_aircooler=3.314,
    Thermal_Conductance_Warm=193000/10,
    dpHeatexchanger_nominal=20000,
    dpValve_nominal_generation_hot=40000,
    T_conMax_1=328.15,
    T_conMax_2=328.15,
    dpValve_nominal_warmwater=37000,
    dpValve_nominal_coldwater=40000,
    dpValve_nominal_generation_aircooler=60000,
    m_flow_nominal_generation_air_small_max=7.5808,
    m_flow_nominal_generation_air_small_min=6.1376,
    m_flow_nominal_generation_air_big_max=30.1309,
    m_flow_nominal_generation_air_big_min=23.9081,
    Area_Heatexchanger_Air=856.01,
    Earthtemperature_start=283.15)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
 Utilities.HeatTransfer.HeatConvOutside        heatTransfer_Outside(surfaceType=
       DataBase.Surfaces.RoughnessForHT.Glass(), A=169.594)                                                                                                                                 annotation(Placement(transformation(extent={{17,84},
            {6,96}})));
  Modelica.Blocks.Math.Gain gain(k=2)
    annotation (Placement(transformation(extent={{34,88},{26,96}})));
  Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=30,
    V=5,
    nPorts=3)
           annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-1,57})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=30,
    V=5,
    nPorts=3)
           annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={21,57})));
  Infiltration infiltration(
    room_V_openplanoffice=4050,
    room_V_conferenceroom=150,
    room_V_multipersonoffice=300,
    room_V_canteen=1800,
    room_V_workshop=2700,
    n50=1.5,
    e=0.05,
    eps=1,
    rho=1.2041)
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  BusSystems.Bus_measure                                Measure
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  BusSystems.Bus_Control                                Control
    annotation (Placement(transformation(extent={{-120,-48},{-80,-8}})));
  Building.Office_new office_new
    annotation (Placement(transformation(extent={{42,2},{62,22}})));
  InternalLoad.InternalLoads_new internalLoads_new
    annotation (Placement(transformation(extent={{-40,18},{-20,38}})));
  Transfer.SupplyAir_RLT supplyAir_RLT
    annotation (Placement(transformation(extent={{42,80},{62,100}})));
  Weather_new weather_new
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,90})));
  Generation.PVSystem pVSystem
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
equation
  connect(full_Transfer_RLT.measureBus,Measure)  annotation (Line(
      points={{20.2,-53},{28,-53},{28,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.controlBus,Control)  annotation (Line(
      points={{20.2,-47.2},{24,-47.2},{24,-32},{-66,-32},{-66,-28},{-100,-28}},
      color={255,204,51},
      thickness=0.5));
  connect(evaluation.measureBus,Measure)  annotation (Line(
      points={{-40,-6},{-74,-6},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(senTem1.T,Measure. Air_out) annotation (Line(points={{72.2,56},{76,56},
          {76,72},{-74,72},{-74,20.1},{-99.9,20.1}}, color={0,0,127}));
  connect(senTem2.T,Measure. Air_in) annotation (Line(points={{-23.8,52},{-20,
          52},{-20,72},{-74,72},{-74,20.1},{-99.9,20.1}},
                                                    color={0,0,127}));
  connect(full_Transfer_TBA_Heatexchanger.controlBus,Control)  annotation (Line(
      points={{80,-46},{84,-46},{84,-32},{-66,-32},{-66,-28},{-100,-28}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_TBA_Heatexchanger.measureBus,Measure)  annotation (Line(
      points={{80,-54},{88,-54},{88,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(logModel.logger_Bus_measure,Measure)  annotation (Line(
      points={{100,-40},{88,-40},{88,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(logModel.logger_Bus_Control,Control)  annotation (Line(
      points={{100,-32},{-66,-32},{-66,-28},{-100,-28}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_v2_1.measureBus,Measure)  annotation (Line(
      points={{-74,-40},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_v2_1.controlBus,Control)  annotation (Line(
      points={{-66,-40},{-66,-28},{-100,-28}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_v2_1.Fluid_in_hot,full_Transfer_RLT. Fluid_out_hot)
    annotation (Line(points={{-60,-46},{0,-46}}, color={0,127,255}));
  connect(generation_v2_1.Fluid_out_cold,full_Transfer_RLT. Fluid_in_cold)
    annotation (Line(points={{-60,-58},{-34,-58},{-34,-54},{0,-54}}, color={0,127,
          255}));
  connect(generation_v2_1.Fluid_in_cold,full_Transfer_RLT. Fluid_out_cold)
    annotation (Line(points={{-60,-54},{-34,-54},{-34,-58},{0,-58}}, color={0,127,
          255}));
  connect(generation_v2_1.Fluid_out_warm,full_Transfer_TBA_Heatexchanger. Fluid_in_warm)
    annotation (Line(points={{-60,-48},{-18,-48},{-18,-66},{36,-66},{36,-47.4},
          {60,-47.4}},color={0,127,255}));
  connect(full_Transfer_TBA_Heatexchanger.Fluid_out_warm,generation_v2_1. Fluid_in_warm)
    annotation (Line(points={{60,-51.4},{36,-51.4},{36,-66},{-18,-66},{-18,-52},
          {-60,-52}}, color={0,127,255}));
  connect(full_Transfer_TBA_Heatexchanger.Fluid_in_cold,generation_v2_1. Fluid_out_cold)
    annotation (Line(points={{60,-54},{36,-54},{36,-66},{-18,-66},{-18,-58},{
          -60,-58}},
                 color={0,127,255}));
  connect(full_Transfer_TBA_Heatexchanger.Fluid_out_cold,generation_v2_1. Fluid_in_cold)
    annotation (Line(points={{60,-58},{36,-58},{36,-66},{-18,-66},{-18,-54},{
          -60,-54}},
                 color={0,127,255}));
  connect(heatTransfer_Outside.WindSpeedPort,gain. y) annotation (Line(points={{16.56,
          85.68},{25.28,85.68},{25.28,92},{25.6,92}},        color={0,0,127}));
  connect(heatTransfer_Outside.port_b,vol2. heatPort)
    annotation (Line(points={{6,90},{-1,90},{-1,62}},
                                                    color={191,0,0}));
  connect(heatTransfer_Outside.port_a,vol1. heatPort)
    annotation (Line(points={{17,90},{21,90},{21,62}}, color={191,0,0}));
  connect(vol2.ports[1],full_Transfer_RLT. Air_in)
    annotation (Line(points={{4,58.3333},{4,10},{6,10},{6,-40}},
                                              color={0,127,255}));
  connect(senTem2.port,vol2. ports[2])
    annotation (Line(points={{-28,46},{4,46},{4,57}},      color={0,127,255}));
  connect(full_Transfer_RLT.Fluid_in_hot,generation_v2_1. Fluid_out_hot)
    annotation (Line(points={{0,-42},{-60,-42}}, color={0,127,255}));
  connect(infiltration.measureBus,Measure)  annotation (Line(
      points={{0,-80},{-8,-80},{-8,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(office_new.Air_out, vol1.ports[1])
    annotation (Line(points={{55.2,2},{54,2},{54,-6},{16,-6},{16,58.3333}},
                                                       color={0,127,255}));
  connect(office_new.Air_out, senTem1.port) annotation (Line(points={{55.2,2},{
          54,2},{54,-6},{16,-6},{16,46},{68,46},{68,50}},
                                       color={0,127,255}));
  connect(internalLoads_new.macConv_port, office_new.port_IntConvGains)
    annotation (Line(points={{-19.6,28.8},{74.2,28.8},{74.2,10.2},{62,10.2}},
        color={191,0,0}));
  connect(internalLoads_new.perConv_port, office_new.port_IntConvGains)
    annotation (Line(points={{-19.6,32.8},{74,32.8},{74,10},{68,10},{68,10.2},{62,
          10.2}}, color={191,0,0}));
  connect(internalLoads_new.perRad_port, office_new.port_IntRadGains)
    annotation (Line(points={{-19.6,37},{28,37},{28,38},{74,38},{74,13.6},{62,
          13.6}},                                                         color=
         {191,0,0}));
  connect(weather_new.therm_roof, office_new.port_roof) annotation (Line(points={{90.6,
          99.6},{90,99.6},{90,100},{100,100},{100,26},{52,26},{52,22}},
                                             color={191,0,0}));
  connect(weather_new.therm_window, office_new.port_windows) annotation (Line(
        points={{90.4,93.6},{90,93.6},{90,94},{100,94},{100,26},{18,26},{18,12},
          {42,12},{42,13.6}},                                   color={191,0,0}));
  connect(weather_new.therm_wall, office_new.port_walls) annotation (Line(
        points={{90.4,86.4},{90,86.4},{90,86},{100,86},{100,26},{18,26},{18,
          10.2},{42,10.2}},                                     color={191,0,0}));
  connect(weather_new.therm_floor, office_new.port_floor) annotation (Line(
        points={{90.2,81.2},{90.2,82},{100,82},{100,-10},{52,-10},{52,2}},
                                                           color={191,0,0}));
  connect(supplyAir_RLT.RLT_Velocity, gain.u) annotation (Line(points={{41.4,
          91.4},{42.7,91.4},{42.7,92},{34.8,92}},
                                            color={0,0,127}));
  connect(supplyAir_RLT.Air_out, vol2.ports[3]) annotation (Line(points={{42,88},
          {42,74},{4,74},{4,55.6667}}, color={0,127,255}));
  connect(supplyAir_RLT.Air_in, vol1.ports[2]) annotation (Line(points={{42,84},
          {42,74},{16,74},{16,57}}, color={0,127,255}));
  connect(office_new.Air_out, vol1.ports[3]) annotation (Line(points={{55.2,2},
          {54,2},{54,-6},{16,-6},{16,55.6667}}, color={0,127,255}));
  connect(weather_new.AirTemp, supplyAir_RLT.AirTemp) annotation (Line(points={
          {77.8,79.4},{70.9,79.4},{70.9,88.4},{62.4,88.4}}, color={0,0,127}));
  connect(weather_new.WaterInAir, supplyAir_RLT.WaterInAir) annotation (Line(
        points={{71.8,79.4},{71.8,85.7},{62.4,85.7},{62.4,92.2}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FullModel_new;
