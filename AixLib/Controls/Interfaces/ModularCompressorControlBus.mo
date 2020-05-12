within AixLib.Controls.Interfaces;
expandable connector ModularCompressorControlBus
  "Connector used for modular compressor controller"
  extends Modelica.Icons.SignalBus;

  // Definition of parameters describing modular approach in general
  //
  parameter Integer nComCon = 1
    "Number of compressors valves that shall be controlled"
    annotation(Dialog(tab="Compressors",group="General"));

  // Definition of parameters describing controlling system in general
  //
  parameter Boolean extConCom = false
    "= true, if external signal is used for compressors"
    annotation(Dialog(tab="Compressors",group="General"));

  // Definition of variables describing compressors
  //
  parameter Types.ControlVariable conVarCom=
      Types.ControlVariable.THea
    "Choose between different control variables for compressors"
    annotation (Dialog(tab="Compressors", group="Control variable"));
  Real meaConVarCom[nComCon]
    "Array of measured values of compressors' controlled variables"
    annotation(Dialog(tab="Compressors",group="Control variable"));

  Real intSetPoiCom[nComCon]
    "Array of compressors' set points given for internal controllers"
    annotation(Dialog(tab="Compressors",group="Set signals"));
  Real extManVarCom[nComCon]
    "Array of compressors' manipulated variables (rotational speeds) given externally"
    annotation(Dialog(tab="Compressors",group="Manipulated signals"));
  Real curManVarCom[nComCon]
    "Array of compressors' current manipulated variables (rotational speeds)"
    annotation(Dialog(tab="Compressors",group="Manipulated signals"));

  annotation (Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/479\">issue 479</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This connector is a base connector used for modular compressors and
  contains typical variables that may be needed in the modular
  compressor models.
</p>
</html>"));
end ModularCompressorControlBus;
