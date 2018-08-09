within AixLib.Fluid.HydraulicModules;
model Injection "Injection circuit with pump and three way valve"
  extends AixLib.Fluid.Interfaces.PartialFourPort(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    final allowFlowReversal1=allowFlowReversal,
    final allowFlowReversal2=allowFlowReversal);
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  replaceable BaseClasses.BasicPumpInterface basicPumpInterface(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal) annotation (
    Dialog(group="Actuators"),
    choicesAllMatching=true,
    Placement(transformation(extent={{46,12},{62,28}})));

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  parameter Modelica.SIunits.Temperature T_amb "Ambient temperature";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";

  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume"
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation (Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors"
    annotation (Dialog(tab="Advanced"));


  AixLib.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    l={0.001,0.001},
    dpFixed_nominal={8000,8000},
    redeclare package Medium = Medium,
    T_start=T_start,
    init=Modelica.Blocks.Types.Init.NoInit,
    y_start=0.5,
    tau=0.2,
    Kv=10,
    final m_flow_nominal=m_flow_nominal) annotation (Dialog(enable=true, group="Actuators"),
      Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-40,-60})));

  BaseClasses.HydraulicBus hydraulicBus annotation (Placement(transformation(
          extent={{-20,80},{20,120}}), iconTransformation(extent={{-20,80},{20,118}})));
  FixedResistances.PlugFlowPipe pipe1(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-86,28},{-70,12}})));

  FixedResistances.PlugFlowPipe pipe2(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-20,20})));
  FixedResistances.PlugFlowPipe pipe3(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={34,20})));


  FixedResistances.PlugFlowPipe pipe4(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{70,28},{86,12}})));
  FixedResistances.PlugFlowPipe pipe5(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{70,-68},{54,-52}})));
  FixedResistances.PlugFlowPipe pipe7(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-60,-68},{-76,-52}})));
  FixedResistances.PlugFlowPipe pipe8(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true, group="Pipes"),
      Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-40,-12})));
  FixedResistances.PlugFlowPipe pipe9(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={20,-12})));
  FixedResistances.PlugFlowPipe pipe6(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{0,-68},{-16,-52}})));


  MixingVolumes.MixingVolume junc3v6(
    redeclare package Medium = Medium,
    T_start=T_start,
    final V=vol,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{14,-60},{26,-72}})));
  Modelica.Blocks.Sources.Constant const(k=T_amb)
    annotation (Placement(transformation(extent={{76,-20},{60,-4}})));

  // -------------------------------------------------
  // Sensors
  // -------------------------------------------------

protected
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_out(redeclare package Medium =
        Medium, final allowFlowReversal=allowFlowReversal)
    "Inflow into admix module" annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=270,
        origin={-100,40})));
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_in(redeclare package Medium =
        Medium, final allowFlowReversal=allowFlowReversal)
    "Inflow into consumer (out of module)" annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={100,38})));
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_injection(redeclare package
      Medium = Medium, final allowFlowReversal=allowFlowReversal)
    "Volume flow in injection line" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={0,20})));
  MixingVolumes.MixingVolume junc15j(
    redeclare package Medium = Medium,
    final V=vol,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-46,20},{-34,32}})));
  MixingVolumes.MixingVolume juncjp6(
    redeclare package Medium = Medium,
    final V=vol,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{14,20},{26,32}})));

  Sensors.TemperatureTwoPort senT_a1(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-100,14},{-88,26}})));
  Sensors.TemperatureTwoPort senT_b1(
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{88,14},{100,26}})));
  Sensors.TemperatureTwoPort senT_b2(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-80,-66},{-92,-54}})));
  Sensors.TemperatureTwoPort senT_a2(
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{86,-66},{74,-54}})));

  Modelica.Blocks.Continuous.FirstOrder PT1_a1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-70,70})));
  Modelica.Blocks.Continuous.FirstOrder PT1_b1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={70,70})));

  Modelica.Blocks.Continuous.FirstOrder PT1_b2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-110,-30})));

  Modelica.Blocks.Continuous.FirstOrder PT1_a2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={110,-30})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={42,-12})));


equation
  connect(pipe7.port_a, val.port_2)
    annotation (Line(points={{-60,-60},{-48,-60}}, color={0,127,255}));

  connect(val.y, hydraulicBus.valSet) annotation (Line(
      points={{-40,-69.6},{-40,-106},{-122,-106},{-122,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=true), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.V_flow, hydraulicBus.VF_in) annotation (Line(points={{-108.8,
          40},{-122,40},{-122,100},{-68,100},{-68,100.1},{0.1,100.1}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_in.V_flow, hydraulicBus.VF_out) annotation (Line(points={{108.8,
          38},{122,38},{122,100},{68,100},{68,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(port_a1, VFSen_out.port_a)
    annotation (Line(points={{-100,60},{-100,48}}, color={0,127,255}));
  connect(port_b1, VFSen_in.port_b)
    annotation (Line(points={{100,60},{100,46}}, color={0,127,255}));
  connect(basicPumpInterface.port_b, pipe4.port_a)
    annotation (Line(points={{62,20},{70,20}}, color={0,127,255}));
  connect(VFSen_injection.V_flow, hydraulicBus.VF_injection) annotation (Line(
        points={{0,28.8},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(val.y_actual, hydraulicBus.valSetAct) annotation (Line(
      points={{-44,-65.6},{-44,-106},{-122,-106},{-122,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=true), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(basicPumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{54,28},{54,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe2.ports_b[1], VFSen_injection.port_a)
    annotation (Line(points={{-12,20},{-8,20}}, color={0,127,255}));
  connect(val.port_1, pipe6.ports_b[1])
    annotation (Line(points={{-32,-60},{-16,-60}}, color={0,127,255}));
  connect(pipe8.ports_b[1], val.port_3)
    annotation (Line(points={{-40,-20},{-40,-52}}, color={0,127,255}));
  connect(pipe1.port_a, senT_a1.port_b)
    annotation (Line(points={{-86,20},{-88,20}}, color={0,127,255}));
  connect(senT_a1.port_a, VFSen_out.port_b)
    annotation (Line(points={{-100,20},{-100,32}}, color={0,127,255}));
  connect(senT_b1.port_a, pipe4.ports_b[1])
    annotation (Line(points={{88,20},{86,20}}, color={0,127,255}));
  connect(senT_b1.port_b, VFSen_in.port_a)
    annotation (Line(points={{100,20},{100,30}}, color={0,127,255}));
  connect(port_b2, senT_b2.port_b)
    annotation (Line(points={{-100,-60},{-92,-60}}, color={0,127,255}));
  connect(senT_b2.port_a, pipe7.ports_b[1])
    annotation (Line(points={{-80,-60},{-76,-60}}, color={0,127,255}));
  connect(pipe5.port_a, senT_a2.port_b)
    annotation (Line(points={{70,-60},{74,-60}}, color={0,127,255}));
  connect(senT_a2.port_a, port_a2)
    annotation (Line(points={{86,-60},{100,-60}}, color={0,127,255}));
  connect(senT_a1.T, PT1_a1.u) annotation (Line(points={{-94,26.6},{-82,26.6},{-82,
          58},{-70,58}}, color={0,0,127}));
  connect(PT1_a1.y, hydraulicBus.TFwrd_in) annotation (Line(points={{-70,81},{-70,
          100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_b1.T, PT1_b1.u) annotation (Line(points={{94,26.6},{86,26.6},{86,
          58},{70,58}}, color={0,0,127}));
  connect(PT1_b1.y, hydraulicBus.TFwrd_out) annotation (Line(points={{70,81},{70,
          100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PT1_b2.u, senT_b2.T) annotation (Line(points={{-98,-30},{-86,-30},{-86,
          -53.4}}, color={0,0,127}));
  connect(PT1_b2.y, hydraulicBus.TRtrn_out) annotation (Line(points={{-121,-30},
          {-122,-30},{-122,100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_a2.T, PT1_a2.u)
    annotation (Line(points={{80,-53.4},{80,-30},{98,-30}}, color={0,0,127}));
  connect(PT1_a2.y, hydraulicBus.TRtrn_in) annotation (Line(points={{121,-30},{130,
          -30},{130,100},{116,100},{116,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe7.heatPort, prescribedTemperature.port) annotation (Line(points={{
          -68,-52},{-68,-46},{34,-46},{34,-12}}, color={191,0,0}));
  connect(pipe2.heatPort, prescribedTemperature.port) annotation (Line(points={{
          -20,12},{-20,8},{34,8},{34,-12}}, color={191,0,0}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{
          -78,12},{-78,8},{34,8},{34,-12}}, color={191,0,0}));
  connect(pipe6.heatPort, prescribedTemperature.port) annotation (Line(points={{
          -8,-52},{-8,-46},{34,-46},{34,-12}}, color={191,0,0}));
  connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{
          62,-52},{62,-46},{34,-46},{34,-12}}, color={191,0,0}));
  connect(pipe4.heatPort, prescribedTemperature.port) annotation (Line(points={{
          78,12},{78,8},{34,8},{34,-12}}, color={191,0,0}));
  connect(const.y, prescribedTemperature.T)
    annotation (Line(points={{59.2,-12},{51.6,-12}}, color={0,0,127}));
  connect(pipe9.heatPort, prescribedTemperature.port)
    annotation (Line(points={{28,-12},{34,-12}}, color={191,0,0}));
  connect(pipe8.heatPort, pipe9.heatPort)
    annotation (Line(points={{-32,-12},{28,-12}}, color={191,0,0}));
  connect(pipe1.ports_b[1], junc15j.ports[1])
    annotation (Line(points={{-70,20},{-41.6,20}}, color={0,127,255}));
  connect(pipe8.port_a, junc15j.ports[2])
    annotation (Line(points={{-40,-4},{-40,-4},{-40,20}}, color={0,127,255}));
  connect(pipe2.port_a, junc15j.ports[3])
    annotation (Line(points={{-28,20},{-38.4,20}}, color={0,127,255}));
  connect(pipe9.port_a, juncjp6.ports[1])
    annotation (Line(points={{20,-4},{20,20},{18.4,20}}, color={0,127,255}));
  connect(VFSen_injection.port_b, juncjp6.ports[2])
    annotation (Line(points={{8,20},{20,20}}, color={0,127,255}));
  connect(pipe5.ports_b[1], junc3v6.ports[1])
    annotation (Line(points={{54,-60},{18.4,-60}}, color={0,127,255}));
  connect(pipe6.port_a, junc3v6.ports[2])
    annotation (Line(points={{0,-60},{20,-60}}, color={0,127,255}));
  connect(pipe9.ports_b[1], junc3v6.ports[3]) annotation (Line(points={{20,-20},
          {20,-40},{20,-60},{21.6,-60}}, color={0,127,255}));
  connect(juncjp6.ports[3], pipe3.port_a)
    annotation (Line(points={{21.6,20},{26,20}}, color={0,127,255}));
  connect(pipe3.ports_b[1], basicPumpInterface.port_a)
    annotation (Line(points={{42,20},{46,20}}, color={0,127,255}));
  connect(pipe3.heatPort, prescribedTemperature.port)
    annotation (Line(points={{34,12},{34,-12}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(initialScale=0.1), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Line(
          points={{-90,60},{-78,60},{-78,60},{90,60},{90,60},{100,60}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-40,60},{-40,-40}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-92,-60},{-84,-60},{-84,-60},{84,-60},{84,-60},{90,-60}},
          color={0,128,255},
          thickness=0.5),
        Polygon(
          points={{-66,-50},{-66,-50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-70},{-60,-50},{-40,-60},{-60,-70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-70},{-20,-50},{-40,-60},{-20,-70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,10},{-10,10},{0,-10},{10,10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-40,-50},
          rotation=0),
        Line(
          points={{-40,-60},{-40,-68}},
          color={95,95,95},
          thickness=0.5),
        Ellipse(
          extent={{-42,62},{-38,58}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{2,60},{2,-58}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{0,62},{4,58}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-58},{4,-62}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,80},{58,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{38,80},{58,60},{38,40}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-64,70},{-64,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,68},{-62,52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,68},{-62,52}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Ellipse(
          extent={{-78,84},{-62,68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,84},{-62,68}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{62,68},{78,52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,68},{78,52}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Ellipse(
          extent={{62,84},{78,68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,84},{78,68}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{-78,-38},{-62,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,-38},{-62,-54}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{-70,-54},{-70,-60}}, color={0,0,0}),
        Ellipse(
          extent={{62,-38},{78,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,-38},{78,-54}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{70,-54},{70,-60}}, color={0,0,0}),
        Ellipse(
          extent={{-28,68},{-12,52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-28,68},{-12,52}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Text(
          extent={{-16,-68},{82,-92}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Injection"),
        Ellipse(
          extent={{-46,-68},{-34,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-64,60},{-48,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{76,60},{92,42}},
          lineColor={135,135,135},
          textString="4"),
        Text(
          extent={{32,-42},{48,-60}},
          lineColor={135,135,135},
          textString="5"),
        Text(
          extent={{-92,-42},{-76,-60}},
          lineColor={135,135,135},
          textString="7"),
        Text(
          extent={{-42,10},{-26,-8}},
          lineColor={135,135,135},
          textString="8"),
        Text(
          extent={{0,10},{16,-8}},
          lineColor={135,135,135},
          textString="9"),
        Text(
          extent={{-16,60},{0,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{-20,-42},{-4,-60}},
          lineColor={135,135,135},
          textString="6"),
        Text(
          extent={{6,60},{22,42}},
          lineColor={135,135,135},
          textString="3")}),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)),
    Documentation(info="<html>
<p>Injection circuit with a replaceable pump model for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus.</p>
<h4><span style=\"color: #008000\">Characteristics</span></h4>
<p>When the valve is fully opened, the consumer module is plugged into the primary hydronic circuit whereas when the valve is fully closed, the consumer is isolated from the primary hydronic circuit</p>
<p>This model uses a pipe model to include the heat loss and insulation effects</p>
</html>", revisions="<html>
<ul>
<li>Mai 30, 2018, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib</li>
<li>2017-07-25 by Peter Matthes:<br/>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li><i>March,2016&nbsp;</i> by Rohit Lad:<br/>Implemented</li>
</ul>
</html>"));
end Injection;
