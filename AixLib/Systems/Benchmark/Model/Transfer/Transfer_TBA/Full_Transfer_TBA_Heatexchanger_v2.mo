within AixLib.Systems.Benchmark.Model.Transfer.Transfer_TBA;
model Full_Transfer_TBA_Heatexchanger_v2
    replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter Modelica.SIunits.Pressure dp_Heatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
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
  BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{80,20},{120,60}})));
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{80,-60},{120,-20}})));
  TBA_Pipe_Openplanoffice_v3 OpenPlanOffice(
    V_mixing=0.0001,
    dp_Valve_nominal=dp_Valve_nominal_openplanoffice,
    m_flow_nominal=m_flow_nominal_openplanoffice,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=45,
    TBA_wall_height=30,
    pipe_diameter=0.0419,
    dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
    pipe_height=0,
    pipe_length=35,
    Thermal_Conductance=70072/10)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  TBA_Pipe_v3 Conferenceroom(
    m_flow_nominal=m_flow_nominal_conferenceroom,
    dp_Valve_nominal=dp_Valve_nominal_conferenceroom,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=5,
    TBA_wall_height=10,
    V_mixing=0.0001,
    pipe_diameter=0.0161,
    dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
    pipe_length=45,
    Thermal_Conductance=11105/10)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  TBA_Pipe_v3 Multipersonoffice(
    dp_Valve_nominal=dp_Valve_nominal_multipersonoffice,
    m_flow_nominal=m_flow_nominal_multipersonoffice,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=5,
    TBA_wall_height=20,
    V_mixing=0.0001,
    dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
    pipe_length=70,
    pipe_height=0,
    Thermal_Conductance=16397/10,
    pipe_diameter=0.0161)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  TBA_Pipe_v3 Canteen(
    dp_Valve_nominal=dp_Valve_nominal_canteen,
    m_flow_nominal=m_flow_nominal_canteen,
    pipe_length=10,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=20,
    TBA_wall_height=30,
    V_mixing=0.0001,
    pipe_diameter=0.0273,
    pipe_height=0,
    dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
    Thermal_Conductance=31781/10)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  TBA_Pipe_v3 Workshop(
    dp_Valve_nominal=dp_Valve_nominal_workshop,
    m_flow_nominal=m_flow_nominal_workshop,
    pipe_length=15,
    TBA_pipe_diameter=0.02,
    TBA_wall_length=30,
    TBA_wall_height=30,
    V_mixing=0.0001,
    pipe_height=0,
    dp_Heatexchanger_nominal=dp_Heatexchanger_nominal,
    pipe_diameter(displayUnit="m") = 0.0419,
    Thermal_Conductance=57972/10)
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
equation
  connect(OpenPlanOffice.HeatPort_TBA, HeatPort_TBA[1]) annotation (Line(points=
         {{-94,80},{-94,88},{40,88},{40,92}}, color={191,0,0}));
  connect(Conferenceroom.HeatPort_TBA, HeatPort_TBA[2]) annotation (Line(points=
         {{-54,80},{-54,88},{40,88},{40,96}}, color={191,0,0}));
  connect(Multipersonoffice.HeatPort_TBA, HeatPort_TBA[3]) annotation (Line(
        points={{-14,80},{-14,88},{40,88},{40,100}}, color={191,0,0}));
  connect(Canteen.HeatPort_TBA, HeatPort_TBA[4]) annotation (Line(points={{26,
          80},{26,88},{40,88},{40,104}}, color={191,0,0}));
  connect(Workshop.HeatPort_TBA, HeatPort_TBA[5]) annotation (Line(points={{66,
          80},{66,88},{40,88},{40,108}}, color={191,0,0}));
  connect(OpenPlanOffice.Valve_warm, controlBus.Valve_TBA_Warm_OpenPlanOffice)
    annotation (Line(points={{-100,64},{-110,64},{-110,40.1},{100.1,40.1}},
        color={0,0,127}));
  connect(OpenPlanOffice.valve_temp, controlBus.Valve_TBA_OpenPlanOffice_Temp)
    annotation (Line(points={{-100,70},{-110,70},{-110,40.1},{100.1,40.1}},
        color={0,0,127}));
  connect(OpenPlanOffice.pump, controlBus.Pump_TBA_OpenPlanOffice_y)
    annotation (Line(points={{-100,76},{-110,76},{-110,40.1},{100.1,40.1}},
        color={0,0,127}));
  connect(Conferenceroom.Valve_warm, controlBus.Valve_TBA_Warm_conferenceroom)
    annotation (Line(points={{-60,64},{-68,64},{-68,40.1},{100.1,40.1}}, color=
          {0,0,127}));
  connect(Conferenceroom.valve_temp, controlBus.Valve_TBA_ConferenceRoom_Temp)
    annotation (Line(points={{-60,70},{-68,70},{-68,40.1},{100.1,40.1}}, color=
          {0,0,127}));
  connect(Conferenceroom.pump, controlBus.Pump_TBA_ConferenceRoom_y)
    annotation (Line(points={{-60,76},{-68,76},{-68,40.1},{100.1,40.1}}, color=
          {0,0,127}));
  connect(Multipersonoffice.Valve_warm, controlBus.Valve_TBA_Warm_multipersonoffice)
    annotation (Line(points={{-20,64},{-26,64},{-26,40.1},{100.1,40.1}}, color=
          {0,0,127}));
  connect(Multipersonoffice.valve_temp, controlBus.Valve_TBA_MultiPersonOffice_Temp)
    annotation (Line(points={{-20,70},{-26,70},{-26,40.1},{100.1,40.1}}, color=
          {0,0,127}));
  connect(Multipersonoffice.pump, controlBus.Pump_TBA_MultiPersonOffice_y)
    annotation (Line(points={{-20,76},{-26,76},{-26,40.1},{100.1,40.1}}, color=
          {0,0,127}));
  connect(Canteen.Valve_warm, controlBus.Valve_TBA_Warm_canteen) annotation (
      Line(points={{20,64},{14,64},{14,40.1},{100.1,40.1}}, color={0,0,127}));
  connect(Canteen.valve_temp, controlBus.Valve_TBA_Canteen_Temp) annotation (
      Line(points={{20,70},{14,70},{14,40.1},{100.1,40.1}}, color={0,0,127}));
  connect(Canteen.pump, controlBus.Pump_TBA_Canteen_y) annotation (Line(points=
          {{20,76},{14,76},{14,40.1},{100.1,40.1}}, color={0,0,127}));
  connect(Workshop.Valve_warm, controlBus.Valve_TBA_Warm_workshop) annotation (
      Line(points={{60,64},{54,64},{54,40.1},{100.1,40.1}}, color={0,0,127}));
  connect(Workshop.pump, controlBus.Pump_TBA_Workshop_y) annotation (Line(
        points={{60,76},{54,76},{54,40.1},{100.1,40.1}}, color={0,0,127}));
  connect(Workshop.valve_temp, controlBus.Valve_TBA_Workshop_Temp) annotation (
      Line(points={{60,70},{54,70},{54,40.1},{100.1,40.1}}, color={0,0,127}));
  connect(OpenPlanOffice.Temp_in, measureBus.TBA_openplanoffice_in) annotation (
     Line(points={{-80,64},{-74,64},{-74,40},{60,40},{60,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(OpenPlanOffice.Temp_out, measureBus.TBA_openplanoffice_out)
    annotation (Line(points={{-80,68},{-74,68},{-74,40},{60,40},{60,-39.9},{
          100.1,-39.9}}, color={0,0,127}));
  connect(Conferenceroom.Temp_in, measureBus.TBA_conferencerom_in) annotation (
      Line(points={{-40,64},{-36,64},{-36,40},{60,40},{60,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Conferenceroom.Temp_out, measureBus.TBA_conferencerom_out)
    annotation (Line(points={{-40,68},{-36,68},{-36,40},{60,40},{60,-39.9},{
          100.1,-39.9}}, color={0,0,127}));
  connect(Multipersonoffice.Temp_in, measureBus.TBA_multipersonoffice_in)
    annotation (Line(points={{0,64},{2,64},{2,64},{4,64},{4,40},{60,40},{60,
          -39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Multipersonoffice.Temp_out, measureBus.TBA_multipersonoffice_out)
    annotation (Line(points={{0,68},{4,68},{4,40},{60,40},{60,-39.9},{100.1,
          -39.9}}, color={0,0,127}));
  connect(Canteen.Temp_in, measureBus.TBA_canteen_in) annotation (Line(points={
          {40,64},{46,64},{46,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
          127}));
  connect(Canteen.Temp_out, measureBus.TBA_canteen_out) annotation (Line(points=
         {{40,68},{46,68},{46,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
          127}));
  connect(Workshop.Temp_in, measureBus.TBA_workshop_in) annotation (Line(points=
         {{80,64},{84,64},{84,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
          127}));
  connect(Workshop.Temp_out, measureBus.TBA_workshop_out) annotation (Line(
        points={{80,68},{84,68},{84,40},{60,40},{60,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(OpenPlanOffice.m_flow, measureBus.TBA_openplanoffice) annotation (
      Line(points={{-80,72},{-74,72},{-74,40},{60,40},{60,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Conferenceroom.m_flow, measureBus.TBA_conferenceroom) annotation (
      Line(points={{-40,72},{-38,72},{-38,72},{-36,72},{-36,40},{60,40},{60,
          -39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Multipersonoffice.m_flow, measureBus.TBA_multipersonoffice)
    annotation (Line(points={{0,72},{4,72},{4,40},{60,40},{60,-39.9},{100.1,
          -39.9}}, color={0,0,127}));
  connect(Canteen.m_flow, measureBus.TBA_canteen) annotation (Line(points={{40,
          72},{46,72},{46,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,127}));
  connect(Workshop.m_flow, measureBus.TBA_workshop) annotation (Line(points={{
          80,72},{84,72},{84,40},{60,40},{60,-39.9},{100.1,-39.9}}, color={0,0,
          127}));
  connect(OpenPlanOffice.Power_pump, measureBus.Pump_TBA_openplanoffice)
    annotation (Line(points={{-80,76},{-74,76},{-74,40},{60,40},{60,-39.9},{
          100.1,-39.9}}, color={0,0,127}));
  connect(Conferenceroom.Power_pump, measureBus.Pump_TBA_conferenceroom)
    annotation (Line(points={{-40,76},{-36,76},{-36,40},{60,40},{60,-39.9},{
          100.1,-39.9}}, color={0,0,127}));
  connect(Multipersonoffice.Power_pump, measureBus.Pump_TBA_multipersonoffice)
    annotation (Line(points={{0,76},{4,76},{4,40},{60,40},{60,-39.9},{100.1,
          -39.9}}, color={0,0,127}));
  connect(Canteen.Power_pump, measureBus.Pump_TBA_canteen) annotation (Line(
        points={{40,76},{46,76},{46,40},{60,40},{60,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(Workshop.Power_pump, measureBus.Pump_TBA_workshop) annotation (Line(
        points={{80,76},{84,76},{84,40},{60,40},{60,-39.9},{100.1,-39.9}},
        color={0,0,127}));
  connect(OpenPlanOffice.Fluid_in_cold, Fluid_in_cold) annotation (Line(points=
          {{-96,60},{-96,10},{-96,-40},{-100,-40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_in_warm, Fluid_in_warm) annotation (Line(points=
          {{-92,60},{-92,60},{-92,26},{-100,26}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_warm, Fluid_out_warm) annotation (Line(
        points={{-88,60},{-88,60},{-88,-14},{-94,-14},{-94,-14},{-100,-14}},
        color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{-84,60},{-84,60},{-84,-80},{-100,-80}}, color={0,127,255}));
  connect(Conferenceroom.Fluid_in_cold, Fluid_in_cold) annotation (Line(points=
          {{-56,60},{-56,-40},{-100,-40}}, color={0,127,255}));
  connect(Conferenceroom.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{-44,60},{-44,60},{-44,-80},{-72,-80},{-72,-80},{-100,-80}},
        color={0,127,255}));
  connect(Multipersonoffice.Fluid_in_cold, Fluid_in_cold) annotation (Line(
        points={{-16,60},{-16,-40},{-100,-40}}, color={0,127,255}));
  connect(Multipersonoffice.Fluid_out_cold, Fluid_out_cold)
    annotation (Line(points={{-4,60},{-4,-80},{-100,-80}}, color={0,127,255}));
  connect(Canteen.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{24,60},{24,-40},{-100,-40}}, color={0,127,255}));
  connect(Canteen.Fluid_out_cold, Fluid_out_cold)
    annotation (Line(points={{36,60},{36,-80},{-100,-80}}, color={0,127,255}));
  connect(Workshop.Fluid_in_cold, Fluid_in_cold)
    annotation (Line(points={{64,60},{64,-40},{-100,-40}}, color={0,127,255}));
  connect(Workshop.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{76,
          60},{76,60},{76,-80},{-100,-80}}, color={0,127,255}));
  connect(Conferenceroom.Fluid_in_warm, Fluid_in_warm)
    annotation (Line(points={{-52,60},{-52,26},{-100,26}}, color={0,127,255}));
  connect(Multipersonoffice.Fluid_in_warm, Fluid_in_warm)
    annotation (Line(points={{-12,60},{-12,26},{-100,26}}, color={0,127,255}));
  connect(Canteen.Fluid_in_warm, Fluid_in_warm)
    annotation (Line(points={{28,60},{28,26},{-100,26}}, color={0,127,255}));
  connect(Workshop.Fluid_in_warm, Fluid_in_warm)
    annotation (Line(points={{68,60},{68,26},{-100,26}}, color={0,127,255}));
  connect(Conferenceroom.Fluid_out_warm, Fluid_out_warm) annotation (Line(
        points={{-48,60},{-48,-14},{-100,-14}}, color={0,127,255}));
  connect(Multipersonoffice.Fluid_out_warm, Fluid_out_warm)
    annotation (Line(points={{-8,60},{-8,-14},{-100,-14}}, color={0,127,255}));
  connect(Canteen.Fluid_out_warm, Fluid_out_warm)
    annotation (Line(points={{32,60},{32,-14},{-100,-14}}, color={0,127,255}));
  connect(Workshop.Fluid_out_warm, Fluid_out_warm)
    annotation (Line(points={{72,60},{72,-14},{-100,-14}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA_Heatexchanger_v2;
