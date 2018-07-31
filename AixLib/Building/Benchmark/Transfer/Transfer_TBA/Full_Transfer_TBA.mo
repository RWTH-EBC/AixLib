within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model Full_Transfer_TBA
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  TBA_Pipe OpenPlanOffice(wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{48,60},{68,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,16},{-90,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-24},{-90,-4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
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
  TBA_Pipe OpenPlanOffice1(
                          wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  TBA_Pipe OpenPlanOffice2(
                          wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  TBA_Pipe OpenPlanOffice3(
                          wall_length=40, wall_height=30)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  TBA_Pipe OpenPlanOffice4(
                          wall_length=40, wall_height=30)
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
equation
  connect(OpenPlanOffice.Fluid_in, Valve_WarmCold_Workshop_1.port_2)
    annotation (Line(points={{52,60},{52,32}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.port_3, Fluid_in_warm)
    annotation (Line(points={{46,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_1.port_1, Fluid_in_cold)
    annotation (Line(points={{52,20},{52,-40},{-100,-40}}, color={0,127,255}));
  connect(OpenPlanOffice.HeatPort_TBA_OpenPlanOffice, HeatPort_TBA) annotation (
     Line(points={{58,80},{58,88},{0,88},{0,100}}, color={191,0,0}));
  connect(OpenPlanOffice.Fluid_out, Valve_WarmCold_Workshop_2.port_2)
    annotation (Line(points={{64,60},{64,-8}}, color={0,127,255}));
  connect(Valve_WarmCold_Canteen_1.port_2, OpenPlanOffice1.Fluid_in)
    annotation (Line(points={{24,24},{24,60}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_2, OpenPlanOffice2.Fluid_in)
    annotation (Line(points={{-6,24},{-6,60}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_2, OpenPlanOffice3.Fluid_in)
    annotation (Line(points={{-36,24},{-36,60}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_2, OpenPlanOffice4.Fluid_in)
    annotation (Line(points={{-64,24},{-64,60}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_2.port_3, Fluid_out_warm)
    annotation (Line(points={{58,-14},{-100,-14}}, color={0,127,255}));
  connect(Valve_WarmCold_Workshop_2.port_1, Fluid_out_cold) annotation (Line(
        points={{64,-20},{64,-80},{-100,-80}}, color={0,127,255}));
  connect(OpenPlanOffice1.Fluid_out, Valve_WarmCold_Canteen_2.port_2)
    annotation (Line(points={{36,60},{36,4}}, color={0,127,255}));
  connect(OpenPlanOffice4.Fluid_out, Valve_WarmCold_OpenPlanOffice_2.port_2)
    annotation (Line(points={{-52,60},{-52,4}}, color={0,127,255}));
  connect(OpenPlanOffice3.Fluid_out, Valve_WarmCold_ConferenceRoom_2.port_2)
    annotation (Line(points={{-24,60},{-24,4}}, color={0,127,255}));
  connect(OpenPlanOffice2.Fluid_out, Valve_WarmCold_MultiPersonOffice_2.port_2)
    annotation (Line(points={{6,60},{6,4}}, color={0,127,255}));
  connect(Valve_WarmCold_OpenPlanOffice_1.port_3, Fluid_in_warm) annotation (
      Line(points={{-70,18},{-72,18},{-72,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_ConferenceRoom_1.port_3, Fluid_in_warm) annotation (
      Line(points={{-42,18},{-44,18},{-44,26},{-100,26}}, color={0,127,255}));
  connect(Valve_WarmCold_MultiPersonOffice_1.port_3, Fluid_in_warm) annotation
    (Line(points={{-12,18},{-14,18},{-14,26},{-100,26}}, color={0,127,255}));
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Full_Transfer_TBA;
