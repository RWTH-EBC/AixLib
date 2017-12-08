within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Interfaces;
connector ModeCVOutput = output Types.ModeCV
  "Connector that has the type 'ModeCV' as connector"
  annotation (Icon(
                coordinateSystem(preserveAspectRatio=true,
                  extent={{-100.0,-100.0},{100.0,100.0}}),
                  graphics={
                Polygon(
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
              Diagram(
                coordinateSystem(preserveAspectRatio=true,
                  extent={{-100.0,-100.0},{100.0,100.0}}),
                  graphics={
                Polygon(
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  points={{-100.0,50.0},{0.0,0.0},{-100.0,-50.0}}),
                Text(
                  lineColor={0,0,127},
                  extent={{30.0,60.0},{30.0,110.0}},
                  textString="%name")}));
