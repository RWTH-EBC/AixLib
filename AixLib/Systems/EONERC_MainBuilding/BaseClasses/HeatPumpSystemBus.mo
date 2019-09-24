within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector HeatPumpSystemBus
  "Data bus for ERC Heatpump system"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  AixLib.Controls.Interfaces.HeatPumpControlBus busHP;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleHS;
  HydraulicModules.BaseClasses.HydraulicBus busPumpHot;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleRecool;
  HydraulicModules.BaseClasses.HydraulicBus busPumpCold;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleCS;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleFreecool;
  Boolean AirCoolerOn "Cooler for reccoling or freecooling";

  SI.Temperature TTopHS "Temperature in top layer of heat storage";
  SI.Temperature TBottomHS "Temperature in bottom layer of heat storage";
  SI.Temperature TTopCS "Temperature in top layer of cold storage";
  SI.Temperature TBottomCS "Temperature in bottom layer of cold storage";

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
end HeatPumpSystemBus;
