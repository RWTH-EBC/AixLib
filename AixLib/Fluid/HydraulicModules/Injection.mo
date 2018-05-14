within AixLib.Fluid.HydraulicModules;
model Injection "Injection circuit with pump and three way valve"
public
  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume";
  parameter Modelica.SIunits.Temperature Tinit = 303.15 "Initialization temperature";
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors";
 replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
      constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-40,80},{0,118}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_fwrdIn(redeclare package Medium =
        Medium) "forward line inflowing medium" annotation (Placement(
        transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent=
            {{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_rtrnIn(redeclare package Medium =
        Medium) "Return line inflowing medium"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_rtrnOut(redeclare package Medium =
        Medium) "Return line outflowing medium" annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
          extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_fwrdOut(redeclare package Medium =
        Medium) "forward line outflowing medium"
                                      annotation (Placement(transformation(
          extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,
            70}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-46,116})));
  Modelica.Fluid.Sensors.VolumeFlowRate vFRfwrdIn(redeclare package Medium =
        Medium) "inflow into admix module" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-82,60})));
  Modelica.Fluid.Sensors.VolumeFlowRate vFRfwrdOut(redeclare package Medium =
        Medium) "inflow into consumer (out of module)" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={80,60})));
  Modelica.Fluid.Sensors.VolumeFlowRate vFRinjection(redeclare package Medium =
        Medium) "volume flow in injection line" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-10,60})));
public
  FixedResistances.DPEAgg_ambientLoss                    pipe1(redeclare
      package                                                                    Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(
        transformation(extent={{-64,66},{-52,54}})));
protected
  Modelica.Fluid.Vessels.ClosedVolume juncjp6(
    nPorts=3,
    use_portsData=false,
    V=vol,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-2,60},{14,76}})));
  Modelica.Fluid.Vessels.ClosedVolume junc15j(
    nPorts=3,
    use_portsData=false,
    V=vol,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-32,60},{-16,76}})));
public
FixedResistances.DPEAgg_ambientLoss pipe6(redeclare package Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={6,6})));

FixedResistances.DPEAgg_ambientLoss pipe2(redeclare package Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(
        transformation(extent={{54,66},{66,54}})));
FixedResistances.DPEAgg_ambientLoss pipe3(redeclare package Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(
        transformation(extent={{60,-66},{48,-54}})));
protected
  Modelica.Fluid.Vessels.ClosedVolume junc3v6(
    nPorts=3,
    use_portsData=false,
    redeclare package Medium = Medium,
    V=vol) annotation (Placement(transformation(extent={{-2,-60},{14,-76}})));
public
  AixLib.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    l={0.001,0.001},
    Kv=10.0,
    m_flow_nominal=8*996/3600,
    dpFixed_nominal={8000,8000},
    redeclare package Medium = Medium,
    tau=0.2)                           annotation (Dialog(enable=true), Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-24,-60})));
FixedResistances.DPEAgg_ambientLoss pipe5(redeclare package Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={-24,6})));
FixedResistances.DPEAgg_ambientLoss pipe4(redeclare package Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(
        transformation(extent={{-50,-66},{-62,-54}})));
protected
  Modelica.Blocks.Sources.RealExpression TfwrdIn(y=pipe1.pipe.mediums[1].T)
    "temperature of inflowing medium on forward line."
    annotation (Placement(transformation(extent={{-52,4},{-84,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1FwrdIn(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-96,32})));
  Modelica.Blocks.Sources.RealExpression TfwrdOut(y=pipe2.pipe.mediums[pipe2.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{54,4},{86,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1FwrdOut(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={94,32})));
  Modelica.Blocks.Continuous.FirstOrder Pt1RtrnIn(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnIn(y=pipe3.pipe.mediums[1].T)
    "temperature of inflowing medium in return line."
    annotation (Placement(transformation(extent={{34,-98},{66,-78}})));
  Modelica.Blocks.Sources.RealExpression TrtrnOut(y=pipe4.pipe.mediums[pipe4.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{-34,-98},{-66,-78}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1RtrnOut(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-100})));
public
  Movers.SpeedControlled_Nrpm pump(redeclare package Medium = Medium)
    annotation (Dialog(enable=true),Placement(transformation(extent={{22,50},{42,70}})));
equation
  connect(juncjp6.ports[1], pipe6.port_a)
    annotation (Line(points={{3.86667,60},{6,60},{6,12.24}},
                                                       color={0,127,255}));
  connect(val.port_3, pipe5.port_b)
    annotation (Line(points={{-24,-52},{-24,-0.24}}, color={0,127,255}));
  connect(port_fwrdOut,port_fwrdOut)
    annotation (Line(points={{100,60},{100,60}},         color={0,127,255}));
  connect(pipe4.port_a, val.port_2) annotation (Line(points={{-49.76,-60},{-32,-60}},
                           color={0,127,255}));
  connect(junc3v6.ports[1], pipe3.port_b) annotation (Line(points={{3.86667,-60},
          {47.76,-60},{47.76,-60}}, color={0,127,255}));
  connect(junc3v6.ports[2], val.port_1)
    annotation (Line(points={{6,-60},{-16,-60}},         color={0,127,255}));
  connect(pipe6.port_b, junc3v6.ports[3]) annotation (Line(points={{6,-0.24},{6,
          -60},{8.13333,-60}}, color={0,127,255}));
  connect(pipe1.heatPort_outside, pipe2.heatPort_outside) annotation (Line(
        points={{-57.04,56.64},{-57.04,40},{60.96,40},{60.96,56.64}},
                                                          color={191,0,0},visible=false));
  connect(pipe3.heatPort_outside, pipe4.heatPort_outside) annotation (Line(
        points={{53.04,-56.64},{54,-56.64},{54,-40},{-56.96,-40},{-56.96,-56.64}},
                                                                          color=
         {191,0,0},visible=false));
  connect(pipe5.heatPort_outside, pipe2.heatPort_outside) annotation (Line(
        points={{-27.36,5.04},{-38,5.04},{-38,40},{60.96,40},{60.96,56.64}},
                                                                 color={191,0,0},visible=false));
  connect(pipe6.heatPort_outside, pipe2.heatPort_outside) annotation (Line(
        points={{2.64,5.04},{-10,5.04},{-10,40},{60.96,40},{60.96,56.64}},
                                                               color={191,0,0},visible=false));
  connect(prescribedTemperature.port, pipe2.heatPort_outside) annotation (Line(
        points={{-50,116},{-80,116},{-80,6},{-38,6},{-38,40},{60.96,40},{60.96,
          56.64}},
        color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe4.heatPort_outside) annotation (Line(
        points={{-50,116},{-80,116},{-80,-40},{-56.96,-40},{-56.96,-56.64}},
                                                                     color={191,0,0},
      visible=false));

  connect(prescribedTemperature.T, hydraulicBus.Tambient) annotation (Line(
        points={{-41.2,116},{-20,116},{-20,99}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(val.y, hydraulicBus.valveSet) annotation (Line(points={{-24,-69.6},{-24,
          -80},{-80,-80},{-80,99.095},{-19.9,99.095}},   color={0,0,127},
      visible=false),                                                      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(port_fwrdIn, vFRfwrdIn.port_a)
    annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
  connect(pipe1.port_b, junc15j.ports[1])
    annotation (Line(points={{-51.76,60},{-26.1333,60}}, color={0,127,255}));
  connect(pipe5.port_a, junc15j.ports[2]) annotation (Line(points={{-24,12.24},{
          -24,36},{-24,60},{-24,60}}, color={0,127,255}));
  connect(junc15j.ports[3], vFRinjection.port_a)
    annotation (Line(points={{-21.8667,60},{-16,60}}, color={0,127,255}));
  connect(vFRinjection.port_b, juncjp6.ports[2])
    annotation (Line(points={{-4,60},{6,60}},       color={0,127,255}));
  connect(port_fwrdOut, vFRfwrdOut.port_b)
    annotation (Line(points={{100,60},{86,60}}, color={0,127,255}));
  connect(vFRfwrdIn.port_b, pipe1.port_a)
    annotation (Line(points={{-76,60},{-64.24,60}}, color={0,127,255}));
  connect(pipe2.port_b, vFRfwrdOut.port_a)
    annotation (Line(points={{66.24,60},{74,60}}, color={0,127,255}));
  connect(port_rtrnIn, pipe3.port_a)
    annotation (Line(points={{100,-60},{60.24,-60}}, color={0,127,255}));
  connect(pipe4.port_b, port_rtrnOut)
    annotation (Line(points={{-62.24,-60},{-100,-60}}, color={0,127,255}));
  connect(TfwrdIn.y, Pt1FwrdIn.u)
    annotation (Line(points={{-85.6,14},{-96,14},{-96,20}}, color={0,0,127}));
  connect(Pt1FwrdIn.y, hydraulicBus.TfwrdIn) annotation (Line(
      points={{-96,43},{-96,99},{-20,99}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TfwrdOut.y, Pt1FwrdOut.u)
    annotation (Line(points={{87.6,14},{94,14},{94,20}}, color={0,0,127}));
  connect(Pt1FwrdOut.y, hydraulicBus.TfwrdOut) annotation (Line(
      points={{94,43},{94,99},{-20,99}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnIn.y, Pt1RtrnIn.u)
    annotation (Line(points={{67.6,-88},{80,-88}}, color={0,0,127}));
  connect(Pt1RtrnIn.y, hydraulicBus.TrtrnIn) annotation (Line(points={{80,-111},
          {80,-116},{116,-116},{116,99},{-20,99}},           color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnOut.y, Pt1RtrnOut.u)
    annotation (Line(points={{-67.6,-88},{-80,-88}}, color={0,0,127}));
  connect(Pt1RtrnOut.y, hydraulicBus.TrtrnOut) annotation (Line(points={{-80,
          -111},{-80,-118},{-116,-118},{-116,99},{-20,99}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRfwrdIn.V_flow, hydraulicBus.vFRfwrdIn) annotation (Line(points={{
          -82,66.6},{-82,99},{-20,99}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRinjection.V_flow, hydraulicBus.vFRinjection) annotation (Line(
        points={{-10,66.6},{-10,99},{-20,99}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRfwrdOut.V_flow, hydraulicBus.vFRfwrdOut) annotation (Line(points={
          {80,66.6},{80,99},{-20,99}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.P, hydraulicBus.P) annotation (Line(points={{43,69},{43,99.095},{
          -19.9,99.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.Nrpm, hydraulicBus.rpm_Input) annotation (Line(points={{32,72},{32,
          99.095},{-19.9,99.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(juncjp6.ports[3], pump.port_a)
    annotation (Line(points={{8.13333,60},{22,60}}, color={0,127,255}));
  connect(pump.port_b, pipe2.port_a)
    annotation (Line(points={{42,60},{53.76,60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
        Text(
          extent={{-60,-80},{62,-120}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Injection"),
                          Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Line(
          points={{-90,60},{-84,60},{-84,40},{84,40},{84,60},{90,60}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-40,40},{-40,-20}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-90,-60},{-84,-60},{-84,-40},{84,-40},{84,-60},{90,-60}},
          color={0,128,255},
          thickness=0.5),
        Polygon(
          points={{-66,-30},{-66,-30}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-50},{-60,-30},{-40,-40},{-60,-50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-50},{-20,-30},{-40,-40},{-20,-50}},
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
          origin={-40,-30},
          rotation=0),
        Ellipse(
          extent={{-46,-48},{-34,-60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,-40},{-40,-48}},
          color={95,95,95},
          thickness=0.5),
        Ellipse(
          extent={{-42,42},{-38,38}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{2,40},{2,-40}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{0,42},{4,38}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-38},{4,-42}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
                         Ellipse(
          extent={{16,60},{56,20}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{36,60},{56,40},{36,20}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-60,50},{-60,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,48},{-62,32}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,48},{-62,32}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Ellipse(
          extent={{-78,64},{-62,48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,64},{-62,48}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{62,48},{78,32}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,48},{78,32}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Ellipse(
          extent={{62,64},{78,48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,64},{78,48}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{-78,-18},{-62,-34}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-78,-18},{-62,-34}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{-70,-34},{-70,-40}}, color={0,0,0}),
        Ellipse(
          extent={{62,-18},{78,-34}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,-18},{78,-34}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{70,-34},{70,-40}}, color={0,0,0}),
        Ellipse(
          extent={{-26,48},{-10,32}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-26,48},{-10,32}},
          lineColor={0,128,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q")}),    Diagram(coordinateSystem(extent={{-120,-120},{120,
            120}}, initialScale=0.1)),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<ul>
<li>This is a model for BCIC (Heating/Cooling - Injection Circuit)</li>
<li>It is operated along with <a href=\"Zugabe.Controls.Modules.Consumer.Ctr_BCIC_01\">BCIC Controller</a> which controls the TflowConsumer wrt the BCIC set temperature by opening or closing the 3way valve</li>
<li>When the valve is fully opened, the consumer module is plugged into the primary hydraulic circuit whereas when the valve is fully closed, the consumer is isolated from the primary hydraulic circuit</li>
<li>This model uses <a href=\"HVAC.Components.Pipes.DPE_ambientLoss\">DPE_AmbientLoss</a> pipe model to include the heat loss and insulation effects</li>
</ul>
<h4><span style=\"color: #008c48\">Examples</span></h4>
<p>The working example for BCIC module along with observations is provided in <a href=\"Zugabe.Modules.Consumer.Examples.test_BCIC_01\">test_BCIC_01</a></p>
</html>", revisions="<html>
<ul>
<li>2017-07-25 by Peter Matthes:<br>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li><i>March,2016&nbsp;</i> by Rohit Lad:<br>Implemented</li>
</ul>
</html>"));
end Injection;
