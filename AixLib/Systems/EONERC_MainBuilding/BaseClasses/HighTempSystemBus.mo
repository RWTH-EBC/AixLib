within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector HighTempSystemBus
  "Data bus for ERC high temperature circuit"
  extends Modelica.Icons.SignalBus;
  import      Modelica.Units.SI;
  HydraulicModules.BaseClasses.HydraulicBus admixBus1 "Hydraulic circuit of boiler 1";
  HydraulicModules.BaseClasses.HydraulicBus admixBus2 "Hydraulic circuit of boiler 2";
  HydraulicModules.BaseClasses.HydraulicBus throttlePumpBus "Hydraulic circuit of chp";
  Real uRelBoiler1Set "Set value for relative power of boiler 1 [0..1]";
  Real uRelBoiler2Set "Set value for relative power of boiler 2 [0..1]";
  Real uRelChpSet "Set value for relative power of chp [0..1]";
  Real fuelPowerBoiler1Mea "Fuel consumption of boiler 1 [0..1]";
  Real fuelPowerBoiler2Mea "Fuel consumption of boiler 2 [0..1]";
  Real TChpSet "Set temperature for chp";
  Boolean onOffChpSet "On off set point for chp";
  Real fuelPowerChpMea "Fuel consumption of chp [0..1]";
  Real thermalPowerChpMea "Thermal power of chp [0..1]";
  Real electricalPowerChpMea "Electrical power consumption of chp [0..1]";
  SI.Temperature T_in "Inflow temperature";
  SI.Temperature T_out "Inflow temperature";
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
end HighTempSystemBus;
