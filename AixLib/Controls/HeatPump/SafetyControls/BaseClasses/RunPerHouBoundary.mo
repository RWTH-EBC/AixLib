within AixLib.Controls.HeatPump.SafetyControls.BaseClasses;
block RunPerHouBoundary "Checks if a maximal run per hour value is in boundary"
  extends Modelica.Blocks.Interfaces.BooleanSISO;
  parameter Integer maxRunPer_h "Number of maximal on/off cycles per hour";
  parameter Modelica.Units.SI.Time delayTime(displayUnit="h") = 3600
    "Delay time of output with respect to input signal";
 Modelica.Blocks.Logical.LessThreshold
                              runCouLesMax(threshold=maxRunPer_h)
    "Checks if the count of total runs is lower than the maximal value"
    annotation (Placement(transformation(extent={{74,-8},{90,8}})));
  Modelica.Blocks.MathInteger.TriggeredAdd triggeredAdd
    annotation (Placement(transformation(extent={{-36,6},{-24,-6}})));
  Modelica.Blocks.Sources.IntegerConstant intConPluOne(final k=1)
    "Value for counting"
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
  Modelica.Blocks.Math.IntegerToReal intToReal
    annotation (Placement(transformation(extent={{-14,-6},{-2,6}})));
  Modelica.Blocks.Math.Add sub(k2=-1)
    annotation (Placement(transformation(extent={{44,0},{60,16}})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(final delayTime(displayUnit=
          "h") = delayTime)
               annotation (Placement(transformation(extent={{14,-14},{24,-4}})));
equation
  connect(intConPluOne.y, triggeredAdd.u)
    annotation (Line(points={{-49.4,0},{-38.4,0}}, color={255,127,0}));
  connect(intToReal.u, triggeredAdd.y)
    annotation (Line(points={{-15.2,0},{-22.8,0}}, color={255,127,0}));
  connect(intToReal.y, sub.u1) annotation (Line(points={{-1.4,0},{0.15,0},{0.15,
          12.8},{42.4,12.8}}, color={0,0,127}));
  connect(intToReal.y, fixedDelay.u)
    annotation (Line(points={{-1.4,0},{0,0},{0,-9},{13,-9}}, color={0,0,127}));
  connect(fixedDelay.y, sub.u2) annotation (Line(points={{24.5,-9},{34,-9},{34,3.2},
          {42.4,3.2}}, color={0,0,127}));
  connect(runCouLesMax.y, y)
    annotation (Line(points={{90.8,0},{110,0},{110,0}}, color={255,0,255}));
  connect(u, triggeredAdd.trigger) annotation (Line(points={{-120,0},{-82,0},{
          -82,24},{-33.6,24},{-33.6,7.2}}, color={255,0,255}));
  connect(sub.y, runCouLesMax.u) annotation (Line(points={{60.8,8},{68,8},{68,0},
          {72.4,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}),
        Line(points={{0,80},{0,60}}, color={160,160,164}),
        Line(points={{80,0},{60,0}}, color={160,160,164}),
        Line(points={{0,-80},{0,-60}}, color={160,160,164}),
        Line(points={{-80,0},{-60,0}}, color={160,160,164}),
        Line(points={{37,70},{26,50}}, color={160,160,164}),
        Line(points={{70,38},{49,26}}, color={160,160,164}),
        Line(points={{71,-37},{52,-27}}, color={160,160,164}),
        Line(points={{39,-70},{29,-51}}, color={160,160,164}),
        Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
        Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
        Line(points={{-71,37},{-54,28}}, color={160,160,164}),
        Line(points={{-38,70},{-28,51}}, color={160,160,164}),
        Line(
          points={{0,0},{-50,50}},
          thickness=0.5),
        Line(
          points={{0,0},{40,0}},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Everytime the boolean input signal has a rising edge, a counter is
  triggered and adds 1 to the total sum. This represents an on-turning
  of a certain device. With a delay this number is being substracted
  again, as this block counts the number of rising edges in a given
  amount of time(e.g. 1 hour). If this value is higher than a given
  maximal value, the output turns to false.
</p>
<ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end RunPerHouBoundary;
