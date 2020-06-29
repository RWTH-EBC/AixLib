within AixLib.Systems.EONERC_MainBuilding_old.BaseClasses;
expandable connector TwoCircuitBus
  "Data bus for systems with primary and secondary cicruit"
  extends Modelica.Icons.SignalBus;
  HydraulicModules_old.BaseClasses.HydraulicBus primBus
    "Primary hydraulic circuit";
  HydraulicModules_old.BaseClasses.HydraulicBus secBus
    "Secondary hydraulic circuit";

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
end TwoCircuitBus;
