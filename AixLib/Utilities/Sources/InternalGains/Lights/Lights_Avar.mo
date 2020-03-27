within AixLib.Utilities.Sources.InternalGains.Lights;
model Lights_Avar
  extends BaseClasses.PartialInternalGain(emissivity=0.98,
    productHeatOutput(nu=1),
    radConvertor(final use_A_in=true));

  parameter Modelica.SIunits.RadiantEnergyFluenceRate specificPower=100
    "radiative power per m2";

  Modelica.Blocks.Math.Gain gain(final k=1/specificPower) annotation (Placement(transformation(extent={{-26,-46},{-14,-34}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=Modelica.Constants.inf, final uMin=Modelica.Constants.eps) annotation (Placement(transformation(extent={{-6,-46},{6,-34}})));
equation

  connect(radConvertor.rad, radHeat) annotation (Line(
      points={{71.1,-60},{90,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(radiativeHeat.port, radConvertor.conv) annotation (Line(points={{44,-20},{48,-20},{48,-60},{52.8,-60}}, color={191,0,0}));
  connect(schedule, productHeatOutput.u[1]) annotation (Line(points={{-100,0},{-20,0}}, color={0,0,127}));
  connect(gain.y,limiter. u) annotation (Line(points={{-13.4,-40},{-7.2,-40}}, color={0,0,127}));
  connect(limiter.y, radConvertor.A_in) annotation (Line(points={{6.6,-40},{62,-40},{62,-51}}, color={0,0,127}));
  connect(gain.u, schedule) annotation (Line(points={{-27.2,-40},{-60,-40},{-60,0},{-100,0}}, color={0,0,127}));
  annotation ( Icon(graphics={
        Ellipse(
          extent={{-52,72},{50,-40}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-26,-48},{22,-48}},
          thickness=1),
        Line(
          points={{-24,-56},{22,-56}},
          thickness=1),
        Line(
          points={{-24,-64},{22,-64}},
          thickness=1),
        Line(
          points={{-24,-72},{22,-72}},
          thickness=1),
        Line(
          points={{-28,-42},{-28,-80},{26,-80},{26,-42}},
          thickness=1)}),
    Documentation(revisions="<html>
<ul>
<li><i>October 21, 2014&nbsp;</i> by Ana Constantin:<br/>Added a lower positive limit to the surface area, so it will not lead to a division by zero</li>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple light heat source model.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The area is variable and can be set via a special input in the radiative converter.</p>
<p>The input signal can take values from 0 to an arbitrary maximum value. </p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The surface for radiation exchange is computed from the schedule, which leads to a surface area of zero, when no activity takes place. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero. For this reason a lower limitation of 1e-4 m2 has been introduced.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Building.Examples.Sources.InternalGains.Lights\">AixLib.Building.Examples.Sources.InternalGains.Lights</a> </p>
</html>"));
end Lights_Avar;
