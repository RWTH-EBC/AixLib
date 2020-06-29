within AixLib.Systems.Benchmark_old.Controller;
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
  HydraulicModules_old.Controller.CtrThrottle ctrThrottleHot(useExternalTset=
        true) annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  HydraulicModules_old.Controller.CtrThrottle ctrThrottleCold(useExternalTset=
        true, reverseAction=true)
    annotation (Placement(transformation(extent={{-18,-40},{2,-20}})));
  HydraulicModules_old.Controller.CtrPump ctrPump(rpm_pump=2500)
    annotation (Placement(transformation(extent={{-18,60},{2,80}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-48,20},{-38,30}})));
  Modelica.Blocks.Sources.Constant constTflowSet1(final k=0.25)  annotation (Placement(transformation(extent={{-62,18},
            {-54,26}})));
  Modelica.Blocks.Math.Add add1(k2=+1)
    annotation (Placement(transformation(extent={{-42,-42},{-32,-32}})));
  Modelica.Blocks.Sources.Constant constTflowSet2(final k=0.25) annotation (Placement(transformation(extent={{-56,-44},
            {-48,-36}})));
equation
  connect(ctrPump.hydraulicBus, tabsBus.pumpBus) annotation (Line(points = {{3.4, 70.2}, {40, 70.2}, {40, 70}, {99.085, 70}, {99.085, 0.09}}, color = {255, 204, 51}, thickness = 0.5));
  connect(ctrThrottleHot.Tact, tabsBus.pumpBus.TFwrdOutMea) annotation (Line(
        points={{-22,38},{-22,52},{99.085,52},{99.085,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrThrottleCold.Tact, tabsBus.pumpBus.TFwrdOutMea) annotation (Line(
        points={{-20,-24},{-20,-4},{99.085,-4},{99.085,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleCold.hydraulicBus, tabsBus.coldThrottleBus) annotation (
      Line(
      points={{3.4,-29.8},{99.085,-29.8},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleHot.hydraulicBus, tabsBus.hotThrottleBus) annotation (Line(
      points={{1.4,32.2},{99.085,32.2},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constTflowSet1.y, add.u2)
    annotation (Line(points={{-53.6,22},{-49,22}}, color={0,0,127}));
  connect(add.y, ctrThrottleHot.Tset) annotation (Line(points={{-37.5,25},{-29.75,
          25},{-29.75,26},{-22,26}}, color={0,0,127}));
  connect(constTflowSet2.y, add1.u2)
    annotation (Line(points={{-47.6,-40},{-43,-40}}, color={0,0,127}));
  connect(add1.y, ctrThrottleCold.Tset) annotation (Line(points={{-31.5,-37},{-26.75,
          -37},{-26.75,-36},{-20,-36}}, color={0,0,127}));
  connect(constTflowSet.y, add1.u1) annotation (Line(
      points={{-79,-50},{-76,-50},{-76,-34},{-43,-34}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constTflowSet.y, add.u1) annotation (Line(
      points={{-79,-50},{-72,-50},{-72,28},{-49,28}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Tset, add.u1) annotation (Line(
      points={{-120,0},{-76,0},{-76,28},{-49,28}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Tset, add1.u1) annotation (Line(
      points={{-120,0},{-76,0},{-76,-34},{-43,-34}},
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
end CtrTabs2;
