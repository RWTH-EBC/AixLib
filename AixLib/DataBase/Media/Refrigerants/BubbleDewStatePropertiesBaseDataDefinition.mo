within AixLib.DataBase.Media.Refrigerants;
record BubbleDewStatePropertiesBaseDataDefinition
  "Record definition for thermodynamic state properties at bubble or dew line"
  extends Modelica.Icons.Record;

  parameter String name
  "Short description of the record"
  annotation (Dialog(group="General"));

  parameter Integer saturationPressure_nT
  "Number of terms for saturation pressure"
  annotation (Dialog(group="Saturation pressure"));
  parameter Real saturationPressure_n[:]
  "First coefficient for saturation pressure"
  annotation (Dialog(group="Saturation pressure"));
  parameter Real saturationPressure_e[:]
  "Second coefficient for saturation pressure"
  annotation (Dialog(group="Saturation pressure"));

  parameter Integer saturationTemperature_nT
  "Number of terms for saturation temperature"
  annotation (Dialog(group="Saturation temperature"));
  parameter Real saturationTemperature_n[:]
  "Fitting coefficients for saturation temperature"
  annotation (Dialog(group="Saturation temperature"));
  parameter Real saturationTemperature_iO[:]
  "Mean input | Std input | Mean output | Std output"
  annotation (Dialog(group="Saturation temperature"));

  parameter Integer bubbleDensity_nT
  "Number of terms for bubble density"
  annotation (Dialog(group="Bubble density"));
  parameter Real bubbleDensity_n[:]
  "Fitting coefficients for bubble density"
  annotation (Dialog(group="Bubble density"));
  parameter Real bubbleDensity_iO[:]
  "Mean input | Std input | Mean output | Std output"
  annotation (Dialog(group="Bubble density"));

  parameter Integer dewDensity_nT
  "Number of terms for dew density"
  annotation (Dialog(group="Dew density"));
  parameter Real dewDensity_n[:]
  "Fitting coefficients for dew density"
  annotation (Dialog(group="Dew density"));
  parameter Real dewDensity_iO[:]
  "Mean input | Std input | Mean output | Std output"
  annotation (Dialog(group="Dew density"));

  parameter Integer bubbleEnthalpy_nT
  "Number of terms for bubble enthalpy"
  annotation (Dialog(group="Bubble Enthalpy"));
  parameter Real bubbleEnthalpy_n[:]
  "Fitting coefficients for bubble enthalpy"
  annotation (Dialog(group="Bubble Enthalpy"));
  parameter Real bubbleEnthalpy_iO[:]
  "Mean input | Std input | Mean output | Std output"
  annotation (Dialog(group="Bubble Enthalpy"));

  parameter Integer dewEnthalpy_nT
  "Number of terms for dew enthalpy"
  annotation (Dialog(group="Dew Enthalpy"));
  parameter Real dewEnthalpy_n[:]
  "Fitting coefficients for dew enthalpy"
  annotation (Dialog(group="Dew Enthalpy"));
  parameter Real dewEnthalpy_iO[:]
  "Mean input | Std input | Mean output | Std output"
  annotation (Dialog(group="Dew Enthalpy"));

  parameter Integer bubbleEntropy_nT
  "Number of terms for bubble entropy"
  annotation (Dialog(group="Bubble Entropy"));
  parameter Real bubbleEntropy_n[:]
  "Fitting coefficients for bubble entropy"
  annotation (Dialog(group="Bubble Entropy"));
  parameter Real bubbleEntropy_iO[:]
  "Mean input | Std input | Mean output | Std output"
  annotation (Dialog(group="Bubble Entropy"));

  parameter Integer dewEntropy_nT
  "Number of terms for dew entropy"
  annotation (Dialog(group="Dew Entropy"));
  parameter Real dewEntropy_n[:]
  "Fitting coefficients for dew entropy"
  annotation (Dialog(group="Dew Entropy"));
  parameter Real dewEntropy_iO[:]
  "Mean input | Std input | Mean output | Std output"
  annotation (Dialog(group="Dew Entropy"));
end BubbleDewStatePropertiesBaseDataDefinition;
