within AixLib.Systems.HydraulicModules.Controller;
block CtrMix "Controller for mixed and injection circuits "
  //Boolean choice;

  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Modelica.SIunits.Temperature TflowSet = 289.15 "Flow temperature set point of consumer";
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
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
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
    final reverseAction=reverseAction)
            annotation (Placement(transformation(extent={{-16,-60},{4,-40}})));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
equation

public
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{76,-24},{124,24}}),
        iconTransformation(extent={{90,-22},{138,26}})));
equation
    connect(PID.u_s, Tset) annotation (Line(
      points={{-18,-50},{-47.1,-50},{-47.1,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(constTflowSet.y, PID.u_s) annotation (Line(
      points={{-79,-50},{-18,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(PID.y, hydraulicBus.valveSet) annotation (Line(points={{5,-50},{48,
          -50},{48,0.12},{100.12,0.12}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PID.u_m, hydraulicBus.TFwrdOutMea) annotation (Line(points={{-6,-62},
          {-6,-80},{100.12,-80},{100.12,0.12}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(constRpmPump.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
          {41,0},{70,0},{70,0.12},{100.12,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, hydraulicBus.pumpBus.onSet) annotation (Line(
        points={{81,30},{100.12,30},{100.12,0.12}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
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
  <li>January 22, 2019, by Alexander Kümpel:<br/>
    External T_set added.
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple controller for admix and injection circuit. The controlled
  variable is the outflow temperature T_fwrd_out and controlled by a
  PID controller. The pump is always on and has a constant frequency.
</p>
</html>"));
end CtrMix;
