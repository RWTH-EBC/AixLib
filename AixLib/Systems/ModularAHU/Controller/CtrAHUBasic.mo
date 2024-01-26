within AixLib.Systems.ModularAHU.Controller;
model CtrAHUBasic "Simple controller for AHU"

  parameter Modelica.Units.SI.Temperature TFlowSet=289.15
    "Flow temperature set point of consumer"
    annotation (Dialog(enable=useExternalTset == false));
  parameter Boolean usePreheater=true "Set true, if ahu contains a preaheater"
    annotation (choices(checkBox=true));
  parameter Real TFrostProtect=273.15 + 5
    "Temperature set point of preheater for frost protection"
    annotation (Dialog(enable=usePreheater == true));

  parameter Boolean useExternalTset=false
    "If True, set temperature can be given externally";

  // Register controllers
  CtrRegBasic ctrPh(
    final useExternalTset=true,
    Td=0,
    final initType=initType,
    final reverseAction=true)
                             if usePreheater annotation (dialog(group="Register controller",
        enable=usePreheater), Placement(transformation(extent={{0,70},{20,90}})));
  CtrRegBasic ctrCo(
    final useExternalTset=true,
    Td=0,
    final initType=initType,
    final reverseAction=false)
                              annotation (dialog(group="Register controller",
        enable=True), Placement(transformation(extent={{0,40},{20,60}})));
  CtrRegBasic ctrRh(
    final useExternalTset=true,
    final useExternalTMea=true,
    Td=0,
    final initType=initType,
    final reverseAction=true)
                             annotation (dialog(group="Register controller",
        enable=True), Placement(transformation(extent={{0,10},{20,30}})));


  // Parameter for volume flow controller
  parameter Modelica.Units.SI.VolumeFlowRate VFlowSet=3000/3600
    "Set value of volume flow [m^3/s]"
    annotation (dialog(group="Fan Controller"));
  parameter Real dpMax=5000 "Maximal pressure difference of the fans [Pa]"
    annotation (dialog(group="Fan Controller"));
  parameter Boolean useTwoFanCtr=false
    "If True, a PID for each of the two fans is used. Use two PID controllers for open systems (if the air canal is not closed)."
    annotation (dialog(group="Fan Controller"));
  parameter Real k=50 "Gain of controller"
    annotation (dialog(group="Fan Controller"));
  parameter Modelica.Units.SI.Time Ti=5 "Time constant of Integrator block"
    annotation (dialog(group="Fan Controller"));
  parameter Real y_start=0 "Initial value of output"
    annotation (dialog(group="Fan Controller"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (dialog(group="Initialization"));



  BaseClasses.GenericAHUBus genericAHUBus "Bus connector for genericAHU"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{84,-14},{116,16}})));

  Modelica.Blocks.Sources.Constant constTflowSet(final k=TFlowSet) if not useExternalTset
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of set temperature, if given externally" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.Constant TFrostProtection(final k=TFrostProtect)
 if usePreheater
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Controls.Continuous.LimPID PID_VflowSup(
    final yMax=dpMax,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k,
    final Ti=Ti,
    final Td=0,
    final initType=initType,
    y_start=y_start,
    final reverseActing=true,
    final reset=AixLib.Types.Reset.Disabled) "PID controller for supply fan"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Controls.Continuous.LimPID PID_VflowRet(
    final yMax=dpMax,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k,
    final Ti=Ti,
    final Td=0,
    final initType=initType,
    y_start=y_start,
    final reverseActing=true,
    final reset=AixLib.Types.Reset.Disabled) if useTwoFanCtr
    "PID controller for return fan. Is deactivated if useTwoFanCtr is false."
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Modelica.Blocks.Sources.Constant ConstVflow(final k=VFlowSet)
    "Constant volume flow setpoint"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Modelica.Blocks.Sources.Constant ConstHRS(final k=0)
    "Heat recovery is deactivated"
    annotation (Placement(transformation(extent={{40,-32},{52,-20}})));
  Modelica.Blocks.Sources.Constant ConstFlap(final k=1) "Flaps are always open"
    annotation (Placement(transformation(extent={{20,-20},{32,-8}})));
  Modelica.Blocks.Sources.Constant ConstHum(final k=0) "Humidifiers are off"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={66,-36})));



  Modelica.Blocks.Routing.RealPassThrough realPassThrough if not useTwoFanCtr
    annotation (Placement(transformation(extent={{60,-66},{72,-54}})));
equation
  connect(ctrPh.registerBus, genericAHUBus.preheaterBus) annotation (Line(
      points={{20.2,80},{100.05,80},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrCo.registerBus, genericAHUBus.coolerBus) annotation (Line(
      points={{20.2,50},{100.05,50},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrRh.registerBus, genericAHUBus.heaterBus) annotation (Line(
      points={{20.2,20},{100.05,20},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constTflowSet.y, ctrCo.Tset) annotation (Line(
      points={{-79,50},{-2,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constTflowSet.y, ctrRh.Tset) annotation (Line(
      points={{-79,50},{-28,50},{-28,20},{-2,20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TFrostProtection.y, ctrPh.Tset)
    annotation (Line(points={{-39,80},{-2,80}}, color={0,0,127}));
  connect(ConstVflow.y, PID_VflowSup.u_s)
    annotation (Line(points={{-59,-50},{-2,-50}}, color={0,0,127}));
  connect(PID_VflowSup.u_m, genericAHUBus.heaterBus.VFlowAirMea) annotation (
      Line(points={{10,-62},{10,-72},{100,-72},{100,-36},{100.05,-36},{100.05,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Tset, ctrCo.Tset) annotation (Line(
      points={{-120,0},{-28,0},{-28,50},{-2,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Tset, ctrRh.Tset) annotation (Line(
      points={{-120,0},{-28,0},{-28,20},{-2,20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ConstHRS.y, genericAHUBus.bypassHrsSet) annotation (Line(points={{52.6,
          -26},{100.05,-26},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ConstFlap.y, genericAHUBus.flapEtaSet) annotation (Line(points={{32.6,
          -14},{100.05,-14},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ConstFlap.y, genericAHUBus.flapSupSet) annotation (Line(points={{32.6,
          -14},{100.05,-14},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ConstHum.y, genericAHUBus.steamHumSet) annotation (Line(points={{72.6,
          -36},{100,-36},{100,-2},{100.05,-2},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ConstHum.y, genericAHUBus.adiabHumSet) annotation (Line(points={{72.6,
          -36},{100,-36},{100,0},{100.05,0},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ConstVflow.y, PID_VflowRet.u_s) annotation (Line(points={{-59,-50},{-42,
          -50},{-42,-80},{-22,-80}}, color={0,0,127}));
  connect(PID_VflowSup.y, genericAHUBus.dpFanSupSet) annotation (Line(points={{21,
          -50},{100,-50},{100,-34},{100.05,-34},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID_VflowRet.u_m, genericAHUBus.V_flow_EtaMea) annotation (Line(
        points={{-10,-92},{100,-92},{100,-50},{100,0.05},{100.05,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID_VflowRet.y, genericAHUBus.dpFanEtaSet) annotation (Line(points={{1,-80},
          {100.05,-80},{100.05,0.05}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrRh.TMea, genericAHUBus.TSupMea) annotation (Line(points={{10,8},{10,
          0},{100.05,0},{100.05,0.05}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  if not useTwoFanCtr then
  end if;
  connect(PID_VflowSup.y, realPassThrough.u) annotation (Line(points={{21,-50},
          {22,-50},{22,-60},{58.8,-60}}, color={0,0,127}));
  connect(realPassThrough.y, genericAHUBus.dpFanEtaSet) annotation (Line(points=
         {{72.6,-60},{100.05,-60},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,100},{100,0},{20,-100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control"),
        Text(
          extent={{-100,140},{100,100}},
          textColor={0,0,0},
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This control uses the heating and cooling register to regulate the supply air temperature. The set point of the supply air can be given either by the parameter <i>TFlowSet </i>or by the external input variable <i>Tset.</i> The preheater use used for frost protection and has a fixed set point of 5&deg;C. The heat recovery system is always used and the bypass closed. The supply and return air flaps are always open. </p>
<p>The volume flow is controlled by PID controllers with two options: </p>
<ul>
<li>useTwoFanCtr = False: the supply and return air fans are controlled by only one PID controller. Both fans get the same pressure setpoint. This option is recommended for closed systems where the supply air volume flow is equal to the return air volume flow. Without this option, only one fan could be active to provide volume flow.</li>
<li>useTwoFanCtr = True: The supply air fan and the return air fan are controlled separately. Each controller aims to reach the volume flow set point for the supply or return air chanal. This option is recommended for open systems.</li>
</ul>
<p><br>The maximal volume flow can be limited by the maximal pressure difference of the fans <i>dpMax</i>.</p>
</html>", revisions="<html>
<ul>
<li>October 29, 2019, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>"));
end CtrAHUBasic;
