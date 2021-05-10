within AixLib.Systems.Benchmark.Controller;
model CtrTabsVSet "Controller for concrete core activation"

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

  EONERC_MainBuilding.BaseClasses.TabsBus2 tabsBus annotation (Placement(
        transformation(extent={{82,-18},{116,18}}), iconTransformation(extent={
            {88,-14},{112,14}})));
  HydraulicModules.Controller.CtrPump ctrPump(rpm_pump=2500)
    annotation (Placement(transformation(extent={{-18,60},{2,80}})));
  Modelica.Blocks.Interfaces.RealInput vFlowHotSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-114,30},{-92,52}})));
  Modelica.Blocks.Interfaces.RealInput vFlowColdSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-114,-52},{-92,-30}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-68,16},{-48,36}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec1(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-68,-46},{-48,-26}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr(
    useExternalVset=true,
    k=1500,
    Ti=130,
    Td=0,
    rpm_pump=3580)
          annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr1(
    useExternalVset=true,
    k=1500,
    Ti=130,
    Td=0,
    rpm_pump=3580)
          annotation (Placement(transformation(extent={{-18,24},{2,44}})));
equation
  connect(ctrPump.hydraulicBus, tabsBus.pumpBus) annotation (Line(
      points={{3.4,70.2},{40,70.2},{40,72},{99.085,72},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(vFlowHotSet, toCubicMetersPerSec.u) annotation (Line(points={{-103,41},
          {-86.5,41},{-86.5,26},{-70,26}}, color={0,0,127}));
  connect(toCubicMetersPerSec1.u, vFlowColdSet) annotation (Line(points={{-70,
          -36},{-82,-36},{-82,-41},{-103,-41}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr1.hydraulicBus, tabsBus.hotThrottleBus)
    annotation (Line(
      points={{3.4,34.2},{98.7,34.2},{98.7,0.09},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr.hydraulicBus, tabsBus.coldThrottleBus)
    annotation (Line(
      points={{5.4,-29.8},{97.7,-29.8},{97.7,0.09},{99.085,0.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(toCubicMetersPerSec.y, ctrThrottleVflowCtr1.Vset) annotation (Line(
        points={{-47,26},{-34,26},{-34,28},{-20,28}}, color={0,0,127}));
  connect(toCubicMetersPerSec1.y, ctrThrottleVflowCtr.Vset) annotation (Line(
        points={{-47,-36},{-32,-36},{-32,-36},{-18,-36}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr1.Vact, tabsBus.hotThrottleBus.VFlowOutMea)
    annotation (Line(points={{-20,40},{-32,40},{-32,52},{99.085,52},{99.085,
          0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr.Vact, tabsBus.coldThrottleBus.VFlowOutMea)
    annotation (Line(points={{-18,-24},{-34,-24},{-34,0.09},{99.085,0.09}},
        color={0,0,127}), Text(
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
end CtrTabsVSet;
