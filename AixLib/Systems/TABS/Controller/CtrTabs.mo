within AixLib.Systems.TABS.Controller;
model CtrTabs "Controller for concrete core activation"
  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Modelica.SIunits.Temperature TflowSet = 293.15 "Flow temperature set point of consumer";


  parameter Real k_hot(min=0, unit="1") = 0.03 "Gain of controller for the hot throttle circuit" annotation(Dialog(group="Hot water supply circuit"));
  parameter Modelica.SIunits.Time Ti_hot(min=Modelica.Constants.small)=60
    "Time constant of Integrator block for the hot throttle circuit" annotation(Dialog(group="Hot water supply circuit"));
  parameter Real rpm_pump_hot(min=0, unit="1") = 3000 "Rpm of the pump of the hot throttle circuit" annotation(Dialog(group="Hot water supply circuit"));

  parameter Real k_cold(min=0, unit="1") = 0.03 "Gain of controller for the cold throttle circuit" annotation(Dialog(group="Cold water supply circuit"));
  parameter Modelica.SIunits.Time Ti_cold(min=Modelica.Constants.small)=60
    "Time constant of Integrator block the cold throttle circuit" annotation(Dialog(group="Cold water supply circuit"));
  parameter Real rpm_pump_cold(min=0, unit="1") = 3000 "Rpm of the pump of the cold throttle circuit" annotation(Dialog(group="Cold water supply circuit"));


  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm
  rpm_pump_concrete=2500
  "Rpm of the Pump that supplies the concrete core" annotation(Dialog(group="Concrete supply circuit"));

  Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,
            -60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  TABS.BaseClasses.TabsBus tabsBus annotation (Placement(
        transformation(extent={{82,-18},{116,18}}), iconTransformation(extent={
            {88,-14},{112,14}})));
  HydraulicModules.Controller.CtrThrottle ctrThrottleHot(
    final useExternalTset=true,
    final k=k_hot,
    final Ti=Ti_hot,
    final Td=0,
    final rpm_pump=rpm_pump_hot,
    final reverseAction)
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  HydraulicModules.Controller.CtrThrottle ctrThrottleCold(
    final useExternalTset=true,
    final k=k_cold,
    final Ti=Ti_cold,
    final Td=0,
    rpm_pump=rpm_pump_cold,
      reverseAction=false)
    annotation (Placement(transformation(extent={{-18,-40},{2,-20}})));
  HydraulicModules.Controller.CtrPump ctrPump(rpm_pump=rpm_pump_concrete)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-48,20},{-38,30}})));
  Modelica.Blocks.Sources.Constant constTflowSet1(final k=0.15)  annotation (Placement(transformation(extent={{-62,18},
            {-54,26}})));
  Modelica.Blocks.Math.Add add1(k2=+1)
    annotation (Placement(transformation(extent={{-42,-42},{-32,-32}})));
  Modelica.Blocks.Sources.Constant constTflowSet2(final k=offset)
                                                                annotation (Placement(transformation(extent={{-56,-44},
            {-48,-36}})));

  parameter Real offset=0.1
    "Constant offset between cooling and heating setpoint to avoid oscillations and simultaneous cooling and heating.";
equation
  connect(ctrPump.hydraulicBus, tabsBus.pumpBus) annotation (Line(
      points={{1.4,70.2},{40,70.2},{40,70},{100,70},{100,36},{99.085,36},{
          99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
           false)),
    Documentation(info="<html><p>
  Simple controller for TABS. The temperature of the water that flows
  into the concrete is controlled.
</p>
</html>", revisions="<html>
<ul>
  <li>December 09, 2021, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end CtrTabs;
