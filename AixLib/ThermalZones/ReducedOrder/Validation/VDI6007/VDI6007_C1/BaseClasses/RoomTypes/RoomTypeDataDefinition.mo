within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007.VDI6007_C1.BaseClasses.RoomTypes;
record RoomTypeDataDefinition
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Temperature T_start "Initial temperature";
  parameter Modelica.Units.SI.Volume VAir "Air volume of the zone";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRad
    "Coefficient of heat transfer for linearized radiation exchange between walls";
  parameter Integer nOrientations(min=1) "Number of orientations";

  parameter Modelica.Units.SI.Area AWin[nOrientations]
    "Areas of windows by orientations";
  parameter Modelica.Units.SI.Area ATransparent[nOrientations]
    "Areas of transparent (solar radiation transmittend) elements by orientations";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWin
    "Convective coefficient of heat transfer of windows (indoor)";
  parameter Modelica.Units.SI.ThermalResistance RWin "Resistor for windows";
  parameter Modelica.Units.SI.TransmissionCoefficient gWin
    "Total energy transmittance of windows";
  parameter Real ratioWinConRad    "Ratio for windows between convective and radiative heat emission";
  parameter Modelica.Units.SI.Area AExt[nOrientations]
    "Areas of exterior walls by orientations";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConExt
    "Convective coefficient of heat transfer for exterior walls (indoor)";
  parameter Integer nExt(min=1) "Number of RC-elements of exterior walls";
  parameter Modelica.Units.SI.ThermalResistance RExt[nExt]
    "Resistances of exterior walls, from inside to outside";
  parameter Modelica.Units.SI.ThermalResistance RExtRem
    "Resistance of remaining resistor RExtRem between capacity n and outside";
  parameter Modelica.Units.SI.HeatCapacity CExt[nExt]
    "Heat capacities of exterior walls, from inside to outside";
  parameter Modelica.Units.SI.Area AInt "Area of interior walls";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConInt
    "Convective coefficient of heat transfer of interior walls (indoor)";
  parameter Integer nInt(min=1) "Number of RC-elements of interior walls";
  parameter Modelica.Units.SI.ThermalResistance RInt[nInt]
    "Resistances of interior wall, from port to center";
  parameter Modelica.Units.SI.HeatCapacity CInt[nInt]
    "Heat capacities of interior walls, from port to center";

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWallOut=25
    "Exterior walls convective coefficient of heat transfer (outdoor)";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRadWall=5
    "Coefficient of heat transfer for linearized radiation for exterior walls";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWinOut=25
    "Windows' convective coefficient of heat transfer (outdoor)";

  parameter Boolean WithTabs = false "Zone has TABS";
  parameter Boolean ExtTabs = false  "Zone TABS are external (Groundfloor or rooftop)";
  parameter Boolean CCTabs = false "Zone TABS are concrete core type";
  parameter Integer nTabs(min=1) = 1 "Number of RC-elements of TABS";
  parameter Modelica.Units.SI.ThermalResistance RTabs[nTabs]={0}
    "Resistances of TABS, from inside to outside";
  parameter Modelica.Units.SI.ThermalResistance RRemTabs=0
    "Resistance of remaining resistor RExtRem between capacity n and outside";
  parameter Modelica.Units.SI.HeatCapacity CTabs[nTabs]={0}
    "Heat capacities of TABS, from inside to outside";
  parameter Real HeatLoad "Upper limit controller output";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RoomTypeDataDefinition;
