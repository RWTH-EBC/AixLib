within AixLib.Systems.ModularAHU.Controller;
model CtrVentilationUnitBasic "Simple controller for Ventilation Unit"

  parameter Modelica.SIunits.Temperature TFlowSet=289.15
    "Flow temperature set point of consumer"
    annotation (Dialog(enable=useExternalTset == false));
  parameter Boolean useExternalTset=false
    "If True, set temperature can be given externally";
  parameter Modelica.SIunits.VolumeFlowRate VFlowSet=1000/3600
    "Set value of volume flow [m^3/s]"
    annotation (dialog(group="Fan Controller"));
  parameter Real k=0.01 "Gain of controller"
    annotation (dialog(group="Fan Controller"));
  parameter Modelica.SIunits.Time Ti=60 "Time constant of Integrator block"
    annotation (dialog(group="Fan Controller"));
  parameter Real y_start=0 "Initial value of output"
    annotation (dialog(group="Fan Controller"));

  BaseClasses.GenericAHUBus genericAHUBus annotation (Placement(transformation(
          extent={{90,-10},{110,10}}), iconTransformation(extent={{84,-14},{116,
            16}})));
  CtrRegBasic ctrCo(
    final useExternalTset=true,
    Td=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    final reverseAction=true) annotation (dialog(enable=True), Placement(
        transformation(extent={{0,40},{20,60}})));
  CtrRegBasic ctrRh(
    final useExternalTset=true,
    final useExternalTMea=false,
    Td=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit)
          annotation (dialog(enable=True), Placement(transformation(extent={{0,0},
            {20,20}})));
  Modelica.Blocks.Sources.Constant constTflowSet(final k=TFlowSet) if not useExternalTset
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  Controls.Continuous.LimPID PID_VflowSup(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k,
    final Ti=Ti,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=y_start,
    final reverseAction=false,
    final reset=AixLib.Types.Reset.Disabled)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant ConstVflow(final k=VFlowSet)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Modelica.Blocks.Sources.Constant ConstVflow1(final k=1)
    annotation (Placement(transformation(extent={{46,-42},{66,-22}})));
equation
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
  connect(ConstVflow.y, PID_VflowSup.u_s) annotation (Line(points={{-59,-50},{-2,-50}},
                                    color={0,0,127}));
  connect(PID_VflowSup.u_m, genericAHUBus.heaterBus.VFlowAirMea) annotation (
      Line(points={{10,-62},{10,-98},{100.05,-98},{100.05,0.05}}, color={0,0,
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
  connect(PID_VflowSup.y, genericAHUBus.flapSupSet) annotation (Line(points={{
          21,-50},{100.05,-50},{100.05,0.05}}, color={0,0,127}), Text(
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
end CtrVentilationUnitBasic;
