within AixLib.Systems.HydraulicModules.Controller;
block CtrThrottleValveCtr "Controller for unmixed circuit with valve"
  //Boolean choice;

  parameter Boolean useExternalVset = false "If True, set temperature can be given externally";
  parameter Modelica.SIunits.VolumeFlowRate VflowSet = 0.1 "Volume Flow in m³/s set point of consumer";
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=130
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time Td(min=0)= 4 "Time constant of Derivative block";
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm rpm_pump(min=0) = 2000 "Rpm of the Pump";
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
  Modelica.Blocks.Interfaces.RealInput valveSet
    "Connector of measurement input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Blocks.Logical.GreaterThreshold
                                        pumpSwitchOff(final threshold=0)
    annotation (Placement(transformation(extent={{16,32},{32,48}})));
equation

public
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{76,-24},{124,24}}),
        iconTransformation(extent={{90,-22},{138,26}})));
equation

  connect(constRpmPump.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
          {41,0},{100.12,0},{100.12,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pumpSwitchOff.y, hydraulicBus.pumpBus.onSet) annotation (Line(points=
          {{32.8,40},{100.12,40},{100.12,0.12}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(hydraulicBus.valveSet, valveSet) annotation (Line(
      points={{100.12,0.12},{-20,0.12},{-20,0},{-120,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pumpSwitchOff.u, valveSet) annotation (Line(points={{14.4,40},{-24,40},
          {-24,0},{-120,0}}, color={0,0,127}));
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
          textString="Control")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html>
<ul>
<li>January 22, 2019, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Simple controller for Throttle and ThrottlePump circuit that is based on a PID controller. The controlled variable needs to be connected to Tact.</p>
<p>If the valve is fully closed, the pump will switch off. The pump frequency is constant, if pump is on</p>
</html>"));
end CtrThrottleValveCtr;
