within AixLib.DataBase.CHP.ModularCHPEngineMedia;
record CombustionEngineFuelDataBaseRecord

    extends Modelica.Icons.Record;

    //Base-Record for physical combustion calculations of natural gas out of (Nitrogen,Methane,Ethene,Ethane,Propane,n-Butane,n-Pentane,n-Hexane,Carbondioxide)
    parameter String naturalGasType "Name of the natural gas composition";
    parameter String substanceNames[:] = {"Nitrogen","Methane","Ethene","Ethane","Propane","n-Butane","n-Pentane","n-Hexane","Carbondioxide"};
    parameter Modelica.SIunits.MoleFraction Xi_mole[:] "Volumetric proportion of each fuel component";
    parameter Modelica.SIunits.MolarMass MMi[:] = {0.02802,0.01604,0.02805,0.03007,0.0441,0.05815,0.07215,0.08618,0.04401} "Molar mass of natural gas components";
    parameter Modelica.SIunits.SpecificEnergy H_Ui[:] = {0,50000000,50900000,47160000,46440000,45720000,45000000,44640000,0};
    //constant Modelica.SIunits.MolarMass MM = sum(Xi_mole[i]/MMi[i] for i in 1:size(MMi, 1));
    parameter Real nue_C[size(MMi, 1)] = {0, 1, 2, 2, 3, 4, 5, 6, 1} "Number of carbon atoms for each gas component (for composition calculation)";
    parameter Real nue_H[size(MMi, 1)] = {0, 4, 4, 6, 8, 10, 12, 14, 0} "Number of hydrogen atoms for each gas component (for composition calculation)";
    parameter Real nue_O[size(MMi, 1)] = {0, 0, 0, 0, 0, 0, 0, 0, 2} "Number of oxygen atoms for each gas component (for composition calculation)";
    parameter Real nue_N[size(MMi, 1)] = {2, 0, 0, 0, 0, 0, 0, 0, 0} "Number of nitrogen atoms for each gas component (for composition calculation)";
    parameter Real nue_min[:] = {0, 2, 3, 3.5, 5, 6.5, 8, 9.5, 0} "Number of O2 molecules needed for combustion";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CombustionEngineFuelDataBaseRecord;
