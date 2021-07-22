within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector MainBus2Zones
  "Data bus for E.ON ERC main building system with two zones"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus hpSystemBus
    "Heat pump system bus";
  EONERC_MainBuilding.BaseClasses.SwitchingUnitBus swuBus "Switching unit bus";
  EONERC_MainBuilding.BaseClasses.HighTempSystemBus htsBus "High temoerature system bus";
  EONERC_MainBuilding.BaseClasses.TwoCircuitBus gtfBus "Geothermalfield bus";
  EONERC_MainBuilding.BaseClasses.TwoCircuitBus hxBus
    "Heat exchanger system bus";
  TabsBus2 tabs1Bus "Bus for concrete core activation 1";
  TabsBus2 tabs2Bus "Bus for concrete core activation 2";
  ModularAHU.BaseClasses.GenericAHUBus ahu1Bus "Bus for AHU";
  ModularAHU.BaseClasses.GenericAHUBus ahu2Bus "Bus for AHU";
  SI.Temperature TZone1Mea "Temperature in room 1";
  SI.Temperature TZone2Mea "Temperature in room 2";
  Systems.HydraulicModules.BaseClasses.HydraulicBus consHtcBus "Consumer bus high temperature cycle";
  Systems.HydraulicModules.BaseClasses.HydraulicBus consCold1Bus "Consumer bus cold temperature cycle 1";
  EONERC_MainBuilding.BaseClasses.EvaluationBus2Zones evaBus
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
end MainBus2Zones;
