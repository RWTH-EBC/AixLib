within AixLib.PlugNHarvest.Components.Ventilation.Old;
model NoAirPassage "no air passage in the fassade"
  extends PlugNHarvest.Components.Ventilation.BaseClasses.PartialAirPassage;

equation

  connect(port_a, port_b)
    annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-100,100},{-100,78},{-42,78},{-42,36},{42,36},{42,76},{100,76},
              {100,100},{-100,100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-100},{-100,-78},{-42,-78},{-42,-36},{42,-36},{42,-78},{
              100,-78},{100,-100},{-100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{-140,78}}, color={0,0,0}),
        Polygon(
          points={{-36,36},{-46,20},{-38,20},{-38,-20},{-46,-20},{-36,-36},{-26,
              -20},{-34,-20},{-34,20},{-26,20},{-36,36}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-32,12},{78,-8}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          textString="%A_open% cm2")}),                          Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end NoAirPassage;
