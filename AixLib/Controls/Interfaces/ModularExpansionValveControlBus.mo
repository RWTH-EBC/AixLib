within AixLib.Controls.Interfaces;
expandable connector ModularExpansionValveControlBus
  "Connector used for modular expansion valve controller"
  extends Modelica.Icons.SignalBus;

  // Definition of parameters describing modular approach in general
  //
  parameter Integer nValCon = 1
    "Number of expansion valves that shall be controlled"
    annotation(Dialog(tab="Expansion Valves",group="General"));

  // Definition of parameters describing controlling system in general
  //
  parameter Boolean extConVal = false
    "= true, if external signal is used for expansion valves"
    annotation(Dialog(tab="Expansion Valves",group="General"));

  // Definition of variables describing expansion valves
  //
  parameter Types.ControlVariable conVarVal=
      Types.ControlVariable.TSupHea
    "Choose between different control variables for expansion valves"
    annotation (Dialog(tab="Expansion Valves", group="Control variable"));
  Real meaConVarVal[nValCon]
    "Array of measured values of expansion valves' controlled variables"
    annotation(Dialog(tab="Expansion Valves",group="Control variable"));

  Real intSetPoiVal[nValCon]
    "Array of expansion valves' set points given for internal controllers"
    annotation(Dialog(tab="Expansion Valves",group="Set signals"));
  Real extManVarVal[nValCon]
    "Array of expansion valves' manipulated variables (openings) given externally"
    annotation(Dialog(tab="Expansion Valves",group="Manipulated signals"));
  Real curManVarVal[nValCon]
    "Array of expansion valves' current manipulated variables (openings)"
    annotation(Dialog(tab="Expansion Valves",group="Manipulated signals"));

  annotation (Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/479\">issue 479</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This connector is a base connector used for modular expansion valves
  and contains typical variables that may be needed in the modular
  expansion valve models.
</p>
</html>"));
end ModularExpansionValveControlBus;
