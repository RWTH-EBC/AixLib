within AixLib.Systems.Benchmark.BaseClasses;
expandable connector MainBus
  "Data bus for E.ON ERC main building system"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus hpSystemBus
    "Heat pump system bus";
  EONERC_MainBuilding.BaseClasses.SwitchingUnitBus swuBus "Switching unit bus";
  HighTempSystemBus htsBus
    "High temoerature system bus";
  EONERC_MainBuilding.BaseClasses.TwoCircuitBus gtfBus "Geothermalfield bus";
  EONERC_MainBuilding.BaseClasses.TwoCircuitBus hxBus
    "Heat exchanger system bus";
  EONERC_MainBuilding.BaseClasses.TabsBus2 tabs1Bus
    "Bus for concrete core activation 1";
  EONERC_MainBuilding.BaseClasses.TabsBus2 tabs2Bus
    "Bus for concrete core activation 2";
  EONERC_MainBuilding.BaseClasses.TabsBus2 tabs3Bus
    "Bus for concrete core activation 3";
  EONERC_MainBuilding.BaseClasses.TabsBus2 tabs4Bus
    "Bus for concrete core activation 4";
  EONERC_MainBuilding.BaseClasses.TabsBus2 tabs5Bus
    "Bus for concrete core activation 5";
  ModularAHU.BaseClasses.GenericAHUBus ahuBus "Bus for AHU";
  ModularAHU.BaseClasses.GenericAHUBus vu1Bus "Ventilation unit 1";
  ModularAHU.BaseClasses.GenericAHUBus vu2Bus "Ventilation unit 2";
  ModularAHU.BaseClasses.GenericAHUBus vu3Bus "Ventilation unit 3";
  ModularAHU.BaseClasses.GenericAHUBus vu4Bus "Ventilation unit 4";
  ModularAHU.BaseClasses.GenericAHUBus vu5Bus "Ventilation unit 5";
  SI.Temperature TRoom1Mea "Temperature in room 1";
  SI.Temperature TRoom2Mea "Temperature in room 2";
  SI.Temperature TRoom3Mea "Temperature in room 3";
  SI.Temperature TRoom4Mea "Temperature in room 4";
  SI.Temperature TRoom5Mea "Temperature in room 5";
  EvaluationBus evaBus
    "Bus for energy consumption measurement";
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
end MainBus;
