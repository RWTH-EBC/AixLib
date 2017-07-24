within AixLib.Utilities.Math.Functions.Examples;
model RegNonZeroPower
  extends Modelica.Icons.Example;
  Real y "Function value";
equation
  y=AixLib.Utilities.Math.Functions.regNonZeroPower(
                                             time, 0.3, 0.5);
  annotation(experiment(StartTime=-1,Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Math/Functions/Examples/RegNonZeroPower.mos"
        "Simulate and plot"),
Documentation(info="<html>
<p>
This example tests the implementation of
<a href=\"modelica://AixLib.Utilities.Math.Functions.regNonZeroPower\">
AixLib.Utilities.Math.Functions.regNonZeroPower</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 8, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end RegNonZeroPower;
