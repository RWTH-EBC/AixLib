within AixLib.DataBase.CHP.ModularCHPEngineMedia;
package CHPFlueGasLambdaOnePlus
  "Simple flue gas for overstoichiometric O2-fuel ratios"
  extends AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
    mediumName="FlueGasLambdaPlus",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.O2,
        Modelica.Media.IdealGases.Common.SingleGasesData.H2O,Modelica.Media.IdealGases.Common.SingleGasesData.CO2},
    fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.O2,
        Modelica.Media.IdealGases.Common.FluidData.H2O,Modelica.Media.IdealGases.Common.FluidData.CO2},
    substanceNames={"Nitrogen","Oxygen","Water","Carbondioxide"},
    reference_X={0.768,0.232,0.0,0.0});

  annotation (Documentation(info="<html>
</html>"));
end CHPFlueGasLambdaOnePlus;
