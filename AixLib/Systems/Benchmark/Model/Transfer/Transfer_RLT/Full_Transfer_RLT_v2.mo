within AixLib.Systems.Benchmark.Model.Transfer.Transfer_RLT;
model Full_Transfer_RLT_v2
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

  RLT_v2 Workshop(
    RLT_m_flow_nominal=0.65,
    m_flow_nominal_hot=0.194,
    pipe_length=15,
    V_mixing=0.0001,
    pipe_height=0,
    pipe_length_air=25,
    pipe_diameter_hot=0.0126,
    pipe_diameter_air=0.415,
    RLT_tau=6.25,
    V_air=0.55,
    Area_pipe_air=1950/(4*3600),
    Area_Heatexchanger_AirWater_Hot=4.75,
    Area_Heatexchanger_AirWater_Cold=414.86,
    RLT_dp_Heatexchanger(displayUnit="Pa") = 38,
    dpValve_nominal_hot=7000,
    pipe_diameter_cold=0.0273,
    m_flow_nominal_cold=1.085,
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
  BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{82,8},{122,48}})));
  RLT_v2 Canteen(
    RLT_m_flow_nominal=1.1,
    m_flow_nominal_hot=1.072,
    pipe_length=10,
    V_mixing=0.0001,
    pipe_height=0,
    pipe_length_air=10,
    pipe_diameter_hot=0.0273,
    pipe_diameter_air=0.54,
    RLT_tau=3.75,
    V_air=0.92,
    Area_pipe_air=3300/(4*3600),
    Area_Heatexchanger_AirWater_Hot=26.31,
    pipe_diameter_cold=0.0419,
    Area_Heatexchanger_AirWater_Cold=577.82,
    RLT_dp_Heatexchanger(displayUnit="Pa") = 39,
    dpValve_nominal_hot=7000,
    m_flow_nominal_cold=1.729,
    dpValve_nominal_cold=10000)
    annotation (Placement(transformation(extent={{-10,-66},{10,-86}})));

  RLT_v2 MultiPersonOffice(
    RLT_m_flow_nominal=0.08,
    m_flow_nominal_hot=0.152,
    V_mixing=0.0001,
    pipe_diameter_hot=0.0126,
    pipe_diameter_air=0.146,
    V_air=0.07,
    Area_pipe_air=240/(4*3600),
    Area_Heatexchanger_AirWater_Hot=3.72,
    pipe_length=70,
    pipe_height=0,
    pipe_length_air=55,
    RLT_tau=13.75,
    RLT_dp_Heatexchanger(displayUnit="Pa") = 39.5,
    pipe_diameter_cold=0.0161,
    m_flow_nominal_cold=0.340,
    Area_Heatexchanger_AirWater_Cold=100.14,
    dpValve_nominal_hot=7000,
    dpValve_nominal_cold=10000)
    annotation (Placement(transformation(extent={{-66,-66},{-46,-86}})));

  RLT_v2 ConferenceRoom(
    RLT_m_flow_nominal=0.333,
    m_flow_nominal_hot=0.153,
    V_mixing=0.0001,
    pipe_diameter_hot=0.0126,
    pipe_diameter_air=0.297,
    V_air=0.28,
    Area_pipe_air=1000/(4*3600),
    Area_Heatexchanger_AirWater_Hot=3.75,
    pipe_length=45,
    pipe_height=0,
    pipe_length_air=30,
    RLT_tau=7.5,
    RLT_dp_Heatexchanger(displayUnit="Pa") = 37.5,
    pipe_diameter_cold=0.0126,
    m_flow_nominal_cold=0.161,
    Area_Heatexchanger_AirWater_Cold=47.42,
    dpValve_nominal_hot=7000,
    dpValve_nominal_cold=10000)
    annotation (Placement(transformation(extent={{46,72},{66,52}})));

  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{82,-50},{122,-10}})));
  RLT_Central_v2 Central(
    pipe_length=20,
    V_mixing=0.0001,
    pipe_height=0,
    Area_pipe_air=10090/(4*3600),
    Area_Heatexchanger_AirWater_Hot=89.51,
    pipe_diameter_hot=0.0419,
    Area_Heatexchanger_AirWater_Cold=819.41,
    m_flow_nominal_hot=3.649,
    dpValve_nominal_hot=7000,
    pipe_diameter_cold=0.0419,
    m_flow_nominal_cold=1.639,
    dpValve_nominal_cold=10000)
    annotation (Placement(transformation(extent={{-64,72},{-44,52}})));
  RLT_OpenPlanOffice_v2 OpenPlanOffice(
    m_flow_nominal_hot=2.078,
    RLT_m_flow_nominal=1.204,
    V_mixing=0.0001,
    pipe_diameter_hot=0.0419,
    pipe_diameter_air=0.564,
    Area_pipe_air=3600/(4*3600),
    Area_Heatexchanger_AirWater_Hot=50.98,
    pipe_length=35,
    pipe_height=0,
    pipe_length_air=15,
    Area_Heatexchanger_AirWater_Cold=431.91,
    RLT_tau=3.75,
    RLT_dp_Heatexchanger(displayUnit="Pa") = 38.5,
    pipe_diameter_cold=0.0273,
    m_flow_nominal_cold=1.151,
    dpValve_nominal_hot=7000,
    dpValve_nominal_cold=10000)
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
  connect(Central.Air_in, Air_in) annotation (Line(points={{-64,68.6},{-72,68.6},
          {-72,68},{-72,68},{-72,80},{-40,80},{-40,100}}, color={0,127,255}));
  connect(Central.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{-58,52},
          {-58,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
  connect(Central.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{-50,
          52},{-50,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  connect(Central.Fluid_in_cold, Fluid_in_cold) annotation (Line(points={{-46,
          52},{-46,-40},{-100,-40}}, color={0,127,255}));
  connect(Central.X_w, controlBus.X_Central) annotation (Line(points={{-54,52},
          {-54,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(Central.valve_cold, controlBus.Valve_RLT_Cold_Central) annotation (
      Line(points={{-44,54},{-36,54},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(Central.valve_hot, controlBus.Valve_RLT_Hot_Central) annotation (Line(
        points={{-44,58},{-36,58},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(Central.pump_cold, controlBus.Pump_RLT_Central_cold_y) annotation (
      Line(points={{-44,62},{-36,62},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(Central.pump_hot, controlBus.Pump_RLT_Central_hot_y) annotation (Line(
        points={{-44,66},{-36,66},{-36,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(ConferenceRoom.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{52,
          52},{52,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
  connect(MultiPersonOffice.Fluid_in_hot, Fluid_in_hot) annotation (Line(points=
         {{-60,-86},{-60,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
  connect(Canteen.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{-4,-86},
          {-4,-86},{-4,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
  connect(Workshop.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{50,-86},
          {50,-86},{50,-90},{-74,-90},{-74,80},{-100,80}}, color={0,127,255}));
  connect(Central.cold_out, measureBus.RLT_central_cold_out) annotation (Line(
        points={{-64,54},{-68,54},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Central.cold_in, measureBus.RLT_central_cold_in) annotation (Line(
        points={{-64,58},{-68,58},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Central.hot_out, measureBus.RLT_central_hot_out) annotation (Line(
        points={{-64,62},{-68,62},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Central.hot_in, measureBus.RLT_central_hot_in) annotation (Line(
        points={{-64,66},{-68,66},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Central.massflow_hot, measureBus.RLT_central_warm) annotation (Line(
        points={{-62,72},{-62,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Central.power_pump_hot, measureBus.Pump_RLT_central_warm) annotation (
     Line(points={{-58,72},{-58,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,
          -29.9}}, color={0,0,127}));
  connect(Central.massflow_cold, measureBus.RLT_central_cold) annotation (Line(
        points={{-46,72},{-46,76},{-68,76},{-68,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  connect(Central.power_pump_cold, measureBus.Pump_RLT_central_cold)
    annotation (Line(points={{-50,72},{-50,76},{-68,76},{-68,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(Central.Fluid_out_hot, Fluid_out_hot)
    annotation (Line(points={{-62,52},{-62,40},{-100,40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_hot, Fluid_out_hot)
    annotation (Line(points={{-8,52},{-8,40},{-100,40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_hot, Fluid_in_hot) annotation (Line(points={{
          -4,52},{-4,46},{-74,46},{-74,80},{-100,80}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{4,52},{4,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{8,52},{8,-40},{-100,-40}}, color={0,127,255}));
  connect(OpenPlanOffice.valve_cold, controlBus.Valve_RLT_Cold_OpenPlanOffice)
    annotation (Line(points={{10,54},{18,54},{18,28.1},{102.1,28.1}}, color={0,
          0,127}));
  connect(OpenPlanOffice.valve_hot, controlBus.Valve_RLT_Hot_OpenPlanOffice)
    annotation (Line(points={{10,58},{18,58},{18,28.1},{102.1,28.1}}, color={0,
          0,127}));
  connect(OpenPlanOffice.pump_cold, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
    annotation (Line(points={{10,62},{18,62},{18,28.1},{102.1,28.1}}, color={0,
          0,127}));
  connect(OpenPlanOffice.pump_hot, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
    annotation (Line(points={{10,66},{18,66},{18,28.1},{102.1,28.1}}, color={0,
          0,127}));
  connect(OpenPlanOffice.cold_out, measureBus.RLT_openplanoffice_cold_out)
    annotation (Line(points={{-10,54},{-18,54},{-18,28},{86,28},{86,-29.9},{
          102.1,-29.9}}, color={0,0,127}));
  connect(OpenPlanOffice.cold_in, measureBus.RLT_openplanoffice_cold_in)
    annotation (Line(points={{-10,58},{-18,58},{-18,28},{86,28},{86,-29.9},{
          102.1,-29.9}}, color={0,0,127}));
  connect(OpenPlanOffice.hot_out, measureBus.RLT_openplanoffice_hot_out)
    annotation (Line(points={{-10,62},{-18,62},{-18,28},{86,28},{86,-29.9},{
          102.1,-29.9}}, color={0,0,127}));
  connect(OpenPlanOffice.hot_in, measureBus.RLT_openplanoffice_hot_in)
    annotation (Line(points={{-10,66},{-18,66},{-18,28},{86,28},{86,-29.9},{
          102.1,-29.9}}, color={0,0,127}));
  connect(OpenPlanOffice.massflow_hot, measureBus.RLT_openplanoffice_warm)
    annotation (Line(points={{-8,72},{-8,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(OpenPlanOffice.massflow_cold, measureBus.RLT_openplanoffice_cold)
    annotation (Line(points={{8,72},{8,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(OpenPlanOffice.power_pump_hot, measureBus.Pump_RLT_openplanoffice_warm)
    annotation (Line(points={{-4,72},{-4,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(OpenPlanOffice.power_pump_cold, measureBus.Pump_RLT_openplanoffice_cold)
    annotation (Line(points={{4,72},{4,76},{-18,76},{-18,28},{86,28},{86,-29.9},
          {102.1,-29.9}}, color={0,0,127}));
  connect(ConferenceRoom.Air_in, Central.Air_out) annotation (Line(points={{46,
          68.6},{28,68.6},{28,68},{28,68},{28,80},{-26,80},{-26,68.6},{-44,68.6}},
        color={0,127,255}));
  connect(OpenPlanOffice.Air_in, Central.Air_out) annotation (Line(points={{-10,
          68.6},{-28,68.6},{-28,68.6},{-44,68.6}}, color={0,127,255}));
  connect(Canteen.Air_in, Central.Air_out) annotation (Line(points={{-10,-69.4},
          {-26,-69.4},{-26,-70},{-26,-70},{-26,68.6},{-44,68.6}}, color={0,127,
          255}));
  connect(MultiPersonOffice.Air_in, Central.Air_out) annotation (Line(points={{
          -66,-69.4},{-70,-69.4},{-70,-44},{-26,-44},{-26,68.6},{-44,68.6}},
        color={0,127,255}));
  connect(Workshop.Air_in, Central.Air_out) annotation (Line(points={{44,-69.4},
          {40,-69.4},{40,-70},{36,-70},{36,-44},{-26,-44},{-26,68.6},{-44,68.6}},
        color={0,127,255}));
  connect(OpenPlanOffice.Air_out, Air_out[1]) annotation (Line(points={{10,68.6},
          {16,68.6},{16,70},{16,70},{16,80},{40,80},{40,92}}, color={0,127,255}));
  connect(Central.Airtemp_out, measureBus.Air_RLT_Central_out) annotation (Line(
        points={{-43,71.2},{-36,71.2},{-36,28},{86,28},{86,-29.9},{102.1,-29.9}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_RLT_v2;
