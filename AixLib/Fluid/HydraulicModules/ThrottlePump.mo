within AixLib.Fluid.HydraulicModules;
model ThrottlePump "Throttle circuit with pump and two way valve"
  extends AixLib.Fluid.Interfaces.PartialFourPort(redeclare package Medium1 =
        Medium, redeclare package Medium2 = Medium);
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  inner Modelica.Fluid.System system;
  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));

  replaceable BaseClasses.BasicPumpInterface basicPumpInterface(redeclare
      package Medium = Medium)
    annotation (Dialog(group="Actuators"), choicesAllMatching=true, Placement(transformation(extent={{18,48},
            {42,72}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    m_flow_nominal=8*996/3600,
    dpValve_nominal=8000) annotation (Dialog(enable=true,group="Actuators"), Placement(
        transformation(extent={{-38,50},{-18,70}})));
  AixLib.Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}}),
        iconTransformation(extent={{-20,80},{20,120}})));
  FixedResistances.Pipe pipe1(redeclare package Medium = Medium, T_start=T_start)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-68,70},{
            -48,50}})));

  FixedResistances.Pipe pipe2(redeclare package Medium = Medium, T_start=T_start)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-10,70},{
            10,50}})));

  FixedResistances.Pipe pipe3(redeclare package Medium = Medium, T_start=
        T_start)
    annotation (Dialog(enable=true), Placement(transformation(extent={{50,70},{70,
            50}})));
  FixedResistances.Pipe pipe4(redeclare package Medium = Medium, T_start=
        T_start)
    annotation (Dialog(enable=true), Placement(transformation(extent={{10,-70},{
            -10,-50}})));

protected
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_out(redeclare package Medium =
        Medium) "Inflow into module in forward line" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-82,60})));
  Modelica.Blocks.Sources.RealExpression TfwrdIn(y=pipe1.pipe.mediums[1].T)
    "Temperature of inflowing medium in forward line."
    annotation (Placement(transformation(extent={{-48,-20},{-80,0}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,10})));
  Modelica.Blocks.Sources.RealExpression TfwrdOut(y=pipe3.pipe.mediums[pipe2.nNodes].T)
    "Temperature of outflowing medium in forward line."
    annotation (Placement(transformation(extent={{48,-20},{80,0}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_out(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,10})));
  Modelica.Blocks.Sources.RealExpression TrtrnIn(y=pipe4.pipe.mediums[1].T)
    "Temperature of inflowing medium in return line."
    annotation (Placement(transformation(extent={{34,-98},{66,-78}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Rtrn_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnOut(y=pipe4.pipe.mediums[pipe3.nNodes].T)
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
  connect(val.port_b,pipe2. port_a)
    annotation (Line(points={{-18,60},{-10.4,60}}, color={0,127,255}));
  connect(val.y, hydraulicBus.valveSet) annotation (Line(points={{-28,72},{-28,100},
          {0,100},{0,100.1},{0.1,100.1}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe2.heatPort_outside,pipe3. heatPort_outside) annotation (Line(
        points={{1.6,54.4},{1.6,40},{61.6,40},{61.6,54.4}},
                                                        color={191,0,0},visible=false));
  connect(prescribedTemperature.port,pipe3. heatPort_outside) annotation (Line(
        points={{-68,84},{-72,84},{-72,40},{61.6,40},{61.6,54.4}},
                                                               color={191,0,0},visible=false));
  connect(pipe4.heatPort_outside,pipe3. heatPort_outside) annotation (Line(
        points={{-1.6,-54.4},{-1.6,-40},{-72,-40},{-72,40},{61.6,40},{61.6,54.4}},
        color={191,0,0},visible=false));
  connect(VFSen_out.V_flow, hydraulicBus.VF_out) annotation (Line(points={{-82,66.6},
          {-82,100.1},{0.1,100.1}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TfwrdIn.y, Pt1Fwrd_in.u) annotation (Line(points={{-81.6,-10},{-90,-10},
          {-90,-2}}, color={0,0,127}));
  connect(Pt1Fwrd_in.y, hydraulicBus.Tfwrd_in) annotation (Line(
      points={{-90,21},{-90,100},{0,100}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TfwrdOut.y, Pt1Fwrd_out.u)
    annotation (Line(points={{81.6,-10},{90,-10},{90,-2}}, color={0,0,127}));
  connect(Pt1Fwrd_out.y, hydraulicBus.Tfwrd_out) annotation (Line(
      points={{90,21},{90,100},{0,100}},
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
  connect(prescribedTemperature.T, hydraulicBus.T_amb) annotation (Line(points={
          {-59.2,84},{-40,84},{-40,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(port_a1,VFSen_out.port_a)
    annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
  connect(pipe3.port_b, port_b1)
    annotation (Line(points={{70.4,60},{100,60}}, color={0,127,255}));
  connect(port_a2,pipe4. port_a)
    annotation (Line(points={{100,-60},{10.4,-60}}, color={0,127,255}));
  connect(pipe4.port_b, port_b2)
    annotation (Line(points={{-10.4,-60},{-100,-60}}, color={0,127,255}));
  connect(basicPumpInterface.port_b,pipe3. port_a)
    annotation (Line(points={{42,60},{49.6,60}}, color={0,127,255}));
  connect(pipe2.port_b, basicPumpInterface.port_a)
    annotation (Line(points={{10.4,60},{18,60}}, color={0,127,255}));
  connect(hydraulicBus, basicPumpInterface.pumpBus) annotation (Line(
      points={{0,100},{30,100},{30,72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-2,6},{-2,6}}));
  connect(val.y_actual, hydraulicBus.valveSetAct) annotation (Line(points={{-23,67},
          {-23,100.1},{0.1,100.1}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe1.heatPort_outside,pipe3. heatPort_outside) annotation (Line(
        points={{-56.4,54.4},{-56.4,-4},{61.6,-4},{61.6,54.4}},
                                                        color={191,0,0},visible=false));
  connect(pipe1.port_b, val.port_a)
    annotation (Line(points={{-47.6,60},{-38,60}}, color={0,127,255}));
  connect(pipe1.port_a, VFSen_out.port_b)
    annotation (Line(points={{-68.4,60},{-76,60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-100,-64},{100,-104}},
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
          extent={{52,60},{68,42}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{-22,-40},{-6,-58}},
          lineColor={135,135,135},
          textString="4")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
          initialScale=0.1), graphics={
        Text(
          extent={{-10,70},{10,66}},
          lineColor={28,108,200},
          textString="Pipe 2"),
        Text(
          extent={{50,70},{70,66}},
          lineColor={28,108,200},
          textString="Pipe 3"),
        Text(
          extent={{-10,-66},{10,-70}},
          lineColor={28,108,200},
          textString="Pipe 4"),
        Text(
          extent={{-68,70},{-48,66}},
          lineColor={28,108,200},
          textString="Pipe 1")}),
    Documentation(revisions="<html>
<ul>
<li>Mai 30, 2018, by Alexander K&uuml;mpel:<br>Transfer from ZUGABE to AixLib</li>
<li>2017-07-25 by Peter Matthes:<br>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li>2017-06 by Alexander K&uuml;mpel:<br>Implemented</li>
</ul>
</html>", info="<html>
<p>Throttle circuit with a replaceable pump model and a valve for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus (not all connections are visible).</p>
<h4><span style=\"color: #008c48\">Characteristics</span></h4>
<p>The volume flow depends on the valve opening and the pump speed. If the pump is switched of or the valve is completly closed, there is no volume flow (except leackage).</p>
<p>This model uses a pipe model to include the heat loss and insulation effects.</p>
</html>"));
end ThrottlePump;
