within AixLib.DataBase.Buildings;
record ZoneBaseRecord "Base record definition for zone records"
  extends Modelica.Icons.Record;
  // General
  parameter String zoneID = "B1Z1" "unique identifier of the zone";
  parameter String usage = "Single Office" "typical usage of zone space";
  parameter Modelica.SIunits.Temp_K T0all = 273.15 + 20.1
    "Initial temperature for all components";
  parameter Modelica.SIunits.Area RoomArea = 20 "Area of room";
  // Heater and Cooler
  parameter Real h_heater = 30000 "Upper limit controller output" annotation(Dialog(tab = "Heater"));
  parameter Real l_heater = 0 "Lower limit controller output" annotation(Dialog(tab = "Heater"));
  parameter Real KR_heater = 10000 "Gain of the controller, h_heater/60" annotation(Dialog(tab = "Heater"));
  parameter Modelica.SIunits.Time TN_heater = 1
    "Time constant of the controller, KR_heater*0.15" annotation(Dialog(tab = "Heater"));
  parameter Boolean Heater_on = true "if use heater component" annotation(Dialog(tab = "Heater"));
  parameter Real h_cooler = 0 "Upper limit controller output" annotation(Dialog(tab = "Cooler"));
  parameter Real l_cooler = -30000 "Lower limit controller output" annotation(Dialog(tab = "Cooler"));
  parameter Real KR_cooler = 10000 "Gain of the controller, abs(l_cooler/80)" annotation(Dialog(tab = "Cooler"));
  parameter Modelica.SIunits.Time TN_cooler = 1
    "Time constant of the controller, l_cooler*0.15" annotation(Dialog(tab = "Cooler"));
  parameter Boolean Cooler_on = true "if use chiller component" annotation(Dialog(tab = "Cooler"));
  // Internal Gains
  parameter Integer ActivityTypePeople = 3 "Physical activity" annotation(Dialog(tab = "Inner loads", group = "Persons"));
  parameter Real NrPeople = 1 "Number of people in the room" annotation(Dialog(tab = "Inner loads", group = "Persons"));
  parameter Real RatioConvectiveHeatPeople = 0.5
    "Ratio of convective heat from overall heat output" annotation(Dialog(tab = "Inner loads", group = "Persons"));
  parameter Integer ActivityTypeMachines = 2 "Machine activity" annotation(Dialog(tab = "Inner loads", group = "Machines"));
  parameter Real NrPeopleMachines = 1 "Number of people with machines" annotation(Dialog(tab = "Inner loads", group = "Machines"));
  parameter Real RatioConvectiveHeatMachines = 0.6
    "Ratio of convective heat from overall heat output" annotation(Dialog(tab = "Inner loads", group = "Machines"));
  parameter Real LightingPower = 10 "Heating power of lighting in W/m2" annotation(Dialog(tab = "Inner loads", group = "Lighting"));
  parameter Real RatioConvectiveHeatLighting = 0.5
    "Ratio of convective heat from overall heat output" annotation(Dialog(tab = "Inner loads", group = "Lighting"));
  // Internal Walls
  parameter Boolean withInnerwalls = true "If inner walls are existent" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.ThermalResistance R1i = 0.000656956 "Resistor 1" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.HeatCapacity C1i = 12049200 "Capacity 1" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.Area Ai = 60.5 "Inner wall area" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi = 2.1
    "Inner wall's coefficient of heat transfer" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.Emissivity epsi = 0.9 "Emissivity" annotation(Dialog(tab = "Inner walls"));
  // External Walls
  parameter Boolean withOuterwalls = true
    "If outer walls (including windows) are existent" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.ThermalResistance RRest = 0.001717044
    "Resistor Rest" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.ThermalResistance R1o = 0.02045808 "Resistor 1" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.HeatCapacity C1o = 4896650 "Capacity 1" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.Area Ao = 25.5 "Outer wall area" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi = 2.7
    "Outer wall's coefficient of heat transfer (inner side)" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo = 20
    "Outer wall's coefficient of heat transfer (outer side)" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.Emissivity epso = 0.9 "Emissivity" annotation(Dialog(tab = "Outer walls"));
  parameter Real aowo = 0.7
    "Outer wall's coefficient of absorption (outer side)" annotation(Dialog(tab = "Outer walls"));
  parameter Integer n = 4 "Number of orientations (without ground)" annotation(Dialog(tab = "Outer walls"));
  parameter Real weightfactorswall[n] = {0.5, 0.2, 0.2, 0.1}
    "Weightfactors of the walls (Aj/Atot)" annotation(Dialog(tab = "Outer walls"));
  parameter Real weightfactorground = 0
    "Weightfactor of the earth (0 if not considered)" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.Temp_K temperatureground = 286.15
    "Temperature of the earth" annotation(Dialog(tab = "Outer walls"));
  // Windows
  parameter Boolean withWindows = true "If windows are existent" annotation(Dialog(tab = "Windows"));
  parameter Modelica.SIunits.ThermalResistance RWin=0.017727777777
    "Resistor Window" annotation(Dialog(tab="Windows"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer UWin=3
    "Thermal transmission coefficient of windows"   annotation(Dialog(tab = "Windows"));
  parameter Modelica.SIunits.Area Aw[n] = {1, 1, 1, 1} "Area of the windows" annotation(Dialog(tab = "Windows"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaConvWinInner=3.16
    "Coefficient of convective heat transfer of the window (inner side)" annotation(Dialog(tab="Windows"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaConvWinOuter=16.37
    "Coefficient of convective heat transfer of the window (outer side)" annotation(Dialog(tab="Windows"));
  parameter Modelica.SIunits.Emissivity epsw = 0.9 "Emissivity" annotation(Dialog(tab = "Windows"));
  parameter Real awin=0.0 "Coefficient of absorption of the window" annotation(Dialog(tab="Windows"));
  parameter Real splitfac = 0
    "part of convective heat transfer through windows" annotation(Dialog(tab = "Windows"));
  parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n] = {1, 1, 1, 1}
    "Energy transmittances if sunblind is closed" annotation(Dialog(tab = "Windows", group = "Shading"));
  parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax = 200
    "Intensity at which the sunblind closes" annotation(Dialog(tab = "Windows", group = "Shading"));
  parameter Real weightfactorswindow[n] = {0, 0, 0, 0}
    "Weightfactors of the windows" annotation(Dialog(tab = "Windows"));
  parameter Modelica.SIunits.TransmissionCoefficient g = 0.7
    "Total energy transmittance" annotation(Dialog(tab = "Windows"));
  // Room Air
  parameter Modelica.SIunits.Volume Vair = 52.5 "Volume" annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.Density rhoair = 1.19 "Density" annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.SpecificHeatCapacity cair = 1007 "Heat capacity" annotation(Dialog(tab = "Room air"));
  // AHU (Mechanical Ventilation)
  parameter Boolean withAHU = false
    "Choose if zone is connected to central air handling unit" annotation(Dialog(tab = "Room air", group = "Mechanical Ventilation"));
  parameter Real minAHU(unit = "m3/(h.m2)") = 0
    "Minimum specific air flow supplied by the AHU" annotation(Dialog(tab = "Room air", group = "Mechanical Ventilation"));
  parameter Real maxAHU(unit = "m3/(h.m2)") = 4
    "Maximum specific air flow supplied by the AHU" annotation(Dialog(tab = "Room air", group = "Mechanical Ventilation"));
  // ACH (Infiltration and Natural Ventilation)
  parameter Boolean useConstantACHrate = false
    "Choose if a constant infiltration rate is used" annotation(Dialog(tab = "Room air", group = "Natural Ventilation and Infiltration"));
  parameter Real baseACH = 0.2 "base ACH rate for ventilation controller" annotation(Dialog(tab = "Room air", group = "Natural Ventilation and Infiltration"));
  parameter Real maxUserACH = 1.0 "additional ACH value for max. user activity"
   annotation(Dialog(tab = "Room air", group = "Natural Ventilation and Infiltration"));
  parameter Real maxOverheatingACH[2] = {3.0, 2.0}
    "additional ACH value when overheating appears, transition range in K" annotation(Dialog(tab = "Room air", group = "Natural Ventilation and Infiltration"));
  parameter Real maxSummerACH[3] = {1.0, 273.15 + 10, 273.15 + 17}
    "additional ACH in summer, Tmin, Tmax" annotation(Dialog(tab = "Room air", group = "Natural Ventilation and Infiltration"));
  parameter Real winterReduction[3]={0.2,273.15,273.15 + 10}
    "reduction factor of userACH for cold weather." annotation (Dialog(tab="Room air", group="Natural Ventilation and Infiltration"));
  annotation(Documentation(info="<html>
<p>This is the base definition of zone records used in <a href=\"AixLib.Building.LowOrder.ThermalZone\">AixLib.Building.LowOrder.ThermalZone</a>. All necessary parameters are defined here. Most values should be overwritten for a specific building, some are default values that might be appropriate in most cases. However, fell free to overwrite them in your own records. </p>
</html>",  revisions="<html>
<ul>
<li><i>January 4, 2016 </i>by Moritz Lauster:
<br>Clean up.</li>
<li><i>June, 2015 </i>by Moritz Lauster:
<br>Added new parameters to use further calculation cores.</li>
<li><i>February 4, 2014&nbsp;</i>by Ole Odendahl:<br>Added new parameters for the setup of the ACH. It is now possible to assign different values to the ACH for each zone based on this record. </li>
<li><i>January 27, 2014&nbsp;</i>by Ole Odendahl:<br>Added new parameter withAHU to choose whether the zone is connected to a central air handling unit. Default false </li>
<li><i>March, 2012&nbsp;</i> by Peter Matthes:<br>Implemented </li>
<li><i>November, 2012&nbsp;</i> by Moritz Lauster:<br>Restored links </li>
</ul>
</html>"));
end ZoneBaseRecord;
