within AixLib.Building.Benchmark.Transfer.Transfer_RLT;
model Full_Transfer_RLT
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  RLT Workshop annotation (Placement(transformation(extent={{60,72},{80,52}})));
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
    annotation (Placement(transformation(extent={{82,-20},{122,20}})));
  RLT Canteen annotation (Placement(transformation(extent={{32,72},{52,52}})));
  RLT MultiPersonOffice
    annotation (Placement(transformation(extent={{4,72},{24,52}})));
  RLT ConferenceRoom
    annotation (Placement(transformation(extent={{-24,72},{-4,52}})));
  RLT OpenPlanOffice
    annotation (Placement(transformation(extent={{-52,72},{-32,52}})));
  RLT Central annotation (Placement(transformation(extent={{-78,72},{-58,52}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Hot_Central(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-72,20})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Hot_OpenPlanOffice(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-46,20})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Hot_ConferenceRoom(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-18,20})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Hot_MultiPersonOffice(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={10,20})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Hot_Canteen(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={38,20})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Cold_Central(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-60,-40})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Cold_OpenPlanOffce(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-34,-40})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Cold_ConferenceRoom(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-6,-40})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Cold_MultiPersonOffice(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={22,-40})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve_RLT_Cold_Canteen(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={50,-40})));
equation
  connect(Air_in, Central.Air_in) annotation (Line(points={{-40,100},{-40,80},{
          -77.8,80},{-77.8,68.6}}, color={0,127,255}));
  connect(Central.Air_out, OpenPlanOffice.Air_in) annotation (Line(points={{-58,
          68.6},{-56,68.6},{-56,68.6},{-51.8,68.6}}, color={0,127,255}));
  connect(ConferenceRoom.Air_in, OpenPlanOffice.Air_in) annotation (Line(points
        ={{-23.8,68.6},{-28,68.6},{-28,74},{-56,74},{-56,68.6},{-51.8,68.6}},
        color={0,127,255}));
  connect(MultiPersonOffice.Air_in, OpenPlanOffice.Air_in) annotation (Line(
        points={{4.2,68.6},{0,68.6},{0,74},{-56,74},{-56,68.6},{-51.8,68.6}},
        color={0,127,255}));
  connect(Canteen.Air_in, OpenPlanOffice.Air_in) annotation (Line(points={{32.2,
          68.6},{28,68.6},{28,74},{-56,74},{-56,68.6},{-51.8,68.6}}, color={0,
          127,255}));
  connect(Workshop.Air_in, OpenPlanOffice.Air_in) annotation (Line(points={{
          60.2,68.6},{56,68.6},{56,74},{-56,74},{-56,68.6},{-51.8,68.6}}, color
        ={0,127,255}));
  connect(OpenPlanOffice.Air_out, Air_out[1]) annotation (Line(points={{-32,
          68.6},{-32,80},{40,80},{40,92}}, color={0,127,255}));
  connect(ConferenceRoom.Air_out, Air_out[2]) annotation (Line(points={{-4,68.6},
          {-4,80},{40,80},{40,96}}, color={0,127,255}));
  connect(MultiPersonOffice.Air_out, Air_out[3]) annotation (Line(points={{24,
          68.6},{24,80},{40,80},{40,100}}, color={0,127,255}));
  connect(Canteen.Air_out, Air_out[4]) annotation (Line(points={{52,68.6},{52,
          80},{40,80},{40,104}}, color={0,127,255}));
  connect(Workshop.Air_out, Air_out[5]) annotation (Line(points={{80,68.6},{80,
          80},{40,80},{40,108}}, color={0,127,255}));
  connect(Valve_RLT_Hot_Central.port_3, Central.Fluid_in_warm)
    annotation (Line(points={{-72,26},{-72,52}}, color={0,127,255}));
  connect(Fluid_in_hot, Valve_RLT_Hot_Central.port_2) annotation (Line(points={
          {-100,80},{-88,80},{-88,20},{-78,20}}, color={0,127,255}));
  connect(Valve_RLT_Hot_OpenPlanOffice.port_3, OpenPlanOffice.Fluid_in_warm)
    annotation (Line(points={{-46,26},{-46,52}}, color={0,127,255}));
  connect(Valve_RLT_Hot_ConferenceRoom.port_3, ConferenceRoom.Fluid_in_warm)
    annotation (Line(points={{-18,26},{-18,52}}, color={0,127,255}));
  connect(Valve_RLT_Hot_MultiPersonOffice.port_3, MultiPersonOffice.Fluid_in_warm)
    annotation (Line(points={{10,26},{10,52}}, color={0,127,255}));
  connect(Valve_RLT_Hot_Canteen.port_3, Canteen.Fluid_in_warm)
    annotation (Line(points={{38,26},{38,52}}, color={0,127,255}));
  connect(Valve_RLT_Hot_Canteen.port_1, Workshop.Fluid_in_warm)
    annotation (Line(points={{44,20},{66,20},{66,52}}, color={0,127,255}));
  connect(Valve_RLT_Hot_MultiPersonOffice.port_1, Valve_RLT_Hot_Canteen.port_2)
    annotation (Line(points={{16,20},{32,20}}, color={0,127,255}));
  connect(Valve_RLT_Hot_ConferenceRoom.port_1, Valve_RLT_Hot_MultiPersonOffice.port_2)
    annotation (Line(points={{-12,20},{4,20}}, color={0,127,255}));
  connect(Valve_RLT_Hot_OpenPlanOffice.port_1, Valve_RLT_Hot_ConferenceRoom.port_2)
    annotation (Line(points={{-40,20},{-24,20}}, color={0,127,255}));
  connect(Valve_RLT_Hot_Central.port_1, Valve_RLT_Hot_OpenPlanOffice.port_2)
    annotation (Line(points={{-66,20},{-52,20}}, color={0,127,255}));
  connect(Central.Fluid_out_warm, Fluid_out_hot)
    annotation (Line(points={{-76,52},{-76,40},{-100,40}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_warm, Fluid_out_hot)
    annotation (Line(points={{-50,52},{-50,40},{-100,40}}, color={0,127,255}));
  connect(ConferenceRoom.Fluid_out_warm, Fluid_out_hot)
    annotation (Line(points={{-22,52},{-22,40},{-100,40}}, color={0,127,255}));
  connect(MultiPersonOffice.Fluid_out_warm, Fluid_out_hot)
    annotation (Line(points={{6,52},{6,40},{-100,40}}, color={0,127,255}));
  connect(Canteen.Fluid_out_warm, Fluid_out_hot)
    annotation (Line(points={{34,52},{34,40},{-100,40}}, color={0,127,255}));
  connect(Workshop.Fluid_out_warm, Fluid_out_hot)
    annotation (Line(points={{62,52},{62,40},{-100,40}}, color={0,127,255}));
  connect(Valve_RLT_Cold_MultiPersonOffice.port_1, Valve_RLT_Cold_Canteen.port_2)
    annotation (Line(points={{28,-40},{44,-40}}, color={0,127,255}));
  connect(Valve_RLT_Cold_ConferenceRoom.port_1,
    Valve_RLT_Cold_MultiPersonOffice.port_2)
    annotation (Line(points={{0,-40},{16,-40}}, color={0,127,255}));
  connect(Valve_RLT_Cold_OpenPlanOffce.port_1, Valve_RLT_Cold_ConferenceRoom.port_2)
    annotation (Line(points={{-28,-40},{-12,-40}}, color={0,127,255}));
  connect(Valve_RLT_Cold_Central.port_1, Valve_RLT_Cold_OpenPlanOffce.port_2)
    annotation (Line(points={{-54,-40},{-48,-40},{-48,-40},{-42,-40},{-42,-40},
          {-40,-40}}, color={0,127,255}));
  connect(Valve_RLT_Cold_Central.port_3, Central.Fluid_in_cold)
    annotation (Line(points={{-60,-34},{-60,52}}, color={0,127,255}));
  connect(Valve_RLT_Cold_OpenPlanOffce.port_3, OpenPlanOffice.Fluid_in_cold)
    annotation (Line(points={{-34,-34},{-34,52}}, color={0,127,255}));
  connect(Valve_RLT_Cold_ConferenceRoom.port_3, ConferenceRoom.Fluid_in_cold)
    annotation (Line(points={{-6,-34},{-6,52}}, color={0,127,255}));
  connect(Valve_RLT_Cold_MultiPersonOffice.port_3, MultiPersonOffice.Fluid_in_cold)
    annotation (Line(points={{22,-34},{22,52}}, color={0,127,255}));
  connect(Valve_RLT_Cold_Canteen.port_3, Canteen.Fluid_in_cold)
    annotation (Line(points={{50,-34},{50,52}}, color={0,127,255}));
  connect(Valve_RLT_Cold_Central.port_2, Fluid_in_cold)
    annotation (Line(points={{-66,-40},{-100,-40}}, color={0,127,255}));
  connect(Valve_RLT_Cold_Canteen.port_1, Workshop.Fluid_in_cold)
    annotation (Line(points={{56,-40},{78,-40},{78,52}}, color={0,127,255}));
  connect(Central.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{-64,
          52},{-64,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  connect(OpenPlanOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{-38,52},{-38,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,
          255}));
  connect(ConferenceRoom.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{-10,52},{-10,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,
          255}));
  connect(MultiPersonOffice.Fluid_out_cold, Fluid_out_cold) annotation (Line(
        points={{18,52},{18,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  connect(Canteen.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{46,
          52},{46,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  connect(Workshop.Fluid_out_cold, Fluid_out_cold) annotation (Line(points={{74,
          52},{74,0},{-80,0},{-80,-80},{-100,-80}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_RLT;
