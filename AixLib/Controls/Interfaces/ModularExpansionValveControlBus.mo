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
  parameter Choices.ControlVariable controlVariableVal=
    Choices.ControlVariable.TSupHea
    "Choose between different control variables for expansion valves"
    annotation (Dialog(tab="Expansion Valves", group="Control variable"));
  Real actConVarVal[nValCon]
    "Array of measured values of expansion valves' controlled variables"
    annotation(Dialog(tab="Expansion Valves",group="Control variable"));

  Real intSetSigVal[nValCon]
    "Array of expansion valves' set signals given for internal controllers"
    annotation(Dialog(tab="Expansion Valves",group="Set signals"));
  Real extManSigVal[nValCon]
    "Array of expansion valves' manipulated signals (openings) given externally"
    annotation(Dialog(tab="Expansion Valves",group="Manipulated signals"));
  Real actManSigVal[nValCon]
    "Array of expansion valves' actual manipulated signals (openings)"
    annotation(Dialog(tab="Expansion Valves",group="Manipulated signals"));

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
This connector is a base connector used for modular expansion valves and 
contains typical variables that may be needed in modular expansion valves.
</p>
</html>"));
end ModularExpansionValveControlBus;
