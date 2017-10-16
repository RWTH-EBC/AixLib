within AixLib.Controls;
package Choices "Types, constants to define menu choices"
  extends Modelica.Icons.Package;

  // Types describing the mode of a heat pump
  //
  type heatPumpMode = enumeration(
      heatPump
      "Heat pump is used as heat pump",
      chiller
      "Heat pump is used as chiller")
    "Enumeration to define mode of heat pump"
    annotation (Evaluate=true);

  // Types describing control variables
  //
  type ControlVariableValve = enumeration(
      pEva
      "Pressure of evaporation",
      TEva
      "Temperature of evaporation",
      TSupHea
      "Degree of superheating at evaporator's outlet")
    "Enumeration to control variables of expansion valves"
    annotation (Evaluate=true);

end Choices;
