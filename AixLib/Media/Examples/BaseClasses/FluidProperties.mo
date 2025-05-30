within AixLib.Media.Examples.BaseClasses;
partial model FluidProperties
  "Model that tests the implementation of the fluid properties"
  extends PartialProperties;

  Medium.ThermodynamicState state_phX "Medium state";
  Medium.ThermodynamicState state_psX "Medium state";

  Modelica.Media.Interfaces.Types.DerDensityByPressure ddpT
    "Density derivative w.r.t. pressure";
  Modelica.Media.Interfaces.Types.DerDensityByTemperature ddTp
    "Density derivative w.r.t. temperature";
  Modelica.Units.SI.Density[Medium.nX] dddX
    "Density derivative w.r.t. mass fraction";

equation

   // Check setting the states
    state_pTX = Medium.setState_pTX(p=p, T=T, X=X);
    state_phX = Medium.setState_phX(p=p, h=h, X=X);
    state_psX = Medium.setState_psX(p=p, s=s, X=X);
    checkState(state_pTX, state_phX, errAbs, "state_phX");
    checkState(state_pTX, state_psX, errAbs, "state_psX");

    // Check the implementation of the functions
    ddpT = Medium.density_derp_T(state_pTX);
    ddTp = Medium.density_derT_p(state_pTX);
    dddX   = Medium.density_derX(state_pTX);
   annotation (Documentation(info="<html>
<p>
This example checks thermophysical properties of the medium.
</p>
</html>",
revisions="<html>
<ul>
<li>
June 6, 2015, by Michael Wetter:<br/>
Changed type of <code>T</code> from
<code>Modelica.Units.SI.Temperature</code> to <code>Medium.Temperature</code>.
Otherwise, it has a different start value than <code>BaseProperties.T</code>, which
causes an error if
<a href=\"modelica://AixLib.Media.Examples.WaterProperties\">
AixLib.Media.Examples.WaterProperties</a>
is translated in pedantic mode.
This fixes
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/266\">#266</a>.
</li>
<li>
October 16, 2014, by Michael Wetter:<br/>
Removed call to <code>setState_dTX</code> as this
function is physically not defined for incompressible media.
</li>
<li>
December 19, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end FluidProperties;
