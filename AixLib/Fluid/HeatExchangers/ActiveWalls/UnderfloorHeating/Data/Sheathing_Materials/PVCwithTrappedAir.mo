within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.Sheathing_Materials;
record PVCwithTrappedAir "PVC with trapped air according to EN 1264"
  extends Modelica.Icons.Record;
  extends SheathingMaterialDefinition(lambda=0.15);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Record for sheathing material polyvinyl chloride with trapped air
</p>
</html>"), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVCwithTrappedAir;
