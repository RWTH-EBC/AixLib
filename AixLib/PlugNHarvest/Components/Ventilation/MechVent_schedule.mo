within AixLib.PlugNHarvest.Components.Ventilation;
model MechVent_schedule "Mechanical ventilation using a schedule"
  extends PlugNHarvest.Components.Ventilation.BaseClasses.PartialVentFreshAir;

  parameter Modelica.SIunits.Volume room_V = 50 "Volume of the room";

public
  Modelica.Blocks.Sources.RealExpression realExpression(y=-(Schedule_mechVent*
        room_V*senDen.d)/3600)
    annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
public
  Modelica.Blocks.Interfaces.RealInput Schedule_mechVent(unit="m3/s")
    "schedule for mechanical ventilation" annotation (Placement(transformation(
          extent={{-120,-80},{-80,-40}}), iconTransformation(extent={{-100,-80},
            {-80,-60}})));
equation

  connect(realExpression.y, boundary.m_flow_in)
    annotation (Line(points={{-39,-24},{-22,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-90,90},{90,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-38,70},{-2,42},{0,0},{-54,54},{-38,70}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{36,-8},{36,14},{-40,14},{-10,-14},{36,-8}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={14,40},
          rotation=90,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{0,0},{42,2},{70,38},{54,54},{0,0}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{76,-22},{76,0},{0,0},{30,-28},{76,-22}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{38,-70},{2,-42},{0,0},{54,-54},{38,-70}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-36,8},{-36,-14},{40,-14},{10,14},{-36,8}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-14,-40},
          rotation=90,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{0,0},{-42,-2},{-70,-38},{-54,-54},{0,0}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-76,22},{-76,0},{0,0},{-30,28},{-76,22}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-16,16},{16,-16}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-90,-80},{90,-90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
end MechVent_schedule;
