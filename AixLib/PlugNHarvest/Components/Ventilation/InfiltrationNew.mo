within AixLib.PlugNHarvest.Components.Ventilation;
model InfiltrationNew "Simple infiltration"
  extends PlugNHarvest.Components.Ventilation.BaseClasses.PartialVentFreshAir;

  parameter Modelica.SIunits.Volume room_V = 50 "Volume of the room";
  parameter Real n50(unit = "h-1") = 4
    "Air exchange rate at 50 Pa pressure difference";
  parameter Real e = 0.03 "Coefficient of windshield";
  parameter Real eps = 1.0 "Coefficient of height";

protected
  parameter Real InfiltrationRate = 2 * n50 * e * eps;

public
  Modelica.Blocks.Sources.RealExpression realExpression(y=-(InfiltrationRate*
        room_V*senDen.d)/3600)
    annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
equation

  connect(realExpression.y, boundary.m_flow_in)
    annotation (Line(points={{-39,-24},{-22,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-36,100},{36,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,26},{-20,46},{20,26},{60,46},{60,36},{20,16},{-20,36},{-60,
              16},{-60,26}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-34},{-20,-14},{20,-34},{60,-14},{60,-24},{20,-44},{-20,-24},
              {-60,-44},{-60,-34}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-4},{-20,16},{20,-4},{60,16},{60,6},{20,-14},{-20,6},{-60,
              -14},{-60,-4}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>", info="<html>
<p>Infiltration of fresh air (outside air), according to the german standard <code>DIN 12831.</code></p>
<p>The boundary component pulls the same mass flow from the room in order to have mass equlibrium. </p>
<p>The air model is a medium model.</p>
</html>"));
end InfiltrationNew;
