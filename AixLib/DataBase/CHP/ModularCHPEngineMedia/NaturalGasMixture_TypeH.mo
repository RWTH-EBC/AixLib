within AixLib.DataBase.CHP.ModularCHPEngineMedia;
package NaturalGasMixture_TypeH
  "Simple natural gas mixture (type H) for CHP-engine combustion"

  extends AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
    mediumName="NaturalGasMixtureTypeH",
    data={Modelica.Media.IdealGases.Common.SingleGasesData.N2,Modelica.Media.IdealGases.Common.SingleGasesData.CH4,
        Modelica.Media.IdealGases.Common.SingleGasesData.C2H4,Modelica.Media.IdealGases.Common.SingleGasesData.C2H6,
        Modelica.Media.IdealGases.Common.SingleGasesData.C3H8,Modelica.Media.IdealGases.Common.SingleGasesData.C4H10_n_butane,
        Modelica.Media.IdealGases.Common.SingleGasesData.C5H12_n_pentane,
        Modelica.Media.IdealGases.Common.SingleGasesData.C6H14_n_hexane,
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2},
    fluidConstants={Modelica.Media.IdealGases.Common.FluidData.N2,Modelica.Media.IdealGases.Common.FluidData.CH4,
        Modelica.Media.IdealGases.Common.FluidData.C2H4,Modelica.Media.IdealGases.Common.FluidData.C2H6,
        Modelica.Media.IdealGases.Common.FluidData.C3H8,Modelica.Media.IdealGases.Common.FluidData.C4H10_n_butane,
        Modelica.Media.IdealGases.Common.FluidData.C5H12_n_pentane,Modelica.Media.IdealGases.Common.FluidData.C6H14_n_hexane,
        Modelica.Media.IdealGases.Common.FluidData.CO2},
    substanceNames={"Nitrogen","Methane","Ethene","Ethane","Propane",
        "n-Butane","n-Pentane","n-Hexane","Carbondioxide"});

  constant
    AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord
    Fuel=NaturalGasTypeH() "Needed natural gas data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Natural gas type"));

   import Modelica.Units.SI.*;

  constant Boolean isGas = Fuel.isGasoline "True = Gasoline fuel, False = Liquid fuel";
  constant MoleFraction moleFractions_Gas[:] = Fuel.Xi_mole;
  constant MolarMass MM = sum(Fuel.Xi_mole[i]*Fuel.MMi[i] for i in 1:size(Fuel.MMi, 1)) "Molar mass of natural gas type from its composition";
  constant MassFraction massFractions_Gas[:] = Modelica.Media.Interfaces.PartialMixtureMedium.moleToMassFractions(Fuel.Xi_mole, Fuel.MMi);
  constant SpecificEnergy H_U = sum(massFractions_Gas[i]*Fuel.H_Ui[i] for i in 1:size(Fuel.MMi, 1)) "Calorific Value of the fuel gas";
  constant Real l_min = sum(Fuel.Xi_mole[i]*Fuel.nue_min[i] for i in 1:size(Fuel.MMi, 1))/0.21;
  constant Real L_st = l_min*0.02885/MM "Stoichiometric air consumption";

  record NaturalGasTypeH
    extends AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord(
        fuelType="TypeH",
        isGasoline = true,
        Xi_mole={0.007,0.854,0,0.08,0.029,0.01,0,0,
          0.02});
  end NaturalGasTypeH;
  annotation (Documentation(info="<html><p>
  Gasoline model for natural gas type H.
</p>
</html>"));
end NaturalGasMixture_TypeH;
