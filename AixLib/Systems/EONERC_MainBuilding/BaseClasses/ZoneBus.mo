within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector ZoneBus
  "Data bus for a thermal Zone with AHU and CCA"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  TabsBus2 tabsBus "Bus for concrete core activation 1";
  ModularAHU.BaseClasses.GenericAHUBus ahuBus "Bus for AHU";
  SI.Temperature TZoneMea "Temperature in room 1";

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
end ZoneBus;
