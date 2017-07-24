within AixLib.Utilities.Math.Examples;
model InverseXRegularized "Test model for inverseXRegularized function "
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp x1(duration=1,
    height=2,
    offset=-1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  AixLib.Utilities.Math.InverseXRegularized inverseXRegularized(delta=0.1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(x1.y, inverseXRegularized.u) annotation (Line(
      points={{-39,0},{-12,0}},
      color={0,0,127}));
  annotation (experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Math/Examples/InverseXRegularized.mos"
        "Simulate and plot"), Documentation(info="<html>
<p>
This model tests the implementation of
<a href=\"modelica://AixLib.Utilities.Math.InverseXRegularized\">
AixLib.Utilities.Math.InverseXRegularized</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 28, 2013, by Marcus Fuchs:<br/>
Implementation based on Functions.inverseXRegularized.
</li>
</ul>
</html>"));
end InverseXRegularized;
