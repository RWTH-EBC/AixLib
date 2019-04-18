within AixLib.PlugNHarvest.Components.Ventilation.Old;
model AirPassage
  extends PlugNHarvest.Components.Ventilation.BaseClasses.PartialAirPassage;
  parameter Real A_open(unit="cm2")=45 "area of the air passage opening";
  Real V_flow_eff(final unit="m3/h") "effecitve volume flow";
  Real dp_inPa(final unit="Pa");
  Modelica.SIunits.Density d = 0.5*(Medium.density(state_a)+Medium.density(state_b));

equation
  V_flow_eff = A_open/10000*3600*sign(dp_inPa)*sqrt(abs(dp_inPa)/d);
  dp = dp_inPa;
  m_flow = V_flow_eff * d / 3600;
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
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
end AirPassage;
