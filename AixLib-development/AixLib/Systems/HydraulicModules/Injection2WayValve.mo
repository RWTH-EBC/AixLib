within AixLib.Systems.HydraulicModules;
model Injection2WayValve
  "Injection circuit with pump and two way valve"
  extends AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule;

      replaceable BaseClasses.BasicPumpInterface PumpInterface(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal)
                                        "Needs to be redeclared" annotation (
    Dialog(group="Actuators"),
    choicesAllMatching=true,
    Placement(transformation(extent={{42,12},{58,28}})));
  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume"  annotation(Dialog(tab="Advanced"));


  Fluid.Actuators.Valves.TwoWayLinear valve(
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    Kv=Kv) annotation (Dialog(enable=true, group="Actuators"), Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-42,-60})));

  Fluid.FixedResistances.PlugFlowPipe pipe1(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final v_nominal=1.5,
    nPorts=1,
    final allowFlowReversal=allowFlowReversal,
    dh=d,
    dIns=dIns,
    kIns=kIns,
    final R=1/(pipe1.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe1.dh/2
         + pipe1.dIns)/(pipe1.dh/2))),
    length=length)                             annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-40,28},{-24,12}})));
  Fluid.FixedResistances.PlugFlowPipe pipe2(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final v_nominal=1.5,
    nPorts=1,
    final allowFlowReversal=allowFlowReversal,
    dh=d,
    dIns=dIns,
    kIns=kIns,
    final R=1/(pipe2.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe2.dh/2
         + pipe2.dIns)/(pipe2.dh/2))),
    length=length)                             annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{16,28},{32,12}})));

  Fluid.FixedResistances.PlugFlowPipe pipe3(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    nPorts=1,
    dh=d,
    dIns=dIns,
    kIns=kIns,
    final R=1/(pipe3.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe3.dh/2
         + pipe3.dIns)/(pipe3.dh/2))),
    length=length)                             annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{68,28},{84,12}})));
  Fluid.FixedResistances.PlugFlowPipe pipe4(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    dh=d,
    dIns=dIns,
    kIns=kIns,
    final R=1/(pipe4.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe4.dh/2
         + pipe4.dIns)/(pipe4.dh/2))),
    length=length)                             annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{60,-68},{44,-52}})));
  Fluid.FixedResistances.PlugFlowPipe pipe5(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    dh=d,
    dIns=dIns,
    kIns=kIns,
    final R=1/(pipe5.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe5.dh/2
         + pipe5.dIns)/(pipe5.dh/2))),
    length=length)                             annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-4,-68},{-20,-52}})));

  Fluid.FixedResistances.PlugFlowPipe pipe6(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    nPorts=1,
    dh=d,
    dIns=dIns,
    kIns=kIns,
    final R=1/(pipe6.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe6.dh/2
         + pipe6.dIns)/(pipe6.dh/2))),
    length=length)                             annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(extent={{-58,-68},{-74,-52}})));
  Fluid.FixedResistances.PlugFlowPipe pipe7(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    nPorts=1,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    dh=d,
    dIns=dIns,
    kIns=kIns,
    final R=1/(pipe7.kIns*2*Modelica.Constants.pi/Modelica.Math.log((pipe7.dh/2
         + pipe7.dIns)/(pipe7.dh/2))),
    length=length)                             annotation (Dialog(enable=true,
        group="Pipes"), Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={6,-20})));

   Fluid.MixingVolumes.MixingVolume junc3v6(
    redeclare package Medium = Medium,
    T_start=T_start,
    final V=vol,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal,
    energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{0,-60},{12,-72}})));



protected
  Fluid.MixingVolumes.MixingVolume juncjp6(
    redeclare package Medium = Medium,
    final V=vol,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3,
    final allowFlowReversal=allowFlowReversal,
    energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{0,20},{12,32}})));

equation

  connect(PumpInterface.port_b, pipe3.port_a)
    annotation (Line(points={{58,20},{68,20}}, color={0,127,255}));

  connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
      points={{50,28},{50,100.1},{0.1,100.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe7.port_a, juncjp6.ports[1])
    annotation (Line(points={{6,-12},{6,20},{4.4,20}},   color={0,127,255}));
  connect(pipe4.ports_b[1], junc3v6.ports[1])
    annotation (Line(points={{44,-60},{4.4,-60}},  color={0,127,255}));
  connect(pipe5.port_a, junc3v6.ports[2])
    annotation (Line(points={{-4,-60},{6,-60}}, color={0,127,255}));
  connect(pipe7.ports_b[1], junc3v6.ports[3]) annotation (Line(points={{6,-28},{6,
          -60},{7.6,-60}},               color={0,127,255}));
  connect(pipe1.ports_b[1], juncjp6.ports[2])
    annotation (Line(points={{-24,20},{6,20}},    color={0,127,255}));
  connect(valve.port_a, pipe5.ports_b[1])
    annotation (Line(points={{-34,-60},{-20,-60}}, color={0,127,255}));
  connect(valve.port_b, pipe6.port_a)
    annotation (Line(points={{-50,-60},{-58,-60}}, color={0,127,255}));
  connect(juncjp6.ports[3], pipe2.port_a)
    annotation (Line(points={{7.6,20},{16,20}}, color={0,127,255}));
  connect(pipe2.ports_b[1], PumpInterface.port_a)
    annotation (Line(points={{32,20},{42,20}}, color={0,127,255}));
  connect(senT_a1.port_b, pipe1.port_a)
    annotation (Line(points={{-88,20},{-40,20}}, color={0,127,255}));
  connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-32,
          12},{-32,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe2.heatPort, prescribedTemperature.port)
    annotation (Line(points={{24,12},{24,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe7.heatPort, prescribedTemperature.port)
    annotation (Line(points={{14,-20},{32,-20}}, color={191,0,0}));
  connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{76,
          12},{78,12},{78,0},{32,0},{32,-20}}, color={191,0,0}));
  connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{-12,
          -52},{-12,-46},{32,-46},{32,-20}}, color={191,0,0}));
  connect(pipe6.heatPort, prescribedTemperature.port) annotation (Line(points={{-66,
          -52},{-66,-46},{32,-46},{32,-20}}, color={191,0,0}));
  connect(pipe4.heatPort, prescribedTemperature.port) annotation (Line(points={{52,
          -52},{52,-46},{32,-46},{32,-20}}, color={191,0,0}));
  connect(pipe6.ports_b[1], senT_b2.port_a)
    annotation (Line(points={{-74,-60},{-78,-60}}, color={0,127,255}));
  connect(pipe4.port_a, senT_a2.port_b)
    annotation (Line(points={{60,-60},{72,-60}}, color={0,127,255}));
  connect(pipe3.ports_b[1], senT_b1.port_a)
    annotation (Line(points={{84,20},{88,20}}, color={0,127,255}));
  connect(valve.y, hydraulicBus.valSet) annotation (Line(points={{-42,-69.6},{-42,
          -80},{-122,-80},{-122,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valve.y_actual, hydraulicBus.valSetAct) annotation (Line(points={{-46,
          -65.6},{-46,-80},{-122,-80},{-122,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
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
        Line(
          points={{-40,-60},{-40,-68}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{-4,60},{-4,-58}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{-6,62},{-2,58}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,-58},{-2,-62}},
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
        Text(
          extent={{-30,-68},{94,-98}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Injection 2 Way"),
        Ellipse(
          extent={{-46,-68},{-34,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,60},{-24,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{76,60},{92,42}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{32,-42},{48,-60}},
          lineColor={135,135,135},
          textString="4"),
        Text(
          extent={{-92,-42},{-76,-60}},
          lineColor={135,135,135},
          textString="6"),
        Text(
          extent={{0,10},{16,-8}},
          lineColor={135,135,135},
          textString="7"),
        Text(
          extent={{-20,-42},{-4,-60}},
          lineColor={135,135,135},
          textString="5"),
        Text(
          extent={{0,60},{16,42}},
          lineColor={135,135,135},
          textString="2")}),    Diagram(coordinateSystem(extent={{-120,-120},{120,
            120}}, initialScale=0.1)),
    Documentation(info="<html>
<p>Injection circuit with a replaceable pump model for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus.</p>
<h4><span style=\"color: #008000\">Characteristics</span></h4>
<p>When the valve is fully opened, the consumer module is plugged into the primary hydronic circuit (port_a1, port_b2) whereas when the valve is fully closed, the consumer is isolated from the primary hydronic circuit. The primary needs a supply pump or a pressure difference.</p>
<p>This model uses a pipe model to include the heat loss and insulation effects</p>
</html>", revisions="<html>
<ul>
<li>August 09, 2018, by Alexander K&uuml;mpel:<br/>Extension from base PartioalHydraulicModuls</li>
<li>June 30, 2018, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>"));
end Injection2WayValve;
