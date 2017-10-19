within AixLib.Media.Specialized.Water.Examples;
model TemperatureDependentDensityProperties
  "Model that tests the implementation of the fluid properties"
  extends Modelica.Icons.Example;
  extends AixLib.Media.Examples.BaseClasses.FluidProperties(
    redeclare package Medium =
        AixLib.Media.Specialized.Water.TemperatureDependentDensity,
    TMin=273.15,
    TMax=373.15);
equation
  // Check the implementation of the base properties
  basPro.state.p=p;
  basPro.state.T=T;
   annotation(experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Media/Specialized/Water/Examples/TemperatureDependentDensityProperties.mos"
        "Simulate and plot"),
      Documentation(info="<html>
<p>
This example checks thermophysical properties of the medium.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end TemperatureDependentDensityProperties;
