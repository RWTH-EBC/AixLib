within AixLib.Fluid.BoilerCHP.ModularCHP.MediaModelsAndEngineRecords.CHPCombustionMixtureGasNasa;
function MixEntropy "Return mixing entropy of ideal gases / R"
  extends Modelica.Icons.Function;
  input Modelica.SIunits.MoleFraction x[:] "Mole fraction of mixture";
  output Real smix "Mixing entropy contribution, divided by gas constant";
algorithm
  smix := sum(if x[i] > Modelica.Constants.eps then -x[i]*Modelica.Math.log(x[i]) else
                   x[i] for i in 1:size(x,1));
  annotation(Inline=true,smoothOrder=2);
end MixEntropy;
