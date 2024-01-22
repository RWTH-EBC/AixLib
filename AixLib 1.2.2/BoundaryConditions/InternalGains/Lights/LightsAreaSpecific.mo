within AixLib.BoundaryConditions.InternalGains.Lights;
model LightsAreaSpecific "Heat flow due to lighting relative to room area and specific lighting power"
  extends BaseClasses.PartialInternalGain(
    emissivity=0.98,
    ratioConv=0.5,
    radConvertor(final A=max(Modelica.Constants.eps, areaSurfaceLightsTotal)),
    gain(final k=roomArea*lightingPowerRoomAreaSpecific),
    gainSurfaces(final k=areaSurfaceLightsTotal));
  parameter Modelica.Units.SI.Area roomArea "Area of room"
    annotation (Dialog(descriptionLabel=true));
  parameter Real lightingPowerRoomAreaSpecific=10 "Lighting power per square meter room"
                                                                           annotation(Dialog( descriptionLabel = true));
  parameter Modelica.Units.SI.Area areaSurfaceLightsTotal=0.01*roomArea
    "Surface of all lights in the room";

  annotation (Icon(graphics={
        Ellipse(
          extent={{-50,72},{50,-40}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-40,60},{40,20}},
          lineColor={0,0,0},
          textString="A"),
        Text(
          extent={{-44,20},{44,-8}},
          lineColor={0,0,0},
          textString="Room"),
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
          thickness=1)}), Documentation(revisions="<html><ul>
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
  determined by multiplying a schedule (input 0..1) and a specific
  thermal power and the room's area.
</p>
</html>"));
end LightsAreaSpecific;
