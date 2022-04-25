within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions;
model to_HDirNor
  "Converts the direct irradiation onto a horizontal surface to direct
  irradiation on a normal surface"
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealInput alt(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar altitude angle"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput HDirHor(final quantity=
        "RadiantEnergyFluenceRate", final unit="W/m2")
    "Direct normal radiation"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput HDirNor(final quantity=
        "RadiantEnergyFluenceRate", final unit="W/m2")
    "Direct normal radiation"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));

equation
  HDirNor=HDirHor/Modelica.Math.sin(alt);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-78,0},{42,0}}, color={191,0,0}),
        Polygon(
          points={{94,0},{34,20},{34,-20},{94,0}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model converts the direct irradiation on a horizontal surface to
  the direct irradiation on a normal surface. Therefore it needs the
  solar altitude angle.
</p>
</html>",
    revisions="<html><ul>
  <li>June 30, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end to_HDirNor;
