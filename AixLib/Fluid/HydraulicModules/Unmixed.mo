within AixLib.Fluid.HydraulicModules;
model Unmixed "Unmixed circuit with pump"
public
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors";
  parameter Modelica.SIunits.Temperature Tinit=303.15
    "Initialization temperature";

  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  AixLib.Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-60,80},{-20,120}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_fwrdIn(redeclare package Medium =
        Medium) "forward line inflowing medium" annotation (Placement(
        transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent=
            {{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_rtrnOut(redeclare package Medium =
        Medium) "Return line outflowing medium" annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
          extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_fwrdOut(redeclare package Medium =
        Medium) "Forward line outflowing medium"
                                      annotation (Placement(transformation(
          extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_rtrnIn(redeclare package Medium =
        Medium) "Return line inflowing medium"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-60,80},{-68,88}})));
public
  FixedResistances.DPEAgg_ambientLoss pipe1(redeclare package Medium = Medium)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-40,70},
            {-20,50}})));

  FixedResistances.DPEAgg_ambientLoss pipe2(redeclare package Medium = Medium)
    annotation (Dialog(enable=true), Placement(transformation(extent={{40,70},
            {60,50}})));
  FixedResistances.DPEAgg_ambientLoss pipe3(redeclare package Medium = Medium)
    annotation (Dialog(enable=true), Placement(transformation(extent={{20,-70},
            {0,-50}})));

protected
  Modelica.Fluid.Sensors.VolumeFlowRate vFRfwrdIn(redeclare package Medium =
        Medium) "inflow into module" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-82,60})));
  Modelica.Blocks.Sources.RealExpression TfwrdIn(y=pipe1.pipe.mediums[1].T)
    "temperature of inflowing medium on forward line."
    annotation (Placement(transformation(extent={{-36,4},{-68,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1FwrdIn(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,32})));
  Modelica.Blocks.Sources.RealExpression TfwrdOut(y=pipe2.pipe.mediums[pipe2.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{40,4},{72,24}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1FwrdOut(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,32})));
  Modelica.Blocks.Continuous.FirstOrder Pt1RtrnOut(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnOut(y=pipe3.pipe.mediums[pipe3.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{-34,-98},{-66,-78}})));
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
public
  Movers.SpeedControlled_Nrpm pump(redeclare package Medium = Medium)
    annotation (Dialog(enable=true),Placement(transformation(extent={{0,50},{20,70}})));
equation
  connect(hydraulicBus.Tambient, prescribedTemperature.T) annotation (Line(
      points={{-39.9,100.1},{-40,100.1},{-40,84},{-59.2,84}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(pipe1.heatPort_outside, pipe2.heatPort_outside) annotation (Line(
        points={{-28.4,54.4},{-28.4,40},{51.6,40},{51.6,54.4}},
                                                        color={191,0,0},visible=false));
  connect(prescribedTemperature.port, pipe2.heatPort_outside) annotation (Line(
        points={{-68,84},{-72,84},{-72,40},{51.6,40},{51.6,54.4}},
                                                               color={191,0,0},
      visible=false));

  connect(pipe3.heatPort_outside, pipe2.heatPort_outside) annotation (Line(
        points={{8.4,-54.4},{8.4,-40},{-72,-40},{-72,40},{51.6,40},{51.6,54.4}},
        color={191,0,0},
      visible=false));
  connect(port_fwrdIn, vFRfwrdIn.port_a)
    annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
  connect(vFRfwrdIn.V_flow, hydraulicBus.vFRflowModule) annotation (Line(points=
         {{-82,66.6},{-80,66.6},{-80,100},{-40,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRfwrdIn.port_b, pipe1.port_a)
    annotation (Line(points={{-76,60},{-40.4,60}}, color={0,127,255}));
  connect(pipe2.port_b, port_fwrdOut)
    annotation (Line(points={{60.4,60},{100,60}}, color={0,127,255}));
  connect(port_rtrnIn, pipe3.port_a)
    annotation (Line(points={{100,-60},{20.4,-60}}, color={0,127,255}));
  connect(pipe3.port_b, port_rtrnOut)
    annotation (Line(points={{-0.4,-60},{-100,-60}}, color={0,127,255}));
  connect(TfwrdIn.y, Pt1FwrdIn.u)
    annotation (Line(points={{-69.6,14},{-80,14},{-80,20}}, color={0,0,127}));
  connect(Pt1FwrdIn.y, hydraulicBus.TfwrdIn) annotation (Line(
      points={{-80,43},{-80,100.1},{-39.9,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TfwrdOut.y, Pt1FwrdOut.u)
    annotation (Line(points={{73.6,14},{80,14},{80,20}}, color={0,0,127}));
  connect(Pt1FwrdOut.y, hydraulicBus.TfwrdOut) annotation (Line(
      points={{80,43},{80,100.1},{-39.9,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnOut.y, Pt1RtrnOut.u)
    annotation (Line(points={{-67.6,-88},{-80,-88}}, color={0,0,127}));
  connect(Pt1RtrnOut.y, hydraulicBus.TrtrnOut) annotation (Line(points={{-80,-111},
          {-80,-118},{-116,-118},{-116,100.1},{-39.9,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Pt1RtrnIn.y, hydraulicBus.TrtrnIn) annotation (Line(points={{80,-111},
          {80,-116},{116,-116},{116,100.1},{-39.9,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnIn.y, Pt1RtrnIn.u)
    annotation (Line(points={{67.6,-88},{80,-88}}, color={0,0,127}));
  connect(pump.Nrpm, hydraulicBus.rpm_Input) annotation (Line(points={{10,72},{10,
          100},{-28,100},{-28,100.1},{-39.9,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.P, hydraulicBus.P) annotation (Line(points={{21,69},{21,100.1},{-39.9,
          100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.port_a, pipe1.port_b)
    annotation (Line(points={{0,60},{-19.6,60}}, color={0,127,255}));
  connect(pump.port_b, pipe2.port_a)
    annotation (Line(points={{20,60},{39.6,60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,-80},{60,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Unmixed"),
        Line(
          points={{-90,60},{-84,60},{-84,40},{84,40},{84,60},{90,60}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{-20,60},{20,20}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,60},{20,40},{0,20}},
          color={135,135,135},
          thickness=0.5),
        Line(
          points={{-90,-60},{-84,-60},{-84,-40},{84,-40},{84,-60},{90,-60}},
          color={0,128,255},
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
          extent={{62,62},{78,46}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{62,62},{78,46}},
          lineColor={216,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Line(points={{70,46},{70,40}}, color={0,0,0}),
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
        Line(points={{-70,-34},{-70,-40}}, color={0,0,0})}),
                            Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
          initialScale=0.1)),
    Documentation(revisions="<html>
<ul>
<li>2017-07-25 by Peter Matthes:<br>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li>2017-06 by ???:<br>Implemented</li>
</ul>
</html>"));
end Unmixed;
