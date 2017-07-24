within AixLib.Utilities.Math.Examples;
model RegNonZeroPower "Test model for regNonZeroPower function "
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp x1(duration=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  AixLib.Utilities.Math.RegNonZeroPower regNonZeroPower(n=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(x1.y, regNonZeroPower.u) annotation (Line(
      points={{-39,0},{-12,0}},
      color={0,0,127}));
  annotation ( experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Math/Examples/RegNonZeroPower.mos"
        "Simulate and plot"), Documentation(info="<html>
<p>
This model tests the implementation of
<a href=\"modelica://AixLib.Utilities.Math.RegNonZeroPower\">
AixLib.Utilities.Math.RegNonZeroPower</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 28, 2013, by Marcus Fuchs:<br/>
First implementation.
</li>
</ul>
</html>"));
end RegNonZeroPower;
