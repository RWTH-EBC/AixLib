within AixLib.DataBase.CHP.ModularCHPEngineMedia;
record CombustionEngineFuelDataBaseRecord

    extends Modelica.Icons.Record;

    parameter Boolean isGasoline "True = Gasoline fuel, False = Liquid fuel";
    parameter String fuelType "Name of the fuel";

    //Base-Records for physical combustion calculations of natural gas out of (Nitrogen,Methane,Ethene,Ethane,Propane,n-Butane,n-Pentane,n-Hexane,Carbondioxide)

    parameter String substanceNames[:] = {"Nitrogen","Methane","Ethene","Ethane","Propane","n-Butane","n-Pentane","n-Hexane","Carbondioxide"};
  parameter Modelica.Units.SI.MoleFraction Xi_mole[:]={0,0,0,0,0,0,0,0,0}
    "Volumetric proportion of each fuel component";
  parameter Modelica.Units.SI.MolarMass MMi[:]={0.02802,0.01604,0.02805,0.03007,
      0.0441,0.05815,0.07215,0.08618,0.04401}
    "Molar mass of natural gas components";
  parameter Modelica.Units.SI.SpecificEnergy H_Ui[:]={0,50000000,50900000,
      47160000,46440000,45720000,45000000,44640000,0};
    parameter Real nue_C[size(MMi, 1)] = {0, 1, 2, 2, 3, 4, 5, 6, 1} "Number of carbon atoms for each gas component (for composition calculation)";
    parameter Real nue_H[size(MMi, 1)] = {0, 4, 4, 6, 8, 10, 12, 14, 0} "Number of hydrogen atoms for each gas component (for composition calculation)";
    parameter Real nue_O[size(MMi, 1)] = {0, 0, 0, 0, 0, 0, 0, 0, 2} "Number of oxygen atoms for each gas component (for composition calculation)";
    parameter Real nue_N[size(MMi, 1)] = {2, 0, 0, 0, 0, 0, 0, 0, 0} "Number of nitrogen atoms for each gas component (for composition calculation)";
    parameter Real nue_min[:] = {0, 2, 3, 3.5, 5, 6.5, 8, 9.5, 0} "Number of O2 molecules needed for combustion";

    //Base-Data for combustion calculations with liquid fuels (sulfur is not considered)

  parameter Modelica.Units.SI.SpecificEnergy H_U=0
    "Calorific value of the liquid fuel based on VK1 by S.Pischinger";
  parameter Modelica.Units.SI.MassFraction Xi_liq[:]={0,0,0}
    "Elements mass fractions of carbon, hydrogen and oxygen";
  parameter Modelica.Units.SI.MolarMass MMi_liq[:]={0.012,0.001,0.016}
    "Molar mass of the main liquid fuel elements (C,H,O)";
  parameter Modelica.Units.SI.MolarMass MM_liq=0
    "Total molar mass of the liquid fuel based on VK1 by S.Pischinger";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CombustionEngineFuelDataBaseRecord;
