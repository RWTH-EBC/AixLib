within AixLib.PlugNHarvest.Components.Ventilation;
model PVventilation
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_pv annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_wall annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ambient annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));

  Modelica.SIunits.Temperature Tamb;
  Modelica.SIunits.Temperature Tcl1;
  Modelica.SIunits.Temperature Tcl2;
  flow Modelica.SIunits.HeatFlowRate Q2_1;
  flow Modelica.SIunits.HeatFlowRate Q2_2;

  Real p0;
  Real p1;
  Real p2;
  Real p3;
  Real p4;
  Real p5;
  Real r0;
  Real r1;
  Real r2;
  Real r3;
  Real r4;
  Real r5;

equation
  Tamb = ambient.T;
  Tcl1 = port_pv.T;
  Tcl2 = port_wall.T;
  Q2_1 = port_pv.Q_flow;
  Q2_2 = port_wall.Q_flow;
  0 = ambient.Q_flow;

  Q2_1 = p0 + p1 * Tcl2 + p2 * Tamb + p3 * Tcl2^2 + p4 * Tcl2 * Tamb + p5 * Tamb^2;

  p0 = 0.1872 * Tcl1^2 -14.855 * Tcl1 + 370.91;
  p1 = -0.01275 * Tcl1^2 + 1.2033 * Tcl1 - 30.5;
  p2 = -0.0005907 * Tcl1^2 + 0.01381 * Tcl1 + 0.4697;
  p3 = 0.0002322 * Tcl1^2 - 0.02354 * Tcl1 + 0.5944;
  p4 = 0.00002892 * Tcl1^2 - 0.0002283 * Tcl1 - 0.04188;
  p5 = -0.00001145 * Tcl1^2 + 0.0004642 * Tcl1 - 0.0003216;

  Q2_2 = r0 + r1 * Tcl2 + r2 * Tamb + r3 * Tcl2^2 + r4 * Tcl2 * Tamb + r5 * Tamb^2;

  r0 = -0.1654 * Tcl1^2 + 13.05 * Tcl1 - 334.5;
  r1 = 0.01199 * Tcl1^2 - 1.118 * Tcl1 + 28.36;
  r2 = 0.0002555 * Tcl1^2 - 0.007558 * Tcl1 - 0.2005;
  r3 = -0.000234 * Tcl1^2 + 0.02298 * Tcl1 - 0.565;
  r4 = -0.000007333 * Tcl1^2 - 0.001073 * Tcl1 + 0.04905;
  r5 = 0.000005842 * Tcl1^2 + 0.0002043 * Tcl1 - 0.01159;
  annotation (                                 Icon(graphics={
        Rectangle(
          extent={{-64,90},{-54,-90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-54,-40},{-40,32},{-32,44},{-20,52},{-6,56},{6,56},{20,52},{
              32,44},{40,32},{54,-40},{-54,-40}},
          lineColor={0,0,0},
          fillColor={14,191,245},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,90},{-76,-90}},
          lineColor={0,0,0},
          fillColor={149,149,149},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{76,90},{90,-90}},
          lineColor={0,0,0},
          fillColor={149,149,149},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-76,90},{-64,-90}},
          lineColor={0,0,0},
          fillColor={181,181,181},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{54,90},{64,-90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{64,90},{76,-90}},
          lineColor={0,0,0},
          fillColor={181,181,181},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(extent={{-90,90},{-54,-90}}, lineColor={0,0,0}),
        Rectangle(extent={{54,90},{90,-90}}, lineColor={0,0,0}),
        Polygon(
          points={{-54,-40},{-40,6},{-30,22},{-18,28},{-6,30},{6,30},{18,28},{
              30,22},{40,6},{54,-40},{-54,-40}},
          lineColor={0,0,0},
          fillColor={27,152,229},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-54,-40},{-38,-10},{-28,0},{-16,8},{-4,10},{4,10},{16,8},{28,
              0},{38,-10},{54,-40},{-54,-40}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(points={{-40,32},{-40,-40}}, color={0,0,0}),
        Line(points={{40,32},{40,-40}}, color={0,0,0}),
        Line(points={{-20,52},{-20,-40}}, color={0,0,0}),
        Line(points={{0,56},{0,-40}}, color={0,0,0}),
        Line(points={{20,52},{20,-40}}, color={0,0,0}),
        Polygon(
          points={{-40,32},{-48,18},{-32,18},{-40,32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,56},{-8,42},{8,42},{0,56}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,52},{-28,38},{-12,38},{-20,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,52},{12,38},{28,38},{20,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,32},{32,18},{48,18},{40,32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end PVventilation;
