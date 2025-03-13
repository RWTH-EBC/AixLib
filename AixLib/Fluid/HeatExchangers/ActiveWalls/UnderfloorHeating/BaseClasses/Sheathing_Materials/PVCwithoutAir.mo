within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials;
record PVCwithoutAir "PVC according to EN 1264"
  extends Modelica.Icons.Record;
  extends SheathingMaterialDefinition(lambda=0.2);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Record for sheathing material polyvinyl chloride (without air)
</p>
</html>"), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVCwithoutAir;
