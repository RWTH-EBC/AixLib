within AixLib.Utilities.Sources.InternalGains.Lights;
model LightsRelToMaxValue "Multiplies relative input with max value (heat flow due to lighting in W)"
  extends BaseClasses.PartialInternalGain(emissivity=0.98, gainSurfaces(final k=areaSurfaceLightsTotal),
    gain(final k=maxHeatFlowAbsolute));

  parameter Modelica.SIunits.HeatFlowRate maxHeatFlowAbsolute "Maximal absolute heat flow due to lighting";
  parameter Modelica.SIunits.Area areaSurfaceLightsTotal=0.001*maxHeatFlowAbsolute "Surface of all lights in the room";

equation

  connect(radConvertor.rad, radHeat) annotation (Line(
      points={{71.1,-60},{90,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(radiativeHeat.port, radConvertor.conv) annotation (Line(points={{44,-20},{48,-20},{48,-60},{52.8,-60}}, color={191,0,0}));
  annotation ( Icon(graphics={
        Ellipse(
          extent={{-50,72},{50,-40}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-26,-48},{26,-48}},
          thickness=1),
        Line(
          points={{-24,-56},{24,-56}},
          thickness=1),
        Line(
          points={{-22,-64},{22,-64}},
          thickness=1),
        Line(
          points={{-20,-72},{20,-72}},
          thickness=1),
        Line(
          points={{-28,-42},{-28,-80},{28,-80},{28,-42}},
          thickness=1),
        Text(
          extent={{-44,20},{44,-8}},
          lineColor={0,0,0},
          textString="Power"),
        Text(
          extent={{-44,48},{44,20}},
          lineColor={0,0,0},
          textString="Max")}),
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
end LightsRelToMaxValue;
