within AixLib.DataBase.Materials;
record MaterialBaseDataDefinition "Template record for material"
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Density rho "Density of material";
  parameter Modelica.SIunits.ThermalConductivity lambda
    "Thermal conductivity of material";
  parameter Modelica.SIunits.SpecificHeatCapacity c[n]
    "Specific heat capacity of material";
  parameter Modelica.SIunits.Emissivity epsLw = 0.85 "Longwave emisivity";
  parameter Modelica.SIunits.Emissivity epsSw = 0.85 "Shortwave emissivity";
end MaterialBaseDataDefinition;
