within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model testMix
parameter Integer nZones=2;
parameter Real shareVolume[nZones];
parameter Real totalVolume[nZones];


Modelica.Blocks.Interfaces.RealInput Tzone[nZones]
  annotation (Placement(transformation(extent={{-120,-32},{-80,8}})));
Modelica.Blocks.Interfaces.RealInput ventHRS[nZones]
    annotation (Placement(transformation(extent={{-116,-86},{-86,-56}})));
Modelica.Blocks.Interfaces.RealOutput Tfromzone
  annotation (Placement(transformation(extent={{100,-16},{130,14}})));
equation

Tfromzone = ((shareVolume.*ventHRS*Tzone)/(shareVolume*ventHRS))
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testMix;
