within AixLib.DataBase.Buildings;
record BuildingBaseRecord
  extends Modelica.Icons.Record;
  parameter String buildingID = "M4120" "unique identifier of the building";

  parameter String usage = "Office Building" "typical usage of the building";

  parameter Integer numZones=1 "Number of Zones in the building";

  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneSetup[:]={AixLib.DataBase.Buildings.ZoneBaseRecord()}
    "Provide zone setup as vector entries to zone parameter definitions";

  parameter Modelica.SIunits.Temp_K T0all=273.15+20.1
    "Initial temperature for all components";

  parameter Boolean MinHeating = true
    "Selects if a minimum share of heat is provided to each thermal zone, can be removed";

  parameter Real MinHeatingShare = 0.05
    "percentage of minimum heating share, can be removed";

  parameter Modelica.SIunits.Volume Vair=4850.5 "Volume of building";
  parameter Modelica.SIunits.Area BuildingArea =  2000 "Area of building";
  parameter Modelica.SIunits.HeatFlowRate Q_flow_heat=1 "Heat flow rate"
    annotation(Dialog(tab="Heater", enable = Heater_on));
  parameter Modelica.SIunits.HeatFlowRate Q_N=30000
    "nominal heating power of zone"
    annotation(Dialog(tab="Heater", enable = Heater_on));
  parameter Real h_heater=30000 "Upper limit controller output"
    annotation(Dialog(tab="Heater",group = "Controller", enable = Heater_on));
  parameter Real l_heater=0 "Lower limit controller output"
    annotation(Dialog(tab="Heater",group = "Controller", enable = Heater_on));
  parameter Real KR_heater=10000 "Gain of the controller, h_heater/60"
    annotation(Dialog(tab="Heater",group = "Controller", enable = Heater_on));
  parameter Modelica.SIunits.Time TN_heater=1
    "Time constant of the controller, KR_heater*0.15"
    annotation(Dialog(tab="Heater",group = "Controller", enable = Heater_on));
  parameter Real weightfactor_heater=1 "Weightfactor"
    annotation(Dialog(tab="Heater", enable = Heater_on));
  parameter Boolean Heater_on=true "if use heater component"
    annotation(Dialog(tab="Heater"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_cooler=1 "Heat flow rate"
    annotation(Dialog(tab="Cooler", enable = Cooler_on));
  parameter Real h_cooler=0 "Upper limit controller output"
    annotation(Dialog(tab="Cooler",group = "Controller", enable = Cooler_on));
  parameter Real l_cooler=-30000 "Lower limit controller output"
    annotation(Dialog(tab="Cooler",group = "Controller", enable = Cooler_on));
  parameter Real KR_cooler=10000 "Gain of the controller, abs(l_cooler/80)"
    annotation(Dialog(tab="Cooler",group = "Controller", enable = Cooler_on));
  parameter Modelica.SIunits.Time TN_cooler=1
    "Time constant of the controller, l_cooler*0.15"
    annotation(Dialog(tab="Cooler",group = "Controller"));
  parameter Real weightfactor_cooler=1 "Weightfactor"
    annotation(Dialog(tab="Cooler", enable = Cooler_on));
  parameter Boolean Cooler_on=true "if use chiller component"
    annotation(Dialog(tab="Cooler"));

  // Booleans for possible AHU modes
  parameter Boolean heating=true "Heating Function of AHU" annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean cooling=true "Cooling Function of AHU" annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean dehumidification=if heating and cooling then true else false
    "Dehumidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes", enable=(heating and cooling)));
  parameter Boolean humidification=if heating and cooling then true else false
    "Humidification Function of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes", enable=(heating and cooling)));

  parameter Real BPF_DeHu(
    min=0,
    max=1) = 0.2
    "By-pass factor of cooling coil during dehumidification. Necessary to calculate the real outgoing enthalpy flow of heat exchanger in dehumidification mode taking the surface enthalpy of the cooling coil into account"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value", enable=(dehumidification and cooling and heating)));
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
                                                                                                        annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value", enable=HRS));
  annotation (Documentation(revisions="<html>
<ul>
  <li><i>February 7, 2014&nbsp;</i> by Ole Odendahl:<br/>Added two more parameters, buildingID and usage for an easier identification of the building</li>
  <li><i>January 28, 2014&nbsp;</i>by Ole Odendahl:<br/>Implemented first version of record</li>
</ul>
</html>", info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Building base record te be used with the new multizone model for easy parameterization of the whole building consisting of multiple zones.</p>
<p>Refer to the description of the parameters to learn about the usage of the record. Examples will be provided in the future
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
</html>"));
end BuildingBaseRecord;
