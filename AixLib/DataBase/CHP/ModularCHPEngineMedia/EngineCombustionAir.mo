within AixLib.DataBase.CHP.ModularCHPEngineMedia;
package EngineCombustionAir "Air as mixture of N2 and O2"
  extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
    mediumName="CombustionAirN2O2",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.O2},
    fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.O2},
    substanceNames={"Nitrogen","Oxygen"}, reference_X = {0.768, 0.232});

  //!!For the script calculating the combustion: Nitrogen has to be at first place for the composition of the fuel!!"
    constant ThermodynamicState stateAir = setState_pTX(reference_p, reference_T, reference_X);
    constant MolarMass MM = 1/sum(stateAir.X[j]/data[j].MM for j in 1:size(stateAir.X, 1));
    constant MolarMass MMX[:] = data[:].MM;
    constant Real X[:] = stateAir.X;
    constant MoleFraction moleFractions_Air[:] = massToMoleFractions(X, MMX);
  annotation (Documentation(info="<html>
</html>"));
end EngineCombustionAir;
