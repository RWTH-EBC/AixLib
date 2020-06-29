within AixLib.Systems.EONERC_MainBuilding_old.BaseClasses;
expandable connector MainBus
  "Data bus for E.ON ERC main building system"
  extends Modelica.Icons.SignalBus;
  HeatPumpSystemBus hpSystemBus "Heat pump system bus";
  SwitchingUnitBus swuBus  "Switching unit bus";
  HighTempSystemBus htsBus "High temoerature system bus";
  TwoCircuitBus gtfBus "Geothermalfield bus";
  TwoCircuitBus hxBus "Heat exchanger system bus";
  HydraulicModules_old.BaseClasses.HydraulicBus consHtcBus
    "Consumer bus high temperature cycle";
  HydraulicModules_old.BaseClasses.HydraulicBus consLtcBus
    "Consumer bus low temperature heating cycle";
  HydraulicModules_old.BaseClasses.HydraulicBus consCold1Bus
    "Consumer bus cold temperature cycle 1";
  HydraulicModules_old.BaseClasses.HydraulicBus consCold2Bus
    "Consumer bus cold temperature cycle 2";
  EvaluationBus evaBus "Bus for energy consumption measurement";
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
