within AixLib.Systems.Benchmark.Controller;
model CtrTabs "Controller for concrete core activation"
  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Modelica.SIunits.Temperature TflowSet = 293.15 "Flow temperature set point of consumer";
  parameter Real k(min=0, unit="1") = 0.03 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=60
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time Td(min=0)= 0 "Time constant of Derivative block";
  parameter Real rpm_pump(min=0, unit="1") = 3000 "Rpm of the Pump";
  parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(group="PID"));
  parameter Boolean reverseAction = false
    "Set to true for throttling the water flow rate through a cooling coil controller";
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));

  BaseClasses.TabsBus tabsBus annotation (Placement(transformation(extent={{82,-20},
            {120,20}}), iconTransformation(extent={{86,-16},{118,20}})));
  Controls.Continuous.LimPID PID(
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
    y_reset=0,
    reverseActing=not (true))
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{60,70},
            {80,90}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Controls.Continuous.LimPID PID1(
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
    y_reset=0,
    reverseActing=not (false))
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Logical.Greater heatingMode
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-20,64},{-8,76}})));
equation
    connect(PID.u_s,Tset)  annotation (Line(
      points={{-22,-30},{-47.1,-30},{-47.1,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(constTflowSet.y, PID.u_s) annotation (Line(
      points={{-79,-50},{-48,-50},{-48,-30},{-22,-30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanConstant.y, tabsBus.admixBus.pumpBus.onSet) annotation (
      Line(points={{81,50},{100,50},{100,0.1},{101.095,0.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constRpmPump.y, tabsBus.admixBus.pumpBus.rpmSet) annotation (Line(
        points={{81,80},{100,80},{100,20},{101.095,20},{101.095,0.1}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID1.u_m, tabsBus.admixBus.TFwrdOutMea) annotation (Line(points={{-10,
          18},{100,18},{100,0.1},{101.095,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.u_m, tabsBus.admixBus.TFwrdOutMea) annotation (Line(points={{-10,-42},
          {100,-42},{100,-22},{101.095,-22},{101.095,0.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID1.y, switch1.u1) annotation (Line(points={{1,30},{14,30},{14,-2},{18,
          -2}}, color={0,0,127}));
  connect(PID.y, switch1.u3) annotation (Line(points={{1,-30},{6,-30},{6,-22},{18,
          -22},{18,-18}}, color={0,0,127}));
  connect(switch1.y, tabsBus.admixBus.valveSet) annotation (Line(points={{41,-10},
          {58,-10},{58,-8},{101.095,-8},{101.095,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Tset, PID1.u_s) annotation (Line(
      points={{-120,0},{-48,0},{-48,30},{-22,30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constTflowSet.y, PID1.u_s) annotation (Line(
      points={{-79,-50},{-48,-50},{-48,30},{-22,30}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatingMode.u2, tabsBus.admixBus.TRtrnInMea) annotation (Line(points={
          {-62,62},{-100,62},{-100,100},{101.095,100},{101.095,0.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatingMode.y, switch1.u2) annotation (Line(points={{-39,70},{-32,70},
          {-32,-10},{18,-10}}, color={255,0,255}));
  connect(booleanToReal.y, tabsBus.valveSet) annotation (Line(points={{21,70},{
          32,70},{32,100},{101,100},{101,0}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatingMode.y, not1.u)
    annotation (Line(points={{-39,70},{-21.2,70}}, color={255,0,255}));
  connect(not1.y, booleanToReal.u)
    annotation (Line(points={{-7.4,70},{-2,70}}, color={255,0,255}));
  connect(constTflowSet.y, heatingMode.u1) annotation (Line(
      points={{-79,-50},{-76,-50},{-76,70},{-62,70}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatingMode.u1, Tset) annotation (Line(
      points={{-62,70},{-76,70},{-76,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-80,20},{66,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control"),
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,100},{-38,0},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,24},{98,-16}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end CtrTabs;
