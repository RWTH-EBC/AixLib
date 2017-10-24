within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency;
model PowerEngineEfficiency
  "Model describing flow engine efficiency on power approach"
  extends PartialEngineEfficiency;

  // Definition of parameters
  //
  parameter Choices.EnginePowerModels
    powMod=Choices.EnginePowerModels.MendozaMirandaEtAl2016
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
  if (powMod == Choices.EnginePowerModels.MendozaMirandaEtAl2016) then
    /*Power approach presented by Mendoza et al. (2005):
      etaEng = piPre^b1 * (rotSpeRef/rotSpe)^b2 * (1/((TInl+TOutISe)/2-TOut))^b3
               * (MRef/M)^b4

      Caution with parameters - Uses isentropic specific enthalpy difference      
    */
    p[1] = piPre
      "Pressure ratio";
    p[2] = rotSpeRef/rotSpe
      "Rotational Speed";
    p[3] = 1/((Medium.temperature(staInl)+Medium.temperature(staOutIse))/2-TOut)
      "Temperature difference isentropic compression and ambient";
    p[4] = MRef/Medium.fluidConstants[1].molarMass
      "Molar Mass";

    corFac = {1,1}
      "No correction factors are needed";

  else
    assert(false, "Invalid choice of power approach");
  end if;

  // Calculationg of flow coefficient
  //
  etaEng = corFac[1] * a * product(p[i]^b[i] for i in 1:nT)^corFac[2]
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
end PowerEngineEfficiency;
