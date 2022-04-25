within AixLib.Systems.ModularAHU.Controller;
block CtrRegBasic "Controller for heating and cooling registers"
  //Boolean choice;

  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Modelica.Units.SI.Temperature TflowSet=293.15
    "Flow temperature set point of consumer"
    annotation (Dialog(enable=useExternalTset == false));
  parameter Real k(min=0, unit="1") = 0.02 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 130
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time Td(min=0) = 4
    "Time constant of Derivative block";
  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
  parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PID"));
  parameter Boolean reverseAction = true
    "Set to true if a heating coil, and false if a cooling coil is controlled";
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
    final reverseActing=reverseAction,
    final reset=AixLib.Types.Reset.Disabled)
            annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  BaseClasses.RegisterBus registerBus annotation (Placement(transformation(
          extent={{76,-22},{124,22}}), iconTransformation(extent={{92,-14},{120,
            14}})));
equation

    connect(PID.u_s, Tset) annotation (Line(
      points={{-22,-50},{-47.1,-50},{-47.1,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(constTflowSet.y, PID.u_s) annotation (Line(
      points={{-79,-50},{-22,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(PID.y, registerBus.hydraulicBus.valveSet) annotation (Line(points={{1,-50},
          {100.12,-50},{100.12,0.11}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constRpmPump.y, registerBus.hydraulicBus.pumpBus.rpmSet)
    annotation (Line(points={{41,0},{72,0},{72,0.11},{100.12,0.11}},  color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, registerBus.hydraulicBus.pumpBus.onSet)
    annotation (Line(points={{81,30},{100.12,30},{100.12,0.11}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.u_m, registerBus.TAirOutMea) annotation (Line(points={{-10,-62},{-10,
          -80},{100,-80},{100,0.11},{100.12,0.11}},           color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
  <li>August 1, 2019, by Alexander Kümpel:<br/>
    Improvement.
  </li>
  <li>October 18, 2018, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple controller for heating and cooling registers. The controlled
  variable is the air outflow temperature T_air_out. The pump (if
  existing in hydraulic circuit) operates at constant frequency and is
  always on.
</p>
</html>"));
end CtrRegBasic;
