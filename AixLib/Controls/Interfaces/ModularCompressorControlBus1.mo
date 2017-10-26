within AixLib.Controls.Interfaces;
expandable connector ModularCompressorControlBus1
  "Connector used for modular expansion valve controller"
  extends Modelica.Icons.SignalBus;

  // Definition of parameters describing modular approach in general
  //
  parameter Integer nComCon = 1
    "Number of expansion valves that shall be controlled"
    annotation(Dialog(tab="Compressors",group="General"));

  // Definition of parameters describing controlling system in general
  //
  parameter Boolean extConCom = false
    "= true, if external signal is used for expansion valves"
    annotation(Dialog(tab="Compressors",group="General"));

  // Definition of variables describing expansion valves
  //
  parameter Choices.ControlVariable controlVariableCom=
    Choices.ControlVariable.THea
    "Choose between different control variables for compressors"
    annotation (Dialog(tab="Compressors", group="Control variable"));
  Real actConVarCom[nComCon]
    "Array of measured values of compressors' controlled variables"
    annotation(Dialog(tab="Compressors",group="Control variable"));

  Real intSetSigCom[nComCon]
    "Array of compressors' set signals given for internal controllers"
    annotation(Dialog(tab="Compressors",group="Set signals"));
  Real extSetSigCom[nComCon]
    "Array of compressors' manipulated signals (rotational speeds) given externally"
    annotation(Dialog(tab="Compressors",group="Manipulated signals"));
  Real actSetSigCom[nComCon]
    "Array of compressors' actual manipulated signals (rotational speeds)"
    annotation(Dialog(tab="Compressors",group="Manipulated signals"));

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
This connector is a base connector used for modular compressors and 
contains typical variables that may be needed in modular compressors.
</p>
</html>"));
end ModularCompressorControlBus1;
