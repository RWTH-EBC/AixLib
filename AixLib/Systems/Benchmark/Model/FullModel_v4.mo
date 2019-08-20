within AixLib.Systems.Benchmark.Model;
model FullModel_v4
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  AixLib.Systems.Benchmark.Model.Weather weather
    annotation (Placement(transformation(extent={{50,82},{70,102}})));
  Building.Office_v2 office
    annotation (Placement(transformation(extent={{30,0},{92,60}})));
  Transfer.Transfer_RLT.Full_Transfer_RLT_v2 full_Transfer_RLT
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  AixLib.Systems.Benchmark.Model.InternalLoad.InternalLoads internalLoads
    annotation (Placement(transformation(extent={{-48,50},{-8,10}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Systems.Benchmark.Model.Evaluation.Evaluation evaluation
    annotation (Placement(transformation(extent={{-40,-16},{-20,4}})));
  AixLib.Fluid.Sensors.Temperature
                            senTem2(redeclare package Medium = Medium_Air)
    annotation (Placement(transformation(extent={{-34,52},{-22,64}})));
  AixLib.Fluid.Sensors.Temperature
                            senTem1(redeclare package Medium = Medium_Air)
    annotation (Placement(transformation(extent={{62,64},{74,76}})));
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
  AixLib.Systems.Benchmark.Model.BusSystems.LogModel logModel
    annotation (Placement(transformation(extent={{100,-26},{120,-46}})));
  AixLib.Systems.Benchmark.Model.BusSystems.Bus_measure Measure
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  AixLib.Systems.Benchmark.Model.BusSystems.Bus_Control Control
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
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
 AixLib.Utilities.HeatTransfer.HeatConvOutside heatTransfer_Outside(
    surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
    A=169.594)                                                                                                                                                                              annotation(Placement(transformation(extent={{17,92},
            {6,104}})));
  Modelica.Blocks.Math.Gain gain(k=2)
    annotation (Placement(transformation(extent={{36,92},{28,100}})));
  Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=5,
    nPorts=3)
           annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={1,67})));
  Fluid.MixingVolumes.MixingVolume vol1(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=5)   annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={21,67})));
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
equation
  connect(weather.measureBus,Measure)  annotation (Line(
      points={{60,82},{60,80},{-74,80},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(office.measureBus,Measure)  annotation (Line(
      points={{30,30},{0,30},{0,80},{-74,80},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.measureBus,Measure)  annotation (Line(
      points={{20.2,-53},{28,-53},{28,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(internalLoads.AddPower,office. AddPower)
    annotation (Line(points={{-9.2,18},{30,18}}, color={191,0,0}));
  connect(internalLoads.internalBus,office. internalBus) annotation (Line(
      points={{-9.6,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.internalBus,office. internalBus) annotation (Line(
      points={{66,81.8},{66,81.8},{66,80},{0,80},{0,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.controlBus,Control)  annotation (Line(
      points={{54,82},{54,74},{-66,74},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.controlBus,Control)  annotation (Line(
      points={{20.2,-47.2},{24,-47.2},{24,-32},{-66,-32},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(internalLoads.measureBus,office. measureBus) annotation (Line(
      points={{-9.6,30},{0,30},{0,30},{30,30}},
      color={255,204,51},
      thickness=0.5));
  connect(evaluation.measureBus,Measure)  annotation (Line(
      points={{-40,-6},{-74,-6},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.SolarRadiation_North5,office. SolarRadiationPort_North)
    annotation (Line(points={{71,99},{110,99},{110,54},{88.9,54}}, color={255,
          128,0}));
  connect(weather.SolarRadiation_East,office. SolarRadiationPort_East)
    annotation (Line(points={{71,95},{114,95},{114,42},{88.9,42}}, color={255,
          128,0}));
  connect(weather.SolarRadiation_South,office. SolarRadiationPort_South1)
    annotation (Line(points={{71,91},{118,91},{118,30},{88.9,30}}, color={255,
          128,0}));
  connect(weather.SolarRadiation_West,office. SolarRadiationPort_West1)
    annotation (Line(points={{71,87},{122,87},{122,88},{122,88},{122,18},{88.9,
          18},{88.9,18}}, color={255,128,0}));
  connect(weather.SolarRadiation_Hor,office. SolarRadiationPort_Hor1)
    annotation (Line(points={{71,83},{126,83},{126,6},{88.9,6}}, color={255,128,
          0}));
  connect(senTem1.port,office. Air_out) annotation (Line(points={{68,64},{68,62},
          {26,62},{26,46},{16,46},{16,-16},{36,-16},{36,-8},{36.2,-8},{36.2,0}},
        color={0,127,255}));
  connect(senTem1.T,Measure. Air_out) annotation (Line(points={{72.2,70},{76,70},
          {76,80},{-74,80},{-74,20.1},{-99.9,20.1}}, color={0,0,127}));
  connect(senTem2.T,Measure. Air_in) annotation (Line(points={{-23.8,58},{-20,
          58},{-20,80},{-74,80},{-74,20.1},{-99.9,20.1}},
                                                    color={0,0,127}));
  connect(full_Transfer_TBA_Heatexchanger.HeatPort_TBA,office. Heatport_TBA)
    annotation (Line(points={{74,-40},{74,-20},{79.6,-20},{79.6,0}}, color={191,
          0,0}));
  connect(full_Transfer_TBA_Heatexchanger.controlBus,Control)  annotation (Line(
      points={{80,-46},{84,-46},{84,-32},{-66,-32},{-66,-20},{-100,-20}},
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
      points={{100,-32},{-66,-32},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_v2_1.measureBus, Measure) annotation (Line(
      points={{-74,-40},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_v2_1.controlBus, Control) annotation (Line(
      points={{-66,-40},{-66,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_v2_1.Fluid_in_hot, full_Transfer_RLT.Fluid_out_hot)
    annotation (Line(points={{-60,-46},{0,-46}}, color={0,127,255}));
  connect(generation_v2_1.Fluid_out_cold, full_Transfer_RLT.Fluid_in_cold)
    annotation (Line(points={{-60,-58},{-34,-58},{-34,-54},{0,-54}}, color={0,127,
          255}));
  connect(generation_v2_1.Fluid_in_cold, full_Transfer_RLT.Fluid_out_cold)
    annotation (Line(points={{-60,-54},{-34,-54},{-34,-58},{0,-58}}, color={0,127,
          255}));
  connect(generation_v2_1.Fluid_out_warm, full_Transfer_TBA_Heatexchanger.Fluid_in_warm)
    annotation (Line(points={{-60,-48},{-18,-48},{-18,-66},{36,-66},{36,-47.4},
          {60,-47.4}},color={0,127,255}));
  connect(full_Transfer_TBA_Heatexchanger.Fluid_out_warm, generation_v2_1.Fluid_in_warm)
    annotation (Line(points={{60,-51.4},{36,-51.4},{36,-66},{-18,-66},{-18,-52},
          {-60,-52}}, color={0,127,255}));
  connect(full_Transfer_TBA_Heatexchanger.Fluid_in_cold, generation_v2_1.Fluid_out_cold)
    annotation (Line(points={{60,-54},{36,-54},{36,-66},{-18,-66},{-18,-58},{
          -60,-58}},
                 color={0,127,255}));
  connect(full_Transfer_TBA_Heatexchanger.Fluid_out_cold, generation_v2_1.Fluid_in_cold)
    annotation (Line(points={{60,-58},{36,-58},{36,-66},{-18,-66},{-18,-54},{
          -60,-54}},
                 color={0,127,255}));
  connect(vol1.ports[1], office.Air_out) annotation (Line(points={{16,68},{16,
          -16},{36,-16},{36,-8},{36.2,-8},{36.2,0}}, color={0,127,255}));
  connect(vol1.ports[2], weather.Air_in)
    annotation (Line(points={{16,66},{16,86},{50,86}}, color={0,127,255}));
  connect(vol2.ports[1], weather.Air_out)
    annotation (Line(points={{6,68.3333},{6,90},{50,90}}, color={0,127,255}));
  connect(heatTransfer_Outside.WindSpeedPort, gain.y) annotation (Line(points={
          {16.56,93.68},{25.28,93.68},{25.28,96},{27.6,96}}, color={0,0,127}));
  connect(gain.u, weather.RLT_Velocity) annotation (Line(points={{36.8,96},{42,
          96},{42,100},{49,100}}, color={0,0,127}));
  connect(heatTransfer_Outside.port_b, vol2.heatPort)
    annotation (Line(points={{6,98},{1,98},{1,72}}, color={191,0,0}));
  connect(heatTransfer_Outside.port_a, vol1.heatPort)
    annotation (Line(points={{17,98},{21,98},{21,72}}, color={191,0,0}));
  connect(vol2.ports[2], full_Transfer_RLT.Air_in)
    annotation (Line(points={{6,67},{6,-40}}, color={0,127,255}));
  connect(senTem2.port, vol2.ports[3])
    annotation (Line(points={{-28,52},{6,52},{6,65.6667}}, color={0,127,255}));
  connect(full_Transfer_RLT.Air_out, office.Air_in) annotation (Line(points={{
          14,-40},{14,-20},{48.6,-20},{48.6,0}}, color={0,127,255}));
  connect(full_Transfer_RLT.Fluid_in_hot, generation_v2_1.Fluid_out_hot)
    annotation (Line(points={{0,-42},{-60,-42}}, color={0,127,255}));
  connect(infiltration.Air_out, office.Air_in) annotation (Line(points={{20,-80},
          {48.6,-80},{48.6,0}}, color={0,127,255}));
  connect(infiltration.measureBus, Measure) annotation (Line(
      points={{0,-80},{-8,-80},{-8,-36},{-74,-36},{-74,20},{-100,20}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FullModel_v4;
