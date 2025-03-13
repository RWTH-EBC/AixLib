within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.PipeMaterials;
record PEXpipe "Pipe Material PE-X"
  extends Modelica.Icons.Record;
  extends PipeMaterialDefinition(
    lambda=0.35);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Record for pipe material of cross-linked polyethylene
</p>
</html>"),Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PEXpipe;
