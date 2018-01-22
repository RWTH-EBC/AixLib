within AixLib.Building.Components.Ventilation;
model FanUnit "Simple fan unit"
  extends AixLib.Building.Components.Ventilation.BaseClasses.PartialVentilationSourceOutside;

  parameter Real V_flow_nom(final unit="m3/h")=40 "nominal volume flow";
  parameter Real DV_flowDp(final unit="m3/(Pa.h)")=1 "gradient of the fan's characteristic curve";

equation
  dp_inPa * DV_flowDp + V_flow_nom = V_flow_eff;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-76,22},{-76,0},{0,0},{-30,28},{-76,22}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-36,8},{-36,-14},{40,-14},{10,14},{-36,8}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-14,-40},
          rotation=90,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{36,-8},{36,14},{-40,14},{-10,-14},{36,-8}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={14,40},
          rotation=90,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{76,-22},{76,0},{0,0},{30,-28},{76,-22}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-38,70},{-2,42},{0,0},{-54,54},{-38,70}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          pattern=LinePattern.None),
        Ellipse(
          extent={{-96,82},{-52,40}},
          lineColor={28,108,200},
          pattern=LinePattern.None),
        Polygon(
          points={{0,0},{-42,-2},{-70,-38},{-54,-54},{0,0}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{38,-70},{2,-42},{0,0},{54,-54},{38,-70}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{0,0},{42,2},{70,38},{54,54},{0,0}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-20,20},{20,-20}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-16,16},{16,-16}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-90,90},{90,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,-80},{90,-90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanUnit;
