within AixLib.Systems.EONERC_MainBuilding.Controller;
model CtrTabsQflow "Power based Controller for concrete core activation"
  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Modelica.Units.SI.Temperature TflowSet=293.15   "Flow temperature set point of consumer";
  parameter Real k(unit="1")=0.03          "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small)=60
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time Td(min=0)= 0 "Time constant of Derivative block";
  parameter Real rpm_pump(unit="1")=3000          "Rpm of the Pump";
//   parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
//     "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
//     annotation(Dialog(group="PID"));
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

  EONERC_MainBuilding.BaseClasses.TabsBus2 tabsBus annotation (Placement(
        transformation(extent={{84,-18},{118,18}}), iconTransformation(extent={
            {88,-14},{112,14}})));
  HydraulicModules.Controller.CtrPump ctrPump(rpm_pump=2500)
    annotation (Placement(transformation(extent={{-20,58},{0,78}})));
  HydraulicModules.Controller.CtrThrottleQFlow ctrThrottleHotQFlow(
      useExternalQset=true, reverseAction=true)
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  HydraulicModules.Controller.CtrThrottleQFlow ctrThrottleColdQFlow(
      useExternalQset=true, reverseAction=false)
    annotation (Placement(transformation(extent={{52,-68},{72,-48}})));
  HydraulicModules.Controller.CalcHydraulicPower calcHydraulicPower
    annotation (Placement(transformation(extent={{0,28},{-20,48}})));
  Modelica.Blocks.Interfaces.RealInput QFlowSet
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-120,-16},{-86,18}}), iconTransformation(extent=
           {{-120,-16},{-86,18}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-22,2},{-6,18}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-18,-58},{-2,-42}})));
  Modelica.Blocks.Math.Max max3
    annotation (Placement(transformation(extent={{20,14},{30,24}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{16,-40},{26,-30}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{98,80},{118,100}})));
equation
  connect(ctrPump.hydraulicBus, tabsBus.pumpBus) annotation (Line(
      points={{1.4,68.2},{42,68.2},{42,70},{102,70},{102,36},{101.085,36},{101.085,
          0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(calcHydraulicPower.hydraulicBus, tabsBus.pumpBus) annotation (Line(
      points={{0,38},{101.085,38},{101.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleHotQFlow.hydraulicBus, tabsBus.hotThrottleBus) annotation (
     Line(
      points={{73.4,0.2},{101.7,0.2},{101.7,0.09},{101.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleColdQFlow.hydraulicBus, tabsBus.coldThrottleBus)
    annotation (Line(
      points={{73.4,-57.8},{101.085,-57.8},{101.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(max3.u2, const.y) annotation (Line(points={{19,16},{16,16},{16,14},{
          14,14},{14,10},{-5.2,10}},
                     color={0,0,127}));
  connect(const1.y, min1.u2) annotation (Line(points={{-1.2,-50},{10,-50},{10,
          -38},{15,-38}},     color={0,0,127}));
  connect(max3.y, ctrThrottleHotQFlow.Q_flowMea) annotation (Line(points={{30.5,
          19},{30.5,18},{44,18},{44,6},{50,6}}, color={0,0,127}));
  connect(min1.y, ctrThrottleColdQFlow.Q_flowMea) annotation (Line(points={{
          26.5,-35},{44,-35},{44,-52},{50,-52}}, color={0,0,127}));
  connect(QFlowSet, ctrThrottleColdQFlow.Q_flowSet) annotation (Line(points={{
          -103,1},{-50,1},{-50,-6},{40,-6},{40,-63},{50,-63}}, color={0,0,127}));
  connect(QFlowSet, ctrThrottleHotQFlow.Q_flowSet) annotation (Line(points={{
          -103,1},{-50,1},{-50,-5},{50,-5}}, color={0,0,127}));
  connect(min1.u1, calcHydraulicPower.Q_flow) annotation (Line(points={{15,-32},
          {-16,-32},{-16,-30},{-54,-30},{-54,38},{-20.8,38}}, color={0,0,127}));
  connect(max3.u1, calcHydraulicPower.Q_flow) annotation (Line(points={{19,22},
          {-38,22},{-38,38},{-20.8,38}}, color={0,0,127}));
  connect(calcHydraulicPower.Q_flow, Q_flow1) annotation (Line(points={{-20.8,
          38},{-24,38},{-24,90},{108,90}}, color={0,0,127}));
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
end CtrTabsQflow;
