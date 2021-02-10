within AixLib.Systems.EONERC_MainBuilding.Controller;
block CtrHXmflow "Controller for heat exchanger system"
  //Boolean choice;
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
    annotation (Placement(transformation(extent={{14,22},{34,42}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{40,42},{60,62}})));
  Modelica.Blocks.Sources.Constant constRpmPump1(final k=rpmPumpPrim)
                                                                  annotation (Placement(transformation(extent={{-74,80},
            {-54,100}})));
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller" annotation(Dialog(group="PID"));
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=60
    "Time constant of Integrator block" annotation(Dialog(group="PID"));
  parameter Real rpmPumpPrim( min=0, unit="1") = 1500 "Rpm of the pump on the high temperature side";
  parameter Real rpmPumpSec( min=0, unit="1") = 1000 "Rpm of the Pump on the low temperature side";
  parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(group="PID"));
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpmPumpSec)
                                                                  annotation (Placement(transformation(extent={{-54,-16},
            {-34,4}})));

  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{42,6},{62,26}})));
  BaseClasses.TwoCircuitBus hxBus annotation (Placement(transformation(extent={{84,-16},
            {116,16}}),         iconTransformation(extent={{92,-20},{130,22}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{26,-96},{46,-76}})));
  Controls.Continuous.LimPID        PID1(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final initType=initType,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    final reverseAction=false)
            annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
  Controls.Continuous.LimPID        PID2(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final initType=initType,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    final reverseAction=false)
            annotation (Placement(transformation(extent={{-54,-54},{-34,-34}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-16,60},{4,80}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-6,-36},{14,-16}})));
  Modelica.Blocks.Math.Gain cubicmetertokg(k=1000) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-65,27})));
  Modelica.Blocks.Math.Gain cubicmetertokg1(k=1000) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-45,-69})));
  Modelica.Blocks.Interfaces.RealInput mflowSet_prim
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-110,44},{-90,64}}), iconTransformation(extent={{-110,44},{
            -90,64}})));
  Modelica.Blocks.Interfaces.RealInput mflowSet_sec
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-110,-54},{-90,-34}}), iconTransformation(extent={{-110,-68},
            {-90,-48}})));
equation

  connect(booleanConstant.y, hxBus.secBus.pumpBus.onSet) annotation (Line(
        points={{63,16},{100.08,16},{100.08,0.08}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold.y, booleanToReal.u)
    annotation (Line(points={{35,32},{38,32},{38,52}}, color={255,0,255}));
  connect(greaterThreshold.y, hxBus.primBus.pumpBus.onSet) annotation (
      Line(points={{35,32},{100.08,32},{100.08,0.08}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanToReal.y, hxBus.primBus.valveSet) annotation (Line(points={{61,52},
          {100.08,52},{100.08,0.08}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, hxBus.secBus.valveSet) annotation (Line(points={{47,-86},{
          100.08,-86},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID1.y, product1.u2) annotation (Line(points={{-53,54},{-36,54},{-36,
          64},{-18,64}}, color={0,0,127}));
  connect(constRpmPump1.y, product1.u1) annotation (Line(points={{-53,90},{-36,
          90},{-36,76},{-18,76}}, color={0,0,127}));
  connect(product1.y, hxBus.primBus.pumpBus.rpmSet) annotation (Line(points={{5,
          70},{100,70},{100,0.08},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(product1.y, greaterThreshold.u)
    annotation (Line(points={{5,70},{12,70},{12,32}}, color={0,0,127}));
  connect(product2.y, hxBus.secBus.pumpBus.rpmSet) annotation (Line(points={{15,
          -26},{98,-26},{98,0.08},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(product2.u1, constRpmPump.y) annotation (Line(points={{-8,-20},{-20,
          -20},{-20,-6},{-33,-6}}, color={0,0,127}));
  connect(product2.u2, PID2.y) annotation (Line(points={{-8,-32},{-22,-32},{-22,
          -44},{-33,-44}}, color={0,0,127}));
  connect(cubicmetertokg.y, PID1.u_m) annotation (Line(points={{-65,32.5},{-65,
          36.25},{-64,36.25},{-64,42}}, color={0,0,127}));
  connect(cubicmetertokg.u, hxBus.primBus.VFlowInMea) annotation (Line(points={
          {-65,21},{-2.5,21},{-2.5,0.08},{100.08,0.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cubicmetertokg1.y, PID2.u_m) annotation (Line(points={{-45,-63.5},{
          -45,-62.75},{-44,-62.75},{-44,-56}}, color={0,0,127}));
  connect(cubicmetertokg1.u, hxBus.secBus.VFlowInMea) annotation (Line(points={
          {-45,-75},{100.5,-75},{100.5,0.08},{100.08,0.08}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID1.u_s, mflowSet_prim)
    annotation (Line(points={{-76,54},{-100,54}}, color={0,0,127}));
  connect(mflowSet_sec, PID2.u_s)
    annotation (Line(points={{-100,-44},{-56,-44}}, color={0,0,127}));
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
end CtrHXmflow;
