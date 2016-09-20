within AixLib.ThermalZones.ReducedOrder.Examples;
model ThermalZone "Illustrates the use of ThermalZone"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone thermalZone
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermalZone;
