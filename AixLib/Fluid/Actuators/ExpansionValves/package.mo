within AixLib.Fluid.Actuators;
package ExpansionValves "Package that contains models of expansion valves"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
        Polygon(
          points={{0,18},{-40,48},{-40,-12},{0,18}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,18},{40,48},{40,-12},{0,18}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-20,82},{20,42}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,82},{20,42}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,42},{0,18}},
          color={0,0,0},
          thickness=0.5),
        Polygon(
          points={{-48,-50},{-88,-20},{-88,-80},{-48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{-48,-50},{-8,-20},{-8,-80},{-48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{48,-50},{8,-20},{8,-80},{48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{48,-50},{88,-20},{88,-80},{48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}));
end ExpansionValves;
