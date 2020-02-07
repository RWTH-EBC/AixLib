within AixLib.Systems.Benchmark_fb.Model;
model FullModel_new
  Transfer.Transfer_RLT.Full_Transfer_RLT_v2 full_Transfer_RLT
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
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
    nPorts=2)
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
  Transfer.SupplyAir_RLT supplyAir_RLT
    annotation (Placement(transformation(extent={{42,80},{62,100}})));
  Weather_new weather_new
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,90})));
  Building.Office_new office_new
    annotation (Placement(transformation(extent={{42,0},{62,20}})));
  Electrical.PVSystem.PVSystemTMY3 pVSystemTMY3_1(
    NumberOfPanels=50*9,
    data=DataBase.SolarElectric.SymphonyEnergySE6M181(),
    MaxOutputPower=50*9*250)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));

  InternalLoad.InternalLoads_new internalLoads_new
    annotation (Placement(transformation(extent={{-38,22},{-18,42}})));
  Evaluation.Evaluation_CCCS evaluation_CCCS
    annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
equation
  connect(full_Transfer_RLT.measureBus,Measure)  annotation (Line(
      points={{20.2,-53},{28,-53},{28,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.controlBus,Control)  annotation (Line(
      points={{20.2,-47.2},{24,-47.2},{24,-32},{-66,-32},{-66,-28},{-100,-28}},
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
    annotation (Line(points={{-59.8,-48},{-18,-48},{-18,-66},{36,-66},{36,-47.4},
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
  connect(supplyAir_RLT.RLT_Velocity, gain.u) annotation (Line(points={{41.4,
          91.4},{42.7,91.4},{42.7,92},{34.8,92}},
                                            color={0,0,127}));
  connect(supplyAir_RLT.Air_out, vol2.ports[3]) annotation (Line(points={{42,88},
          {34,88},{34,74},{4,74},{4,55.6667}},
                                       color={0,127,255}));
  connect(supplyAir_RLT.Air_in, vol1.ports[1]) annotation (Line(points={{42,84},
          {42,74},{16,74},{16,58}}, color={0,127,255}));
  connect(weather_new.AirTemp, supplyAir_RLT.AirTemp) annotation (Line(points={{77.8,
          79.4},{77.8,80},{78,80},{78,76},{66,76},{66,88.4},{62.4,88.4}},
                                                            color={0,0,127}));
  connect(weather_new.WaterInAir, supplyAir_RLT.WaterInAir) annotation (Line(
        points={{73.2,79.4},{73.2,91.7},{62.4,91.7},{62.4,92.2}}, color={0,0,
          127}));
  connect(weather_new.SolarRad[1], office_new.SolarRadIn[1]) annotation (Line(
        points={{84.2,79.9},{84.2,49.7},{41.6,49.7},{41.6,18}}, color={0,0,127}));
  connect(weather_new.SolarRad[2], office_new.SolarRadIn[2]) annotation (Line(
        points={{84.2,78.9},{84.2,49.7},{41.6,49.7},{41.6,20}}, color={0,0,127}));
  connect(weather_new.therm_window, office_new.port_windows) annotation (Line(
        points={{90.4,93.6},{90.4,-14.2},{42.2,-14.2},{42.2,14}}, color={191,0,0}));
  connect(weather_new.therm_wall, office_new.port_walls) annotation (Line(
        points={{90.4,86.4},{90.4,-13.8},{42.2,-13.8},{42.2,6}}, color={191,0,0}));
  connect(weather_new.therm_floor, office_new.port_floor) annotation (Line(
        points={{90.2,81.2},{90.2,-14.4},{46,-14.4},{46,0.2}}, color={191,0,0}));
  connect(office_new.Air_out, vol1.ports[2]) annotation (Line(points={{52,0},{52,
          -14},{16,-14},{16,56}}, color={0,127,255}));
  connect(office_new.Air_out, senTem1.port) annotation (Line(points={{52,0},{52,
          -14},{16,-14},{16,50},{68,50}}, color={0,127,255}));
  connect(infiltration.Air_out[1], office_new.Air_in[1]) annotation (Line(
        points={{20,-80.8},{36,-80.8},{36,-0.8},{58,-0.8}}, color={0,127,255}));
  connect(infiltration.Air_out[2], office_new.Air_in[2]) annotation (Line(
        points={{20,-80.4},{36,-80.4},{36,-0.4},{58,-0.4}}, color={0,127,255}));
  connect(infiltration.Air_out[3], office_new.Air_in[3]) annotation (Line(
        points={{20,-80},{36,-80},{36,0},{58,0}}, color={0,127,255}));
  connect(infiltration.Air_out[4], office_new.Air_in[4]) annotation (Line(
        points={{20,-79.6},{36,-79.6},{36,0.4},{58,0.4}}, color={0,127,255}));
  connect(infiltration.Air_out[5], office_new.Air_in[5]) annotation (Line(
        points={{20,-79.2},{36,-79.2},{36,0},{58,0},{58,0.8}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out[1], office_new.Air_in[1]) annotation (Line(
        points={{14,-40.8},{36,-40.8},{36,-0.8},{58,-0.8}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out[2], office_new.Air_in[2]) annotation (Line(
        points={{14,-40.4},{36,-40.4},{36,-0.4},{58,-0.4}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out[3], office_new.Air_in[3]) annotation (Line(
        points={{14,-40},{36,-40},{36,0},{58,0}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out[4], office_new.Air_in[4]) annotation (Line(
        points={{14,-39.6},{36,-39.6},{36,0.4},{58,0.4}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out[5], office_new.Air_in[5]) annotation (Line(
        points={{14,-39.2},{36,-39.2},{36,0.8},{58,0.8}}, color={0,127,255}));
  connect(Control, supplyAir_RLT.controlBus) annotation (Line(
      points={{-100,-28},{-74,-28},{-74,80},{46,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Measure, supplyAir_RLT.measureBus) annotation (Line(
      points={{-100,20},{-74,20},{-74,80},{52,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weather_new.weaBus, pVSystemTMY3_1.weaBus) annotation (Line(
      points={{74,89.8},{74,76},{-48,76},{-48,90},{-40,90}},
      color={255,204,51},
      thickness=0.5));
  connect(pVSystemTMY3_1.PVPowerW, Measure.PV_Power) annotation (Line(points={{-19,
          90},{-14,90},{-14,78},{-74,78},{-74,20.1},{-99.9,20.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(office_new.bus_measure, Measure) annotation (Line(
      points={{60.8,17.8},{-16.6,17.8},{-16.6,20},{-100,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weather_new.therm_roof, office_new.port_roof1) annotation (Line(
        points={{90.6,99.6},{90.6,20},{47.2,20}}, color={191,0,0}));
  connect(weather_new.therm_roof, office_new.port_roof2) annotation (Line(
        points={{90.6,99.6},{90.6,20},{49.6,20}}, color={191,0,0}));
 connect(weather_new.therm_roof, office_new.port_roof3) annotation (Line(
        points={{90.6,99.6},{90.6,20},{52,20}},   color={191,0,0}));
  connect(weather_new.therm_roof, office_new.port_roof4) annotation (Line(
        points={{90.6,99.6},{90.6,20},{54.4,20}}, color={191,0,0}));
   connect(weather_new.therm_roof, office_new.port_roof5) annotation (Line(
        points={{90.6,99.6},{90.6,20},{56.8,20}}, color={191,0,0}));

  connect(full_Transfer_TBA_Heatexchanger.HeatPort_TBA[1], office_new.port_roof1)
    annotation (Line(points={{74,-40.8},{74,20},{47.2,20}}, color={191,0,0}));
     connect(full_Transfer_TBA_Heatexchanger.HeatPort_TBA[2], office_new.port_roof2)
    annotation (Line(points={{74,-40.4},{74,20},{49.6,20}}, color={191,0,0}));
    connect(full_Transfer_TBA_Heatexchanger.HeatPort_TBA[3], office_new.port_roof3)
    annotation (Line(points={{74,-40},{74,20},{52,20}},     color={191,0,0}));
    connect(full_Transfer_TBA_Heatexchanger.HeatPort_TBA[4], office_new.port_roof4)
    annotation (Line(points={{74,-39.6},{74,20},{54.4,20}}, color={191,0,0}));
    connect(full_Transfer_TBA_Heatexchanger.HeatPort_TBA[5], office_new.port_roof5)
    annotation (Line(points={{74,-39.2},{74,20},{56.8,20}}, color={191,0,0}));

  connect(Control, evaluation_CCCS.bus_Control1) annotation (Line(
      points={{-100,-28},{-44,-28},{-44,-15},{-40,-15}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Measure, evaluation_CCCS.bus_measure) annotation (Line(
      points={{-100,20},{-40.3,20},{-40.3,-12.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(internalLoads_new.PerCon[1], office_new.port_IntConvGains[1])
    annotation (Line(points={{-18.2,39.6},{-18.2,40},{68,40},{68,5.2},{62,5.2}},
        color={191,0,0}));
  connect(internalLoads_new.PerCon[2], office_new.port_IntConvGains[2])
    annotation (Line(points={{-18.2,40},{68,40},{68,5.6},{62,5.6}}, color={191,
          0,0}));
  connect(internalLoads_new.PerCon[3], office_new.port_IntConvGains[3])
    annotation (Line(points={{-18.2,40.4},{68,40.4},{68,6},{62,6}}, color={191,
          0,0}));
  connect(internalLoads_new.PerCon[4], office_new.port_IntConvGains[4])
    annotation (Line(points={{-18.2,40.8},{68,40.8},{68,6.4},{62,6.4}}, color={
          191,0,0}));
  connect(internalLoads_new.PerCon[5], office_new.port_IntConvGains[5])
    annotation (Line(points={{-18.2,41.2},{68,41.2},{68,6.8},{62,6.8}}, color={
          191,0,0}));
  connect(internalLoads_new.PerRad[1], office_new.port_IntRadGains[1])
    annotation (Line(points={{-18.2,35.4},{-18.2,36},{66,36},{66,13.2},{62,13.2}},
        color={191,0,0}));
  connect(internalLoads_new.PerRad[2], office_new.port_IntRadGains[2])
    annotation (Line(points={{-18.2,35.8},{66,35.8},{66,13.6},{62,13.6}}, color=
         {191,0,0}));
  connect(internalLoads_new.PerRad[3], office_new.port_IntRadGains[3])
    annotation (Line(points={{-18.2,36.2},{66,36.2},{66,14},{62,14}}, color={
          191,0,0}));
  connect(internalLoads_new.PerRad[4], office_new.port_IntRadGains[4])
    annotation (Line(points={{-18.2,36.6},{66,36.6},{66,14.4},{62,14.4}}, color=
         {191,0,0}));
  connect(internalLoads_new.PerRad[5], office_new.port_IntRadGains[5])
    annotation (Line(points={{-18.2,37},{66,37},{66,14.8},{62,14.8}}, color={
          191,0,0}));
  connect(internalLoads_new.MacCon[1], office_new.port_IntConvGains[1])
    annotation (Line(points={{-18,32},{-14,32},{-14,32},{68,32},{68,5.2},{62,
          5.2}}, color={191,0,0}));
  connect(internalLoads_new.MacCon[2], office_new.port_IntConvGains[2])
    annotation (Line(points={{-18,32.4},{-16,32.4},{-16,32},{68,32},{68,5.6},{
          62,5.6}}, color={191,0,0}));
  connect(internalLoads_new.MacCon[3], office_new.port_IntConvGains[3])
    annotation (Line(points={{-18,32.8},{-16,32.8},{-16,32},{68,32},{68,6},{62,
          6}}, color={191,0,0}));
  connect(internalLoads_new.MacCon[4], office_new.port_IntConvGains[4])
    annotation (Line(points={{-18,33.2},{-18,32},{68,32},{68,6.4},{62,6.4}},
        color={191,0,0}));
  connect(internalLoads_new.MacCon[5], office_new.port_IntConvGains[5])
    annotation (Line(points={{-18,33.6},{-16,33.6},{-16,32},{68,32},{68,6.8},{
          62,6.8}}, color={191,0,0}));
  connect(Measure, internalLoads_new.measureBus) annotation (Line(
      points={{-100,20},{-12,20},{-12,28},{-18.4,28},{-18.4,29}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
         annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FullModel_new;
