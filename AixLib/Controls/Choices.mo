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
  type ControlVariable = enumeration(
      pEva
      "Pressure of evaporation",
      pCon
      "Pressure of condensation",
      TEva
      "Temperature of evaporation",
      TCon
      "Temperature of condensation",
      TSupHea
      "Degree of superheating at evaporator's outlet",
      TSupCol
      "Degree of supercooling at condenser's outlet",
      TCol
      "Temperature at source-sided evaporator's outlet (Cooling temperature)",
      THea
      "Temperature at sink-sided condenser's outlet (Heating temperature)",
      QFloCol
      "Cooling capacity if system works as chiller",
      QFloHea
      "Heating capacity if system works as heat pump")
    "Enumeration to control variables of expansion valves"
    annotation (Evaluate=true);
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 25, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package contains types and constants to define menue choices.
</p>
</html>"));
end Choices;
