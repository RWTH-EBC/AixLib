within AixLib.Systems.HydraulicModules;
model Admix "Admix circuit with three way valve and rpm controlled pump"
  extends AixLib.Fluid.Interfaces.PartialFourPort(redeclare package Medium1 =
        Medium, redeclare package Medium2 = Medium, final allowFlowReversal1 = allowFlowReversal, final allowFlowReversal2 = allowFlowReversal);
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  replaceable BaseClasses.BasicPumpInterface basicPumpInterface(redeclare
      package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal)
    annotation (Dialog(group="Actuators"), choicesAllMatching=true, Placement(transformation(extent={{22,12},
            {38,28}})));

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter  Modelica.SIunits.Temperature T_amb "Ambient temperature";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";

  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));

  AixLib.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    l={0.001,0.001},
    dpFixed_nominal={8000,8000},
    redeclare package Medium = Medium,
    T_start=T_start,
    init=Modelica.Blocks.Types.Init.NoInit,
    y_start=0.5,
    tau=0.2,
    final m_flow_nominal=m_flow_nominal)
             annotation (Dialog(enable=true,group="Actuators"), Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,20})));

  BaseClasses.HydraulicBus hydraulicBus annotation (Placement(transformation(
          extent={{-20,80},{20,120}}), iconTransformation(extent={{-20,80},{20,120}})));
  Fluid.FixedResistances.PlugFlowPipe pipe1(
    redeclare final package Medium = Medium,
    nPorts=1,
    dh=0.032,
    T_start_in=T_start,
    T_start_out=T_start,
    final m_flow_nominal=m_flow_nominal,
    final v_nominal=1,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-80,28},{-64,12}})));
  Fluid.FixedResistances.PlugFlowPipe pipe2(
    redeclare final package Medium = Medium,
    nPorts=1,
    dh=0.032,
    T_start_in=T_start,
    T_start_out=T_start,
    final m_flow_nominal=m_flow_nominal,
    final v_nominal=1,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-8,28},{8,12}})));
  Fluid.FixedResistances.PlugFlowPipe pipe3(
    redeclare final package Medium = Medium,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    dh=0.032,
    final m_flow_nominal=m_flow_nominal,
    final v_nominal=1,
    dIns=0.01,
    kIns=0.028,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{60,28},{76,12}})));
  Fluid.FixedResistances.PlugFlowPipe pipe4(
    redeclare final package Medium = Medium,
    dh=0.032,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final v_nominal=1,
    dIns=0.01,
    kIns=0.028,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={32,-60})));
  Fluid.FixedResistances.PlugFlowPipe pipe5(
    redeclare final package Medium = Medium,
    T_start_in=T_start,
    T_start_out=T_start,
    dh=0.032,
    nPorts=1,
    final v_nominal=1,
    dIns=0.01,
    kIns=0.028,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={-58,-60})));
  Fluid.FixedResistances.PlugFlowPipe pipe6(
    redeclare final package Medium = Medium,
    dh=0.032,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final m_flow_nominal=m_flow_nominal,
    final v_nominal=1,
    final allowFlowReversal=allowFlowReversal) annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={-30,-20})));
  Fluid.MixingVolumes.MixingVolume junc456(
    redeclare package Medium = Medium,
    T_start=T_start,
    nPorts=3,
    final m_flow_nominal=m_flow_nominal,
    final V=vol)
    annotation (Placement(transformation(extent={{-38,-60},{-22,-76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={8,-20})));

  Modelica.Blocks.Sources.Constant const(k=T_amb)
    annotation (Placement(transformation(extent={{40,-28},{24,-12}})));

  // -------------------------------------------------
  // Sensors
  // -------------------------------------------------
protected
  Fluid.Sensors.VolumeFlowRate VFSen_out(
    redeclare package Medium = Medium,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    "Inflow into admix module in forward line" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-100,40})));
  Fluid.Sensors.VolumeFlowRate VFSen_in(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal) "Outflow out of forward line"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={100,42})));

  Fluid.Sensors.TemperatureTwoPort senT_a1(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-100,14},{-88,26}})));
  Fluid.Sensors.TemperatureTwoPort senT_a2(
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{84,-66},{72,-54}})));
  Fluid.Sensors.TemperatureTwoPort senT_b1(
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{88,14},{100,26}})));
  Fluid.Sensors.TemperatureTwoPort senT_b2(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-78,-66},{-90,-54}})));

  Modelica.Blocks.Continuous.FirstOrder PT1_b2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-110,-30})));
  Modelica.Blocks.Continuous.FirstOrder PT1_b1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={70,70})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-70,70})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={110,-30})));

equation

  connect(val.port_2, pipe2.port_a)
    annotation (Line(points={{-20,20},{-8,20}},    color={0,127,255}));
  connect(VFSen_out.V_flow, hydraulicBus.VF_in) annotation (Line(
      points={{-111,40},{-112,40},{-112,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=true), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_in.V_flow, hydraulicBus.VF_out) annotation (Line(
      points={{111,42},{116,42},{116,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=true), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.port_a, port_a1)
    annotation (Line(points={{-100,50},{-100,60}}, color={0,127,255}));
  connect(VFSen_in.port_b, port_b1)
    annotation (Line(points={{100,52},{100,60}}, color={0,127,255}));
  connect(val.y, hydraulicBus.valSet) annotation (Line(points={{-30,32},{-30,
          100},{-14,100},{-14,100.1},{0.1,100.1}},
                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(val.y_actual, hydraulicBus.valSetAct) annotation (Line(points={{-25,27},
          {-25,100.5},{0.1,100.5},{0.1,100.1}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(basicPumpInterface.port_b, pipe3.port_a)
    annotation (Line(points={{38,20},{60,20}},    color={0,127,255}));
  connect(basicPumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{30,28},{30,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe1.ports_b[1], val.port_1)
    annotation (Line(points={{-64,20},{-40,20}}, color={0,127,255}));
  connect(pipe2.ports_b[1], basicPumpInterface.port_a)
    annotation (Line(points={{8,20},{22,20}}, color={0,127,255}));
  connect(pipe6.ports_b[1], val.port_3)
    annotation (Line(points={{-30,-12},{-30,10}}, color={0,127,255}));
  connect(pipe6.heatPort, prescribedTemperature.port)
    annotation (Line(points={{-22,-20},{0,-20}}, color={191,0,0}));
  connect(pipe2.heatPort, prescribedTemperature.port)
    annotation (Line(points={{0,12},{0,-20}}, color={191,0,0}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-72,12},
          {-72,2},{0,2},{0,-20}},         color={191,0,0}));
  connect(pipe5.heatPort, prescribedTemperature.port)
    annotation (Line(points={{-58,-52},{0,-52},{0,-20}}, color={191,0,0}));
  connect(pipe4.heatPort, prescribedTemperature.port)
    annotation (Line(points={{32,-52},{0,-52},{0,-20}}, color={191,0,0}));
  connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{68,12},
          {68,2},{0,2},{0,-20}},                            color={191,0,0}));
  connect(port_b2, senT_b2.port_b)
    annotation (Line(points={{-100,-60},{-90,-60}}, color={0,127,255}));
  connect(VFSen_out.port_b, senT_a1.port_a) annotation (Line(points={{-100,30},{
          -100,20}},                  color={0,127,255}));
  connect(pipe1.port_a, senT_a1.port_b)
    annotation (Line(points={{-80,20},{-88,20}}, color={0,127,255}));
  connect(pipe3.ports_b[1], senT_b1.port_a)
    annotation (Line(points={{76,20},{88,20}}, color={0,127,255}));
  connect(senT_b1.port_b, VFSen_in.port_a)
    annotation (Line(points={{100,20},{100,32}}, color={0,127,255}));
  connect(pipe4.port_a, senT_a2.port_b)
    annotation (Line(points={{40,-60},{72,-60}}, color={0,127,255}));
  connect(senT_a2.port_a, port_a2) annotation (Line(points={{84,-60},{92,-60},{92,
          -60},{100,-60}}, color={0,127,255}));
  connect(PT1_b2.u, senT_b2.T) annotation (Line(points={{-98,-30},{-84,-30},{-84,
          -53.4}}, color={0,0,127}));
  connect(senT_a1.T, PT1_a1.u) annotation (Line(points={{-94,26.6},{-82,26.6},{-82,
          58},{-70,58}}, color={0,0,127}));
  connect(senT_b1.T, PT1_b1.u) annotation (Line(points={{94,26.6},{86,26.6},{86,
          58},{70,58}}, color={0,0,127}));
  connect(PT1_b1.y, hydraulicBus.TFwrd_out) annotation (Line(points={{70,81},{70,
          100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PT1_a1.y, hydraulicBus.TFwrd_in) annotation (Line(points={{-70,81},{-70,
          100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PT1_b2.y, hydraulicBus.TRtrn_out) annotation (Line(points={{-121,-30},
          {-122,-30},{-122,100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_a2.T, PT1_a2.u)
    annotation (Line(points={{78,-53.4},{78,-30},{98,-30}}, color={0,0,127}));
  connect(PT1_a2.y, hydraulicBus.TRtrn_in) annotation (Line(points={{121,-30},{130,
          -30},{130,100},{116,100},{116,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe5.port_a, junc456.ports[1])
    annotation (Line(points={{-50,-60},{-32.1333,-60}}, color={0,127,255}));
  connect(pipe6.port_a, junc456.ports[2]) annotation (Line(points={{-30,-28},{-30,
          -60}},           color={0,127,255}));
  connect(pipe4.ports_b[1], junc456.ports[3])
    annotation (Line(points={{24,-60},{-27.8667,-60}}, color={0,127,255}));
  connect(const.y, prescribedTemperature.T)
    annotation (Line(points={{23.2,-20},{17.6,-20}}, color={0,0,127}));
  connect(senT_b2.port_a, pipe5.ports_b[1])
    annotation (Line(points={{-78,-60},{-66,-60}}, color={0,127,255}));
  annotation (
    Documentation(info="<html>
<p>Admix circuit with a replaceable pump model for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus.</p>
<h4>Characteristics</h4>
<p>There is a connecting pipe between distributer and collector of manifold so that the pressure difference between them becomes insignificant. The main pump only works against the resistance in the main circuit.</p>
<p>The mass flow in primary and secondary circuits stay constant.</p>
<p>The scondary circuits do not affect each other when switching operational modes.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib</li>
<li>July 25, 2017 by Peter Matthes:<br/>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li>February 6, 2016, by Peter Matthes:<br/>implemented bus-connector-C_H_HRMI_01 model for testing (extends from model with standard data ports)</li>
</ul>
</html>"),
    experiment(StopTime=86400),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-70,-64},{60,-94}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Admix"),
        Line(
          points={{0,100}},
          color={95,95,95},
          thickness=0.5),
        Polygon(
          points={{-60,70},{-60,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,60},{-84,60},{-84,60},{84,60},{88,60},{90,60}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{6,80},{46,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{26,80},{46,60},{26,40}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-52,50},{-52,70},{-32,60},{-52,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,50},{-12,70},{-32,60},{-12,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,-10},{-10,-10},{0,10},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-32,50},
          rotation=0),
        Ellipse(
          extent={{-38,80},{-26,68}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-32,68},{-32,60}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{-90,-60},{-84,-60},{-82,-60},{84,-60},{84,-60},{90,-60}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-32,40},{-32,-58}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{-34,-58},{-30,-62}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
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
        Text(
          extent={{-92,60},{-76,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{-12,60},{4,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{48,60},{64,42}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{18,-42},{34,-60}},
          lineColor={135,135,135},
          textString="4"),
        Text(
          extent={{-60,-42},{-44,-60}},
          lineColor={135,135,135},
          textString="5"),
        Text(
          extent={{-34,10},{-18,-8}},
          lineColor={135,135,135},
          textString="6")}),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)));
end Admix;
