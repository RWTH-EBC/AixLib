within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
model HeatConvRadiator

  parameter Real n "Radiator exponent";
  parameter Real NominalPower "Nominal power of radiator";
  parameter Real s_eff "Fraction of radiation power";
  parameter Real dT_nom "Nominal temperature difference";
  parameter Real kA=(1-s_eff)*NominalPower/dT_nom^n;
  Real alpha_t;
  Modelica.Units.NonSI.Temperature_degC posDiff=noEvent(abs(port_b.T - port_a.T))
    "Positive temperature difference";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{84,-10},{104,10}})));

equation
  alpha_t = if noEvent(posDiff <= 5e-12) then 0 else (kA*noEvent(posDiff^(n-1)));
  port_a.Q_flow + port_b.Q_flow = 0;
  port_a.Q_flow = alpha_t*(port_a.T - port_b.T);
  annotation (Diagram(graphics),
                       Icon(graphics={
        Rectangle(
          extent={{-80,88},{80,-100}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{10,-100},{18,-92},{24,-80},{32,-58},{40,-30},{46,20},{
              48,66},{48,86}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{8,-100},{8,86}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{8,78},{8,76},{10,74},{12,66},{16,56},{24,48},{32,44},{
              38,42},{44,42},{46,42},{48,42},{48,42}},
          color={255,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{8,-10},{8,-10}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{8,-10},{10,-6},{12,0},{14,4},{16,12},{16,12},{18,16},{
              20,20},{22,22},{26,22},{28,22},{30,20},{32,18},{32,16},{34,
              12},{34,12},{34,12},{34,12},{36,2},{36,-2},{38,-6},{40,-8},
              {42,-8},{42,-10}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.None)}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model represents the convective heat transfer from a radiator to
  the environment.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>October, 2016&#160;</i> by Peter Remmen:<br/>
    Transfer to AixLib.
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>
"));
end HeatConvRadiator;
