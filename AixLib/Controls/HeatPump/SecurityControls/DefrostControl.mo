within AixLib.Controls.HeatPump.SecurityControls;
block DefrostControl
  "Control block to ensure no frost limits heat flow at the evaporator"
  parameter Real minIceFac "Minimal value above which no defrost is necessary";
  parameter Boolean use_chiller=true
    "True if ice is defrost operates by changing mode to cooling. False to use an electrical heater" annotation(choices(checkBox=true));
  parameter Modelica.SIunits.Power calcPel_deFro
    "Calculate how much eletrical energy is used to melt ice"
    annotation (Dialog(enable=not use_chiller));
  Modelica.Blocks.Logical.GreaterEqualThreshold iceFacGreMinHea(final threshold=
       minIceFac) if not use_chiller
    "Check if icing factor is greater than a boundary" annotation (Placement(
        transformation(
        extent={{-8,-9},{8,9}},
        rotation=0,
        origin={-31,-76})));
 Modelica.Blocks.Interfaces.RealOutput Pel_deFro if not use_chiller
    "Relative speed of compressor. From 0 to 1" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,110})));
  Modelica.Blocks.Sources.BooleanConstant conTrueNotUseChi(final k=true) if
    not use_chiller
    "If ice is melted with an additional heater, HP can continue running"
    annotation (Placement(transformation(extent={{-36,-6},{-24,6}})));
  Modelica.Blocks.Sources.Constant constPel_deFro(final k=calcPel_deFro) if
                                                                           not
    use_chiller "Calculate how much eletrical energy is used to melt ice"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={10,52})));
  Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of HP mode"
    annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    "Set value relative speed of compressor. Analog from 0 to 1"
    annotation (Placement(transformation(extent={{-132,4},{-100,36}})));
  Utilities.Logical.SmoothSwitch swiErr
    "If an error occurs, the value of the conZero block will be used(0)"
    annotation (Placement(transformation(extent={{58,2},{78,22}})));
  Modelica.Blocks.Sources.Constant conOne(final k=1)
    "If Defrost is enabled, HP runs at full power"
    annotation (Placement(transformation(extent={{24,-12},{36,0}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput modeOut
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-120,-76},{-92,-48}})));
  Utilities.Logical.SmoothSwitch swiPel if not use_chiller
    "If defrost is on, output will be positive" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,84})));
  Modelica.Blocks.Sources.Constant conZero(final k=0) if not use_chiller
    "If Defrost is enabled, HP runs at full power"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-12,52})));
  Modelica.Blocks.Logical.GreaterEqualThreshold iceFacGreMinChi(final threshold=
       minIceFac) if use_chiller
    "Check if icing factor is greater than a boundary" annotation (Placement(
        transformation(
        extent={{-8,-9},{8,9}},
        rotation=0,
        origin={-31,-50})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    "If a chiller is used to defrost, mode will be false"
    annotation (Placement(transformation(extent={{58,-42},{78,-22}})));
  Modelica.Blocks.Sources.BooleanConstant conFalseNotUseChi(final k=false) if
                                                                          not
    use_chiller
    "If ice is melted with an additional heater, HP can continue running"
    annotation (Placement(transformation(extent={{28,-48},{38,-38}})));
  Modelica.Blocks.Sources.BooleanConstant conTrueUseChi(final k=true) if
    use_chiller
    "If ice is melted with an additional heater, HP can continue running"
    annotation (Placement(transformation(extent={{28,-66},{38,-56}})));
equation
  connect(conOne.y, swiErr.u3) annotation (Line(points={{36.6,-6},{38,-6},{38,4},
          {56,4}},        color={0,0,127}));
  connect(swiErr.y, nOut) annotation (Line(points={{79,12},{96,12},{96,20},{110,
          20}}, color={0,0,127}));
  connect(nSet, swiErr.u1) annotation (Line(points={{-116,20},{56,20}},
               color={0,0,127}));
  connect(sigBusHP.iceFac, iceFacGreMinHea.u) annotation (Line(
      points={{-105.93,-61.93},{-68,-61.93},{-68,-76},{-40.6,-76}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Pel_deFro, swiPel.y)
    annotation (Line(points={{0,110},{0,95}}, color={0,0,127}));
  connect(conTrueNotUseChi.y, swiErr.u2) annotation (Line(
      points={{-23.4,0},{0,0},{0,12},{56,12}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(iceFacGreMinHea.y, swiPel.u2) annotation (Line(
      points={{-22.2,-76},{-10,-76},{-10,34},{-6.66134e-16,34},{-6.66134e-16,72}},
      color={255,0,255},
      pattern=LinePattern.Dash));

  connect(constPel_deFro.y, swiPel.u3) annotation (Line(
      points={{10,58.6},{10,68},{8,68},{8,72}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(swiPel.u1, conZero.y) annotation (Line(
      points={{-8,72},{-8,58.6},{-12,58.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP.iceFac, iceFacGreMinChi.u) annotation (Line(
      points={{-105.93,-61.93},{-68,-61.93},{-68,-50},{-40.6,-50}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(iceFacGreMinChi.y, swiErr.u2) annotation (Line(
      points={{-22.2,-50},{8,-50},{8,12},{56,12}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(logicalSwitch.y, modeOut) annotation (Line(points={{79,-32},{84,-32},
          {84,-20},{110,-20}}, color={255,0,255}));
  connect(modeSet, logicalSwitch.u1) annotation (Line(points={{-116,-20},{-32,
          -20},{-32,-24},{56,-24}}, color={255,0,255}));
  connect(conTrueNotUseChi.y, logicalSwitch.u2) annotation (Line(
      points={{-23.4,0},{0,0},{0,-32},{56,-32}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(conFalseNotUseChi.y, logicalSwitch.u3) annotation (Line(
      points={{38.5,-43},{50,-43},{50,-40},{56,-40}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(iceFacGreMinChi.y, logicalSwitch.u2) annotation (Line(
      points={{-22.2,-50},{8,-50},{8,-32},{56,-32}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(conTrueUseChi.y, logicalSwitch.u3) annotation (Line(
      points={{38.5,-61},{50,-61},{50,-40},{56,-40}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,80}}),                                   graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-36,34},{-36,-6}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={-36,14},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={-36,14},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={-36,14},
          rotation=90),
        Line(
          points={{8,64},{8,24}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={8,44},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={8,44},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={8,44},
          rotation=90),
        Line(
          points={{-34,-22},{-34,-62}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={-34,-42},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={-34,-42},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={-34,-42},
          rotation=90),
        Line(
          points={{14,6},{14,-34}},
          color={28,108,200}),
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          origin={14,-14},
          rotation=90),
        Line(
          points={{-14,14},{14,-14}},
          color={28,108,200},
          origin={14,-14},
          rotation=90),
        Line(
          points={{14,14},{-14,-14}},
          color={28,108,200},
          origin={14,-14},
          rotation=90),
        Text(
          extent={{-104,100},{106,76}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(info="<html>
<p>Basic model for a defrost control. The icing factor is calculated in the heat pump based on functions or other models.</p>
<p>If a given lower boundary is surpassed, the mode of the heat pump will be set to false(eq. Chilling) and the compressor speed is set to 1 to make the defrost process as fast as possible.</p>
</html>"));
end DefrostControl;
