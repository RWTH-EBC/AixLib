within AixLib.Systems.Benchmark.Controller;
model CtrTabs2 "Controller for concrete core activation"
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

  Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,
            -60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  BaseClasses.TabsBus2 tabsBus annotation (Placement(transformation(extent={{82,
            -18},{116,18}}), iconTransformation(extent={{88,-14},{112,14}})));
  HydraulicModules.Controller.CtrThrottle ctrThrottleHot(useExternalTset=true)
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  HydraulicModules.Controller.CtrThrottle ctrThrottleCold(useExternalTset=true,
      reverseAction=true)
    annotation (Placement(transformation(extent={{-18,-40},{2,-20}})));
  HydraulicModules.Controller.CtrPump ctrPump
    annotation (Placement(transformation(extent={{-18,60},{2,80}})));
equation
  connect(ctrPump.hydraulicBus, tabsBus.pumpBus) annotation (Line(
      points={{2.1,70},{40,70},{40,72},{99.085,72},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constTflowSet.y, ctrThrottleCold.Tset) annotation (Line(
      points={{-79,-50},{-40,-50},{-40,-36},{-20,-36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constTflowSet.y, ctrThrottleHot.Tset) annotation (Line(
      points={{-79,-50},{-40,-50},{-40,26},{-22,26}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Tset, ctrThrottleHot.Tset) annotation (Line(
      points={{-120,0},{-60,0},{-60,26},{-22,26}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Tset, ctrThrottleCold.Tset) annotation (Line(
      points={{-120,0},{-60,0},{-60,-36},{-20,-36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ctrThrottleHot.Tact, tabsBus.pumpBus.TFwrd_out) annotation (Line(
        points={{-22,38},{-22,52},{99.085,52},{99.085,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrThrottleCold.Tact, tabsBus.pumpBus.TFwrd_out) annotation (Line(
        points={{-20,-24},{-20,-4},{99.085,-4},{99.085,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleCold.hydraulicBus, tabsBus.coldThrottleBus) annotation (
      Line(
      points={{1.3,-31.1},{99.085,-31.1},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleHot.hydraulicBus, tabsBus.hotThrottleBus) annotation (Line(
      points={{-0.7,30.9},{99.085,30.9},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
end CtrTabs2;
