within AixLib.Controls.OBC.CDL.Routing.Validation;
model BooleanScalarReplicator
  "Validation model for the BooleanScalarReplicator block"
  AixLib.Controls.OBC.CDL.Routing.BooleanScalarReplicator booRep(
    nout=3)
    "Block that outputs the array replicating input value"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  AixLib.Controls.OBC.CDL.Logical.Sources.Pulse booPul(
    period=0.2)
    "Block that outputs boolean pulse"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

equation
  connect(booPul.y,booRep.u)
    annotation (Line(points={{-19,0},{18,0}},color={255,0,255}));
  annotation (
    experiment(
      StopTime=1.0,
      Tolerance=1e-06),
    __Dymola_Commands(
      file="modelica://AixLib/Resources/Scripts/Dymola/Controls/OBC/CDL/Routing/Validation/BooleanScalarReplicator.mos" "Simulate and plot"),
    Documentation(
      info="<html>
<p>
Validation test for the block
<a href=\"modelica://AixLib.Controls.OBC.CDL.Routing.BooleanScalarReplicator\">
AixLib.Controls.OBC.CDL.Routing.BooleanScalarReplicator</a>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
July 27, 2021, by Baptiste Ravache:<br/>
Renamed to BooleanScalarReplicator.
</li>
<li>
July 24, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}), 
   __Dymola_LockedEditing="Model from IBPSA");
end BooleanScalarReplicator;
