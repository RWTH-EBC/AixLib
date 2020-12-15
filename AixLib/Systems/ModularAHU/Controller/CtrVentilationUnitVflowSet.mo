within AixLib.Systems.ModularAHU.Controller;
model CtrVentilationUnitVflowSet
  "Simple controller for Ventilation Unit"


      parameter Boolean useExternalVset=false
    "If True, set volume flow can be given externally"
    annotation (Dialog(enable=useExternalVset == false));
  parameter Modelica.SIunits.VolumeFlowRate VFlowSet=1000/3600
    "Set value of volume flow [m^3/s]"
    annotation (dialog(group="Fan Controller", enable=useExternalVset == false));
  parameter Real k=0.01 "Gain of controller"
    annotation (dialog(group="Fan Controller"));
  parameter Modelica.SIunits.Time Ti=60 "Time constant of Integrator block"
    annotation (dialog(group="Fan Controller"));
  parameter Real y_start=0 "Initial value of output"
    annotation (dialog(group="Fan Controller"));

  BaseClasses.GenericAHUBus genericAHUBus annotation (Placement(transformation(
          extent={{90,-10},{110,10}}), iconTransformation(extent={{84,-14},{116,
            16}})));
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
  Modelica.Blocks.Sources.Constant ConstVflow(final k=VFlowSet) if not
    useExternalVset
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));

  Modelica.Blocks.Interfaces.RealInput VFlowAir if
                                                useExternalVset
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-114,-70},{-88,-44}}), iconTransformation(
          extent={{-128,-84},{-88,-44}})));
  CtrRegVSet ctrRegVSet(useExternalVset=true)
    annotation (Placement(transformation(extent={{-22,38},{-2,58}})));
  CtrRegVSet ctrRegVSet1(useExternalVset=true)
    annotation (Placement(transformation(extent={{-22,-4},{-2,16}})));
  Modelica.Blocks.Interfaces.RealInput VsetCooler
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-118,70},{-86,102}})));
  Modelica.Blocks.Interfaces.RealInput VsetHeater
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-116,-10},{-86,20}})));
equation
  connect(ConstVflow.y, PID_VflowSup.u_s) annotation (Line(points={{-59,-30},{-30,
          -30},{-30,-50},{-2,-50}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(PID_VflowSup.u_m, genericAHUBus.heaterBus.VFlowAirMea) annotation (
      Line(points={{10,-62},{10,-98},{100.05,-98},{100.05,0.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID_VflowSup.y, genericAHUBus.flapSupSet) annotation (Line(points={{
          21,-50},{100.05,-50},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(VFlowAir, PID_VflowSup.u_s) annotation (Line(
      points={{-101,-57},{-2,-57},{-2,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(ctrRegVSet.registerBus, genericAHUBus.coolerBus) annotation (Line(
      points={{-1.8,48},{98,48},{98,16},{100.05,16},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrRegVSet1.registerBus, genericAHUBus.heaterBus) annotation (Line(
      points={{-1.8,6},{50,6},{50,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrRegVSet.Vset, VsetCooler) annotation (Line(points={{-24,48},{-62,48},
          {-62,86},{-102,86}}, color={0,0,127}));
  connect(ctrRegVSet1.Vset, VsetHeater) annotation (Line(points={{-24,6},{-66,6},
          {-66,5},{-101,5}}, color={0,0,127}));
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
end CtrVentilationUnitVflowSet;
