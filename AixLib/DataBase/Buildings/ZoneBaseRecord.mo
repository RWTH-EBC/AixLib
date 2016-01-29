within AixLib.DataBase.Buildings;
record ZoneBaseRecord "the used record standard"
  extends Modelica.Icons.Record;
  parameter String zoneID = "B1Z1" "unique identifier of the zone";
  parameter String usage = "Einzelbuero" "typical usage of zone space";
  parameter Modelica.SIunits.Temp_K T0all = 273.15 + 20.1
    "Initial temperature for all components"                                                       annotation(Dialog(descriptionLabel = false));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_heat = 1 "Heat flow rate" annotation(Dialog(tab = "Heater", enable = Heater_on, descriptionLabel = false));
  parameter Modelica.SIunits.HeatFlowRate Q_N = 30000
    "nominal heating power of zone"                                                   annotation(Dialog(tab = "Heater", enable = Heater_on, descriptionLabel = false));
  parameter Real h_heater = 30000 "Upper limit controller output" annotation(Dialog(tab = "Heater", group = "Controller", enable = Heater_on, descriptionLabel = false));
  parameter Real l_heater = 0 "Lower limit controller output" annotation(Dialog(tab = "Heater", group = "Controller", enable = Heater_on, descriptionLabel = false));
  parameter Real KR_heater = 10000 "Gain of the controller, h_heater/60" annotation(Dialog(tab = "Heater", group = "Controller", enable = Heater_on, descriptionLabel = false));
  parameter Modelica.SIunits.Time TN_heater = 1
    "Time constant of the controller, KR_heater*0.15"                                             annotation(Dialog(tab = "Heater", group = "Controller", enable = Heater_on, descriptionLabel = false));
  parameter Real weightfactor_heater = 1 "Weightfactor" annotation(Dialog(tab = "Heater", enable = Heater_on, descriptionLabel = false));
  parameter Boolean Heater_on = true "if use heater component" annotation(Dialog(tab = "Heater", descriptionLabel = false));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_cooler = 1 "Heat flow rate" annotation(Dialog(tab = "Cooler", enable = Cooler_on, descriptionLabel = false));
  parameter Real h_cooler = 0 "Upper limit controller output" annotation(Dialog(tab = "Cooler", group = "Controller", enable = Cooler_on, descriptionLabel = false));
  parameter Real l_cooler = -30000 "Lower limit controller output" annotation(Dialog(tab = "Cooler", group = "Controller", enable = Cooler_on, descriptionLabel = false));
  parameter Real KR_cooler = 10000 "Gain of the controller, abs(l_cooler/80)" annotation(Dialog(tab = "Cooler", group = "Controller", enable = Cooler_on, descriptionLabel = false));
  parameter Modelica.SIunits.Time TN_cooler = 1
    "Time constant of the controller, l_cooler*0.15"                                             annotation(Dialog(tab = "Cooler", group = "Controller", enable = Cooler_on, descriptionLabel = false));
  parameter Real weightfactor_cooler = 1 "Weightfactor" annotation(Dialog(tab = "Cooler", enable = Cooler_on, descriptionLabel = false));
  parameter Boolean Cooler_on = true "if use chiller component" annotation(Dialog(tab = "Cooler", descriptionLabel = false));
  parameter Integer ActivityTypePeople = 3 "Physical activity" annotation(Dialog(tab = "Inner loads", group = "Persons", compact = true, descriptionLabel = false), choices(choice = 2 "light", choice = 3
        "moderate",                                                                                                    choice = 4 "heavy ", radioButtons = true));
  parameter Real NrPeople = 1 "Number of people in the room" annotation(Dialog(tab = "Inner loads", group = "Persons", descriptionLabel = false));
  parameter Real RatioConvectiveHeatPeople = 0.5
    "Ratio of convective heat from overall heat output"                                              annotation(Dialog(tab = "Inner loads", group = "Persons", descriptionLabel = false));
  parameter Integer ActivityTypeMachines = 2 "Machine activity" annotation(Dialog(tab = "Inner loads", group = "Machines", compact = true, descriptionLabel = false), choices(choice = 1 "low", choice = 2 "middle", choice = 3 "high", radioButtons = true));
  parameter Real NrPeopleMachines = 1 "Number of people with machines" annotation(Dialog(tab = "Inner loads", group = "Machines", descriptionLabel = false));
  parameter Real RatioConvectiveHeatMachines = 0.6
    "Ratio of convective heat from overall heat output"                                                annotation(Dialog(tab = "Inner loads", group = "Machines", descriptionLabel = false));
  parameter Modelica.SIunits.Area RoomArea = 20 "Area of room" annotation(Dialog(tab = "Inner loads", group = "Lighting", descriptionLabel = false));
  parameter Real LightingPower = 10 "Heating power of lighting in W/m2" annotation(Dialog(tab = "Inner loads", group = "Lighting", descriptionLabel = false));
  parameter Real RatioConvectiveHeatLighting = 0.5
    "Ratio of convective heat from overall heat output"                                                annotation(Dialog(tab = "Inner loads", group = "Lighting", descriptionLabel = false));
  parameter Boolean withInnerwalls = true "If inner walls are existent" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.ThermalResistance R1i = 0.000656956 "Resistor 1" annotation(Dialog(tab = "Inner walls", descriptionLabel = false, enable = withInnerwalls));
  parameter Modelica.SIunits.HeatCapacity C1i = 12049200 "Capacity 1" annotation(Dialog(tab = "Inner walls", descriptionLabel = false, enable = withInnerwalls));
  parameter Modelica.SIunits.Area Ai = 60.5 "Inner wall area" annotation(Dialog(tab = "Inner walls", descriptionLabel = false, enable = withInnerwalls));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi = 2.1
    "Inner wall's coefficient of heat transfer"                                                                   annotation(Dialog(tab = "Inner walls", descriptionLabel = false, enable = withInnerwalls));
  parameter Modelica.SIunits.Emissivity epsi = 0.9 "Emissivity" annotation(Dialog(tab = "Inner walls", descriptionLabel = false, enable = withInnerwalls));
  parameter Boolean withOuterwalls = true
    "If outer walls (including windows) are existent"                                       annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.ThermalResistance RRest = 0.001717044
    "Resistor Rest"                                                                annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Modelica.SIunits.ThermalResistance R1o = 0.02045808 "Resistor 1" annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Modelica.SIunits.HeatCapacity C1o = 4896650 "Capacity 1" annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Modelica.SIunits.Area Ao = 25.5 "Outer wall area" annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi = 2.7
    "Outer wall's coefficient of heat transfer (inner side)"                                                                   annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo = 20
    "Outer wall's coefficient of heat transfer (outer side)"                                                                  annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaConvWinInner=3.16
    "Coefficient of convective heat transfer of the window (inner side)" annotation(Dialog(tab="Windows", enable = withWindows));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaConvWinOuter=16.37
    "Coefficient of convective heat transfer of the window (outer side)" annotation(Dialog(tab="Windows", enable = withWindows));
  parameter Modelica.SIunits.Emissivity epso = 0.9 "Emissivity" annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Real aowo = 0.7
    "Outer wall's coefficient of absorption (outer side)"                         annotation(Dialog(tab = "Outer walls", descriptionLabel = false, enable = withOuterwalls));
  parameter Real awin=0.0 "Coefficient of absorption of the window" annotation(Dialog(tab="Windows", enable = withWindows));
  parameter Integer n = 4 "Number of orientations (without ground)" annotation(Dialog(tab = "Outer walls", enable = withOuterwalls));
  parameter Real weightfactorswall[n] = {0.5, 0.2, 0.2, 0.1}
    "Weightfactors of the walls (Aj/Atot)"                                                          annotation(Dialog(tab = "Outer walls", enable = withOuterwalls));
  parameter Real weightfactorground = 0
    "Weightfactor of the earth (0 if not considered)"                                     annotation(Dialog(tab = "Outer walls", enable = withOuterwalls));
  parameter Modelica.SIunits.Temp_K temperatureground = 286.15
    "Temperature of the earth"                                                            annotation(Dialog(tab = "Outer walls", enable = withOuterwalls));
  parameter Boolean withWindows = true "If windows are existent" annotation(Dialog(tab = "Windows", enable = withOuterwalls));
  parameter Real splitfac = 0
    "part of convective heat transfer through windows"                           annotation(Dialog(tab = "Windows", enable = withOuterwalls));
  parameter Modelica.SIunits.Area Aw[n] = {1, 1, 1, 1} "Area of the windows" annotation(Dialog(tab = "Windows", descriptionLabel = false, enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n] = {1, 1, 1, 1}
    "Energy transmittances if sunblind is closed"                                                                              annotation(Dialog(tab = "Windows", group = "Shading", descriptionLabel = false, enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax = 200
    "Intensity at which the sunblind closes"                                                              annotation(Dialog(tab = "Windows", group = "Shading", descriptionLabel = false, enable = if withWindows and withOuterwalls then true else false));
  parameter Real weightfactorswindow[n] = {0, 0, 0, 0}
    "Weightfactors of the windows"                                                    annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity epsw = 0.9 "Emissivity" annotation(Dialog(tab = "Windows", descriptionLabel = false, enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient g = 0.7
    "Total energy transmittance"                                                          annotation(Dialog(tab = "Windows", descriptionLabel = false, enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Length Lchar = 12
    "characterisic length of building (longer side)";
  parameter Modelica.SIunits.Length Bchar = 11
    "characterisic width of building (smaller side)";
  parameter Modelica.SIunits.Length Hb = 2.9 "height of one story";
  parameter Real Nb = 3 "number of stories";
  parameter Modelica.SIunits.Volume Vair = 52.5 "Volume" annotation(Dialog(tab = "Room air", descriptionLabel = false));
  parameter Modelica.SIunits.Density rhoair = 1.19 "Density" annotation(Dialog(tab = "Room air", descriptionLabel = false));
  parameter Modelica.SIunits.SpecificHeatCapacity cair = 1007 "Heat capacity" annotation(Dialog(tab = "Room air", descriptionLabel = false));
  parameter Boolean withAHU = false
    "Choose if zone is connected to central air handling unit"                                 annotation(Dialog(tab = "Room air", descriptionLabel = false), choices(choice = true "yes", choice = false "no", radioButtons = true));
  parameter Real minAHU(unit = "m3/(h.m2)") = 0
    "Minimum specific air flow supplied by the AHU"                                             annotation(Dialog(tab = "Room air"));
  parameter Real maxAHU(unit = "m3/(h.m2)") = 4
    "Maximum specific air flow supplied by the AHU"                                             annotation(Dialog(tab = "Room air"));
  parameter Boolean useConstantACHrate = false
    "Choose if a constant infiltration rate is used"                                            annotation(Dialog(tab = "Room air", group = "ACH", descriptionLabel = false), choices(choice = true "yes", choice = false "no", radioButtons = true));
  parameter Real baseACH = 0.2 "base ACH rate for ventilation controller" annotation(Dialog(tab = "Room air", group = "ACH", descriptionLabel = false));
  parameter Real maxUserACH = 1.0 "additional ACH value for max. user activity"
                                                                                annotation(Dialog(tab = "Room air", group = "ACH", descriptionLabel = false));
  parameter Real maxOverheatingACH[2] = {3.0, 2.0}
    "additional ACH value when overheating appears, transition range in K"                                                annotation(Dialog(tab = "Room air", group = "ACH", descriptionLabel = false));
  parameter Real maxSummerACH[3] = {1.0, 273.15 + 10, 273.15 + 17}
    "additional ACH in summer, Tmin, Tmax"                                                                annotation(Dialog(tab = "Room air", group = "ACH", descriptionLabel = false));
  parameter Real winterReduction[3]={0.2,273.15,273.15 + 10}
    "reduction factor of userACH for cold weather." annotation (Dialog(tab="Room air", group="ACH", descriptionLabel = false));
  parameter Modelica.SIunits.ThermalResistance RWin=0.017727777777
    "Resistor Window" annotation(Dialog(tab="Windows", enable = withWindows));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer UWin=3
    "Thermal transmission coefficient of windows"   annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Real orientationswallshorizontal[n] 
    "orientations of the walls against the vertical (wall,roof)"annotation(Dialog(tab = "Outer walls"));
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base definition is zone records used in <a href=\"AixLib.Building.LowOrder.ThermalZone\">AixLib.Building.LowOrder.ThermalZone</a>. All necessary parameters are defined here. Most values should be overwritten for a specific building, some are default values that might be appropriate in most cases. However, fell free to overwrite them in your own records.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Remark: The design heating power Q_N of the building is the sum of net design power according to transmission and ventilation losses at a given outdoor temperature and an additional re-heating power for early morning heat up after night set-back. Net design power can be simulated with constant boundary conditions (e. g.: no internal or external gains, Touside=-12 degC, ACH=0.5). The additional re-heating power is computed by a factor [f_RH]=W/m2 and the heated zone floor area.</p>
 <p>The factor f_RH in W/m2 can be chosen form the following table:</p>
 <table summary=\"factor f_RH\" cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
 <td></td>
 <td><h4 align=\"center\">1 K</h4></td>
 <td><h4 align=\"center\">2 K</h4></td>
 <td><h4 align=\"center\">3 K</h4></td>
 </tr>
 <tr>
 <td><h4 align=\"center\">re-heat time</h4></td>
 <td><h4 align=\"center\">light</h4></td>
 <td><h4 align=\"center\">medium</h4></td>
 <td><h4 align=\"center\">heavy</h4></td>
 </tr>
 <tr>
 <td><p>1 h</p></td>
 <td><p>11</p></td>
 <td><p>22</p></td>
 <td><p>45</p></td>
 </tr>
 <tr>
 <td><p>2 h</p></td>
 <td><p>6</p></td>
 <td><p>11</p></td>
 <td><p>22</p></td>
 </tr>
 <tr>
 <td><p>3 h</p></td>
 <td><p>4</p></td>
 <td><p>9</p></td>
 <td><p>16</p></td>
 </tr>
 <tr>
 <td><p>4 h</p></td>
 <td><p>2</p></td>
 <td><p>7</p></td>
 <td><p>13</p></td>
 </tr>
 </table>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"AixLib.Building.LowOrder.ThermalZone\">AixLib.Building.LowOrder.ThermalZone</a></p>
 </html>", revisions="<html>
<ul>
<li><i>June, 2015 </i>by Moitz Lauster:
<br>Added new parameters to use further calculation cores.</li>
<li><i>February 4, 2014&nbsp;</i>by Ole Odendahl:<br>Added new parameters for the setup of the ACH. It is now possible to assign different values to the ACH for each zone based on this record. </li>
<li><i>January 27, 2014&nbsp;</i>by Ole Odendahl:<br>Added new parameter withAHU to choose whether the zone is connected to a central air handling unit. Default false </li>
<li><i>March, 2012&nbsp;</i> by Peter Matthes:<br>Implemented </li>
<li><i>November, 2012&nbsp;</i> by Moritz Lauster:<br>Restored links </li>
</ul>
</html>"));
end ZoneBaseRecord;
