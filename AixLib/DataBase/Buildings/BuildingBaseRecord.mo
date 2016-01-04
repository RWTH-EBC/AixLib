within AixLib.DataBase.Buildings;
record BuildingBaseRecord "Base record definition for building records"
  extends Modelica.Icons.Record;
  // General
  parameter String buildingID = "M4120" "unique identifier of the building";
  parameter String usage = "Office Building" "typical usage of the building";
  parameter Integer numZones=6 "Number of Zones in the building";
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneSetup[:]={
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting(),AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_2_Storage(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_3_Office(),AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_4_Restroom(),
      AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_5_ICT(),AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_6_Floor()}
    "Provide zone setup as vector entries to zone parameter definitions";
  parameter Modelica.SIunits.Volume Vair=4850.5 "Volume of building";
  parameter Modelica.SIunits.Area BuildingArea =  2000 "Area of building";
  // AHU Modes
  parameter Boolean heating=true "Heating Function of AHU" annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean cooling=true "Cooling Function of AHU" annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean dehumidification=if heating and cooling then true else false
    "Dehumidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean humidification=if heating and cooling then true else false
    "Humidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  // AHU Values
  parameter Real BPF_DeHu(
    min=0,
    max=1) = 0.2
    "By-pass factor of cooling coil during dehumidification. Necessary to calculate the real outgoing enthalpy flow of heat exchanger in dehumidification mode taking the surface enthalpy of the cooling coil into account"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value"));
  parameter Boolean HRS=true
    "Is a HeatRecoverySystem physically integrated in the AHU?"                                annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"), choices(checkBox=true));
  // Efficiency of HRS (both parameters = 0, if HRS is not physically integrated in the AHU at all)
  parameter Real efficiencyHRS_enabled(
    min=0,
    max=1) = 0.8 "efficiency of HRS in the AHU modes when HRS is enabled" annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value", enable=HRS));
  parameter Real efficiencyHRS_disabled(
    min=0,
    max=1) = 0.2
    "taking a little heat transfer into account although HRS is disabled (in the case that a HRS is physically installed in the AHU)"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value"));
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
