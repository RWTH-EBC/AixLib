within AixLib.Utilities.Tables;
model CombiTable2DExtra
  "Altered CombiTable2D with the option to not extrapolate"
  extends Modelica.Blocks.Interfaces.SI2SO;

  parameter Boolean extrapolation = true "False to hold last value";
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation";
  parameter Real table[:,:]=[0,0]
    "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
                                  //Set default value to [0,0] to obmit warnings
  Modelica.Blocks.Tables.CombiTable2Ds combiTable2D(
    final tableOnFile=false,
    final table=table,
    final smoothness=smoothness) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={20,0})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(final uMax=max(table[2:end, 1]),
      final uMin=min(table[2:end, 1])) if not extrapolation
    annotation (Placement(transformation(extent={{-76,24},{-60,40}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(final uMax=max(table[1, 2:end]),
      final uMin=min(table[1, 2:end])) if not extrapolation
    annotation (Placement(transformation(extent={{-76,-40},{-60,-24}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough2 if extrapolation
    annotation (Placement(transformation(extent={{-76,-68},{-60,-52}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough1 if extrapolation
    annotation (Placement(transformation(extent={{-76,52},{-60,68}})));
equation
  connect(combiTable2D.y, y)
    annotation (Line(points={{42,0},{110,0}}, color={0,0,127}));
  connect(u1, limiter1.u) annotation (Line(
      points={{-120,60},{-88,60},{-88,32},{-77.6,32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(limiter1.y, combiTable2D.u1) annotation (Line(
      points={{-59.2,32},{-26,32},{-26,12},{-4,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(u2, limiter2.u) annotation (Line(
      points={{-120,-60},{-90,-60},{-90,-32},{-77.6,-32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(limiter2.y, combiTable2D.u2) annotation (Line(
      points={{-59.2,-32},{-26,-32},{-26,-12},{-4,-12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(u2, realPassThrough2.u) annotation (Line(
      points={{-120,-60},{-77.6,-60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPassThrough2.y, combiTable2D.u2) annotation (Line(
      points={{-59.2,-60},{-26,-60},{-26,-12},{-4,-12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(u1, realPassThrough1.u) annotation (Line(
      points={{-120,60},{-77.6,60}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realPassThrough1.y, combiTable2D.u1) annotation (Line(
      points={{-59.2,60},{-26,60},{-26,12},{-4,12}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (                                 Icon(graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255}),
    Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
    Line(points={{0.0,40.0},{0.0,-40.0}}),
    Line(points={{-60.0,40.0},{-30.0,20.0}}),
    Line(points={{-30.0,40.0},{-60.0,20.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,0.0},{-32.3077,20.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,-20.0},{-32.3077,0.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-30.0,20.0},{0.0,40.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{0.0,20.0},{30.0,40.0}}),
    Rectangle(origin={-2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{32.3077,20.0},{62.3077,40.0}})}), Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  As the standard model for two dimensional tables (<a href=
  \"modelica://Modelica.Blocks.Tables.CombiTable2D\">Modelica.Blocks.Tables.CombiTable2D</a>)
  does not allow extrapolation to be disabled, this models presents a
  work around. Using a simple limiter, extrapolation can be switched on
  or off.
</p>
<p>
  See <a href=
  \"Modelica.Blocks.Tables.CombiTable2D\">Modelica.Blocks.Tables.CombiTable2D</a>
  for further information on the used tables.
</p>
</html>"));
end CombiTable2DExtra;
