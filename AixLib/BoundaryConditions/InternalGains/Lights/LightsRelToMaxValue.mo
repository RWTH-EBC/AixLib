within AixLib.BoundaryConditions.InternalGains.Lights;
model LightsRelToMaxValue "Multiplies relative input with max value (heat flow due to lighting in W)"
  extends BaseClasses.PartialInternalGain(emissivity=0.98, gainSurfaces(final k=areaSurfaceLightsTotal),
    gain(final k=maxHeatFlowAbsolute));

  parameter Modelica.Units.SI.HeatFlowRate maxHeatFlowAbsolute
    "Maximal absolute heat flow due to lighting";
  parameter Modelica.Units.SI.Area areaSurfaceLightsTotal=0.001*
      maxHeatFlowAbsolute "Surface of all lights in the room";

equation

  connect(radConvertor.radPort, radHeat) annotation (Line(
      points={{71.1,-60},{90,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(radiativeHeat.port, radConvertor.convPort) annotation (Line(points={{44,-20},{48,-20},{48,-60},{52.8,-60}}, color={191,0,0}));
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
    Documentation(revisions="<html><ul>
  <li>
    <i>March 30, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/886\">#886</a>:
    Summarize models to partial model. Make all models dependant from a
    relative input 0..1. Many refactorings.
  </li>
  <li>
    <i>October 21, 2014&#160;</i> by Ana Constantin:<br/>
    Added a lower positive limit to the surface area, so it will not
    lead to a division by zero
  </li>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 07, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>",
    info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Heat source with convective and radiative component. The load is
  determined by a relative input which is multiplied with a maximal
  power.
</p>
</html>"));
end LightsRelToMaxValue;
