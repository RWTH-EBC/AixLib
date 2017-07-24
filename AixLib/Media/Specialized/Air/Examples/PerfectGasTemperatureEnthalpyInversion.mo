within AixLib.Media.Specialized.Air.Examples;
model PerfectGasTemperatureEnthalpyInversion
  "Model to check computation of h(T) and its inverse"
  extends Modelica.Icons.Example;
  extends AixLib.Media.Examples.BaseClasses.TestTemperatureEnthalpyInversion(
    redeclare package Medium = AixLib.Media.Specialized.Air.PerfectGas);
  annotation (
experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Media/Specialized/Air/Examples/PerfectGasTemperatureEnthalpyInversion.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests whether the inversion of temperature and enthalpy
is implemented correctly.
If <i>T &ne; T(h(T))</i>, the model stops with an error.
</p>
</html>", revisions="<html>
<ul>
<li>
November 21, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end PerfectGasTemperatureEnthalpyInversion;
