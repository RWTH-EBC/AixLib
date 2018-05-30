within AixLib.Fluid.HydraulicModules;
model Admix "Admix circuit with three way valve and rpm controlled pump"
  extends AixLib.Fluid.Interfaces.PartialFourPort(redeclare package Medium1 =
        Medium, redeclare package Medium2 = Medium);
  replaceable package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  inner Modelica.Fluid.System system;
  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors"
                                                           annotation(Dialog(tab="Advanced"));


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
    tau=0.2) annotation (Dialog(enable=true), Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,20})));

  Movers.SpeedControlled_Nrpm pump(redeclare final package Medium = Medium)
    annotation (Dialog(enable=true), Placement(transformation(extent={{18,10},{38,
            30}})));

  HydraulicModules.HydraulicBus hydraulicBus annotation (Placement(
        transformation(extent={{-20,80},{20,120}}), iconTransformation(extent={{
            -20,80},{20,120}})));
  FixedResistances.Pipe pipe1(
    redeclare final package Medium = Medium,
    T_start=T_start) annotation (Dialog(
        enable=true, group="Pipes"), Placement(transformation(extent={{-80,26},{
            -68,14}})));
  FixedResistances.Pipe pipe2(
    redeclare final package Medium = Medium,
    T_start=T_start) annotation (Dialog(
        enable=true, group="Pipes"), Placement(transformation(extent={{-6,26},{6,
            14}})));
  FixedResistances.Pipe pipe3(
    redeclare final package Medium = Medium,
    T_start=T_start) annotation (Dialog(
        enable=true, group="Pipes"), Placement(transformation(extent={{66,26},{78,
            14}})));
  FixedResistances.Pipe pipe4(
    redeclare final package Medium = Medium,
    T_start=T_start) annotation (Dialog(
        enable=true, group="Pipes"), Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={46,-60})));
  FixedResistances.Pipe pipe5(
    redeclare final package Medium = Medium,
    T_start=T_start) annotation (Dialog(
        enable=true, group="Pipes"), Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-68,-60})));
  FixedResistances.Pipe pipe6(
    redeclare final package Medium = Medium,
    T_start=T_start) annotation (Dialog(
        enable=true, group="Pipes"), Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-30,-22})));

  // -------------------------------------------------
  // Sensors
  // -------------------------------------------------
protected
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_out(redeclare package Medium =
        Medium) "Inflow into admix module in forward line" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,40})));
  Modelica.Fluid.Sensors.VolumeFlowRate VFSen_in(redeclare package Medium =
        Medium) "Out flow out of forward line" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={100,40})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,82})));
  Modelica.Blocks.Sources.RealExpression TfwrdIn(y=pipe1.pipe.mediums[1].T)
    "temperature of inflowing medium on forward line."
    annotation (Placement(transformation(extent={{-36,54},{-68,74}})));
  Modelica.Blocks.Sources.RealExpression TfwrdOut(y=pipe3.pipe.mediums[pipe3.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{44,56},{76,76}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Fwrd_out(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={84,84})));
  Modelica.Blocks.Sources.RealExpression TrtrnOut(y=pipe5.pipe.mediums[pipe5.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{-34,-98},{-66,-78}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Rtrn_out(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-100})));
  Modelica.Blocks.Continuous.FirstOrder Pt1Rtrn_in(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnIn(y=pipe4.pipe.mediums[1].T)
    "temperature of inflowing medium in return line."
    annotation (Placement(transformation(extent={{34,-98},{66,-78}})));
  Modelica.Fluid.Vessels.ClosedVolume junc456(
    nPorts=3,
    V=vol,
    use_portsData=false,
    redeclare package Medium = Medium,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-40,-60},{-24,-76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-2,-22})));


equation

  connect(pipe1.port_b, val.port_1)
    annotation (Line(points={{-67.76,20},{-40,20}}, color={0,127,255}));
  connect(val.port_2, pipe2.port_a)
    annotation (Line(points={{-20,20},{-6.24,20}}, color={0,127,255}));
  connect(pipe4.port_b, junc456.ports[1])
    annotation (Line(points={{39.76,-60},{-34.1333,-60}}, color={0,127,255}));
  connect(junc456.ports[2], pipe5.port_a)
    annotation (Line(points={{-32,-60},{-61.76,-60}}, color={0,127,255}));
  connect(junc456.ports[3], pipe6.port_a) annotation (Line(points={{-29.8667,
          -60},{-29.8667,-56},{-30,-56},{-30,-28.24}},
                                                  color={0,127,255}));
  connect(pipe6.port_b, val.port_3)
    annotation (Line(points={{-30,-15.76},{-30,10}}, color={0,127,255}));
  connect(prescribedTemperature.port, pipe6.heatPort_outside) annotation (Line(
        points={{-6,-22},{-16,-22},{-16,-21.04},{-26.64,-21.04}}, color={191,0,0}));
  connect(prescribedTemperature.port, pipe5.heatPort_outside) annotation (Line(
      points={{-6,-22},{-68.96,-22},{-68.96,-56.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe1.heatPort_outside) annotation (Line(
      points={{-6,-22},{-73.04,-22},{-73.04,16.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe2.heatPort_outside) annotation (Line(
      points={{-6,-22},{-4,-22},{-4,16.64},{0.96,16.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe4.heatPort_outside) annotation (Line(
      points={{-6,-22},{-10,-22},{-10,-36},{45.04,-36},{45.04,-56.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe3.heatPort_outside) annotation (Line(
      points={{-6,-22},{-6,4},{72.96,4},{72.96,16.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.T, hydraulicBus.T_amb) annotation (Line(
        points={{2.8,-22},{14,-22},{14,100.1},{0.1,100.1}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.port_b, pipe1.port_a) annotation (Line(points={{-100,30},{-100,
          20},{-80.24,20}}, color={0,127,255}));
  connect(pipe3.port_b, VFSen_in.port_a) annotation (Line(points={{78.24,20},{100,
          20},{100,30}}, color={0,127,255}));
  connect(TfwrdIn.y, Pt1Fwrd_in.u)
    annotation (Line(points={{-69.6,64},{-80,64},{-80,70}}, color={0,0,127}));
  connect(Pt1Fwrd_in.y, hydraulicBus.TFwrd_in) annotation (Line(
      points={{-80,93},{-80,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TfwrdOut.y, Pt1Fwrd_out.u)
    annotation (Line(points={{77.6,66},{84,66},{84,72}}, color={0,0,127}));
  connect(Pt1Fwrd_out.y, hydraulicBus.TFwrd_out) annotation (Line(
      points={{84,95},{84,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnOut.y, Pt1Rtrn_out.u)
    annotation (Line(points={{-67.6,-88},{-80,-88}}, color={0,0,127}));
  connect(Pt1Rtrn_out.y, hydraulicBus.TRtrn_out) annotation (Line(
      points={{-80,-111},{-80,-118},{-116,-118},{-116,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnIn.y, Pt1Rtrn_in.u)
    annotation (Line(points={{67.6,-88},{80,-88}}, color={0,0,127}));
  connect(Pt1Rtrn_in.y, hydraulicBus.TRtrn_in) annotation (Line(
      points={{80,-111},{80,-116},{116,-116},{116,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.V_flow, hydraulicBus.VF_in) annotation (Line(
      points={{-89,40},{-56,40},{-56,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_in.V_flow, hydraulicBus.VF_out) annotation (Line(
      points={{89,40},{50,40},{50,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.Nrpm, hydraulicBus.rpm_Input) annotation (Line(points={{28,32},{28,
          100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.P, hydraulicBus.P) annotation (Line(points={{39,29},{39,100.1},{0.1,
          100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe2.port_b, pump.port_a)
    annotation (Line(points={{6.24,20},{18,20}}, color={0,127,255}));
  connect(pump.port_b, pipe3.port_a)
    annotation (Line(points={{38,20},{65.76,20}}, color={0,127,255}));
  connect(VFSen_out.port_a, port_a1)
    annotation (Line(points={{-100,50},{-100,60}}, color={0,127,255}));
  connect(VFSen_in.port_b, port_b1)
    annotation (Line(points={{100,50},{100,60}}, color={0,127,255}));
  connect(pipe4.port_a, port_a2)
    annotation (Line(points={{52.24,-60},{100,-60}}, color={0,127,255}));
  connect(pipe5.port_b, port_b2)
    annotation (Line(points={{-74.24,-60},{-100,-60}}, color={0,127,255}));
  connect(val.y, hydraulicBus.valveSet) annotation (Line(points={{-30,32},{-30,100.1},
          {0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(val.y_actual, hydraulicBus.valveSetAct) annotation (Line(points={{-25,
          27},{-25,100.5},{0.1,100.5},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Documentation(info="<html>
<p>Admix circuit with a rpm controlled pump for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus (not all connections are visible).</p>
<h4>Characteristics</h4>
<p>There is a connecting pipe between distributer and collector of manifold so that the pressure difference between them becomes insignificant. The main pump only works against the resistance in the main circuit.</p>
<p>The mass flow in primary and secondary circuits stay constant.</p>
<p>The scondary circuits do not affect each other when switching operational modes.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Transfered to AixLib from ZUGABE.</li>
<li>July 25, 2017 by Peter Matthes:<br/>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li>February 6, 2016, by Peter Matthes:<br/>implemented bus-connector-C_H_HRMI_01 model for testing (extends from model with standard data ports)</li>
</ul>
</html>"),
    __Dymola_Commands,
    experiment(StopTime=86400),
    Icon(coordinateSystem(extent={{-100,-80},{100,100}}),
         graphics={
        Rectangle(
          extent={{-100,100},{100,-80}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,-60},{56,-82}},
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
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1),
        graphics={
        Text(
          extent={{-84,28},{-64,24}},
          lineColor={28,108,200},
          textString="Pipe 1"),
        Text(
          extent={{-10,28},{10,24}},
          lineColor={28,108,200},
          textString="Pipe 2"),
        Text(
          extent={{62,28},{82,24}},
          lineColor={28,108,200},
          textString="Pipe 3"),
        Text(
          extent={{-76,-64},{-56,-68}},
          lineColor={28,108,200},
          textString="Pipe 5"),
        Text(
          extent={{36,-64},{56,-68}},
          lineColor={28,108,200},
          textString="Pipe 4"),
        Text(
          extent={{-10,2},{10,-2}},
          lineColor={28,108,200},
          origin={-36,-22},
          rotation=90,
          textString="Pipe 6")}));
end Admix;
