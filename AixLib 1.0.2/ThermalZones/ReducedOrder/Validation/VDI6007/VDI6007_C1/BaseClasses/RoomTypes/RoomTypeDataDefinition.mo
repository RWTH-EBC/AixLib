within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007.VDI6007_C1.BaseClasses.RoomTypes;
record RoomTypeDataDefinition
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Temperature T_start "Initial temperature";
  parameter Modelica.SIunits.Volume VAir "Air volume of the zone";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hRad "Coefficient of heat transfer for linearized radiation exchange between walls";
  parameter Integer nOrientations(min=1) "Number of orientations";

  parameter Modelica.SIunits.Area AWin[nOrientations]
    "Areas of windows by orientations";
  parameter Modelica.SIunits.Area ATransparent[nOrientations]
    "Areas of transparent (solar radiation transmittend) elements by orientations";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConWin "Convective coefficient of heat transfer of windows (indoor)";
  parameter Modelica.SIunits.ThermalResistance RWin "Resistor for windows";
  parameter Modelica.SIunits.TransmissionCoefficient gWin
    "Total energy transmittance of windows";
  parameter Real ratioWinConRad    "Ratio for windows between convective and radiative heat emission";
  parameter Modelica.SIunits.Area AExt[nOrientations] "Areas of exterior walls by orientations";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConExt "Convective coefficient of heat transfer for exterior walls (indoor)";
  parameter Integer nExt(min=1) "Number of RC-elements of exterior walls";
  parameter Modelica.SIunits.ThermalResistance RExt[nExt] "Resistances of exterior walls, from inside to outside";
  parameter Modelica.SIunits.ThermalResistance RExtRem "Resistance of remaining resistor RExtRem between capacity n and outside";
  parameter Modelica.SIunits.HeatCapacity CExt[nExt] "Heat capacities of exterior walls, from inside to outside";
  parameter Modelica.SIunits.Area AInt "Area of interior walls";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConInt "Convective coefficient of heat transfer of interior walls (indoor)";
  parameter Integer nInt(min=1) "Number of RC-elements of interior walls";
  parameter Modelica.SIunits.ThermalResistance RInt[nInt] "Resistances of interior wall, from port to center";
  parameter Modelica.SIunits.HeatCapacity CInt[nInt] "Heat capacities of interior walls, from port to center";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConWallOut=25 "Exterior walls convective coefficient of heat transfer (outdoor)";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hRadWall=5 "Coefficient of heat transfer for linearized radiation for exterior walls";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConWinOut=25 "Windows' convective coefficient of heat transfer (outdoor)";

  parameter Boolean WithTabs = false "Zone has TABS";
  parameter Boolean ExtTabs = false  "Zone TABS are external (Groundfloor or rooftop)";
  parameter Boolean CCTabs = false "Zone TABS are concrete core type";
  parameter Integer nTabs(min=1) = 1 "Number of RC-elements of TABS";
  parameter Modelica.SIunits.ThermalResistance RTabs[nTabs] = {0} "Resistances of TABS, from inside to outside";
  parameter Modelica.SIunits.ThermalResistance RRemTabs = 0 "Resistance of remaining resistor RExtRem between capacity n and outside";
  parameter Modelica.SIunits.HeatCapacity CTabs[nTabs] = {0} "Heat capacities of TABS, from inside to outside";
  parameter Real HeatLoad "Upper limit controller output";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RoomTypeDataDefinition;
