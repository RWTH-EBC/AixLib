within AixLib.Building.Benchmark.Transfer.Transfer_RLT;
model Full_Transfer_RLT
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  RLT Workshop annotation (Placement(transformation(extent={{44,-66},{64,-86}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out[5](redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium
      = Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium
      = Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium
      = Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium
      = Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{82,8},{122,48}})));
  RLT Canteen annotation (Placement(transformation(extent={{-10,-66},{10,-86}})));
  RLT MultiPersonOffice
    annotation (Placement(transformation(extent={{-66,-66},{-46,-86}})));
  RLT ConferenceRoom
    annotation (Placement(transformation(extent={{46,72},{66,52}})));
  RLT OpenPlanOffice
    annotation (Placement(transformation(extent={{-10,72},{10,52}})));
  RLT Central annotation (Placement(transformation(extent={{-66,72},{-46,52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[5]
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{82,-50},{122,-10}})));
equation
  connect(Air_in, Central.Air_in) annotation (Line(points={{-40,100},{-40,80},{
          -74,80},{-74,80},{-74,68},{-66,68},{-66,68},{-66,68},{-65.8,68},{
          -65.8,68.6}},            color={0,127,255}));
  connect(Central.Air_out, OpenPlanOffice.Air_in) annotation (Line(points={{-46,
          68.6},{-9.8,68.6}},                        color={0,127,255}));
  connect(ConferenceRoom.Air_in, OpenPlanOffice.Air_in) annotation (Line(points={{46.2,
          68.6},{40,68.6},{40,74},{-16,74},{-16,68.6},{-9.8,68.6}},
        color={0,127,255}));
  connect(MultiPersonOffice.Air_in, OpenPlanOffice.Air_in) annotation (Line(
        points={{-65.8,-69.4},{-65.8,-70},{-70,-70},{-70,-60},{-70,-60},{-16,
          -60},{-16,68},{-16,68},{-16,68},{-16,68},{-16,68},{-16,68},{-16,68},{
          -16,68},{-16,68},{-16,68.6},{-12,68.6},{-9.8,68.6}},
        color={0,127,255}));
  connect(Canteen.Air_in, OpenPlanOffice.Air_in) annotation (Line(points={{-9.8,
          -69.4},{-16,-69.4},{-16,-70},{-16,-70},{-16,68},{-16,68},{-16,68},{
          -16,68},{-16,68.6},{-9.8,68.6}},                           color={0,
          127,255}));
  connect(Workshop.Air_in, OpenPlanOffice.Air_in) annotation (Line(points={{44.2,
          -69.4},{36,-69.4},{36,-70},{36,-70},{36,-60},{-16,-60},{-16,68},{-9.8,
          68},{-9.8,68.6}},                                               color=
         {0,127,255}));
  connect(OpenPlanOffice.Air_out, Air_out[1]) annotation (Line(points={{10,68.6},
          {10,68},{16,68},{16,80},{40,80},{40,92}},
                                           color={0,127,255}));
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
  connect(Central.Fluid_out_hot, Fluid_out_hot)
    annotation (Line(points={{-64,52},{-64,40},{-100,40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_hot, Fluid_out_hot)
    annotation (Line(points={{-8,52},{-8,40},{-100,40}}, color={0,127,255}));
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
  connect(Central.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{-52,52},
          {-52,0},{-80,0},{-80,-80},{-100,-80}},     color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{4,52},{4,0},{-80,0},{-80,-80},{-100,-80}},     color={0,127,
          255}));
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
  connect(Workshop.X_w, controlBus.X_Workshop) annotation (Line(points={{54,-86},
          {54,-90},{86,-90},{86,28.1},{102.1,28.1}},
                                                 color={0,0,127}));
  connect(Canteen.X_w, controlBus.X_Canteen) annotation (Line(points={{0,-86},{
          0,-90},{28,-90},{28,28},{86,28},{86,0},{86,0},{86,28.1},{102.1,28.1}},
                                                color={0,0,127}));
  connect(MultiPersonOffice.X_w, controlBus.X_MultiPersonRoom) annotation (Line(
        points={{-56,-86},{-56,-90},{-36,-90},{-36,28},{86,28},{86,28.1},{102.1,
          28.1}},                                              color={0,0,127}));
  connect(ConferenceRoom.X_w, controlBus.X_ConfernceRoom) annotation (Line(
        points={{56,52},{56,28},{86,28},{86,28.1},{102.1,28.1}}, color={0,0,127}));
  connect(OpenPlanOffice.X_w, controlBus.X_OpenPlanOffice) annotation (Line(
        points={{0,52},{0,28},{86,28},{86,28.1},{102.1,28.1}},   color={0,0,127}));
  connect(Central.X_w, controlBus.X_Central) annotation (Line(points={{-56,52},
          {-56,28},{86,28},{86,28.1},{102.1,28.1}},
                                                  color={0,0,127}));
  connect(Central.Fluid_in_cold, Fluid_in_cold) annotation (Line(points={{-48,52},
          {-48,-40},{-100,-40}},     color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_cold, Fluid_in_cold) annotation (Line(points={{8,52},{
          8,-40},{-100,-40}},              color={0,127,255}));
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
  connect(Fluid_in_hot, Central.Fluid_in_hot) annotation (Line(points={{-100,80},
          {-86,80},{-86,20},{-60,20},{-60,52}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_hot, Central.Fluid_in_hot) annotation (Line(
        points={{-4,52},{-4,20},{-60,20},{-60,52}}, color={0,127,255}));
  connect(ConferenceRoom.Fluid_in_hot, Central.Fluid_in_hot) annotation (Line(
        points={{52,52},{52,20},{-60,20},{-60,52}}, color={0,127,255}));
  connect(MultiPersonOffice.Fluid_in_hot, Central.Fluid_in_hot) annotation (
      Line(points={{-60,-86},{-60,-90},{-74,-90},{-76,-90},{-76,20},{-60,20},{
          -60,52}}, color={0,127,255}));
  connect(Canteen.Fluid_in_hot, Central.Fluid_in_hot) annotation (Line(points={
          {-4,-86},{-4,-90},{-14,-90},{-12,-90},{-12,20},{-60,20},{-60,52}},
        color={0,127,255}));
  connect(Workshop.Fluid_in_hot, Central.Fluid_in_hot) annotation (Line(points=
          {{50,-86},{50,-90},{40,-90},{38,-90},{38,20},{-60,20},{-60,52}},
        color={0,127,255}));
  connect(Central.heatPort_pumpsAndPipes, heatPort[4]) annotation (Line(points={{-56,72},
          {-56,80},{0,80},{0,104}},           color={191,0,0}));
  connect(OpenPlanOffice.heatPort_pumpsAndPipes, heatPort[1]) annotation (Line(
        points={{0,72},{0,92}},                   color={191,0,0}));
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
  connect(Central.valve_cold, controlBus.Valve_RLT_Cold_Central) annotation (
      Line(points={{-46,54},{-36,54},{-36,28},{86,28},{86,28.1},{102.1,28.1}},
        color={0,0,127}));
  connect(Central.valve_hot, controlBus.Valve_RLT_Hot_Central) annotation (Line(
        points={{-46,58},{-36,58},{-36,28},{86,28},{86,28.1},{102.1,28.1}},
                                                                          color=
         {0,0,127}));
  connect(Central.pump_cold, controlBus.Pump_RLT_Central_cold_y) annotation (
      Line(points={{-46,62},{-36,62},{-36,28},{86,28},{86,28.1},{102.1,28.1}},
        color={0,0,127}));
  connect(Central.pump_hot, controlBus.Pump_RLT_Central_hot_y) annotation (Line(
        points={{-46,66},{-36,66},{-36,28},{86,28},{86,28.1},{102.1,28.1}},
                                                                          color=
         {0,0,127}));
  connect(OpenPlanOffice.valve_cold, controlBus.Valve_RLT_Cold_OpenPlanOffice)
    annotation (Line(points={{10,54},{18,54},{18,28},{86,28},{86,28.1},{102.1,
          28.1}},color={0,0,127}));
  connect(OpenPlanOffice.valve_hot, controlBus.Valve_RLT_Hot_OpenPlanOffice)
    annotation (Line(points={{10,58},{18,58},{18,28},{86,28},{86,28.1},{102.1,
          28.1}},color={0,0,127}));
  connect(OpenPlanOffice.pump_cold, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
    annotation (Line(points={{10,62},{18,62},{18,28},{86,28},{86,28.1},{102.1,
          28.1}},color={0,0,127}));
  connect(OpenPlanOffice.pump_hot, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
    annotation (Line(points={{10,66},{18,66},{18,28},{86,28},{86,28.1},{102.1,
          28.1}},color={0,0,127}));
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
    annotation (Line(points={{-46,-84},{-36,-84},{-36,28},{86,28},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(MultiPersonOffice.valve_hot, controlBus.Valve_RLT_Hot_MultiPersonOffice)
    annotation (Line(points={{-46,-80},{-36,-80},{-36,28},{86,28},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(MultiPersonOffice.pump_cold, controlBus.Pump_RLT_MultiPersonOffice_cold_y)
    annotation (Line(points={{-46,-76},{-36,-76},{-36,28},{86,28},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(MultiPersonOffice.pump_hot, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
    annotation (Line(points={{-46,-72},{-36,-72},{-36,28},{86,28},{86,28.1},{
          102.1,28.1}},
                 color={0,0,127}));
  connect(Canteen.valve_cold, controlBus.Valve_RLT_Cold_Canteen) annotation (
      Line(points={{10,-84},{28,-84},{28,28},{86,28},{86,0},{86,0},{86,28.1},{
          102.1,28.1}},                                                   color=
         {0,0,127}));
  connect(Canteen.valve_hot, controlBus.Valve_RLT_Hot_Canteen) annotation (Line(
        points={{10,-80},{28,-80},{28,28},{86,28},{86,28.1},{102.1,28.1}},
                                                                       color={0,
          0,127}));
  connect(Canteen.pump_cold, controlBus.Pump_RLT_Canteen_cold_y) annotation (
      Line(points={{10,-76},{28,-76},{28,28},{86,28},{86,28.1},{102.1,28.1}},
                                                                          color=
         {0,0,127}));
  connect(Canteen.pump_hot, controlBus.Pump_RLT_Canteen_hot_y) annotation (Line(
        points={{10,-72},{28,-72},{28,28},{86,28},{86,28.1},{102.1,28.1}},
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_RLT;
