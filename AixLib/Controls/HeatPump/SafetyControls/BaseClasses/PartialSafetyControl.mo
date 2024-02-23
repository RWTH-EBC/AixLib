within AixLib.Controls.HeatPump.SafetyControls.BaseClasses;
partial block PartialSafetyControl "Base Block"
  Modelica.Blocks.Interfaces.RealInput nSet
    "Set value relative speed of compressor. Analog from 0 to 1"
    annotation (Placement(transformation(extent={{-152,4},{-120,36}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{120,10},{140,30}})));
  AixLib.Utilities.Logical.SmoothSwitch swiErr
    "If an error occurs, the value of the conZero block will be used(0)"
    annotation (Placement(transformation(extent={{86,-10},{106,10}})));
  Modelica.Blocks.Sources.Constant conZer(final k=0)
    "If an error occurs, the compressor speed is set to zero"
    annotation (Placement(transformation(extent={{58,-24},{70,-12}})));
  Interfaces.VapourCompressionMachineControlBus sigBusHP
    "Bus-connector for the heat pump"
    annotation (Placement(transformation(extent={{-152,-84},{-118,-54}})));
  Modelica.Blocks.Interfaces.BooleanOutput modeOut
    "Heat pump mode, =true: heating, =false: chilling"
    annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
  Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of heat pump mode"
    annotation (Placement(transformation(extent={{-152,-36},{-120,-4}})));
  Modelica.Blocks.MathInteger.TriggeredAdd disErr(
    y_start=0,
    use_reset=false,
    use_set=false)
               "Used to show if the error was triggered" annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={0,-80})));
  Modelica.Blocks.Interfaces.IntegerOutput ERR
    "Integer for displaying number off Errors during simulation"
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-21,-69})));
  Modelica.Blocks.Sources.IntegerConstant intConOne(final k=1)
    "Used for display of current error"
    annotation (Placement(transformation(extent={{36,-70},{24,-58}})));
equation
  connect(conZer.y,swiErr. u3) annotation (Line(points={{70.6,-18},{78,-18},
          {78,-8},{84,-8}}, color={0,0,127}));
  connect(swiErr.y, nOut) annotation (Line(points={{107,0},{118,0},{118,20},{
          130,20}}, color={0,0,127}));
  connect(disErr.y, ERR) annotation (Line(points={{-1.77636e-15,-89.6},{
          -1.77636e-15,-100},{0,-100},{0,-110}}, color={255,127,0}));
  connect(not1.y, disErr.trigger) annotation (Line(points={{-21,-74.5},{-21,
          -75.2},{-9.6,-75.2}}, color={255,0,255}));
  connect(intConOne.y, disErr.u) annotation (Line(points={{23.4,-64},{0,-64},{0,
          -68.8}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -120,-100},{120,100}}), graphics={
        Polygon(
          points={{-42,20},{0,62},{-42,20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-26},{48,66}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-14},{36,54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,20},{60,-80}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-30},{10,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-14,-40},{16,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-104,100},{106,76}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="%name"),
        Rectangle(
          extent={{-120,100},{120,-100}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None)}),
                                     Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Partial block for a safety control. Based on the signals in the
  sigBusHP either the input signals are equal to the output signals or,
  if an error occurs, set to 0.
</p>
<p>
  The Output ERR informs about the number of errors in the specific
  safety block.
</p>
</html>"));
end PartialSafetyControl;
