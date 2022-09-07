within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector HeatPumpSystemBus
  "Data bus for ERC Heatpump system"
  extends Modelica.Icons.SignalBus;
  import      Modelica.Units.SI;
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus busHP;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleHS;
  HydraulicModules.BaseClasses.HydraulicBus busPumpHot;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleRecool;
  HydraulicModules.BaseClasses.HydraulicBus busPumpCold;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleCS;
  HydraulicModules.BaseClasses.HydraulicBus busThrottleFreecool;
  Boolean AirCoolerOnSet "Cooler for reccoling or freecooling";

  SI.Power PelAirCoolerMea "Electrica Power consumption of air cool";
  SI.Temperature TTopHSMea "Temperature in top layer of heat storage";
  SI.Temperature TBottomHSMea "Temperature in bottom layer of heat storage";
  SI.Temperature TTopCSMea "Temperature in top layer of cold storage";
  SI.Temperature TBottomCSMea "Temperature in bottom layer of cold storage";
  SI.Temperature THotInMea "Inflow temperature hot side";
  SI.Temperature THotOutMea "Outflow temperature hot side";
  SI.Temperature TColdInMea "Inflow temperature hot side";
  SI.Temperature TColdOutMea "Outflow temperature cold side";
  SI.VolumeFlowRate  VFlowHotMea  "Volume flow hot side of heatpump system";
  SI.VolumeFlowRate  VFlowColdMea "Volume flow cold side of heatpump system";
  SI.Temperature TOutsideMea "Outside air temperature";
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
