within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.PipeMaterials;
record Copper "Pipe Material Copper"
  extends Modelica.Icons.Record;
  extends PipeMaterialDefinition(
    lambda=390);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Record for pipe material copper
</p>
</html>"),Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Copper;
