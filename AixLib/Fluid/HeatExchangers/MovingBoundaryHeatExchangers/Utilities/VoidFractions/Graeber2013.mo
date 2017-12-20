within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.VoidFractions;
model Graeber2013
  "Void fraction model only depending on pressure developed by Gräber (2013)"
  extends BaseClasses.PartialVoidFraction;

  // Definition of variables describing the saturation properties
  //
  Medium.SaturationProperties sat = Medium.setSat_p(p=p)
    "Saturation properties used to calculate furhter properties";

  Modelica.SIunits.Density dLiq = Medium.bubbleDensity(sat=sat)
    "Density at bubble line";
  Modelica.SIunits.Density dVap = Medium.dewDensity(sat=sat)
    "Density at dew line";

  // Definition of variables describing derivatives
  //
  Real dpdt(unit="Pa/s")= der(p)
    "Derivative of pressure wrt. time";
  Real ddLiqdp(unit="kg/(m3.Pa)") = Medium.dBubbleDensity_dPressure(sat=sat)
    "Partial derivative of dLiq wrt. p";
  Real ddVapdp(unit="kg/(m3.Pa)") = Medium.dDewDensity_dPressure(sat=sat)
    "Partial derivative of dVap wrt. p";

  // Definition of auxillary variables
  //
  Real auxThe(unit="1") = dVap/dLiq
    "Ratio of the dew and bubble density";
  Real dvoiFradauxThe(unit="1")
    "Partial derivative of voiFra wrt. auxThe";
  Real dauxThedp(unit="1/Pa")
    "Partial derivative of auxThe wrt. p";


equation
  // Calculation of void fraction used internally
  //
  voiFraInt = (auxThe^(2/3) * (2/3 * log(auxThe) - 1) + 1) / (1 - auxThe^(2/3))^2
    "Void fraction";

  // Calculation of the derivative of the void fraction used internally wrt. time
  //
  voiFraInt_der = dvoiFradauxThe*dauxThedp*dpdt
    "Derivative of the void fraction wrt. time";

  dvoiFradauxThe = (-(4*((auxThe^(2/3) + 1)*log(auxThe) - 3*auxThe^(2/3) + 3))/
    (9*(auxThe^(2/3) - 1)^3*auxThe^(1/3)))
    "Partial derivative of voiFra wrt. auxThe";
  dauxThedp = 1/dLiq*ddVapdp - dVap/dLiq^2*ddLiqdp
    "Partial derivative of auxThe wrt. p";

  // Calculation of void fraction and its total derivative used for output
  //
  der(voiFra) = voiFra_der "Integrate derivative of void fraction";

  if modCV==Types.ModeCV.SC then
    /* Supercooled */
    voiFra_der = (0-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Types.ModeCV.SCTP then
    /* Supercooled - Two-phase */
    voiFra_der = (voiFraInt-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Types.ModeCV.TP then
    /* Two-phase */
    voiFra_der = (voiFraInt-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Types.ModeCV.TPSH then
    /* Two-phase - Superheated */
    voiFra_der = (voiFraInt-voiFra)/tauVoiFra "Mean void fraction";
  elseif modCV==Types.ModeCV.SH then
    /* Superheated */
    voiFra_der = (1-voiFra)/tauVoiFra "Mean void fraction";
  else
    /* Supercooled - Two-phase - Superheated*/
    voiFra_der = (voiFraInt-voiFra)/tauVoiFra "Mean void fraction";
  end if;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This model calculates the void fraction of a two-phase regime. The 
calculation approach only depends on the saturation pressure and, thus, 
allows analytical differentiation and integration of the void fraction.
The modelling approach is proposed in the PhD thesis presented by
Gr&auml;ber (2013). Thus, detailed information of the modelling assumptions
as well as the derivation of the equations of the model are given in
Gr&auml;ber&apos;s dissertation.
<h4>References</h4>
<p>
M. Gr&auml;ber (2013): 
<a href=\"https://www.deutsche-digitale-bibliothek.de/item/C6YBIFUYHBKXYQ3WO2VQDZ4XPEQPUYFK\">
Energieoptimale Regelung von Kälteprozessen (in German)</a>.
Dissertation. <i>Technische Universität Braunschweig.</i>
</p>
</html>"));
end Graeber2013;
