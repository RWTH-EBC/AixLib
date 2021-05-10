within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector TabsBus2 "Data bus for concrete cora activation"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  HydraulicModules.BaseClasses.HydraulicBus pumpBus  "Hydraulic circuit of concrete core activation";
  HydraulicModules.BaseClasses.HydraulicBus hotThrottleBus  "Hydraulic circuit of hot supply";
  HydraulicModules.BaseClasses.HydraulicBus coldThrottleBus "Hydraulic circuit of cold supply";
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
end TabsBus2;
