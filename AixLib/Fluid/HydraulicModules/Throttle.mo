within AixLib.Fluid.HydraulicModules;
model Throttle "Throttle circuit with valve"
  extends AixLib.Fluid.Interfaces.PartialFourPort(redeclare package Medium1 =
        Medium, redeclare package Medium2 = Medium);
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  inner Modelica.Fluid.System system;
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));

  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    dpValve_nominal=8000) annotation (Dialog(enable=true,group="Actuators"), Placement(
        transformation(extent={{-10,50},{10,70}})));
  AixLib.Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}}),
        iconTransformation(extent={{-20,80},{20,120}})));
  FixedResistances.Pipe pipe1(redeclare package Medium = Medium, T_start=
        T_start)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-50,70},{
            -30,50}})));

  FixedResistances.Pipe pipe2(redeclare package Medium = Medium, T_start=
        T_start)
    annotation (Dialog(enable=true), Placement(transformation(extent={{30,70},{50,
            50}})));
  FixedResistances.Pipe pipe3(redeclare package Medium = Medium, T_start=
        T_start)
    annotation (Dialog(enable=true), Placement(transformation(extent={{10,-70},{
            -10,-50}})));
protected
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_out(redeclare package Medium =
        Medium) "Inflow into module in forward line" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-80,60})));
  Modelica.Blocks.Sources.RealExpression TfwrdIn(y=pipe1.pipe.mediums[1].T)
    "Temperature of inflowing medium in forward line."
    annotation (Placement(transformation(extent={{-52,4},{-84,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-96,32})));
  Modelica.Blocks.Sources.RealExpression TfwrdOut(y=pipe2.pipe.mediums[pipe2.nNodes].T)
    "Temperature of outflowing medium in forward line."
    annotation (Placement(transformation(extent={{54,4},{86,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_out(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={94,32})));
  Modelica.Blocks.Sources.RealExpression TrtrnIn(y=pipe3.pipe.mediums[1].T)
    "Temperature of inflowing medium in return line."
    annotation (Placement(transformation(extent={{34,-98},{66,-78}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Rtrn_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnOut(y=pipe3.pipe.mediums[pipe3.nNodes].T)
    "Temperature of outflowing medium in return line."
    annotation (Placement(transformation(extent={{-34,-98},{-66,-78}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Rtrn_out(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-60,80},{-68,88}})));
equation
  connect(hydraulicBus.T_amb, prescribedTemperature.T) annotation (Line(
      points={{0.1,100.1},{-40,100.1},{-40,84},{-59.2,84}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(val.y, hydraulicBus.valveSet) annotation (Line(points={{0,72},{0,100},
          {-38,100},{-40,100},{-40,100.1},{0.1,100.1}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe1.heatPort_outside, pipe2.heatPort_outside) annotation (Line(
        points={{-38.4,54.4},{-38.4,40},{41.6,40},{41.6,54.4}},
                                                        color={191,0,0},visible=false));
  connect(prescribedTemperature.port, pipe2.heatPort_outside) annotation (Line(
        points={{-68,84},{-72,84},{-72,40},{41.6,40},{41.6,54.4}},
                                                               color={191,0,0},visible=false));
  connect(pipe3.heatPort_outside, pipe2.heatPort_outside) annotation (Line(
        points={{-1.6,-54.4},{-1.6,-40},{-72,-40},{-72,40},{41.6,40},{41.6,54.4}},
        color={191,0,0},visible=false));
  connect(VFSen_out.V_flow, hydraulicBus.VF_out) annotation (Line(points={{-80,
          66.6},{-80,100.1},{0.1,100.1}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
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
  connect(TrtrnOut.y, Pt1Rtrn_out.u)
    annotation (Line(points={{-67.6,-88},{-80,-88}}, color={0,0,127}));
  connect(Pt1Rtrn_out.y, hydraulicBus.Trtrn_out) annotation (Line(points={{-80,-111},
          {-80,-118},{-116,-118},{-116,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnIn.y, Pt1Rtrn_in.u)
    annotation (Line(points={{67.6,-88},{80,-88}}, color={0,0,127}));
  connect(Pt1Rtrn_in.y, hydraulicBus.Trtrn_in) annotation (Line(points={{80,-111},
          {80,-118},{116,-118},{116,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.port_b, pipe1.port_a)
    annotation (Line(points={{-74,60},{-50.4,60}}, color={0,127,255}));
  connect(pipe1.port_b, val.port_a)
    annotation (Line(points={{-29.6,60},{-10,60}}, color={0,127,255}));
  connect(val.port_b, pipe2.port_a)
    annotation (Line(points={{10,60},{29.6,60}},color={0,127,255}));
  connect(port_a1, VFSen_out.port_a)
    annotation (Line(points={{-100,60},{-86,60}}, color={0,127,255}));
  connect(pipe2.port_b, port_b1)
    annotation (Line(points={{50.4,60},{100,60}}, color={0,127,255}));
  connect(port_a2, pipe3.port_a)
    annotation (Line(points={{100,-60},{10.4,-60}}, color={0,127,255}));
  connect(pipe3.port_b, port_b2)
    annotation (Line(points={{-10.4,-60},{-100,-60}}, color={0,127,255}));
  connect(val.y_actual, hydraulicBus.valveSetAct) annotation (Line(points={{5,67},
          {5,100.1},{0.1,100.1}}, color={0,0,127}), Text(
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
        Text(
          extent={{-60,-64},{48,-92}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Throttle"),
        Line(
          points={{-90,60},{-84,60},{-84,60},{84,60},{84,60},{90,60}},
          color={0,128,255},
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
          points={{80,50},{80,50}},
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
          extent={{-80,60},{-64,42}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{28,60},{44,42}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{-6,-42},{10,-60}},
          lineColor={135,135,135},
          textString="3")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
          initialScale=0.1), graphics={
        Text(
          extent={{-50,70},{-30,66}},
          lineColor={28,108,200},
          textString="Pipe 1"),
        Text(
          extent={{30,70},{50,66}},
          lineColor={28,108,200},
          textString="Pipe 2"),
        Text(
          extent={{-10,-66},{10,-70}},
          lineColor={28,108,200},
          textString="Pipe 3")}),
    Documentation(revisions="<html>
<ul>
<li>Mai 30, 2018, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib</li>
<li>2017-07-25 by Peter Matthes:<br/>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li>2017-06 by Peter Matthes:<br/>Implemented</li>
</ul>
</html>", info="<html>
<p>Throttle circuit with a valve for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus (not all connections are visible).</p>
<h4><span style=\"color: #008c48\">Characteristics</span></h4>
<p>The volume flow depends on the valve opening. If the valve is completly closed, there is no volume flow (except leackage). </p>
<p>This model uses a pipe model to include the heat loss and insulation effects.</p>
</html>"));
end Throttle;
