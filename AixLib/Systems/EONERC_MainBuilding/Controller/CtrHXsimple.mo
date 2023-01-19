within AixLib.Systems.EONERC_MainBuilding.Controller;
block CtrHXsimple "Controller for heat exchanger system"
  //Boolean choice;
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Sources.Constant constRpmPump1(final k=rpmPumpPrim)
                                                                  annotation (Placement(transformation(extent={{0,80},{
            20,100}})));
  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Modelica.Units.SI.Temperature TflowSet = 298.15 "Flow temperature set point of consumer";
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller" annotation(Dialog(group="PID"));
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small)=60
    "Time constant of Integrator block" annotation(Dialog(group="PID"));
  parameter Real rpmPumpPrim( min=0, unit="1") = 1500 "Rpm of the pump on the high temperature side";
  parameter Real rpmPumpSec( min=0, unit="1") = 1000 "Rpm of the Pump on the low temperature side";
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
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpmPumpSec)
                                                                  annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  BaseClasses.TwoCircuitBus hxBus annotation (Placement(transformation(extent={{84,-16},
            {116,16}}),         iconTransformation(extent={{92,-20},{130,22}})));
equation

    connect(PID.u_s, Tset) annotation (Line(
      points={{-22,-50},{-47.1,-50},{-47.1,0},{-120,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(constTflowSet.y, PID.u_s) annotation (Line(
      points={{-79,-50},{-22,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(PID.y, hxBus.secBus.valveSet) annotation (Line(points={{1,-50},{100.08,
          -50},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.u_m, hxBus.secBus.TFwrdOutMea) annotation (Line(points={{-10,-62},
          {-10,-80},{100.08,-80},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(constRpmPump.y, hxBus.secBus.pumpBus.rpmSet) annotation (Line(
        points={{41,0},{72,0},{72,0.08},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, hxBus.secBus.pumpBus.onSet) annotation (Line(
        points={{81,30},{100.08,30},{100.08,0.08}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold.u, PID.y) annotation (Line(points={{-2,50},{2,50},{2,
          -50},{1,-50}}, color={0,0,127}));
  connect(constRpmPump1.y, hxBus.primBus.pumpBus.rpmSet) annotation (Line(
        points={{21,90},{100.08,90},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold.y, booleanToReal.u)
    annotation (Line(points={{21,50},{38,50},{38,80}}, color={255,0,255}));
  connect(greaterThreshold.y, hxBus.primBus.pumpBus.onSet) annotation (
      Line(points={{21,50},{100.08,50},{100.08,0.08}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanToReal.y, hxBus.primBus.valveSet) annotation (Line(points={{61,
          80},{100.08,80},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                         Line(
          points={{20,80},{80,0},{40,-80}},
          color={95,95,95},
          thickness=0.5),
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
<li>January 22, 2019, by Alexander K&uuml;mpel:<br/>External T_set added.</li>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Simple controller for admix and injection circuit. The controlled variable is the outflow temperature T_fwrd_out.</p>
</html>"));
end CtrHXsimple;
