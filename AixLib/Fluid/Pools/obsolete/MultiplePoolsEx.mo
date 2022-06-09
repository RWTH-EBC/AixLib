within AixLib.Fluid.Pools.obsolete;
model MultiplePoolsEx
   extends Modelica.Icons.Example;
  AixLib.Fluid.Pools.obsolete.MultiplePools multiplePools(Swimminghall=
        SwimmingHallMultiplePools())
    annotation (Placement(transformation(extent={{-34,-18},{32,40}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultiplePoolsEx;
