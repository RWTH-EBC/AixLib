within AixLib.Fluid.HydraulicModules;
model Injection "Injection circuit with pump and three way valve"
  extends AixLib.Fluid.Interfaces.PartialFourPort(redeclare package Medium1 =
        Medium, redeclare package Medium2 = Medium);
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
      constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  inner Modelica.Fluid.System system;
  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume"  annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start = 303.15
    "Initialization temperature"  annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors"  annotation(Dialog(tab="Advanced"));

  replaceable BaseClasses.BasicPumpInterface basicPumpInterface(redeclare
      package Medium = Medium)
    annotation (Dialog(group="Actuators"), choicesAllMatching=true, Placement(transformation(extent={{30,52},
            {46,68}})));

  AixLib.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    l={0.001,0.001},
    dpFixed_nominal={8000,8000},
    redeclare package Medium = Medium,
    p_start=system.p_start,
    T_start=T_start,
    init=Modelica.Blocks.Types.Init.NoInit,
    y_start=0.5,
    rhoStd=Medium.density_pTX(
        system.p_start,
        T_start,
        Medium.X_default),
    tau=0.2,
    Kv=10)                             annotation (Dialog(enable=true,group="Actuators"), Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-44,-60})));

  BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}}),
        iconTransformation(extent={{-20,80},{20,118}})));
  FixedResistances.Pipe pipe1(redeclare package Medium = Medium,
      T_start=T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(extent={{-66,66},{-54,54}})));
  FixedResistances.Pipe pipe3(redeclare package Medium = Medium,
      T_start=T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(extent={{54,66},{66,54}})));
  FixedResistances.Pipe pipe4(redeclare package Medium = Medium,
      T_start=T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(extent={{66,-66},{54,-54}})));
  FixedResistances.Pipe pipe6(redeclare package Medium = Medium,
      T_start=T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(extent={{-64,-66},{-76,-54}})));
  FixedResistances.Pipe pipe7(redeclare package Medium = Medium,
      T_start=T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={-44,0})));
  FixedResistances.Pipe pipe8(redeclare package Medium = Medium,
      T_start=T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={12,0})));
  FixedResistances.Pipe pipe5(redeclare package Medium = Medium, T_start=
        T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(extent={{-8,-66},{-20,-54}})));
  FixedResistances.Pipe pipe2(redeclare package Medium = Medium, T_start=
        T_start) annotation (Dialog(enable=true, group="Pipes"), Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-28,60})));

protected
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_out(redeclare package Medium =
        Medium) "Inflow into admix module" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-80,60})));
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_in(redeclare package Medium =
        Medium) "Inflow into consumer (out of module)" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={80,60})));
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_injection(redeclare package
      Medium = Medium) "Volume flow in injection line" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-8,60})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-96,32})));
  Modelica.Blocks.Sources.RealExpression TfwrdIn(y=pipe1.pipe.mediums[1].T)
    "Temperature of inflowing medium in forward line."
    annotation (Placement(transformation(extent={{-52,4},{-84,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_out(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={94,32})));
  Modelica.Blocks.Sources.RealExpression TfwrdOut(y=pipe3.pipe.mediums[pipe2.nNodes].T)
    "Temperature of outflowing medium in forward line."
    annotation (Placement(transformation(extent={{54,4},{86,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Rtrn_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnIn(y=pipe4.pipe.mediums[1].T)
    "Temperature of inflowing medium in return line."
    annotation (Placement(transformation(extent={{34,-98},{66,-78}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Rtrn_out(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnOut(y=pipe6.pipe.mediums[pipe4.nNodes].T)
    "Temperature of outflowing medium in return line."
    annotation (Placement(transformation(extent={{-34,-98},{-66,-78}})));
  Modelica.Fluid.Vessels.ClosedVolume junc15j(
    nPorts=3,
    use_portsData=false,
    V=vol,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-52,60},{-36,76}})));
  Modelica.Fluid.Vessels.ClosedVolume juncjp6(
    nPorts=3,
    use_portsData=false,
    V=vol,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{4,60},{20,76}})));
  Modelica.Fluid.Vessels.ClosedVolume junc3v6(
    nPorts=3,
    use_portsData=false,
    redeclare package Medium = Medium,
    V=vol) annotation (Placement(transformation(extent={{4,-60},{20,-76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-46,116})));

equation
  connect(juncjp6.ports[1],pipe8. port_a)
    annotation (Line(points={{9.86667,60},{12,60},{12,6.24}},
                                                       color={0,127,255}));
  connect(val.port_3,pipe7. port_b)
    annotation (Line(points={{-44,-52},{-44,-6.24}}, color={0,127,255}));
  connect(pipe6.port_a, val.port_2) annotation (Line(points={{-63.76,-60},{-52,-60}},
                           color={0,127,255}));
  connect(junc3v6.ports[1],pipe4. port_b) annotation (Line(points={{9.86667,-60},
          {53.76,-60}},             color={0,127,255}));
  connect(pipe8.port_b, junc3v6.ports[2]) annotation (Line(points={{12,-6.24},{12,
          -60}},               color={0,127,255}));
  connect(pipe1.heatPort_outside,pipe3. heatPort_outside) annotation (Line(
        points={{-59.04,56.64},{-59.04,40},{60.96,40},{60.96,56.64}},
                                                          color={191,0,0},visible=false));
  connect(pipe4.heatPort_outside,pipe6. heatPort_outside) annotation (Line(
        points={{59.04,-56.64},{58,-56.64},{58,-40},{-70.96,-40},{-70.96,-56.64}},
                                                                          color={191,0,0},
      visible=false));

  connect(pipe7.heatPort_outside,pipe3. heatPort_outside) annotation (Line(
        points={{-47.36,-0.96},{-46,-0.96},{-46,40},{60.96,40},{60.96,56.64}},
                                                                 color={191,0,0},
      visible=false));

  connect(pipe8.heatPort_outside,pipe3. heatPort_outside) annotation (Line(
        points={{8.64,-0.96},{2,-0.96},{2,40},{60.96,40},{60.96,56.64}},
                                                               color={191,0,0},visible=false));
  connect(prescribedTemperature.port,pipe3. heatPort_outside) annotation (Line(
        points={{-50,116},{-80,116},{-80,6},{-38,6},{-38,40},{60.96,40},{60.96,
          56.64}},
        color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port,pipe6. heatPort_outside) annotation (Line(
        points={{-50,116},{-80,116},{-80,-40},{-70.96,-40},{-70.96,-56.64}},
                                                                     color={191,0,0},
      visible=false));

  connect(prescribedTemperature.T, hydraulicBus.T_amb) annotation (Line(
        points={{-41.2,116},{0.1,116},{0.1,100.1}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(val.y, hydraulicBus.valveSet) annotation (Line(points={{-44,-69.6},{-44,
          -80},{-80,-80},{-80,100.1},{0.1,100.1}},       color={0,0,127},
      visible=false),                                                      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe1.port_b, junc15j.ports[1])
    annotation (Line(points={{-53.76,60},{-46.1333,60}}, color={0,127,255}));
  connect(pipe7.port_a, junc15j.ports[2]) annotation (Line(points={{-44,6.24},{-44,
          60}},                       color={0,127,255}));
  connect(VFSen_injection.port_b, juncjp6.ports[2])
    annotation (Line(points={{0,60},{12,60}},  color={0,127,255}));
  connect(VFSen_out.port_b, pipe1.port_a)
    annotation (Line(points={{-72,60},{-66.24,60}}, color={0,127,255}));
  connect(pipe3.port_b, VFSen_in.port_a)
    annotation (Line(points={{66.24,60},{72,60}}, color={0,127,255}));
  connect(TfwrdIn.y, Pt1Fwrd_in.u)
    annotation (Line(points={{-85.6,14},{-96,14},{-96,20}}, color={0,0,127}));
  connect(Pt1Fwrd_in.y, hydraulicBus.Tfwrd_in) annotation (Line(
      points={{-96,43},{-96,100},{0,100}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TfwrdOut.y, Pt1Fwrd_out.u)
    annotation (Line(points={{87.6,14},{94,14},{94,20}}, color={0,0,127}));
  connect(Pt1Fwrd_out.y, hydraulicBus.Tfwrd_out) annotation (Line(
      points={{94,43},{94,100},{0,100}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnIn.y, Pt1Rtrn_in.u)
    annotation (Line(points={{67.6,-88},{80,-88}}, color={0,0,127}));
  connect(Pt1Rtrn_in.y, hydraulicBus.Trtrn_in) annotation (Line(points={{80,-111},
          {80,-116},{116,-116},{116,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnOut.y, Pt1Rtrn_out.u)
    annotation (Line(points={{-67.6,-88},{-80,-88}}, color={0,0,127}));
  connect(Pt1Rtrn_out.y, hydraulicBus.Trtrn_out) annotation (Line(points={{-80,-111},
          {-80,-118},{-116,-118},{-116,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.V_flow, hydraulicBus.VF_in) annotation (Line(points={{-80,68.8},
          {-80,100.1},{0.1,100.1}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_in.V_flow, hydraulicBus.VF_out) annotation (Line(points={{80,68.8},
          {80,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(port_a1,VFSen_out. port_a)
    annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
  connect(port_b1, VFSen_in.port_b)
    annotation (Line(points={{100,60},{88,60}}, color={0,127,255}));
  connect(port_a2,pipe4. port_a)
    annotation (Line(points={{100,-60},{66.24,-60}}, color={0,127,255}));
  connect(port_b2,pipe6. port_b)
    annotation (Line(points={{-100,-60},{-76.24,-60}}, color={0,127,255}));
  connect(basicPumpInterface.port_b,pipe3. port_a)
    annotation (Line(points={{46,60},{53.76,60}}, color={0,127,255}));
  connect(juncjp6.ports[3], basicPumpInterface.port_a)
    annotation (Line(points={{14.1333,60},{30,60}}, color={0,127,255}));
  connect(hydraulicBus, basicPumpInterface.pumpBus) annotation (Line(
      points={{0,100},{38,100},{38,68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(VFSen_injection.V_flow, hydraulicBus.VF_injection) annotation (Line(
        points={{-8,68.8},{-8,100},{0,100}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(val.y_actual, hydraulicBus.valveSetAct) annotation (Line(
      points={{-48,-65.6},{-50,-65.6},{-50,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe5.heatPort_outside, pipe6.heatPort_outside) annotation (Line(
      points={{-14.96,-56.64},{32,-56.64},{32,-32},{-70.96,-32},{-70.96,-56.64}},
      color={191,0,0},
      visible=false));

  connect(val.port_1, pipe5.port_b)
    annotation (Line(points={{-36,-60},{-20.24,-60}}, color={0,127,255}));
  connect(pipe5.port_a, junc3v6.ports[3])
    annotation (Line(points={{-7.76,-60},{14.1333,-60}}, color={0,127,255}));
  connect(pipe2.heatPort_outside, pipe6.heatPort_outside) annotation (Line(
      points={{-27.04,56.64},{58,56.64},{58,-40},{-70.96,-40},{-70.96,-56.64}},
      color={191,0,0},
      visible=false));

  connect(pipe2.port_a, junc15j.ports[3])
    annotation (Line(points={{-34.24,60},{-41.8667,60}}, color={0,127,255}));
  connect(pipe2.port_b, VFSen_injection.port_a)
    annotation (Line(points={{-21.76,60},{-16,60}}, color={0,127,255}));
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
          extent={{12,80},{52,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{32,80},{52,60},{32,40}},
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
          extent={{-22,-64},{100,-100}},
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
          extent={{50,60},{66,42}},
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
          extent={{-42,10},{-26,-8}},
          lineColor={135,135,135},
          textString="7"),
        Text(
          extent={{0,10},{16,-8}},
          lineColor={135,135,135},
          textString="8"),
        Text(
          extent={{-16,60},{0,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{-20,-42},{-4,-60}},
          lineColor={135,135,135},
          textString="5")}),    Diagram(coordinateSystem(extent={{-120,-120},{120,
            120}}, initialScale=0.1), graphics={
        Text(
          extent={{-70,68},{-50,64}},
          lineColor={28,108,200},
          textString="Pipe 1"),
        Text(
          extent={{50,68},{70,64}},
          lineColor={28,108,200},
          textString="Pipe 3"),
        Text(
          extent={{-80,-50},{-60,-54}},
          lineColor={28,108,200},
          textString="Pipe 6"),
        Text(
          extent={{-10,2},{10,-2}},
          lineColor={28,108,200},
          origin={-34,0},
          rotation=-90,
          textString="Pipe 7"),
        Text(
          extent={{-10,2},{10,-2}},
          lineColor={28,108,200},
          origin={18,0},
          rotation=-90,
          textString="Pipe 8"),
        Text(
          extent={{50,-50},{70,-54}},
          lineColor={28,108,200},
          textString="Pipe 4"),
        Text(
          extent={{-36,68},{-16,64}},
          lineColor={28,108,200},
          textString="Pipe 2"),
        Text(
          extent={{-24,-50},{-4,-54}},
          lineColor={28,108,200},
          textString="Pipe 5")}),
    Documentation(info="<html>
<p>Injection circuit with a replaceable pump model for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus (not all connections are visible).</p>
<h4><span style=\"color: #008000\">Characteristics</span></h4>
<p>When the valve is fully opened, the consumer module is plugged into the primary hydronic circuit whereas when the valve is fully closed, the consumer is isolated from the primary hydronic circuit</p>
<p>This model uses a pipe model to include the heat loss and insulation effects</p>
</html>", revisions="<html>
<ul>
<li>Mai 30, 2018, by Alexander K&uuml;mpel:<br>Transfer from ZUGABE to AixLib</li>
<li>2017-07-25 by Peter Matthes:<br>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li><i>March,2016&nbsp;</i> by Rohit Lad:<br>Implemented</li>
</ul>
</html>"));
end Injection;
