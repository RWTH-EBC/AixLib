within AixLib.Systems.HydraulicModules.Controller;
block CtrThrottleQFlow
  "Volume Flow Set Point Controller for Throttles"
         Modelica.Blocks.Interfaces.RealInput Q_flowMea
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent=
           {{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowSet
                                            if useExternalQset
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-140,-70},{-100,-30}}), iconTransformation(
          extent={{-140,-70},{-100,-30}})));
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{76,-24},{124,24}}),
        iconTransformation(extent={{90,-22},{138,26}})));

  parameter Boolean useExternalQset = false "If True, set Volume Flow can be given externally";
  parameter Modelica.Units.SI.Power Q_flowSetCon=0
    "Power set point of consumer in W";
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 130
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time Td(min=0) = 4
    "Time constant of Derivative block";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump(min=0) = 2000
    "Rpm of the Pump";
  parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PID"));
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
  Modelica.Blocks.Sources.Constant constQ_flowSet(final k=Q_flowSetCon)
                                                                      if not useExternalQset
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  AixLib.Controls.Continuous.LimPID PID(
    final yMax=1,
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
  Modelica.Blocks.Sources.Constant constPumpSet(final k=rpm_pump)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation

  connect(PID.u_s, Q_flowSet) annotation (Line(
      points={{-22,-50},{-120,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constQ_flowSet.y, PID.u_s) annotation (Line(
      points={{-79,0},{-66,0},{-66,-50},{-22,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(PID.u_m, Q_flowMea)
    annotation (Line(points={{-10,-38},{-10,60},{-120,60}}, color={0,0,127}));
  connect(PID.y,pumpSwitchOff. u)
    annotation (Line(points={{1,-50},{8,-50},{8,40},{18,40}},   color={0,0,127}));
  connect(pumpSwitchOff.y, hydraulicBus.pumpBus.onSet) annotation (Line(points={{41,40},
          {100.12,40},{100.12,0.12}},            color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constPumpSet.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
          {41,0},{70,0},{70,0.12},{100.12,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.y, hydraulicBus.valveSet) annotation (Line(points={{1,-50},{100,-50},
          {100,0.12},{100.12,0.12}}, color={0,0,127}), Text(
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
  QFlowAct. The set point can be passed externally or as parameter.
</p>
<p>
  The controller adjusts the valve to archieve the specified thermal
  Power
</p>
</html>"));
end CtrThrottleQFlow;
