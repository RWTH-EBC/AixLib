within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialGuard
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={135,135,135},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          extent={{-100,-100},{100,100}},
          radius=25),
        Line(points={{100,80},{0,80},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,50},{0,50},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,20},{0,20},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,-20},{0,-20},{-70,0}},     color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,-50},{0,-50},{-70,0}},   color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Line(points={{100,-80},{0,-80},{-70,0}},     color={0,0,0},
          arrow={Arrow.Filled,Arrow.None}),
        Ellipse(
          extent={{-50,20},{-90,-20}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{0,100},{100,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SC"),
        Text(
          extent={{0,70},{100,50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SCTP"),
        Text(
          extent={{0,40},{100,20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="TP"),
        Text(
          extent={{0,0},{100,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="TPSH"),
        Text(
          extent={{0,-30},{100,-50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SH"),
        Text(
          extent={{0,-60},{100,-80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="SCTPSH")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end PartialGuard;
