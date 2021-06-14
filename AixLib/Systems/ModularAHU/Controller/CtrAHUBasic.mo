within AixLib.Systems.ModularAHU.Controller;
model CtrAHUBasic "Simple controller for AHU"

  parameter Modelica.SIunits.Temperature TFlowSet=289.15
    "Flow temperature set point of consumer"
    annotation (Dialog(enable=useExternalTset == false));
  parameter Boolean useExternalTset=false
    "If True, set temperature can be given externally";
      parameter Boolean useExternalVset=false
    "If True, set volume flow can be given externally";
  parameter Modelica.SIunits.VolumeFlowRate VFlowSet=3000/3600
    "Set value of volume flow [m^3/s]"
    annotation (dialog(group="Fan Controller"));
  parameter Real dpMax=5000 "Maximal pressure difference of the fans [Pa]"
    annotation (dialog(group="Fan Controller"));
  parameter Boolean useTwoFanCont=false
    "If True, a PID for each of the two fans is used. Use two PID controllers for open systems (if the air canal is not closed)."
    annotation (dialog(group="Fan Controller"));
  parameter Real k=50 "Gain of controller"
    annotation (dialog(group="Fan Controller"));
  parameter Modelica.SIunits.Time Ti=5 "Time constant of Integrator block"
    annotation (dialog(group="Fan Controller"));
  parameter Real y_start=0 "Initial value of output"
    annotation (dialog(group="Fan Controller"));



  BaseClasses.GenericAHUBus genericAHUBus annotation (Placement(transformation(
          extent={{90,-10},{110,10}}), iconTransformation(extent={{84,-14},{116,
            16}})));
  CtrRegBasic ctrPh(final useExternalTset=true, Td=0) annotation (dialog(enable=
         True), Placement(transformation(extent={{0,80},{20,100}})));
  CtrRegBasic ctrCo(
    final useExternalTset=true,
    Td=0,
    final reverseAction=true) annotation (dialog(enable=True), Placement(
        transformation(extent={{0,40},{20,60}})));
  CtrRegBasic ctrRh(
    final useExternalTset=true,
    final useExternalTMea=true,
    Td=0) annotation (dialog(enable=True), Placement(transformation(extent={{0,0},
            {20,20}})));
  Modelica.Blocks.Sources.Constant constTflowSet(final k=TFlowSet) if not useExternalTset
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.Constant TFrostProtection(final k=273.15 + 5)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Controls.Continuous.LimPID PID_VflowSup(
    final yMax=dpMax,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k,
    final Ti=Ti,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=y_start,
    final reset=AixLib.Types.Reset.Disabled,
    reverseActing=not (false))
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
  Controls.Continuous.LimPID PID_VflowRet(
    final yMax=dpMax,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k,
    final Ti=Ti,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=y_start,
    final reset=AixLib.Types.Reset.Disabled,
    reverseActing=not (false)) if useTwoFanCont
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Blocks.Sources.Constant ConstVflow(final k=VFlowSet) if not
    useExternalVset
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));

  Modelica.Blocks.Sources.Constant ConstWRG(final k=0)
    annotation (Placement(transformation(extent={{40,-32},{52,-20}})));
  Modelica.Blocks.Sources.Constant ConstFlap(final k=1)
    annotation (Placement(transformation(extent={{20,-20},{32,-8}})));
  Modelica.Blocks.Sources.Constant ConstFlap1(final k=0) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={66,-36})));

  Modelica.Blocks.Interfaces.RealInput VFlow if useExternalVset
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}}),iconTransformation(
          extent={{-140,-80},{-100,-40}})));
equation
  connect(ctrPh.registerBus, genericAHUBus.preheaterBus) annotation (Line(
      points={{20.2,90},{54,90},{54,88},{100.05,88},{100.05,0.05}},
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
      points={{20.2,10},{100.05,10},{100.05,0.05}},
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
      points={{-79,50},{-28,50},{-28,10},{-2,10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TFrostProtection.y, ctrPh.Tset)
    annotation (Line(points={{-39,90},{-2,90}}, color={0,0,127}));
  connect(ConstVflow.y, PID_VflowSup.u_s) annotation (Line(points={{-59,-80},{-30,
          -80},{-30,-60},{-2,-60}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PID_VflowSup.u_m, genericAHUBus.heaterBus.VFlowAirMea) annotation (
      Line(points={{10,-72},{10,-98},{100.05,-98},{100.05,0.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Tset, ctrCo.Tset) annotation (Line(
      points={{-120,0},{-28,0},{-28,50},{-2,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(Tset, ctrRh.Tset) annotation (Line(
      points={{-120,0},{-28,0},{-28,10},{-2,10}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ConstWRG.y, genericAHUBus.bypassHrsSet) annotation (Line(points={{52.6,
          -26},{100.05,-26},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ConstFlap.y, genericAHUBus.flapRetSet) annotation (Line(points={{32.6,
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
  connect(ConstFlap1.y, genericAHUBus.steamHumSet) annotation (Line(points={{72.6,
          -36},{100,-36},{100,-2},{100.05,-2},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ConstFlap1.y, genericAHUBus.adiabHumSet) annotation (Line(points={{72.6,
          -36},{100,-36},{100,0},{100.05,0},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ConstVflow.y, PID_VflowRet.u_s) annotation (Line(points={{-59,-80},{-30,
          -80},{-30,-90},{-22,-90}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PID_VflowSup.y, genericAHUBus.dpFanSupSet) annotation (Line(points={{21,-60},
          {100,-60},{100,-34},{100.05,-34},{100.05,0.05}},         color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID_VflowRet.u_m, genericAHUBus.V_flow_RetAirMea) annotation (Line(
        points={{-10,-102},{-10,-112},{100.05,-112},{100.05,0.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID_VflowRet.y, genericAHUBus.dpFanRetSet) annotation (Line(points={{
          1,-90},{100.05,-90},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrRh.TMea, genericAHUBus.TSupAirMea) annotation (Line(points={{10,-2},
          {10,-6},{100.05,-6},{100.05,0.05}},         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  if not useTwoFanCont then
    connect(PID_VflowSup.y, genericAHUBus.dpFanRetSet) annotation (Line(points={{21,-60},
            {100.05,-60},{100.05,0.05}},           color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  end if;
  connect(VFlow, PID_VflowSup.u_s) annotation (Line(
      points={{-120,-60},{-2,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(VFlow, PID_VflowRet.u_s) annotation (Line(
      points={{-120,-60},{-30,-60},{-30,-90},{-22,-90}},
      color={0,0,127},
      pattern=LinePattern.Dash));
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
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end CtrAHUBasic;
