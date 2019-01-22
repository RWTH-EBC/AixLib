within AixLib.Systems.HydraulicModules.Controller;
block CtrMix "Controller for mixed and injection circuits "
  //Boolean choice;

  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Modelica.SIunits.Temperature TflowSet = 289.15 "Flow temperature set point of consumer";
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=130
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time Td(min=0)= 4 "Time constant of Derivative block";
  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
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
  Controls.Continuous.LimPID        PID(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=k,
    Ti=Ti,
    Td=Td,
    initType=initType,
    xi_start=xi_start,
    xd_start=xd_start,
    y_start=y_start,
    reverseAction=reverseAction)
            annotation (Placement(transformation(extent={{-16,-60},{4,-40}})));
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{66,-38},{120,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=rpm_pump)
    annotation (Placement(transformation(extent={{20,-6},{40,14}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=TflowSet)
    annotation (Placement(transformation(extent={{-100,-34},{-80,-14}})));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
equation

  if useExternalTset then
    connect(PID.u_s, Tset) annotation (Line(points={{-18,-50},{-67.1,-50},{-67.1,
            -60},{-120,-60}},
                            color={0,0,127}));
  else
    connect(realExpression.y, PID.u_s) annotation (Line(points={{-79,-24},{-68,-24},
            {-68,-50},{-18,-50}},
                                color={0,0,127}));
  end if;

  connect(PID.y, hydraulicBus.valSet) annotation (Line(points={{5,-50},{48,-50},
          {48,-10.865},{93.135,-10.865}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(realExpression1.y, hydraulicBus.pumpBus.rpm_Input) annotation (Line(
        points={{41,4},{48,4},{48,-10.865},{93.135,-10.865}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PID.u_m, hydraulicBus.TFwrd_out) annotation (Line(points={{-6,-62},{-6,
          -80},{93.135,-80},{93.135,-10.865}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(booleanConstant.y, hydraulicBus.pumpBus.onOff_Input) annotation (Line(
        points={{81,30},{93.135,30},{93.135,-10.865}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
          Rectangle(
          extent={{-90,80},{70,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{10,80},{70,0},{30,-80}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-90,20},{56,-20}},
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
end CtrMix;
