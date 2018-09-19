within AixLib.Controls.HeatPump.SecurityControls;
block DefrostControl
  "Control block to ensure no frost limits heat flow at the evaporator"
  parameter Real minIceFac "Minimal value above which no defrost is necessary";
  parameter Boolean use_chiller=true
    "True if ice is defrosted by changing operating mode to cooling. False to use an electrical heater" annotation(choices(checkBox=true));
  parameter Modelica.SIunits.Power calcPel_deFro
    "Calculate how much eletrical power is used to melt ice"
    annotation (Dialog(enable=not use_chiller));
  Modelica.Blocks.Logical.GreaterEqualThreshold
                                       iceFacGreMin(final threshold=minIceFac) if
    use_chiller
    "Check if icing factor is greater than a boundary" annotation (Placement(
        transformation(
        extent={{-8,-9},{8,9}},
        rotation=0,
        origin={-15,-62})));
 Modelica.Blocks.Interfaces.RealOutput Pel_deFro if not use_chiller
    "Relative speed of compressor. From 0 to 1" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,110})));
  Modelica.Blocks.Sources.BooleanConstant conTrue(final k=true) if not
    use_chiller
    "If ice is melted with an additional heater, HP can continue running"
    annotation (Placement(transformation(extent={{2,-12},{14,0}})));
  Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of HP mode"
    annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    "Set value relative speed of compressor. Analog from 0 to 1"
    annotation (Placement(transformation(extent={{-132,4},{-100,36}})));
  Utilities.Logical.SmoothSwitch swiErr
    "If an error occurs, the value of the conZero block will be used(0)"
    annotation (Placement(transformation(extent={{60,-16},{80,4}})));
  Modelica.Blocks.Sources.Constant conOne(final k=1)
    "If Defrost is enabled, HP runs at full power"
    annotation (Placement(transformation(extent={{24,-30},{36,-18}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput modeOut
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-120,-76},{-92,-48}})));
  Modelica.Blocks.Sources.Constant       realPel_deFro(k=calcPel_deFro) if not
    use_chiller
               "Calculate how much eletrical energy is used to melt ice"
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-26,60})));
  Utilities.Logical.SmoothSwitch swiPelDeFro if not use_chiller
    "If el. defrosting is active, el. power is passed through, otherwise 0"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,84})));
  Modelica.Blocks.Sources.Constant conZero(final k=0) if not use_chiller
    "If defrost is not active, 0 W are used"
    annotation (Placement(transformation(extent={{32,54},{20,66}})));
equation
  connect(conOne.y, swiErr.u3) annotation (Line(points={{36.6,-24},{38,-24},{38,
          -14},{58,-14}}, color={0,0,127}));
  connect(swiErr.y, nOut) annotation (Line(points={{81,-6},{96,-6},{96,20},{110,
          20}}, color={0,0,127}));
  connect(iceFacGreMin.y, modeOut) annotation (Line(
      points={{-6.2,-62},{60,-62},{60,-20},{110,-20}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(iceFacGreMin.y, swiErr.u2) annotation (Line(
      points={{-6.2,-62},{20,-62},{20,-6},{58,-6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(nSet, swiErr.u1) annotation (Line(points={{-116,20},{32,20},{32,2},{58,
          2}}, color={0,0,127}));
  connect(sigBusHP.iceFac, iceFacGreMin.u) annotation (Line(
      points={{-105.93,-61.93},{-78,-61.93},{-78,-62},{-24.6,-62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conTrue.y, swiErr.u2) annotation (Line(
      points={{14.6,-6},{58,-6}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(Pel_deFro, swiPelDeFro.y)
    annotation (Line(points={{0,110},{0,90.6}}, color={0,0,127}));
  connect(realPel_deFro.y, swiPelDeFro.u1) annotation (Line(points={{-19.4,60},{
          -4.8,60},{-4.8,76.8}}, color={0,0,127}));
  connect(conZero.y, swiPelDeFro.u3)
    annotation (Line(points={{19.4,60},{4.8,60},{4.8,76.8}}, color={0,0,127}));
  connect(iceFacGreMin.y, swiPelDeFro.u2)
    annotation (Line(
      points={{-6.2,-62},{0,-62},{0,76.8}},
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
