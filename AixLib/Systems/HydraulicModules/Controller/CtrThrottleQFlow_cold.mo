within AixLib.Systems.HydraulicModules.Controller;
block CtrThrottleQFlow_cold "Volume Flow Set Point Controller for Throttles"
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
  parameter Real k(unit="1")=0.025          "Gain of controller" annotation(Evaluate=false);
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 130
    "Time constant of Integrator block" annotation(Evaluate=false);
  parameter Modelica.Units.SI.Time Td(min=0) = 4
    "Time constant of Derivative block";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump(min=0) = 2000
    "Rpm of the Pump";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
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
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final Td=Td,
    final initType=initType,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    final reverseActing=reverseAction,
    reset=AixLib.Types.Reset.Parameter)
            annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));

  Modelica.Blocks.Sources.Constant constPumpSet(final k=rpm_pump)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold
                                        pumpSwitchOff1(final threshold=0)
    annotation (Placement(transformation(extent={{-32,-88},{-12,-68}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{34,-58},{54,-78}})));
  Modelica.Blocks.Sources.Constant lowerBound(final k=0)
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Modelica.Blocks.Logical.OnOffController
                                        pumpSwitchOff2(bandwidth=0.005)
    annotation (Placement(transformation(extent={{32,48},{52,68}})));
  Modelica.Blocks.Logical.Not           pumpSwitchOff3
    annotation (Placement(transformation(extent={{72,48},{92,68}})));
  Modelica.Blocks.Sources.Constant valveReference(final k=0.01)
    annotation (Placement(transformation(extent={{0,78},{20,98}})));
  Modelica.Blocks.Math.Min min2 annotation (Placement(transformation(extent={{-52,-36},{-32,-16}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-72,4},{-52,24}})));
equation

  connect(constPumpSet.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
          {41,0},{70,0},{70,0.12},{100.12,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q_flowSet, pumpSwitchOff1.u) annotation (Line(points={{-120,-50},{-40,
          -50},{-40,-78},{-34,-78}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pumpSwitchOff1.y, switch1.u2) annotation (Line(points={{-11,-78},{24,
          -78},{24,-68},{32,-68}}, color={255,0,255}));
  connect(switch1.y, hydraulicBus.valveSet) annotation (Line(points={{55,-68},{
          100.12,-68},{100.12,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(lowerBound.y, switch1.u1)
    annotation (Line(points={{21,-90},{32,-90},{32,-76}}, color={0,0,127}));
  connect(PID.y, switch1.u3) annotation (Line(points={{1,-50},{24,-50},{24,-60},
          {32,-60}}, color={0,0,127}));
  connect(pumpSwitchOff2.y, pumpSwitchOff3.u)
    annotation (Line(points={{53,58},{70,58}}, color={255,0,255}));
  connect(pumpSwitchOff3.y, hydraulicBus.pumpBus.onSet) annotation (Line(points={{93,58},
          {100.12,58},{100.12,0.12}},         color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valveReference.y, pumpSwitchOff2.reference) annotation (Line(points={
          {21,88},{26,88},{26,64},{30,64}}, color={0,0,127}));
  connect(switch1.y, pumpSwitchOff2.u) annotation (Line(points={{55,-68},{60,
          -68},{60,36},{10,36},{10,52},{30,52}}, color={0,0,127}));
  connect(min2.u1, const1.y)
    annotation (Line(points={{-54,-20},{-54,0},{-48,0},{-48,14},{-51,14}}, color={0,0,127}));
  connect(min2.u2, Q_flowSet)
    annotation (Line(points={{-54,-32},{-90,-32},{-90,-50},{-120,-50}}, color={0,0,127}));
  connect(min2.y, PID.u_s)
    annotation (Line(points={{-31,-26},{-28,-26},{-28,-50},{-22,-50}}, color={0,0,127}));
  connect(constQ_flowSet.y, PID.u_s)
    annotation (Line(points={{-79,0},{-76,0},{-76,-50},{-22,-50}}, color={0,0,127}));
  connect(PID.u_m, Q_flowMea) annotation (Line(points={{-10,-38},{-10,60},{-120,60}}, color={0,0,127}));
  connect(pumpSwitchOff1.y, PID.trigger)
    annotation (Line(points={{-11,-78},{8,-78},{8,-28},{-18,-28},{-18,-38}}, color={255,0,255}));
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
end CtrThrottleQFlow_cold;
