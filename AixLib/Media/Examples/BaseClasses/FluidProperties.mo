within AixLib.Media.Examples.BaseClasses;
partial model FluidProperties
  "Model that tests the implementation of the fluid properties"
  extends AixLib.Media.Water.Examples.BaseClasses.FluidProperties;
  Medium.ThermodynamicState state_dTX "Medium state";
equation
    state_dTX = Medium.setState_dTX(d=d, T=T, X=X);
    checkState(state_pTX, state_dTX, "state_dTX");

   annotation(      Documentation(info="<html>
<p>
This example checks thermophysical properties of the medium.
It extends from
<a href=\"modelica://AixLib.Media.Water.Examples.BaseClasses.FluidProperties\">
AixLib.Media.Water.Examples.BaseClasses.FluidProperties</a>
and adds tests that are only meaningful for compressible media.
</p>
</html>",
revisions="<html>
<ul>
<li>
October 16, 2014, by Michael Wetter:<br/>
Changed implementation to extend from
<a href=\"modelica://AixLib.Media.Water.Examples.BaseClasses.FluidProperties\">
AixLib.Media.Water.Examples.BaseClasses.FluidProperties</a>.
</li>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FluidProperties;
