within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model Full_Transfer_TBA
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter Real riseTime_valve = 0 annotation(Dialog(tab = "General"));

    parameter Modelica.SIunits.Pressure dp_Valve_nominal_openplanoffice = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal_openplanoffice = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dp_Valve_nominal_conferenceroom = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal_conferenceroom = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dp_Valve_nominal_multipersonoffice = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal_multipersonoffice = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dp_Valve_nominal_canteen = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal_canteen = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dp_Valve_nominal_workshop = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal_workshop = 0 annotation(Dialog(tab = "General"));
  TBA_Pipe Workshop(dp_Valve_nominal=dp_Valve_nominal_workshop, m_flow_nominal=
        m_flow_nominal_workshop,
    riseTime_valve=riseTime_valve,
    v_nominal=1.839,
    pipe_length=15,
    pipe_wall_thickness=0.0032,
    pipe_insulation_thickness=0.02,
    pipe_insulation_conductivity=0.05,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=30,
    TBA_wall_height=30,
    V_mixing=0.0001)
    annotation (Placement(transformation(extent={{58,60},{78,80}})));
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
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_workshop,
    m_flow_nominal=m_flow_nominal_workshop,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={62,26})));

  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{80,20},{120,60}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_Workshop_2(
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_workshop,
    m_flow_nominal=m_flow_nominal_workshop,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={74,-14})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_Canteen_1(
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_canteen,
    m_flow_nominal=m_flow_nominal_canteen,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={24,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_MultiPersonOffice_1(
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_multipersonoffice,
    m_flow_nominal=m_flow_nominal_multipersonoffice,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-12,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_Canteen_2(
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_canteen,
    m_flow_nominal=m_flow_nominal_canteen,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={36,-2})));
  TBA_Pipe Canteen(dp_Valve_nominal=dp_Valve_nominal_canteen, m_flow_nominal=
        m_flow_nominal_canteen,
    riseTime_valve=riseTime_valve,
    v_nominal=1.839,
    pipe_length=10,
    pipe_wall_thickness=0.0032,
    pipe_insulation_thickness=0.02,
    pipe_insulation_conductivity=0.05,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=20,
    TBA_wall_height=30,
    V_mixing=0.0001)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  TBA_Pipe Multipersonoffice(dp_Valve_nominal=
        dp_Valve_nominal_multipersonoffice, m_flow_nominal=
        m_flow_nominal_multipersonoffice,
    riseTime_valve=riseTime_valve,
    v_nominal=1.884,
    pipe_length=28,
    pipe_wall_thickness=0.0026,
    pipe_insulation_thickness=0.02,
    pipe_insulation_conductivity=0.05,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=5,
    TBA_wall_height=20,
    V_mixing=0.0001)
    annotation (Placement(transformation(extent={{-16,60},{4,80}})));
  TBA_Pipe Conferenceroom(m_flow_nominal=m_flow_nominal_conferenceroom,
      dp_Valve_nominal=dp_Valve_nominal_conferenceroom,
    riseTime_valve=riseTime_valve,
    v_nominal=1.546,
    pipe_length=48,
    pipe_wall_thickness=0.0023,
    pipe_insulation_thickness=0.02,
    pipe_insulation_conductivity=0.05,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=5,
    TBA_wall_height=10,
    V_mixing=0.0001)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  TBA_Pipe OpenPlanOffice(dp_Valve_nominal=dp_Valve_nominal_openplanoffice,
      m_flow_nominal=m_flow_nominal_openplanoffice,
    riseTime_valve=riseTime_valve,
    v_nominal=1.851,
    pipe_length=8,
    pipe_wall_thickness=0.0032,
    pipe_insulation_thickness=0.02,
    pipe_insulation_conductivity=0.05,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=45,
    TBA_wall_height=30,
    V_mixing=0.0001)
    annotation (Placement(transformation(extent={{-86,60},{-66,80}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_ConferenceRoom_1(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_conferenceroom,
    dpValve_nominal=dp_Valve_nominal_conferenceroom,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-46,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_OpenPlanOffice_1(
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_openplanoffice,
    m_flow_nominal=m_flow_nominal_openplanoffice,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-82,18})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_MultiPersonOffice_2(
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_multipersonoffice,
    m_flow_nominal=m_flow_nominal_multipersonoffice,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={0,-2})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_ConferenceRoom_2(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_conferenceroom,
    dpValve_nominal=dp_Valve_nominal_conferenceroom,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-34,-2})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_WarmCold_OpenPlanOffice_2(
    redeclare package Medium = Medium_Water,
    dpValve_nominal=dp_Valve_nominal_openplanoffice,
    m_flow_nominal=m_flow_nominal_openplanoffice,
    riseTime=riseTime_valve)                 annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-70,-2})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_pumpsAndPipes[5]
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{80,-60},{120,-20}})));
equation
  connect(Workshop.Fluid_in, Valve_WarmCold_Workshop_1.port_2)
    annotation (Line(points={{62,60},{62,32}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.port_3, Fluid_in_warm)
    annotation (Line(points={{56,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.port_1, Fluid_in_cold)
    annotation (Line(points={{62,20},{62,-40},{-100,-40}}, color={0,127,255}));
  connect(Workshop.Fluid_out, Valve_WarmCold_Workshop_2.port_2)
    annotation (Line(points={{74,60},{74,-8}}, color={0,127,255}));
  connect(Valve_WarmCold_Canteen_1.port_2, Canteen.Fluid_in)
    annotation (Line(points={{24,24},{24,60}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_2, Multipersonoffice.Fluid_in)
    annotation (Line(points={{-12,24},{-12,60}},
                                               color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_2, Conferenceroom.Fluid_in)
    annotation (Line(points={{-46,24},{-46,60}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_2, OpenPlanOffice.Fluid_in)
    annotation (Line(points={{-82,24},{-82,60}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_2.port_3, Fluid_out_warm)
    annotation (Line(points={{68,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_2.port_1, Fluid_out_cold) annotation (Line(
        points={{74,-20},{74,-80},{-100,-80}}, color={0,127,255}));
  connect(Canteen.Fluid_out, Valve_WarmCold_Canteen_2.port_2)
    annotation (Line(points={{36,60},{36,4}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out, Valve_WarmCold_OpenPlanOffice_2.port_2)
    annotation (Line(points={{-70,60},{-70,4}}, color={0,127,255}));
  connect(Conferenceroom.Fluid_out, Valve_WarmCold_ConferenceRoom_2.port_2)
    annotation (Line(points={{-34,60},{-34,4}}, color={0,127,255}));
  connect(Multipersonoffice.Fluid_out, Valve_WarmCold_MultiPersonOffice_2.port_2)
    annotation (Line(points={{0,60},{0,32},{4.44089e-016,32},{4.44089e-016,4}},
                                            color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_3, Fluid_in_warm) annotation (
      Line(points={{-88,18},{-90,18},{-90,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_3, Fluid_in_warm) annotation (
      Line(points={{-52,18},{-54,18},{-54,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_3, Fluid_in_warm) annotation (
     Line(points={{-18,18},{-20,18},{-20,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_Canteen_1.port_3, Fluid_in_warm) annotation (Line(
        points={{18,18},{16,18},{16,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_2.port_3, Fluid_out_warm) annotation (
      Line(points={{-76,-2},{-76,-2},{-78,-2},{-78,-2},{-78,-14},{-100,-14}},
                                                            color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_2.port_3, Fluid_out_warm) annotation (
      Line(points={{-40,-2},{-42,-2},{-42,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_2.port_3, Fluid_out_warm)
    annotation (Line(points={{-6,-2},{-8,-2},{-8,-14},{-100,-14}},color={0,127,
          255}));
  connect(Valve_WarmCold_Canteen_2.port_3, Fluid_out_warm) annotation (Line(
        points={{30,-2},{28,-2},{28,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_1, Fluid_in_cold) annotation (
      Line(points={{-82,12},{-82,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_1, Fluid_in_cold) annotation (
      Line(points={{-46,12},{-46,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_1, Fluid_in_cold)
    annotation (Line(points={{-12,12},{-12,-40},{-100,-40}},
                                                           color={0,127,255}));
  connect(Valve_WarmCold_Canteen_1.port_1, Fluid_in_cold) annotation (Line(
        points={{24,12},{22,12},{22,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_2.port_1, Fluid_out_cold) annotation (
      Line(points={{-70,-8},{-70,-80},{-100,-80}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_2.port_1, Fluid_out_cold) annotation (
      Line(points={{-34,-8},{-34,-80},{-100,-80}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_2.port_1, Fluid_out_cold)
    annotation (Line(points={{-4.44089e-016,-8},{-4.44089e-016,-80},{-100,-80}},
                                                         color={0,127,255}));
  connect(Valve_WarmCold_Canteen_2.port_1, Fluid_out_cold)
    annotation (Line(points={{36,-8},{36,-80},{-100,-80}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.y, controlBus.Valve_TBA_WarmCold_workshop_1)
    annotation (Line(points={{69.2,26},{86,26},{86,40.1},{100.1,40.1}},
                                                                      color={0,
          0,127}));
  connect(Valve_WarmCold_Canteen_1.y, controlBus.Valve_TBA_WarmCold_canteen_1)
    annotation (Line(points={{31.2,18},{44,18},{44,40},{86,40},{86,0},{86,0},{86,
          40},{100.1,40},{100.1,40.1}},
                                 color={0,0,127}));
  connect(Valve_WarmCold_MultiPersonOffice_1.y, controlBus.Valve_TBA_WarmCold_multipersonoffice_1)
    annotation (Line(points={{-4.8,18},{10,18},{10,40},{86,40},{86,0},{86,0},{86,
          40.1},{100.1,40.1}},
                             color={0,0,127}));
  connect(Valve_WarmCold_ConferenceRoom_1.y, controlBus.Valve_TBA_WarmCold_conferenceroom_1)
    annotation (Line(points={{-38.8,18},{-24,18},{-24,40},{86,40},{86,0},{86,0},
          {86,40.1},{100.1,40.1}},
                       color={0,0,127}));
  connect(Valve_WarmCold_OpenPlanOffice_1.y, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_1)
    annotation (Line(points={{-74.8,18},{-60,18},{-60,40},{86,40},{86,0},{86,0},
          {86,40.1},{100.1,40.1}},
                       color={0,0,127}));
  connect(Workshop.HeatPort_TBA, HeatPort_TBA[5]) annotation (Line(points={{64,80},
          {64,90},{40,90},{40,108}},     color={191,0,0}));
  connect(Canteen.HeatPort_TBA, HeatPort_TBA[4]) annotation (Line(points={{26,
          80},{26,90},{40,90},{40,104}}, color={191,0,0}));
  connect(Multipersonoffice.HeatPort_TBA, HeatPort_TBA[3]) annotation (Line(
        points={{-10,80},{-10,90},{40,90},{40,100}},        color={191,0,0}));
  connect(Conferenceroom.HeatPort_TBA, HeatPort_TBA[2]) annotation (Line(points={{-44,80},
          {-44,90},{40,90},{40,96}},          color={191,0,0}));
  connect(OpenPlanOffice.HeatPort_TBA, HeatPort_TBA[1]) annotation (Line(points={{-80,80},
          {-80,90},{40,90},{40,92}},          color={191,0,0}));
  connect(OpenPlanOffice.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[1])
    annotation (Line(points={{-72,80},{-72,90},{-40,90},{-40,92}}, color={191,0,
          0}));
  connect(Conferenceroom.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[2])
    annotation (Line(points={{-36,80},{-36,90},{-40,90},{-40,96}}, color={191,0,
          0}));
  connect(Multipersonoffice.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[3])
    annotation (Line(points={{-2,80},{-2,90},{-40,90},{-40,100}},
                                                                color={191,0,0}));
  connect(Canteen.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[4])
    annotation (Line(points={{34,80},{34,90},{-40,90},{-40,104}}, color={191,0,
          0}));
  connect(Workshop.HeatPort_pumpsAndPipes, HeatPort_pumpsAndPipes[5])
    annotation (Line(points={{72,80},{72,90},{-40,90},{-40,108}}, color={191,0,
          0}));
  connect(OpenPlanOffice.valve, controlBus.Valve_TBA_Cold_OpenPlanOffice_Temp)
    annotation (Line(points={{-86,66},{-90,66},{-90,40},{86,40},{86,0},{86,0},{86,
          40.1},{100.1,40.1}},
                 color={0,0,127}));
  connect(Conferenceroom.valve, controlBus.Valve_TBA_Cold_ConferenceRoom_Temp)
    annotation (Line(points={{-50,66},{-54,66},{-54,40},{86,40},{86,0},{86,0},{86,
          40.1},{100.1,40.1}},
                 color={0,0,127}));
  connect(Multipersonoffice.valve, controlBus.Valve_TBA_Cold_MultiPersonOffice_Temp)
    annotation (Line(points={{-16,66},{-20,66},{-20,40},{86,40},{86,0},{86,0},{86,
          40.1},{100.1,40.1}},
                 color={0,0,127}));
  connect(Canteen.valve, controlBus.Valve_TBA_Cold_Canteen_Temp) annotation (
      Line(points={{20,66},{16,66},{16,40},{86,40},{86,0},{86,0},{86,40.1},{100.1,
          40.1}},                                                         color=
         {0,0,127}));
  connect(Workshop.valve, controlBus.Valve_TBA_Cold_Workshop_Temp) annotation (
      Line(points={{58,66},{54,66},{54,40},{86,40},{86,0},{86,0},{86,40.1},{100.1,
          40.1}},                                                         color=
         {0,0,127}));
  connect(OpenPlanOffice.pump, controlBus.Pump_TBA_OpenPlanOffice_y)
    annotation (Line(points={{-86,72.8},{-90,72.8},{-90,40},{86,40},{86,0},{86,0},
          {86,40.1},{100.1,40.1}},      color={0,0,127}));
  connect(Conferenceroom.pump, controlBus.Pump_TBA_ConferenceRoom_y)
    annotation (Line(points={{-50,72.8},{-54,72.8},{-54,40},{86,40},{86,0},{86,0},
          {86,40.1},{100.1,40.1}},      color={0,0,127}));
  connect(Multipersonoffice.pump, controlBus.Pump_TBA_MultiPersonOffice_y)
    annotation (Line(points={{-16,72.8},{-20,72.8},{-20,40},{86,40},{86,0},{86,0},
          {86,40.1},{100.1,40.1}},      color={0,0,127}));
  connect(Canteen.pump, controlBus.Pump_TBA_Canteen_y) annotation (Line(points={{20,72.8},
          {16,72.8},{16,40},{86,40},{86,0},{86,0},{86,40.1},{100.1,40.1}},
                                                                      color={0,
          0,127}));
  connect(Workshop.pump, controlBus.Pump_TBA_Workshop_y) annotation (Line(
        points={{58,72.8},{54,72.8},{54,40},{86,40},{86,0},{86,0},{86,40.1},{100.1,
          40.1}},
        color={0,0,127}));
  connect(OpenPlanOffice.Temp_in, measureBus.TBA_openplanoffice_in) annotation (
     Line(points={{-66,64},{-60,64},{-60,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(OpenPlanOffice.Temp_out, measureBus.TBA_openplanoffice_out)
    annotation (Line(points={{-66,68},{-60,68},{-60,40},{86,40},{86,-39.9},{100.1,
          -39.9}}, color={0,0,127}));
  connect(Conferenceroom.Temp_in, measureBus.TBA_conferencerom_in) annotation (
      Line(points={{-30,64},{-24,64},{-24,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Conferenceroom.Temp_out, measureBus.TBA_conferencerom_out)
    annotation (Line(points={{-30,68},{-24,68},{-24,40},{86,40},{86,-39.9},{100.1,
          -39.9}}, color={0,0,127}));
  connect(Multipersonoffice.Temp_in, measureBus.TBA_multipersonoffice_in)
    annotation (Line(points={{4,64},{10,64},{10,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Multipersonoffice.Temp_out, measureBus.TBA_multipersonoffice_out)
    annotation (Line(points={{4,68},{10,68},{10,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Canteen.Temp_in, measureBus.TBA_canteen_in) annotation (Line(points={{
          40,64},{44,64},{44,40},{86,40},{86,-39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Canteen.Temp_out, measureBus.TBA_canteen_out) annotation (Line(points=
         {{40,68},{44,68},{44,40},{86,40},{86,-39.9},{100.1,-39.9}}, color={0,0,
          127}));
  connect(Workshop.Temp_in, measureBus.TBA_workshop_in) annotation (Line(points=
         {{78,64},{86,64},{86,-39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Workshop.Temp_out, measureBus.TBA_workshop_out) annotation (Line(
        points={{78,68},{86,68},{86,-39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Workshop.m_flow, measureBus.TBA_workshop) annotation (Line(points={{78,
          72},{86,72},{86,-39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Canteen.m_flow, measureBus.TBA_canteen) annotation (Line(points={{40,72},
          {44,72},{44,40},{86,40},{86,-39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Multipersonoffice.m_flow, measureBus.TBA_multipersonoffice)
    annotation (Line(points={{4,72},{10,72},{10,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Conferenceroom.m_flow, measureBus.TBA_conferenceroom) annotation (
      Line(points={{-30,72},{-24,72},{-24,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(OpenPlanOffice.m_flow, measureBus.TBA_openplanoffice) annotation (
      Line(points={{-66,72},{-60,72},{-60,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(OpenPlanOffice.Power_pump, measureBus.Pump_TBA_openplanoffice)
    annotation (Line(points={{-66,76},{-60,76},{-60,40},{86,40},{86,-39.9},{100.1,
          -39.9}}, color={0,0,127}));
  connect(Conferenceroom.Power_pump, measureBus.Pump_TBA_conferenceroom)
    annotation (Line(points={{-30,76},{-24,76},{-24,40},{86,40},{86,-39.9},{100.1,
          -39.9}}, color={0,0,127}));
  connect(Multipersonoffice.Power_pump, measureBus.Pump_TBA_multipersonoffice)
    annotation (Line(points={{4,76},{10,76},{10,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Canteen.Power_pump, measureBus.Pump_TBA_canteen) annotation (Line(
        points={{40,76},{44,76},{44,40},{86,40},{86,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Workshop.Power_pump, measureBus.Pump_TBA_workshop) annotation (Line(
        points={{78,76},{86,76},{86,-39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Valve_WarmCold_OpenPlanOffice_2.y, controlBus.Valve_TBA_WarmCold_OpenPlanOffice_1)
    annotation (Line(points={{-62.8,-2},{-62,-2},{-62,0},{-60,0},{-60,40.1},{
          100.1,40.1}}, color={0,0,127}));
  connect(Valve_WarmCold_ConferenceRoom_2.y, controlBus.Valve_TBA_WarmCold_conferenceroom_1)
    annotation (Line(points={{-26.8,-2},{-24,-2},{-24,40.1},{100.1,40.1}},
        color={0,0,127}));
  connect(Valve_WarmCold_MultiPersonOffice_2.y, controlBus.Valve_TBA_WarmCold_multipersonoffice_1)
    annotation (Line(points={{7.2,-2},{10,-2},{10,40.1},{100.1,40.1}}, color={0,
          0,127}));
  connect(Valve_WarmCold_Canteen_2.y, controlBus.Valve_TBA_WarmCold_canteen_1)
    annotation (Line(points={{43.2,-2},{44,-2},{44,40.1},{100.1,40.1}}, color={
          0,0,127}));
  connect(Valve_WarmCold_Workshop_2.y, controlBus.Valve_TBA_WarmCold_workshop_1)
    annotation (Line(points={{81.2,-14},{86,-14},{86,40.1},{100.1,40.1}}, color
        ={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
