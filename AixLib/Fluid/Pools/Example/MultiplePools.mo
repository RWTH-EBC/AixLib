within AixLib.Fluid.Pools.Example;
model MultiplePools
   extends Modelica.Icons.Example;
  AixLib.Fluid.Pools.MultiplePools multiplePools(Swimminghall=
        DataBase.ThermalZones.SwimmingHallMultiplePools(numPools=0))
    annotation (Placement(transformation(extent={{-34,-18},{32,40}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiplePools;
