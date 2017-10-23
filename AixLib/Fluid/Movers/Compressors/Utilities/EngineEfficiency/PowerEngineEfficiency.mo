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
    "Reference molar wheight";
  parameter Modelica.SIunits.Frequency rotSpeRef = 9.334
    "Reference rotational speed";

  // Definition of coefficients
  //
  Real P[nT]
    "Array that contains all coefficients used for the calculation procedure";


equation

  // Calculation of coefficients
  //
  if (powMod == Choices.EnginePowerModels.MendozaMirandaEtAl2016) then
    /*Power approach presented by Mendoza et al. (2005):
      etaEng = piPre^b1 * (rotSpeRef/rotSpe)^b2 * (1/((TInl+TOutISe)/2-TOut))^b3
               * (MRef/M)^b4

      Caution with parameters - Uses isentropic specific enthalpy difference      
    */
    P[1] = piPre
      "Pressure ratio";
    P[2] = rotSpeRef/rotSpe
      "Rotational Speed";
    P[3] = 1/abs((Medium.temperature(staInl)+Medium.temperature(
      Medium.setState_psX(p=Medium.pressure(staOut),
      s=Medium.specificEntropy(staInl))))/2-TOut)
      "Temperature difference isentropic compression and ambient";
    P[4] = MRef/Medium.fluidConstants[1].molarMass
      "Molar Mass";

  else
    assert(false, "Invalid choice of power approach");
  end if;

  // Calculationg of flow coefficient
  //
  etaEng = a * product(P[i]^b[i] for i in 1:nT)
    "Calculation procedure of generic power approach";

end PowerEngineEfficiency;
