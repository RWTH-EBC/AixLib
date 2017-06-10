within AixLib.DataBase.Media.Refrigerants;
record ThermodynamicStatePropertiesBaseDataDefinition
  "Record definition for fitting coefficients for the thermodynamic state properties"
  extends Modelica.Icons.Record;

  parameter String name
  "Short description of the record"
  annotation (Dialog(group="General"));

  parameter Integer temperature_ph_nT[:]
  "Polynomial order for p (SC) | Polynomial order for h (SC) | Total number of terms (SC) |
   Polynomial order for p (SH) | Polynomial order for h (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real temperature_ph_sc[:]
  "Coefficients for supercooled regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real temperature_ph_sh[:]
  "Coefficients for superheated regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real temperature_ph_iO[:]
  "Mean SC p | Mean SC h | Std SC p | Std SC h | 
   Mean SH p | Mean SH h | Std SH p | Std SH h"
  annotation (Dialog(group="Temperature_ph"));

  parameter Integer temperature_ps_nT[:]
  "Polynomial order for p (SC) | Polynomial order for s (SC) | Total number of terms (SC) |
   Polynomial order for p (SH) | Polynomial order for s (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real temperature_ps_sc[:]
  "Coefficients for supercooled regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real temperature_ps_sh[:]
  "Coefficients for superheated regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real temperature_ps_iO[:]
  "Mean SC p | Mean SC s | Std SC p | Std SC s | 
   Mean SH p | Mean SH s | Std SH p | Std SH s"
  annotation (Dialog(group="Temperature_ps"));

  parameter Integer density_pT_nT[:]
  "Polynomial order for p (SC) | Polynomial order for T (SC) | Total number of terms (SC) |
   Polynomial order for p (SH) | Polynomial order for T (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Density_pT"));
  parameter Real density_pT_sc[:]
  "Coefficients for supercooled regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real density_pT_sh[:]
  "Coefficients for superheated regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real density_pT_iO[:]
  "Mean SC p | Mean SC T | Std SC p | Std SC T | 
   Mean SH p | Mean SH T | Std SH p | Std SH T"
  annotation (Dialog(group="Density_pT"));
end ThermodynamicStatePropertiesBaseDataDefinition;
