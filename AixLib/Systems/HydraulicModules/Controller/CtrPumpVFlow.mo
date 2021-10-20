﻿within AixLib.Systems.HydraulicModules.Controller;
block CtrPumpVFlow
  "Volume Flow Set Point Controller for variable Speed pumps"
         Modelica.Blocks.Interfaces.RealInput vFlowAct
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent=
           {{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput vFlowSet if
                                               useExternalVset
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
          extent={{-140,-80},{-100,-40}})));
public
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{76,-24},{124,24}}),
        iconTransformation(extent={{90,-22},{138,26}})));
          parameter Boolean useExternalVset = false "If True, set Volume Flow can be given externally";
  parameter Modelica.SIunits.VolumeFlowRate vFlowSetCon = 0.01 "Volume Flow in m³/s set point of consumer";
  parameter Real k(min=0, unit="1") = 100 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=30
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time Td(min=0)= 4 "Time constant of Derivative block";
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm rpm_pump_max(min=0) = 2000 "Rpm of the Pump";
  parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(group="PID"));
  parameter Boolean reverseAction = true
    "Set to true if heating system, and false for cooling system";
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));
  Modelica.Blocks.Sources.Constant constVflowSet(final k=vFlowSetCon) if not useExternalVset annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  AixLib.Controls.Continuous.LimPID PID(
    final yMax=rpm_pump_max,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k,
    final Ti=Ti,
    final Td=Td,
    final initType=initType,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    final reverseActing=reverseAction)
            annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));

  Modelica.Blocks.Logical.GreaterThreshold
                                        pumpSwitchOff(final threshold=0)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Sources.Constant constValvSet(final k=1) if         not useExternalVset
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation

    connect(PID.u_s,vFlowSet)  annotation (Line(
      points={{-22,-50},{-67.1,-50},{-67.1,-60},{-120,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(constVflowSet.y, PID.u_s) annotation (Line(
      points={{-79,-20},{-66,-20},{-66,-50},{-22,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(PID.u_m,vFlowAct)
    annotation (Line(points={{-10,-38},{-10,60},{-120,60}},        color={0,0,127}));
  connect(PID.y,pumpSwitchOff. u)
    annotation (Line(points={{1,-50},{8,-50},{8,40},{18,40}},   color={0,0,127}));
  connect(pumpSwitchOff.y, hydraulicBus.pumpBus.onSet) annotation (Line(points={{41,40},
          {100.12,40},{100.12,0.12}},            color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{1,-50},
          {100,-50},{100,0.12},{100.12,0.12}},
                                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constValvSet.y, hydraulicBus.valveSet) annotation (Line(points={{41,0},{
          48,0},{48,0.12},{100.12,0.12}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-36,-2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,20},{98,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-36,-2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,20},{98,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
            Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-36,-2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,20},{98,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html><ul>
  <li>April 14, 2021, by Phillip Stoffel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple controller for Throttle and ThrottlePump circuit that is based
  on a PID controller. The controlled variable needs to be connected to
  vFlowAct.
</p>
<p>
  The controller adjusts the pump speed to archive the specified volume
  flow
</p>
</html>"));
end CtrPumpVFlow;
