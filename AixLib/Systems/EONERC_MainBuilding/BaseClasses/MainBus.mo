within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector MainBus
  "Data bus for E.ON ERC main building system"
  extends Modelica.Icons.SignalBus;
  HeatPumpSystemBus hpSystemBus "Heat pump system bus";
  SwitchingUnitBus swuBus  "Switching unit bus";
  HighTempSystemBus htsBus "High temoerature system bus";
  TwoCircuitBus gtfBus "Geothermalfield bus";
  TwoCircuitBus hxBus "Heat exchanger system bus";
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
