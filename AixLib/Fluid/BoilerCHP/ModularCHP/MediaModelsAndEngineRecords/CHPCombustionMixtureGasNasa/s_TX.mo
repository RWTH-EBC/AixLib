within AixLib.Fluid.BoilerCHP.ModularCHP.MediaModelsAndEngineRecords.CHPCombustionMixtureGasNasa;
function s_TX
  "Return temperature dependent part of the entropy, expects full entropy vector"
  extends Modelica.Icons.Function;
  input Temperature T "Temperature";
  input MassFraction[nX] X "Mass fraction";
  output SpecificEntropy s "Specific entropy";
algorithm
  s := sum(Modelica.Media.IdealGases.Common.Functions.s0_T(
                              data[i], T)*X[i] for i in 1:size(X,1));
  annotation(Inline=true,smoothOrder=2);
end s_TX;
