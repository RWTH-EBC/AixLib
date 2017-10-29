within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency;
model PowerIsentropicEfficiency
  "Model describing flow isentropic efficiency on power approach"
  extends PartialIsentropicEfficiency;

  // Definition of parameters
  //
  parameter Types.IsentropicPowerModels powMod=Types.IsentropicPowerModels.MendozaMirandaEtAl2016
    "Chose predefined power model for flow coefficient"
    annotation (Dialog(group="Modelling approach"));
  parameter Real a
    "Multiplication factor for generic power approach"
    annotation(Dialog(group="Modelling approach"));
  parameter Real b[:]
    "Exponents for each multiplier"
    annotation(Dialog(group="Modelling approach"));
  parameter Integer nT = size(b,1)
    "Number of terms used for the calculation procedure"
    annotation(Dialog(group="Modelling approach",
                      enable=false));

  // Definition of further parameters required for special approaches
  //
  parameter Modelica.SIunits.MolarMass MRef=0.1
    "Reference molar wheight"
    annotation(Dialog(group="Reference properties"));
  parameter Modelica.SIunits.Frequency rotSpeRef = 9.334
    "Reference rotational speed"
    annotation(Dialog(group="Reference properties"));

  // Definition of coefficients
  //
  Real p[nT]
    "Array that contains all coefficients used for the calculation procedure";
  Real corFac[2]
    "Array of correction factors used if efficiency model proposed in literature
    differs from efficiency model defined in PartialCompressor model";

equation
  // Calculation of coefficients
  //
  if (powMod == Types.IsentropicPowerModels.MendozaMirandaEtAl2016) then
    /*Power approach presented by Mendoza et al. (2005):
      etaIse = piPre^b1 * (rotSpeRef/rotSpe)^b2 * (rotSpe^3*VDis/dhISe^1.5)^b3
               * (1/((TInl+TOutISe)/2-TOut))^b4     
    */
    p[1] = piPre
      "Pressure ratio";
    p[2] = rotSpeRef/rotSpe
      "Rotational Speed";
    p[3] = rotSpe^3*VDis/(Medium.specificEnthalpy(Medium.setState_psX(s=
      Medium.specificEntropy(staInl),p=Medium.pressure(staOut))))^1.5
      "Isentropic specific enthalpy difference";
    p[4] = MRef/Medium.fluidConstants[1].molarMass
      "Molar Mass";

    corFac = {1,1}
      "No correction factors are needed";

  else
    assert(false, "Invalid choice of power approach");
  end if;

  // Calculationg of flow coefficient
  //
  etaIse = min(1, corFac[1] * a *
    product(p[i]^b[i] for i in 1:nT)^corFac[2])
    "Calculation procedure of generic power approach";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end PowerIsentropicEfficiency;
