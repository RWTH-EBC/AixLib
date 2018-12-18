within AixLib.Fluid.BoilerCHP.ModularCHP.MediaModelsAndEngineRecords.CHPCombustionMixtureGasNasa;
function h_TX "Return specific enthalpy"
  import Modelica.Media.Interfaces.Choices;
   extends Modelica.Icons.Function;
   input Modelica.SIunits.Temperature T "Temperature";
   input MassFraction X[nX]=reference_X
    "Independent Mass fractions of gas mixture";
   input Boolean exclEnthForm=excludeEnthalpyOfFormation
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";
   input Modelica.Media.Interfaces.Choices.ReferenceEnthalpy
                                   refChoice=referenceChoice
    "Choice of reference enthalpy";
   input Modelica.SIunits.SpecificEnthalpy h_off=h_offset
      "User defined offset for reference enthalpy, if referenceChoice = UserDefined";
   output Modelica.SIunits.SpecificEnthalpy h
      "Specific enthalpy at temperature T";
algorithm
  h :=(if fixedX then reference_X else X)*
       {Modelica.Media.IdealGases.Common.Functions.h_T(
                          data[i], T, exclEnthForm, refChoice, h_off) for i in 1:nX};
  annotation(Inline=false,smoothOrder=2);
end h_TX;
