within AixLib.Fluid.HydraulicModules;
model Admix "Admix circuit with three way valve and pump"
  import Zugabe;

  parameter Modelica.SIunits.Volume vol=0.0005 "Mixing Volume";
  parameter Modelica.SIunits.Temperature Tinit=303.15
    "Initialization temperature";
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors";

  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
  AixLib.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    l={0.001,0.001},
    Kv=10.0,
    m_flow_nominal=8*996/3600,
    dpFixed_nominal={8000,8000},
    redeclare package Medium = Medium,
    p_start=system.p_start,
    T_start=Tinit,
    init=Modelica.Blocks.Types.Init.NoInit,
    y_start=0.5,
    rhoStd=Medium.density_pTX(
        system.p_start,
        Tinit,
        Medium.X_default))             annotation (Dialog(enable=true),
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,12})));

public
  Modelica.Fluid.Interfaces.FluidPort_a port_fwrdIn(redeclare package Medium =
        Medium) "forward line inflowing medium" annotation (Placement(
        transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent=
            {{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_rtrnOut(redeclare package Medium =
        Medium) "Return line outflowing medium" annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
          extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_fwrdOut(redeclare package Medium =
        Medium) "forward line outflowing medium" annotation (Placement(
        transformation(extent={{90,50},{110,70}}), iconTransformation(extent={{
            90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_rtrnIn(redeclare package Medium =
        Medium) "Return line inflowing medium"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  HydraulicModules.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-60,80},{-20,120}})));
  FixedResistances.DPEAgg_ambientLoss pipe1(redeclare package Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(transformation(
          extent={{-80,18},{-68,6}})));
  FixedResistances.DPEAgg_ambientLoss                    pipe2(redeclare
      package                                                                    Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(transformation(
          extent={{-6,18},{6,6}})));
  FixedResistances.DPEAgg_ambientLoss                    pipe3(redeclare
      package                                                                    Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(transformation(
          extent={{66,18},{78,6}})));
  FixedResistances.DPEAgg_ambientLoss                    pipe4(redeclare
      package                                                                    Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={40,-60})));
protected
  Modelica.Fluid.Vessels.ClosedVolume junc456(
    nPorts=3,
    V=vol,
    use_portsData=false,
    redeclare package Medium = Medium,
    T_start=Tinit)
    annotation (Placement(transformation(extent={{-38,-60},{-22,-76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-2,-22})));
public
  FixedResistances.DPEAgg_ambientLoss                    pipe5(redeclare
      package                                                                    Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-50,-60})));
  FixedResistances.DPEAgg_ambientLoss                    pipe6(redeclare
      package                                                                    Medium = Medium,
      T_start=Tinit) annotation (Dialog(enable=true), Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-30,-22})));

  // -------------------------------------------------
  // Sensors
  // -------------------------------------------------
protected
  Modelica.Fluid.Sensors.VolumeFlowRate vFRfwrdIn(redeclare package Medium =
        Medium) "inflow into admix module in forward line" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-84,32})));
  Modelica.Fluid.Sensors.VolumeFlowRate vFRflowConsumer(redeclare package
      Medium = Medium) "out flow out of forward line" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={84,30})));
  Modelica.Blocks.Continuous.FirstOrder Pt1FwrdIn(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,82})));
  Modelica.Blocks.Sources.RealExpression TfwrdIn(y=pipe1.pipe.mediums[1].T)
    "temperature of inflowing medium on forward line."
    annotation (Placement(transformation(extent={{-36,54},{-68,74}})));
  Modelica.Blocks.Sources.RealExpression TfwrdOut(y=pipe3.pipe.mediums[pipe3.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{40,54},{72,74}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1FwrdOut(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,82})));
  Modelica.Blocks.Sources.RealExpression TrtrnOut(y=pipe5.pipe.mediums[pipe5.nNodes].T)
    "temperature of out flowing medium in forward line."
    annotation (Placement(transformation(extent={{-34,-98},{-66,-78}})));
  Modelica.Blocks.Continuous.FirstOrder Pt1RtrnOut(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,-100})));
  Modelica.Blocks.Continuous.FirstOrder Pt1RtrnIn(
    T=tau,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=Tinit) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,-100})));
  Modelica.Blocks.Sources.RealExpression TrtrnIn(y=pipe4.pipe.mediums[1].T)
    "temperature of inflowing medium in return line."
    annotation (Placement(transformation(extent={{34,-98},{66,-78}})));
public
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-10,-120},{10,-100}})));
  Movers.SpeedControlled_Nrpm pump(redeclare package Medium = Medium)
    annotation (Dialog(enable=true),Placement(transformation(extent={{26,2},{46,
            22}})));
equation

  connect(hydraulicBus.valveSet, val.y) annotation (Line(
      points={{-39.9,100.1},{-39.9,52},{-30,52},{-30,24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));

  connect(pipe1.port_b, val.port_1)
    annotation (Line(points={{-67.76,12},{-40,12}},
                                                  color={0,127,255}));
  connect(val.port_2, pipe2.port_a)
    annotation (Line(points={{-20,12},{-6.24,12}},
                                                 color={0,127,255}));
  connect(pipe4.port_b, junc456.ports[1])
    annotation (Line(points={{33.76,-60},{-32.1333,-60}}, color={0,127,255}));
  connect(junc456.ports[2], pipe5.port_a)
    annotation (Line(points={{-30,-60},{-43.76,-60}}, color={0,127,255}));
  connect(junc456.ports[3], pipe6.port_a) annotation (Line(points={{-27.8667,
          -60},{-27.8667,-56},{-28,-56},{-28,-28.24},{-30,-28.24}},
                                                             color={0,127,255}));
  connect(pipe6.port_b, val.port_3)
    annotation (Line(points={{-30,-15.76},{-30,2}},   color={0,127,255}));
  connect(prescribedTemperature.port, pipe6.heatPort_outside)
    annotation (Line(points={{-6,-22},{-16,-22},{-16,-21.04},{-26.64,-21.04}},
                                                     color={191,0,0}));
  connect(prescribedTemperature.port, pipe5.heatPort_outside) annotation (Line(
      points={{-6,-22},{-50.96,-22},{-50.96,-56.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe1.heatPort_outside) annotation (Line(
      points={{-6,-22},{-73.04,-22},{-73.04,8.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe2.heatPort_outside) annotation (Line(
      points={{-6,-22},{-4,-22},{-4,8.64},{0.96,8.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe4.heatPort_outside) annotation (Line(
      points={{-6,-22},{-10,-22},{-10,-36},{39.04,-36},{39.04,-56.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.port, pipe3.heatPort_outside) annotation (Line(
      points={{-6,-22},{-6,4},{72.96,4},{72.96,8.64}},
      color={191,0,0},
      visible=false));
  connect(prescribedTemperature.T, hydraulicBus.Tambient) annotation (Line(
        points={{2.8,-22},{14,-22},{14,100.1},{-39.9,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRfwrdIn.port_b, pipe1.port_a)
    annotation (Line(points={{-84,22},{-84,12},{-80.24,12}},
                                                           color={0,127,255}));
  connect(pipe3.port_b, vFRflowConsumer.port_a)
    annotation (Line(points={{78.24,12},{84,12},{84,20}},
                                                       color={0,127,255}));
  connect(port_fwrdIn, vFRfwrdIn.port_a)
    annotation (Line(points={{-100,60},{-84,60},{-84,42}}, color={0,127,255}));
  connect(TfwrdIn.y, Pt1FwrdIn.u)
    annotation (Line(points={{-69.6,64},{-80,64},{-80,70}}, color={0,0,127}));
  connect(Pt1FwrdIn.y, hydraulicBus.TfwrdIn) annotation (Line(points={{-80,93},
          {-80,100.1},{-39.9,100.1}}, color={0,0,127},visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRflowConsumer.port_b, port_fwrdOut)
    annotation (Line(points={{84,40},{84,60},{100,60}}, color={0,127,255}));
  connect(TfwrdOut.y, Pt1FwrdOut.u)
    annotation (Line(points={{73.6,64},{80,64},{80,70}}, color={0,0,127}));
  connect(Pt1FwrdOut.y, hydraulicBus.TfwrdOut) annotation (Line(points={{80,93},
          {80,100.1},{-39.9,100.1}}, color={0,0,127},visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TrtrnOut.y, Pt1RtrnOut.u)
    annotation (Line(points={{-67.6,-88},{-80,-88}}, color={0,0,127}));
  connect(pipe5.port_b, port_rtrnOut)
    annotation (Line(points={{-56.24,-60},{-100,-60}}, color={0,127,255}));
  connect(Pt1RtrnOut.y, hydraulicBus.TrtrnOut) annotation (Line(points={{-80,-111},
          {-80,-118},{-116,-118},{-116,100.1},{-39.9,100.1}}, color={0,0,127},visible=false),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(port_rtrnIn, pipe4.port_a)
    annotation (Line(points={{100,-60},{46.24,-60}}, color={0,127,255}));
  connect(TrtrnIn.y, Pt1RtrnIn.u)
    annotation (Line(points={{67.6,-88},{80,-88}}, color={0,0,127}));
  connect(Pt1RtrnIn.y, hydraulicBus.TrtrnIn) annotation (Line(points={{80,-111},
          {80,-116},{116,-116},{116,100.1},{-39.9,100.1}}, color={0,0,127},visible=false),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRfwrdIn.V_flow, hydraulicBus.vFRfwrdIn) annotation (Line(points={{-73,32},
          {-56,32},{-56,100},{-40,100}},         color={0,0,127},visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(vFRflowConsumer.V_flow, hydraulicBus.vFRfwrdOut) annotation (Line(
        points={{73,30},{50,30},{50,100},{-40,100}}, color={0,0,127},visible=false), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.Nrpm, hydraulicBus.rpm_Input) annotation (Line(points={{36,24},{
          32,24},{32,76},{-30,76},{-30,100.1},{-39.9,100.1}},
                                                           color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.P, hydraulicBus.P) annotation (Line(points={{47,21},{47,100.1},{
          -39.9,100.1}},
                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pipe2.port_b, pump.port_a)
    annotation (Line(points={{6.24,12},{26,12}},
                                               color={0,127,255}));
  connect(pump.port_b, pipe3.port_a)
    annotation (Line(points={{46,12},{65.76,12}},
                                                color={0,127,255}));
  annotation (
    Documentation(info="<html>
<h4>Characteristics</h4>
<p><br>There is a connecting pipe between distributer and collector of manifold so that the pressure difference between them becomes insignificant. The main pump only works against the resistance in the main circuit.</p>
<p>The mass flow in primary and secondary circuits stay constant.</p>
<p>The scondary circuits do not affect each other when switching operational modes.</p>
</html>", revisions="<html>
<ul>
<li>2017-07-25 by Peter Matthes:<br>Renames sensors and introduces PT1 behavior for temperature sensors. Adds sensors to icon.</li>
<li><i>2016-02-06 &nbsp;</i> by Peter Matthes:<br>implemented bus-connector-C_H_HRMI_01 model for testing (extends from model with standard data ports)</li>
</ul>
</html>"),
    __Dymola_Commands,
    experiment(StopTime=86400),
    Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,-80},{60,-120}},
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
          points={{-60,50},{-60,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,60},{-84,60},{-84,40},{84,40},{84,60},{90,60}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{6,60},{46,20}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{26,60},{46,40},{26,20}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-52,30},{-52,50},{-32,40},{-52,30}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,30},{-12,50},{-32,40},{-12,30}},
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
          origin={-32,30},
          rotation=0),
        Ellipse(
          extent={{-38,60},{-26,48}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-32,48},{-32,40}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{-90,-60},{-84,-60},{-84,-40},{84,-40},{84,-60},{90,-60}},
          color={0,128,255},
          thickness=0.5),
        Line(
          points={{-32,20},{-32,-40}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{-34,-38},{-30,-42}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
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
        Line(points={{70,-34},{70,-40}}, color={0,0,0})}),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)));
end Admix;
