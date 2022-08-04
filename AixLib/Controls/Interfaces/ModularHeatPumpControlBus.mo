within AixLib.Controls.Interfaces;
expandable connector ModularHeatPumpControlBus
  "Connector used for modular heat pump controller"
  extends Modelica.Icons.SignalBus;

  // Definition of parameters describing the modular approach in general
  //
  parameter Integer nVal = 1
    "Number of expansion valves"
    annotation(Dialog(tab="General",group="Modular approach"));
  parameter Integer nEva = nVal
    "Number of evaporators"
    annotation(Dialog(tab="General",group="Modular approach",
               enable=false));
  parameter Integer nCom = 1
    "Number of compressors"
    annotation(Dialog(tab="General",group="Modular approach"));
  parameter Integer nCon = 1
    "Number of condensers"
    annotation(Dialog(tab="General",group="Modular approach"));

  // Definition of parameters describing controlling system in general
  //
  parameter Types.heatPumpMode mode=
    Types.heatPumpMode.heatPump
    "Choose between heat pump or chiller"
    annotation (Dialog(tab="General", group="Controller"));

  // Extensions and propagation of parameters
  //
  ModularExpansionValveControlBus expValBus(final
      nValCon=nVal)
    "Bus that contains all relevant connections for modular expansion valves";
  ModularCompressorControlBus comBus(final
      nComCon=nCom)
    "Bus that contains all relevant connections for modular compressors";
  ModularSensorControlBus senBus(
    final nValSen=nVal,
    final nEvaSen=nEva,
    final nComSen=nCom,
    final nConSen=nCon)
    "Bus that contains all relevant connections for modular sensors";

  annotation (Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/479\">issue 479</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This connector is a base connector used for modular heat pumps and
  contains typical variables that may be measured in the modular heat
  pump models. Therefore, this connector contains three further
  connectors that are presented below:
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Controls.Interfaces.ModularExpansionValveControlBus\">
    Modular expansion valves bus</a>: This connector contains variables
    that may be needed for modular expansion valves.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Controls.Interfaces.ModularCompressorControlBus\">
    Modular compressors bus</a>: This connector contains variables that
    may be needed for modular compressors.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Controls.Interfaces.ModularSensorControlBus\">Modular
    sensors bus</a>: This connector contains variables that may be
    needed for modular sensors.
  </li>
</ol>
<p>
  Additionally, the heat pump mode as well as the number of components
  (e.g. expansion valves or compressors) can be selected.
</p>
</html>"));
end ModularHeatPumpControlBus;
