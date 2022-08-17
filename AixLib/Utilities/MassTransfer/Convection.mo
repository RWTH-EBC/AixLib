within AixLib.Utilities.MassTransfer;
model Convection
  "Lumped element for mass convection (m_flow = Gc*dX)"
  Modelica.Units.SI.MassFlowRate m_flow "Mass flow rate from solid -> fluid";
  Modelica.Units.SI.PartialPressure dp "= solid.p - fluid.p";
  Modelica.Blocks.Interfaces.RealInput Gc(unit="kg/(s.Pa)")
    "Signal representing the convective mass transfer coefficient in [kg/s]"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  MassPort solid
    annotation (Placement(transformation(extent={{-118,-18},{-82,18}})));
  MassPort fluid
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));
equation
  dp = solid.p - fluid.p;
  solid.m_flow = m_flow;
  fluid.m_flow = -m_flow;
  m_flow = Gc*dp;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-62,80},{98,-80}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          lineColor={0,0,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{-60,20},{76,20}}, color={0,140,72}),
        Line(points={{-60,-20},{76,-20}}, color={0,140,72}),
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
        Line(points={{6,80},{6,-80}}, color={0,127,255}),
        Line(points={{40,80},{40,-80}}, color={0,127,255}),
        Line(points={{76,80},{76,-80}}, color={0,127,255}),
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
        Line(points={{6,-80},{16,-60}}, color={0,127,255}),
        Line(points={{40,-80},{30,-60}}, color={0,127,255}),
        Line(points={{40,-80},{50,-60}}, color={0,127,255}),
        Line(points={{76,-80},{66,-60}}, color={0,127,255}),
        Line(points={{76,-80},{86,-60}}, color={0,127,255}),
        Line(points={{56,-30},{76,-20}}, color={0,140,72}),
        Line(points={{56,-10},{76,-20}}, color={0,140,72}),
        Line(points={{56,10},{76,20}}, color={0,140,72}),
        Line(points={{56,30},{76,20}}, color={0,140,72}),
        Text(
          extent={{22,124},{92,98}},
          textString="Gc")}),
    Documentation(info="<html><p>
  This is a model of linear mass convection, e.g., the mass transfer
  between a plate and the surrounding air. It may be used for
  complicated solid geometries and fluid flow over the solid by
  determining the convective mass transfer coefficient Gc by
  measurements. The basic constitutive equation for convection is
</p>
<p>
  <span style=\"font-family: Courier New;\">m_flow = Gc*(solid.p -
  fluid.p);</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">m_flow: Mass flow rate from
  connector 'solid' (e.g., a plate)</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">to connector 'fluid' (e.g.,
  the surrounding air)</span>
</p>
<p>
  Gc = G.signal[1] is an input signal to the component, since Gc is
  nearly never constant in practice. For example, Gc may be a function
  of the speed of a cooling fan. For simple situations, Gc may be
  <i>calculated</i> according to
</p>
<p>
  <span style=\"font-family: Courier New;\">Gc = A*h</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">A: Convection area (e.g.,
  perimeter*length of a box)</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">h: mass transfer
  coefficient</span>
</p>
<p>
  where the mass transfer coefficient h is calculated from properties
  of the fluid flowing over the solid.
</p>
</html>", revisions="<html>
<ul>
  <li>November 20, 2019, by Martin Kremer:<br/>
    First Implementation.
  </li>
</ul>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-90,80},{-60,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Line(points={{100,0},{100,0}}, color={0,127,255}),
        Text(
          extent={{-40,40},{80,20}},
          lineColor={0,140,72},
          textString="m_flow"),
        Line(points={{-60,20},{76,20}}, color={0,140,72}),
        Line(points={{-60,-20},{76,-20}}, color={0,140,72}),
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}),
        Line(points={{6,80},{6,-80}}, color={0,127,255}),
        Line(points={{40,80},{40,-80}}, color={0,127,255}),
        Line(points={{76,80},{76,-80}}, color={0,127,255}),
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}),
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}),
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}),
        Line(points={{6,-80},{16,-60}}, color={0,127,255}),
        Line(points={{40,-80},{30,-60}}, color={0,127,255}),
        Line(points={{40,-80},{50,-60}}, color={0,127,255}),
        Line(points={{76,-80},{66,-60}}, color={0,127,255}),
        Line(points={{76,-80},{86,-60}}, color={0,127,255}),
        Line(points={{56,-30},{76,-20}}, color={0,140,72}),
        Line(points={{56,-10},{76,-20}}, color={0,140,72}),
        Line(points={{56,10},{76,20}}, color={0,140,72}),
        Line(points={{56,30},{76,20}}, color={0,140,72})}));
end Convection;
