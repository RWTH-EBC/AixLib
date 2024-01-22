within AixLib.DataBase.CHP.ModularCHPEngineMedia;
package LiquidFuel_Petrol "Simple petrol fuel for CHP-engine combustion"

  extends AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa(
    mediumName="Just dummy data and no use for calculation",
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
    Fuel=PetrolFuel() "Needed fuel data for combustion calculations"
    annotation (choicesAllMatching=true, Dialog(group="Natural gas type"));

   import Modelica.Units.SI.*;

  constant Boolean isGas = Fuel.isGasoline "True = Gasoline fuel, False = Liquid fuel";
  constant MolarMass MM = Fuel.MM_liq "Molar mass of the fuel";
  constant SpecificEnergy H_U = Fuel.H_U "Calorific Value of the fuel gas";
  constant Real l_min = L_st*MM/0.02885;
  constant Real L_st = 4.31034*(2.664*Fuel.Xi_liq[1]+7.937*Fuel.Xi_liq[2]-Fuel.Xi_liq[3]) "Stoichiometric air consumption";
  //Unused information for simulation stability
  constant MoleFraction moleFractions_Gas[:] = Fuel.Xi_mole;

  record PetrolFuel "Data record for simple petrol fuel"
    extends AixLib.DataBase.CHP.ModularCHPEngineMedia.CombustionEngineFuelDataBaseRecord(
    fuelType = "Simple petrol fuel",
    isGasoline = false,
    H_U = 42000000,
    MM_liq = 0.098,
    Xi_liq = {0.84,0.14,0.02});

  end PetrolFuel;
  annotation (Documentation(info="<html><p>
  Gasoline model for natural gas type H.
</p>
</html>"));
end LiquidFuel_Petrol;
