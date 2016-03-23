within AixLib.DataBase.Buildings;
record BuildingBaseRecord "Base record definition for building records"
  extends Modelica.Icons.Record;
  // General
  parameter String buildingID="M4120" "unique identifier of the building";
  parameter String usage="Office Building" "typical usage of the building";
  parameter Integer numZones=1 "Number of Zones in the building";
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneSetup[:]={AixLib.DataBase.Buildings.ZoneBaseRecord()}
    "Provide zone setup as vector entries to zone parameter definitions";
  parameter Modelica.SIunits.Volume Vair=4850.5 "Volume of building";
  parameter Modelica.SIunits.Area BuildingArea=2000 "Area of building";

  ///************ Air Handling Unit ************///
  // AHU Modes
  parameter Boolean heatingAHU=true "Heating Function of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean coolingAHU=true "Cooling Function of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean dehumidificationAHU=if heatingAHU and coolingAHU then true
       else false
    "Dehumidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"), enable=(heating and cooling));
  parameter Boolean humidificationAHU=if heatingAHU and coolingAHU then true
       else false
    "Humidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"), enable=(heating and cooling));
  // AHU Values
  parameter Real BPF_DeHu(
    min=0,
    max=1) = 0.2
    "By-pass factor of cooling coil during dehumidification. Necessary to calculate the real outgoing enthalpy flow of heat exchanger in dehumidification mode taking the surface enthalpy of the cooling coil into account"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value"));
  parameter Boolean HRS=true
    "Is a HeatRecoverySystem physically integrated in the AHU?" annotation (
      Dialog(tab="AirHandlingUnit", group="AHU Modes"), choices(checkBox=true));
  // Efficiency of HRS (both parameters = 0, if HRS is not physically integrated in the AHU at all)
  parameter Real efficiencyHRS_enabled(
    min=0,
    max=1) = 0.8 "efficiency of HRS in the AHU modes when HRS is enabled"
    annotation (Dialog(
      tab="AirHandlingUnit",
      group="Settings AHU Value",
      enable=HRS));
  parameter Real efficiencyHRS_disabled(
    min=0,
    max=1) = 0.2
    "taking a little heat transfer into account although HRS is disabled (in the case that a HRS is physically installed in the AHU)"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value"));
  parameter Real sampleRateAHU(min=0) = 1800
    "time period in s for sampling (= converting time-continous into time-discrete) input variables. Recommendation: half of the duration of the simulation interval"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings for State Machines"));
  // assumed increase in ventilator pressure
  parameter Modelica.SIunits.Pressure dpAHU_sup=800
    "pressure difference over supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Pressure dpAHU_eta=800
    "pressure difference over extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  // assumed efficiencies of the ventilators
  parameter Modelica.SIunits.Efficiency effFanAHU_sup=0.7
    "efficiency of supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Efficiency effFanAHU_eta=0.7
    "efficiency of extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  ///*******************************************///

  annotation (Documentation(revisions="<html>
<ul>
  <li><i>January 4, 2016&nbsp;</i> by Moritz Lauster:<br/>Clean up of record</li>
  <li><i>February 7, 2014&nbsp;</i> by Ole Odendahl:<br/>Added two more parameters, buildingID and usage for an easier identification of the building</li>
  <li><i>January 28, 2014&nbsp;</i>by Ole Odendahl:<br/>Implemented first version of record</li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is the base definition of zone records used in <a href=\"AixLib.Building.LowOrder.Multizone\">AixLib.Building.LowOrder.Multizone</a>. All necessary parameters are defined here. Most values should be overwritten for a specific building, some are default values that might be appropriate in most cases. However, fell free to overwrite them in your own records. </span></p>
</html>"));
end BuildingBaseRecord;
