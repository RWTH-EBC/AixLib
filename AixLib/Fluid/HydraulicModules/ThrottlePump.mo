within AixLib.Fluid.HydraulicModules;
model ThrottlePump "Throttle circuit with pump and two way valve"
  extends AixLib.Fluid.Interfaces.PartialFourPort(redeclare package Medium1 =
        Medium, redeclare package Medium2 = Medium);
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  parameter  Modelica.SIunits.Temperature T_amb "Ambient temperature";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));

  replaceable BaseClasses.BasicPumpInterface basicPumpInterface(redeclare
      package Medium = Medium)
    annotation (Dialog(group="Actuators"), choicesAllMatching=true, Placement(transformation(extent={{32,12},
            {48,28}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    dpValve_nominal=8000,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv)
                          annotation (Dialog(enable=true,group="Actuators"), Placement(
        transformation(extent={{-36,10},{-16,30}})));
  AixLib.Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}}),
        iconTransformation(extent={{-20,80},{20,120}})));
  FixedResistances.PlugFlowPipe
                        pipe1(redeclare package Medium = Medium,
    dh=0.032,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-80,30},{
            -60,10}})));

  FixedResistances.PlugFlowPipe
                        pipe2(redeclare package Medium = Medium,
    dh=0.032,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028)
    annotation (Dialog(enable=true), Placement(transformation(extent={{0,30},{20,
            10}})));

  FixedResistances.PlugFlowPipe
                        pipe3(redeclare package Medium = Medium,
    dh=0.032,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final m_flow_nominal=m_flow_nominal,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028)
    annotation (Dialog(enable=true), Placement(transformation(extent={{60,30},{80,
            10}})));
  FixedResistances.PlugFlowPipe
                        pipe4(redeclare package Medium = Medium,
    dh=0.032,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final m_flow_nominal=m_flow_nominal,
    final v_nominal=1.5,
    dIns=0.01,
    kIns=0.028)
    annotation (Dialog(enable=true), Placement(transformation(extent={{10,-70},{
            -10,-50}})));
  Modelica.Blocks.Sources.Constant const(k=T_amb)
    annotation (Placement(transformation(extent={{40,-28},{24,-12}})));


  // -------------------------------------------------
  // Sensors
  // -------------------------------------------------


protected
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_out(redeclare package Medium =
        Medium) "Inflow into module in forward line" annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={-100,40})));
  Sensors.TemperatureTwoPort senT_a1(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-100,14},{-88,26}})));
  Sensors.TemperatureTwoPort senT_b1(
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb)
    annotation (Placement(transformation(extent={{88,14},{100,26}})));
  Sensors.TemperatureTwoPort senT_a2(
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final T_start=T_start)
    annotation (Placement(transformation(extent={{84,-66},{72,-54}})));
  Sensors.TemperatureTwoPort senT_b2(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-78,-66},{-90,-54}})));
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
        origin={8,-20})));

equation
  connect(val.port_b,pipe2. port_a)
    annotation (Line(points={{-16,20},{0,20}},     color={0,127,255}));
  connect(val.y, hydraulicBus.valveSet) annotation (Line(points={{-26,32},{-26,100},
          {0,100}},                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.V_flow, hydraulicBus.VF_out) annotation (Line(points={{-106.6,
          40},{-106.6,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(port_a1,VFSen_out.port_a)
    annotation (Line(points={{-100,60},{-100,46}},color={0,127,255}));
  connect(basicPumpInterface.port_b,pipe3. port_a)
    annotation (Line(points={{48,20},{60,20}},   color={0,127,255}));
  connect(val.y_actual, hydraulicBus.valveSetAct) annotation (Line(points={{-21,27},
          {-21,100},{0,100}},           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(basicPumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{40,28},{40,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.port_b, senT_a1.port_a)
    annotation (Line(points={{-100,34},{-100,20}}, color={0,127,255}));
  connect(senT_a1.port_b, pipe1.port_a)
    annotation (Line(points={{-88,20},{-80,20}}, color={0,127,255}));
  connect(pipe1.ports_b[1], val.port_a)
    annotation (Line(points={{-60,20},{-36,20}}, color={0,127,255}));
  connect(pipe2.ports_b[1], basicPumpInterface.port_a)
    annotation (Line(points={{20,20},{32,20}}, color={0,127,255}));
  connect(pipe3.ports_b[1], senT_b1.port_a)
    annotation (Line(points={{80,20},{88,20}}, color={0,127,255}));
  connect(senT_b1.port_b, port_b1)
    annotation (Line(points={{100,20},{100,60}}, color={0,127,255}));
  connect(senT_a2.port_a, port_a2)
    annotation (Line(points={{84,-60},{100,-60}}, color={0,127,255}));
  connect(senT_a2.port_b, pipe4.port_a)
    annotation (Line(points={{72,-60},{10,-60}}, color={0,127,255}));
  connect(pipe4.ports_b[1], senT_b2.port_a)
    annotation (Line(points={{-10,-60},{-78,-60}}, color={0,127,255}));
  connect(senT_b2.port_b, port_b2)
    annotation (Line(points={{-90,-60},{-100,-60}}, color={0,127,255}));
  connect(senT_a1.T,PT1_a1. u) annotation (Line(points={{-94,26.6},{-82,26.6},{-82,
          58},{-70,58}}, color={0,0,127}));
  connect(PT1_a1.y, hydraulicBus.TFwrd_in) annotation (Line(points={{-70,81},{-70,
          100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_b1.T,PT1_b1. u) annotation (Line(points={{94,26.6},{86,26.6},{86,
          58},{70,58}}, color={0,0,127}));
  connect(PT1_b1.y, hydraulicBus.TFwrd_out) annotation (Line(points={{70,81},{70,
          100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PT1_b2.u, senT_b2.T) annotation (Line(points={{-98,-30},{-84,-30},{-84,
          -53.4}}, color={0,0,127}));
  connect(PT1_b2.y, hydraulicBus.TRtrn_out) annotation (Line(points={{-121,-30},
          {-122,-30},{-122,100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_a2.T,PT1_a2. u)
    annotation (Line(points={{78,-53.4},{78,-30},{98,-30}}, color={0,0,127}));
  connect(PT1_a2.y, hydraulicBus.TRtrn_in) annotation (Line(points={{121,-30},{120,
          -30},{120,100},{106,100},{106,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe2.heatPort,prescribedTemperature. port)
    annotation (Line(points={{10,10},{10,2},{0,2},{0,-20}},
                                              color={191,0,0}));
  connect(pipe1.heatPort,prescribedTemperature. port) annotation (Line(points={{-70,10},
          {-70,2},{0,2},{0,-20}},         color={191,0,0}));
  connect(pipe4.heatPort,prescribedTemperature. port)
    annotation (Line(points={{0,-50},{0,-50},{0,-20}},  color={191,0,0}));
  connect(pipe3.heatPort,prescribedTemperature. port) annotation (Line(points={{70,10},
          {70,2},{0,2},{0,-20}},                            color={191,0,0}));
  connect(const.y,prescribedTemperature. T)
    annotation (Line(points={{23.2,-20},{17.6,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-86,-68},{86,-94}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="ThrottlePump"),
        Line(
          points={{-90,60},{-84,60},{-84,60},{84,60},{84,60},{90,60}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{10,80},{50,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{30,80},{50,60},{30,40}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-50,50},{-50,70},{-30,60},{-50,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,50},{-10,70},{-30,60},{-10,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,80},{-24,68}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,68},{-30,60}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{-90,-60},{-84,-60},{-84,-60},{84,-60},{84,-60},{90,-60}},
          color={0,128,255},
          thickness=0.5),
        Polygon(
          points={{-60,70},{-60,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
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
          extent={{-78,82},{-62,66}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,82},{-62,66}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{-70,66},{-70,60}},
                                       color={0,0,0}),
        Text(
          extent={{-78,60},{-62,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{-6,60},{10,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{50,60},{66,42}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{-8,-42},{8,-60}},
          lineColor={135,135,135},
          textString="4")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
          initialScale=0.1)),
    Documentation(revisions="<html>
<ul>
<li>Mai 30, 2018, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib</li>
<li>2017-07-25 by Peter Matthes:<br/>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li>2017-06 by Alexander K&uuml;mpel:<br/>Implemented</li>
</ul>
</html>", info="<html>
<p>Throttle circuit with a replaceable pump model and a valve for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus.</p>
<h4><span style=\"color: #008c48\">Characteristics</span></h4>
<p>The volume flow depends on the valve opening and the pump speed. If the pump is switched of or the valve is completly closed, there is no volume flow (except leackage).</p>
<p>This model uses a pipe model to include the heat loss and insulation effects.</p>
</html>"));
end ThrottlePump;
