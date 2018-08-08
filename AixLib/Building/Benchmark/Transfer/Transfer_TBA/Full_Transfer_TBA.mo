within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model Full_Transfer_TBA
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  TBA_Pipe Workshop(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{48,60},{68,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,16},{-90,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-24},{-90,-4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA[5]
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_Workshop_1(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={52,26})));

  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{82,-20},{122,20}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_Workshop_2(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={64,-14})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_Canteen_1(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={24,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_MultiPersonOffice_1(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-6,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_Canteen_2(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={36,-2})));
  TBA_Pipe Canteen(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  TBA_Pipe Multipersonoffice(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  TBA_Pipe Conferenceroom(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  TBA_Pipe OpenPlanOffice(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_ConferenceRoom_1(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-36,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_OpenPlanOffice_1(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-64,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_MultiPersonOffice_2(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={6,-2})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_ConferenceRoom_2(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-24,-2})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_OpenPlanOffice_2(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-52,-2})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_pumpsAndPipes[5]
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
equation
  connect(Workshop.Fluid_in, Valve_WarmCold_Workshop_1.port_2)
    annotation (Line(points={{52,60},{52,32}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.port_3, Fluid_in_warm)
    annotation (Line(points={{46,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.port_1, Fluid_in_cold)
    annotation (Line(points={{52,20},{52,-40},{-100,-40}}, color={0,127,255}));
  connect(Workshop.Fluid_out, Valve_WarmCold_Workshop_2.port_2)
    annotation (Line(points={{64,60},{64,-8}}, color={0,127,255}));
  connect(Valve_WarmCold_Canteen_1.port_2, Canteen.Fluid_in)
    annotation (Line(points={{24,24},{24,60}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_2, Multipersonoffice.Fluid_in)
    annotation (Line(points={{-6,24},{-6,60}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_2, Conferenceroom.Fluid_in)
    annotation (Line(points={{-36,24},{-36,60}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_2, OpenPlanOffice.Fluid_in)
    annotation (Line(points={{-64,24},{-64,60}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_2.port_3, Fluid_out_warm)
    annotation (Line(points={{58,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_2.port_1, Fluid_out_cold) annotation (Line(
        points={{64,-20},{64,-80},{-100,-80}}, color={0,127,255}));
  connect(Canteen.Fluid_out, Valve_WarmCold_Canteen_2.port_2)
    annotation (Line(points={{36,60},{36,4}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out, Valve_WarmCold_OpenPlanOffice_2.port_2)
    annotation (Line(points={{-52,60},{-52,4}}, color={0,127,255}));
  connect(Conferenceroom.Fluid_out, Valve_WarmCold_ConferenceRoom_2.port_2)
    annotation (Line(points={{-24,60},{-24,4}}, color={0,127,255}));
  connect(Multipersonoffice.Fluid_out, Valve_WarmCold_MultiPersonOffice_2.port_2)
    annotation (Line(points={{6,60},{6,4}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_3, Fluid_in_warm) annotation (
      Line(points={{-70,18},{-72,18},{-72,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_3, Fluid_in_warm) annotation (
      Line(points={{-42,18},{-44,18},{-44,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_3, Fluid_in_warm) annotation (
     Line(points={{-12,18},{-14,18},{-14,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_Canteen_1.port_3, Fluid_in_warm) annotation (Line(
        points={{18,18},{16,18},{16,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_2.port_3, Fluid_out_warm) annotation (
      Line(points={{-58,-2},{-60,-2},{-60,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_2.port_3, Fluid_out_warm) annotation (
      Line(points={{-30,-2},{-32,-2},{-32,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_2.port_3, Fluid_out_warm)
    annotation (Line(points={{0,-2},{-2,-2},{-2,-14},{-100,-14}}, color={0,127,
          255}));
  connect(Valve_WarmCold_Canteen_2.port_3, Fluid_out_warm) annotation (Line(
        points={{30,-2},{28,-2},{28,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_1, Fluid_in_cold) annotation (
      Line(points={{-64,12},{-64,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_1, Fluid_in_cold) annotation (
      Line(points={{-36,12},{-36,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_1, Fluid_in_cold)
    annotation (Line(points={{-6,12},{-6,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_WarmCold_Canteen_1.port_1, Fluid_in_cold) annotation (Line(
        points={{24,12},{22,12},{22,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_2.port_1, Fluid_out_cold) annotation (
      Line(points={{-52,-8},{-52,-80},{-100,-80}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_2.port_1, Fluid_out_cold) annotation (
      Line(points={{-24,-8},{-24,-80},{-100,-80}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_2.port_1, Fluid_out_cold)
    annotation (Line(points={{6,-8},{6,-80},{-100,-80}}, color={0,127,255}));
  connect(Valve_WarmCold_Canteen_2.port_1, Fluid_out_cold)
    annotation (Line(points={{36,-8},{36,-80},{-100,-80}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.y, controlBus.Valve_TBA_WarmCold_workshop_1)
    annotation (Line(points={{59.2,26},{74,26},{74,0.1},{102.1,0.1}}, color={0,
          0,127}));
  connect(Valve_WarmCold_Workshop_2.y, controlBus.Valve_TBA_WarmCold_workshop_2)
    annotation (Line(points={{71.2,-14},{74,-14},{74,0.1},{102.1,0.1}}, color={
          0,0,127}));
  connect(Valve_WarmCold_Canteen_1.y, controlBus.Valve_TBA_WarmCold_canteen_1)
    annotation (Line(points={{31.2,18},{44,18},{44,0},{44,40},{74,40},{74,0.1},
          {88,0.1},{102.1,0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_Canteen_2.y, controlBus.Valve_TBA_WarmCold_canteen_2)
    annotation (Line(points={{43.2,-2},{44,-2},{44,40},{44,40},{74,40},{74,0.1},
          {88,0.1},{102.1,0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_MultiPersonOffice_1.y, controlBus.Valve_TBA_WarmCold_multipersonoffice_1)
    annotation (Line(points={{1.2,18},{6,18},{6,40},{74,40},{74,0},{88,0},{88,
          0.1},{102.1,0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_MultiPersonOffice_2.y, controlBus.Valve_TBA_WarmCold_multipersonoffice_2)
    annotation (Line(points={{13.2,-2},{16,-2},{16,40},{74,40},{74,0.1},{102.1,
          0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_ConferenceRoom_1.y, controlBus.Valve_TBA_WarmCold_conferenceroom_1)
    annotation (Line(points={{-28.8,18},{-16,18},{-16,40},{74,40},{74,0.1},{
          102.1,0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_ConferenceRoom_2.y, controlBus.Valve_TBA_WarmCold_conferenceroom_2)
    annotation (Line(points={{-16.8,-2},{-16,-2},{-16,40},{74,40},{74,0.1},{
          102.1,0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_OpenPlanOffice_1.y, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_1)
    annotation (Line(points={{-56.8,18},{-44,18},{-44,40},{74,40},{74,0.1},{
          102.1,0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_OpenPlanOffice_2.y, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_2)
    annotation (Line(points={{-44.8,-2},{-44,-2},{-44,-2},{-44,-2},{-44,-2},{
          -44,20},{-44,20},{-44,40},{74,40},{74,0.1},{102.1,0.1}}, color={0,0,
          127}));
  connect(Workshop.HeatPort_TBA, HeatPort_TBA[5]) annotation (Line(points={{54,
          80},{54,90},{40,90},{40,108}}, color={191,0,0}));
  connect(Canteen.HeatPort_TBA, HeatPort_TBA[4]) annotation (Line(points={{26,
          80},{26,90},{40,90},{40,104}}, color={191,0,0}));
  connect(Multipersonoffice.HeatPort_TBA, HeatPort_TBA[3]) annotation (Line(
        points={{-4,80},{-4,90},{40,90},{40,100},{40,100}}, color={191,0,0}));
  connect(Conferenceroom.HeatPort_TBA, HeatPort_TBA[2]) annotation (Line(points=
         {{-34,80},{-34,90},{40,90},{40,96}}, color={191,0,0}));
  connect(OpenPlanOffice.HeatPort_TBA, HeatPort_TBA[1]) annotation (Line(points=
         {{-62,80},{-62,90},{40,90},{40,92}}, color={191,0,0}));
  connect(OpenPlanOffice.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[1])
    annotation (Line(points={{-54,80},{-54,90},{-40,90},{-40,92}}, color={191,0,
          0}));
  connect(Conferenceroom.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[2])
    annotation (Line(points={{-26,80},{-26,90},{-40,90},{-40,96}}, color={191,0,
          0}));
  connect(Multipersonoffice.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[3])
    annotation (Line(points={{4,80},{4,90},{-40,90},{-40,100}}, color={191,0,0}));
  connect(Canteen.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[4])
    annotation (Line(points={{34,80},{34,90},{-40,90},{-40,104}}, color={191,0,
          0}));
  connect(Workshop.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[5])
    annotation (Line(points={{62,80},{62,90},{-40,90},{-40,108}}, color={191,0,
          0}));
  connect(OpenPlanOffice.valve, controlBus.Valve_TBA_Cold_OpenPlanOffice_Temp)
    annotation (Line(points={{-68,66},{-74,66},{-74,40},{74,40},{74,0.1},{102.1,
          0.1}}, color={0,0,127}));
  connect(Conferenceroom.valve, controlBus.Valve_TBA_Cold_ConferenceRoom_Temp)
    annotation (Line(points={{-40,66},{-44,66},{-44,40},{74,40},{74,0.1},{102.1,
          0.1}}, color={0,0,127}));
  connect(Multipersonoffice.valve, controlBus.Valve_TBA_Cold_MultiPersonOffice_Temp)
    annotation (Line(points={{-10,66},{-16,66},{-16,40},{74,40},{74,0.1},{102.1,
          0.1}}, color={0,0,127}));
  connect(Canteen.valve, controlBus.Valve_TBA_Cold_Canteen_Temp) annotation (
      Line(points={{20,66},{16,66},{16,40},{74,40},{74,0.1},{102.1,0.1}}, color=
         {0,0,127}));
  connect(Workshop.valve, controlBus.Valve_TBA_Cold_Workshop_Temp) annotation (
      Line(points={{48,66},{44,66},{44,40},{74,40},{74,0.1},{102.1,0.1}}, color=
         {0,0,127}));
  connect(OpenPlanOffice.pump, controlBus.Pump_TBA_OpenPlanOffice_y)
    annotation (Line(points={{-68,72.8},{-74,72.8},{-74,72},{-74,72},{-74,40},{
          74,40},{74,0.1},{102.1,0.1}}, color={0,0,127}));
  connect(Conferenceroom.pump, controlBus.Pump_TBA_ConferenceRoom_y)
    annotation (Line(points={{-40,72.8},{-44,72.8},{-44,72},{-44,72},{-44,40},{
          74,40},{74,0.1},{102.1,0.1}}, color={0,0,127}));
  connect(Multipersonoffice.pump, controlBus.Pump_TBA_MultiPersonOffice_y)
    annotation (Line(points={{-10,72.8},{-16,72.8},{-16,72},{-16,72},{-16,40},{
          74,40},{74,0.1},{102.1,0.1}}, color={0,0,127}));
  connect(Canteen.pump, controlBus.Pump_TBA_Canteen_y) annotation (Line(points=
          {{20,72.8},{16,72.8},{16,40},{74,40},{74,0.1},{102.1,0.1}}, color={0,
          0,127}));
  connect(Workshop.pump, controlBus.Pump_TBA_Workshop_y) annotation (Line(
        points={{48,72.8},{44,72.8},{44,40},{74,40},{74,0.1},{102.1,0.1}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
