within AixLib.Building.Benchmark.Transfer.Transfer_RLT;
model Full_Transfer_RLT
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

  RLT Workshop(
    RLT_v_nominal=4,
    RLT_m_flow_nominal=0.65,
    RLT_pipe_length=25,
    RLT_pipe_wall_thickness=0.003,
    RLT_pipe_insulation_thickness=0,
    RLT_pipe_insulation_conductivity=1,
    pipe_length_hot=15,
    pipe_length_cold=15,
    v_nominal_hot=1.609,
    m_flow_nominal_hot=0.194,
    pipe_wall_thickness_hot=0.0023,
    pipe_insulation_thickness_hot=0.02,
    pipe_insulation_conductivity_hot=0.05,
    V_mixing_hot=0.0001,
    v_nominal_cold=1.571,
    m_flow_nominal_cold=0.919,
    pipe_wall_thickness_cold=0.0032,
    pipe_insulation_thickness_cold=0.02,
    pipe_insulation_conductivity_cold=0.05,
    V_mixing_cold=0.0001,
    dpValve_nominal_hot=7000,
    dpValve_nominal_cold=10000)
               annotation (Placement(transformation(extent={{44,-66},{64,-86}})));

  Modelica.Fluid.Interfaces.FluidPort_b Air_out[5](redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{82,8},{122,48}})));
  RLT Canteen(
    RLT_v_nominal=4,
    RLT_m_flow_nominal=1.1,
    RLT_pipe_length=15,
    RLT_pipe_wall_thickness=0.003,
    RLT_pipe_insulation_thickness=0,
    RLT_pipe_insulation_conductivity=1,
    pipe_length_hot=10,
    pipe_length_cold=10,
    v_nominal_hot=1.898,
    m_flow_nominal_hot=1.072,
    pipe_wall_thickness_hot=0.0032,
    pipe_insulation_thickness_hot=0.02,
    pipe_insulation_conductivity_hot=0.05,
    V_mixing_hot=0.0001,
    v_nominal_cold=1.328,
    m_flow_nominal_cold=0.777,
    pipe_wall_thickness_cold=0.0032,
    pipe_insulation_thickness_cold=0.02,
    pipe_insulation_conductivity_cold=0.05,
    V_mixing_cold=0.0001,
    dpValve_nominal_hot=7000,
    dpValve_nominal_cold=10000)
              annotation (Placement(transformation(extent={{-10,-66},{10,-86}})));

  RLT MultiPersonOffice(
    RLT_v_nominal=4,
    RLT_m_flow_nominal=0.08,
    RLT_pipe_length=48,
    RLT_pipe_wall_thickness=0.003,
    RLT_pipe_insulation_thickness=0,
    RLT_pipe_insulation_conductivity=1,
    pipe_length_hot=28,
    pipe_length_cold=28,
    pipe_wall_thickness_hot=0.0023,
    pipe_insulation_thickness_hot=0.02,
    pipe_insulation_conductivity_hot=0.05,
    V_mixing_hot=0.0001,
    v_nominal_cold=1.866,
    m_flow_nominal_cold=0.38,
    pipe_wall_thickness_cold=0.0026,
    pipe_insulation_thickness_cold=0.02,
    pipe_insulation_conductivity_cold=0.05,
    V_mixing_cold=0.0001,
    v_nominal_hot=1.26,
    m_flow_nominal_hot=0.152,
    dpValve_nominal_hot=7000,
    dpValve_nominal_cold=10000)
    annotation (Placement(transformation(extent={{-66,-66},{-46,-86}})));

  RLT ConferenceRoom(
    RLT_v_nominal=4,
    RLT_m_flow_nominal=0.333,
    RLT_pipe_length=68,
    RLT_pipe_wall_thickness=0.003,
    RLT_pipe_insulation_thickness=0,
    RLT_pipe_insulation_conductivity=1,
    pipe_length_hot=48,
    pipe_length_cold=48,
    pipe_wall_thickness_hot=0.0023,
    pipe_insulation_thickness_hot=0.02,
    pipe_insulation_conductivity_hot=0.05,
    V_mixing_hot=0.0001,
    pipe_insulation_thickness_cold=0.02,
    pipe_insulation_conductivity_cold=0.05,
    V_mixing_cold=0.0001,
    v_nominal_hot=1.269,
    m_flow_nominal_hot=0.153,
    v_nominal_cold=1.542,
    m_flow_nominal_cold=0.192,
    pipe_wall_thickness_cold=0.0023,
    dpValve_nominal_hot=7000,
    dpValve_nominal_cold=10000)
    annotation (Placement(transformation(extent={{46,72},{66,52}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[5]
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{82,-50},{122,-10}})));
  RLT_Central rLT_Central
    annotation (Placement(transformation(extent={{-64,72},{-44,52}})));
  RLT_OpenPlanOffice rLT_OpenPlanOffice
    annotation (Placement(transformation(extent={{-10,72},{10,52}})));
equation
  connect(ConferenceRoom.Air_out, Air_out[2]) annotation (Line(points={{66,68.6},
          {66,68},{74,68},{74,80},{40,80},{40,96}},
                                    color={0,127,255}));
  connect(MultiPersonOffice.Air_out, Air_out[3]) annotation (Line(points={{-46,
          -69.4},{-46,-70},{-30,-70},{-30,80},{40,80},{40,100}},
                                           color={0,127,255}));
  connect(Canteen.Air_out, Air_out[4]) annotation (Line(points={{10,-69.4},{10,
          -70},{16,-70},{16,-64},{-30,-64},{-30,80},{40,80},{40,104}},
                                 color={0,127,255}));
  connect(Workshop.Air_out, Air_out[5]) annotation (Line(points={{64,-69.4},{64,
          -70},{72,-70},{72,-60},{-30,-60},{-30,80},{40,80},{40,108}},
                                 color={0,127,255}));
  connect(ConferenceRoom.Fluid_out_hot, Fluid_out_hot)
    annotation (Line(points={{48,52},{48,40},{-100,40}}, color={0,127,255}));
  connect(MultiPersonOffice.Fluid_out_hot, Fluid_out_hot) annotation (Line(
        points={{-64,-86},{-64,-90},{-74,-90},{-74,40},{-100,40}}, color={0,127,
          255}));
  connect(Canteen.Fluid_out_hot, Fluid_out_hot) annotation (Line(points={{-8,
          -86},{-8,-90},{-14,-90},{-14,-88},{-14,40},{-100,40}}, color={0,127,
          255}));
  connect(Workshop.Fluid_out_hot, Fluid_out_hot) annotation (Line(points={{46,
          -86},{46,-90},{42,-90},{40,-90},{40,40},{-100,40}}, color={0,127,255}));
  connect(ConferenceRoom.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{60,52},{60,0},{-80,0},{-80,-80},{-100,-80}},   color={0,127,
          255}));
  connect(MultiPersonOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{-52,-86},{-52,-90},{-42,-90},{-42,-90},{-42,0},{-80,0},{-80,
          -80},{-100,-80}},                                   color={0,127,255}));
  connect(Canteen.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{4,-86},
          {4,-90},{16,-90},{16,-90},{16,0},{-80,0},{-80,-80},{-100,-80}},
                                                    color={0,127,255}));
  connect(Workshop.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{58,-86},
          {58,-90},{68,-90},{68,-90},{68,-8},{-80,-8},{-80,-80},{-100,-80}},
                                                    color={0,127,255}));
  connect(ConferenceRoom.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{64,52},{64,-40},{-100,-40}}, color={0,127,255}));
  connect(MultiPersonOffice.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{-48,-86},{-48,-90},{-42,-90},{-40,-90},{-40,-40},
          {-100,-40}},                                     color={0,127,255}));
  connect(Canteen.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{8,-86},{8,-90},{20,-90},{18,-90},{18,-40},{-100,
          -40}},                                           color={0,127,255}));
  connect(Workshop.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{62,-86},{62,-90},{70,-90},{70,-90},{70,-40},{-100,
          -40}},                                           color={0,127,255}));
  connect(ConferenceRoom.heatPort_pumpsAndPipes, heatPort[2]) annotation (Line(
        points={{56,72},{56,80},{0,80},{0,96}},   color={191,0,0}));
  connect(MultiPersonOffice.heatPort_pumpsAndPipes, heatPort[3]) annotation (
      Line(points={{-56,-66},{-56,-46},{-12,-46},{-12,-46},{20,-46},{20,80},{0,
          80},{0,100}},                             color={191,0,0}));
  connect(Canteen.heatPort_pumpsAndPipes, heatPort[4]) annotation (Line(points={{0,-66},
          {0,-46},{20,-46},{20,-46},{20,80},{0,80},{0,104}},
                                            color={191,0,0}));
  connect(Workshop.heatPort_pumpsAndPipes, heatPort[5]) annotation (Line(points={{54,-66},
          {54,-46},{20,-46},{20,80},{0,80},{0,108}},
                                           color={191,0,0}));
  connect(ConferenceRoom.valve_cold, controlBus.Valve_RLT_Cold_ConferenceRoom)
    annotation (Line(points={{66,54},{86,54},{86,28.1},{102.1,28.1}},
        color={0,0,127}));
  connect(ConferenceRoom.valve_hot, controlBus.Valve_RLT_Hot_ConferenceRoom)
    annotation (Line(points={{66,58},{86,58},{86,28.1},{102.1,28.1}},
        color={0,0,127}));
  connect(ConferenceRoom.pump_cold, controlBus.Pump_RLT_ConferenceRoom_cold_y)
    annotation (Line(points={{66,62},{86,62},{86,28.1},{102.1,28.1}},
        color={0,0,127}));
  connect(ConferenceRoom.pump_hot, controlBus.Pump_RLT_ConferenceRoom_hot_y)
    annotation (Line(points={{66,66},{86,66},{86,28.1},{102.1,28.1}},
        color={0,0,127}));
  connect(MultiPersonOffice.valve_cold, controlBus.Valve_RLT_Cold_MultiPersonOffice)
    annotation (Line(points={{-46,-84},{-36,-84},{-36,-90},{86,-90},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(MultiPersonOffice.valve_hot, controlBus.Valve_RLT_Hot_MultiPersonOffice)
    annotation (Line(points={{-46,-80},{-36,-80},{-36,-90},{86,-90},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(MultiPersonOffice.pump_cold, controlBus.Pump_RLT_MultiPersonOffice_cold_y)
    annotation (Line(points={{-46,-76},{-36,-76},{-36,-90},{86,-90},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(MultiPersonOffice.pump_hot, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
    annotation (Line(points={{-46,-72},{-36,-72},{-36,-90},{86,-90},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(Canteen.valve_cold, controlBus.Valve_RLT_Cold_Canteen) annotation (
      Line(points={{10,-84},{28,-84},{28,-90},{86,-90},{86,0},{86,0},{86,28.1},
          {102.1,28.1}},                                                  color=
         {0,0,127}));
  connect(Canteen.valve_hot, controlBus.Valve_RLT_Hot_Canteen) annotation (Line(
        points={{10,-80},{28,-80},{28,-90},{86,-90},{86,28.1},{102.1,28.1}},
                                                                       color={0,
          0,127}));
  connect(Canteen.pump_cold, controlBus.Pump_RLT_Canteen_cold_y) annotation (
      Line(points={{10,-76},{28,-76},{28,-90},{86,-90},{86,28.1},{102.1,28.1}},
                                                                          color=
         {0,0,127}));
  connect(Canteen.pump_hot, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(
        points={{10,-72},{28,-72},{28,-90},{86,-90},{86,28.1},{102.1,28.1}},
                                                                       color={0,
          0,127}));
  connect(Workshop.valve_cold, controlBus.Valve_RLT_Cold_Workshop) annotation (
      Line(points={{64,-84},{86,-84},{86,28.1},{102.1,28.1}},
                                                          color={0,0,127}));
  connect(Workshop.valve_hot, controlBus.Valve_RLT_Hot_Workshop) annotation (
      Line(points={{64,-80},{86,-80},{86,28.1},{102.1,28.1}},
                                                          color={0,0,127}));
  connect(Workshop.pump_cold, controlBus.Pump_RLT_Workshop_cold_y) annotation (
      Line(points={{64,-76},{86,-76},{86,28.1},{102.1,28.1}},
                                                          color={0,0,127}));
  connect(Workshop.pump_hot, controlBus.Pump_RLT_Workshop_hot_y) annotation (
      Line(points={{64,-72},{86,-72},{86,28.1},{102.1,28.1}},
                                                          color={0,0,127}));
  connect(ConferenceRoom.cold_out, measureBus.RLT_conferencerom_cold_out)
    annotation (Line(points={{46,54},{36,54},{36,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(ConferenceRoom.cold_in, measureBus.RLT_conferencerom_cold_in)
    annotation (Line(points={{46,58},{36,58},{36,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(ConferenceRoom.hot_out, measureBus.RLT_conferencerom_hot_out)
    annotation (Line(points={{46,62},{36,62},{36,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(ConferenceRoom.hot_in, measureBus.RLT_conferencerom_hot_in)
    annotation (Line(points={{46,66},{36,66},{36,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(ConferenceRoom.massflow_hot, measureBus.RLT_conferenceroom_warm)
    annotation (Line(points={{48,72},{48,76},{36,76},{36,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(ConferenceRoom.massflow_cold, measureBus.RLT_conferenceroom_cold)
    annotation (Line(points={{64,72},{64,76},{36,76},{36,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(ConferenceRoom.power_pump_cold, measureBus.Pump_RLT_conferenceroom_cold)
    annotation (Line(points={{60,72},{60,76},{36,76},{36,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(ConferenceRoom.power_pump_hot, measureBus.Pump_RLT_conferenceroom_warm)
    annotation (Line(points={{52,72},{52,76},{36,76},{36,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.massflow_cold, measureBus.RLT_multipersonoffice_cold)
    annotation (Line(points={{-48,-66},{-48,-62},{-36,-62},{-36,-90},{86,-90},{
          86,-29.9},{102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.massflow_hot, measureBus.RLT_multipersonoffice_warm)
    annotation (Line(points={{-64,-66},{-64,-62},{-36,-62},{-36,-90},{86,-90},{
          86,-29.9},{102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.power_pump_cold, measureBus.Pump_RLT_multipersonoffice_cold)
    annotation (Line(points={{-52,-66},{-52,-62},{-36,-62},{-36,-90},{86,-90},{
          86,-29.9},{102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.power_pump_hot, measureBus.Pump_RLT_multipersonoffice_warm)
    annotation (Line(points={{-60,-66},{-60,-62},{-36,-62},{-36,-90},{86,-90},{
          86,-29.9},{102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.hot_in, measureBus.RLT_multipersonoffice_hot_in)
    annotation (Line(points={{-66,-72},{-70,-72},{-70,-90},{86,-90},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.cold_out, measureBus.RLT_multipersonoffice_cold_out)
    annotation (Line(points={{-66,-84},{-70,-84},{-70,-90},{86,-90},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.cold_in, measureBus.RLT_multipersonoffice_cold_in)
    annotation (Line(points={{-66,-80},{-70,-80},{-70,-90},{86,-90},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(MultiPersonOffice.hot_out, measureBus.RLT_multipersonoffice_hot_out)
    annotation (Line(points={{-66,-76},{-70,-76},{-70,-90},{86,-90},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(Canteen.cold_out, measureBus.RLT_canteen_cold_out) annotation (Line(
        points={{-10,-84},{-16,-84},{-16,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Canteen.cold_in, measureBus.RLT_canteen_cold_in) annotation (Line(
        points={{-10,-80},{-16,-80},{-16,-82},{-16,-82},{-16,-90},{86,-90},{86,
          -29.9},{102.1,-29.9}}, color={0,0,127}));
  connect(Canteen.hot_out, measureBus.RLT_canteen_hot_out) annotation (Line(
        points={{-10,-76},{-16,-76},{-16,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Canteen.hot_in, measureBus.RLT_canteen_hot_in) annotation (Line(
        points={{-10,-72},{-16,-72},{-16,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Workshop.cold_out, measureBus.RLT_workshop_cold_out) annotation (Line(
        points={{44,-84},{36,-84},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Workshop.cold_in, measureBus.RLT_workshop_cold_in) annotation (Line(
        points={{44,-80},{36,-80},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Workshop.hot_out, measureBus.RLT_workshop_hot_out) annotation (Line(
        points={{44,-76},{36,-76},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Workshop.hot_in, measureBus.RLT_workshop_hot_in) annotation (Line(
        points={{44,-72},{36,-72},{36,-90},{86,-90},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Canteen.massflow_cold, measureBus.RLT_canteen_cold) annotation (Line(
        points={{8,-66},{8,-58},{28,-58},{28,-90},{86,-90},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(Canteen.massflow_hot, measureBus.RLT_canteen_warm) annotation (Line(
        points={{-8,-66},{-8,-58},{28,-58},{28,-90},{86,-90},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(Workshop.massflow_cold, measureBus.RLT_workshop_cold) annotation (
      Line(points={{62,-66},{62,-56},{86,-56},{86,-29.9},{102.1,-29.9}}, color=
          {0,0,127}));
  connect(Workshop.massflow_hot, measureBus.RLT_workshop_warm) annotation (Line(
        points={{46,-66},{46,-56},{86,-56},{86,-29.9},{102.1,-29.9}}, color={0,
          0,127}));
  connect(Workshop.power_pump_cold, measureBus.Pump_RLT_workshop_cold)
    annotation (Line(points={{58,-66},{58,-56},{86,-56},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Workshop.power_pump_hot, measureBus.Pump_RLT_workshop_warm)
    annotation (Line(points={{50,-66},{50,-56},{86,-56},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Canteen.power_pump_cold, measureBus.Pump_RLT_canteen_cold)
    annotation (Line(points={{4,-66},{4,-58},{28,-58},{28,-90},{86,-90},{86,
          -29.9},{102.1,-29.9}}, color={0,0,127}));
  connect(Canteen.power_pump_hot, measureBus.Pump_RLT_canteen_warm) annotation (
     Line(points={{-4,-66},{-4,-58},{28,-58},{28,-90},{86,-90},{86,-29.9},{
          102.1,-29.9}}, color={0,0,127}));
  connect(rLT_Central.Air_in, Air_in) annotation (Line(points={{-64,68.6},{-72,68.6},
          {-72,68},{-72,68},{-72,80},{-40,80},{-40,100}}, color={0,127,255}));
  connect(rLT_Central.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{-58,
          52},{-58,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
  connect(rLT_Central.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{
          -50,52},{-50,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  connect(rLT_Central.Fluid_in_cold, Fluid_in_cold) annotation (Line(points={{-46,
          52},{-46,-40},{-100,-40}}, color={0,127,255}));
  connect(rLT_Central.heatPort_pumpsAndPipes, heatPort[4]) annotation (Line(
        points={{-54,72},{-54,80},{0,80},{0,104}}, color={191,0,0}));
  connect(rLT_Central.X_w, controlBus.X_Central) annotation (Line(points={{-54,52},
          {-54,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(rLT_Central.valve_cold, controlBus.Valve_RLT_Cold_Central)
    annotation (Line(points={{-44,54},{-36,54},{-36,28.1},{102.1,28.1}}, color={
          0,0,127}));
  connect(rLT_Central.valve_hot, controlBus.Valve_RLT_Hot_Central) annotation (
      Line(points={{-44,58},{-36,58},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(rLT_Central.pump_cold, controlBus.Pump_RLT_Central_cold_y)
    annotation (Line(points={{-44,62},{-36,62},{-36,28.1},{102.1,28.1}}, color={
          0,0,127}));
  connect(rLT_Central.pump_hot, controlBus.Pump_RLT_Central_hot_y) annotation (
      Line(points={{-44,66},{-36,66},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(ConferenceRoom.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{52,
          52},{52,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
  connect(MultiPersonOffice.Fluid_in_hot, Fluid_in_hot) annotation (Line(points=
         {{-60,-86},{-60,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
  connect(Canteen.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{-4,-86},
          {-4,-86},{-4,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
  connect(Workshop.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{50,-86},
          {50,-86},{50,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
  connect(rLT_Central.cold_out, measureBus.RLT_central_cold_out) annotation (
      Line(points={{-64,54},{-68,54},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(rLT_Central.cold_in, measureBus.RLT_central_cold_in) annotation (Line(
        points={{-64,58},{-68,58},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(rLT_Central.hot_out, measureBus.RLT_central_hot_out) annotation (Line(
        points={{-64,62},{-68,62},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(rLT_Central.hot_in, measureBus.RLT_central_hot_in) annotation (Line(
        points={{-64,66},{-68,66},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(rLT_Central.massflow_hot, measureBus.RLT_central_warm) annotation (
      Line(points={{-62,72},{-62,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(rLT_Central.power_pump_hot, measureBus.Pump_RLT_central_warm)
    annotation (Line(points={{-58,72},{-58,76},{-68,76},{-68,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(rLT_Central.massflow_cold, measureBus.RLT_central_cold) annotation (
      Line(points={{-46,72},{-46,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(rLT_Central.power_pump_cold, measureBus.Pump_RLT_central_cold)
    annotation (Line(points={{-50,72},{-50,76},{-68,76},{-68,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.heatPort_pumpsAndPipes, heatPort[1])
    annotation (Line(points={{0,72},{0,92}}, color={191,0,0}));
  connect(rLT_Central.Air_out, rLT_OpenPlanOffice.Air_in) annotation (Line(
        points={{-44,68.6},{-27,68.6},{-27,68.6},{-10,68.6}}, color={0,127,255}));
  connect(ConferenceRoom.Air_in, rLT_OpenPlanOffice.Air_in) annotation (Line(
        points={{46,68.6},{20,68.6},{20,70},{20,70},{20,80},{-24,80},{-24,68.6},
          {-10,68.6}}, color={0,127,255}));
  connect(MultiPersonOffice.Air_in, rLT_OpenPlanOffice.Air_in) annotation (Line(
        points={{-66,-69.4},{-74,-69.4},{-74,12},{-24,12},{-24,68},{-24,68.6},{-10,
          68.6}}, color={0,127,255}));
  connect(Canteen.Air_in, rLT_OpenPlanOffice.Air_in) annotation (Line(points={{-10,
          -69.4},{-24,-69.4},{-24,-70},{-24,-70},{-24,68.6},{-10,68.6}}, color={
          0,127,255}));
  connect(Workshop.Air_in, rLT_OpenPlanOffice.Air_in) annotation (Line(points={{
          44,-69.4},{36,-69.4},{36,-70},{36,-70},{36,12},{-24,12},{-24,68.6},{-10,
          68.6}}, color={0,127,255}));
  connect(rLT_Central.Fluid_out_hot, Fluid_out_hot)
    annotation (Line(points={{-62,52},{-62,40},{-100,40}}, color={0,127,255}));
  connect(rLT_OpenPlanOffice.Fluid_out_hot, Fluid_out_hot)
    annotation (Line(points={{-8,52},{-8,40},{-100,40}}, color={0,127,255}));
  connect(rLT_OpenPlanOffice.Fluid_in_hot, Fluid_in_hot) annotation (Line(
        points={{-4,52},{-4,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
  connect(rLT_OpenPlanOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{4,52},{4,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  connect(rLT_OpenPlanOffice.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{8,52},{8,-40},{-100,-40}}, color={0,127,255}));
  connect(rLT_OpenPlanOffice.valve_cold, controlBus.Valve_RLT_Cold_OpenPlanOffice)
    annotation (Line(points={{10,54},{18,54},{18,28.1},{102.1,28.1}}, color={0,0,
          127}));
  connect(rLT_OpenPlanOffice.valve_hot, controlBus.Valve_RLT_Hot_OpenPlanOffice)
    annotation (Line(points={{10,58},{18,58},{18,28.1},{102.1,28.1}}, color={0,0,
          127}));
  connect(rLT_OpenPlanOffice.pump_cold, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
    annotation (Line(points={{10,62},{18,62},{18,28.1},{102.1,28.1}}, color={0,0,
          127}));
  connect(rLT_OpenPlanOffice.pump_hot, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
    annotation (Line(points={{10,66},{18,66},{18,28.1},{102.1,28.1}}, color={0,0,
          127}));
  connect(rLT_OpenPlanOffice.cold_out, measureBus.RLT_openplanoffice_cold_out)
    annotation (Line(points={{-10,54},{-18,54},{-18,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.cold_in, measureBus.RLT_openplanoffice_cold_in)
    annotation (Line(points={{-10,58},{-18,58},{-18,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.hot_out, measureBus.RLT_openplanoffice_hot_out)
    annotation (Line(points={{-10,62},{-18,62},{-18,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.hot_in, measureBus.RLT_openplanoffice_hot_in)
    annotation (Line(points={{-10,66},{-18,66},{-18,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.massflow_hot, measureBus.RLT_openplanoffice_warm)
    annotation (Line(points={{-8,72},{-8,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.massflow_cold, measureBus.RLT_openplanoffice_cold)
    annotation (Line(points={{8,72},{8,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.power_pump_hot, measureBus.Pump_RLT_openplanoffice_warm)
    annotation (Line(points={{-4,72},{-4,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(rLT_OpenPlanOffice.power_pump_cold, measureBus.Pump_RLT_openplanoffice_cold)
    annotation (Line(points={{4,72},{4,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_RLT;
