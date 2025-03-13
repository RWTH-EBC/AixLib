within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.PipeMaterials;
record PERTpipe "Pipe-Material PE-RT"
  extends Modelica.Icons.Record;
  extends PipeMaterialDefinition(
    lambda=0.35);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Record for pipe material polyethylene of increased temperature
  resistance
</p>
</html>"),Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PERTpipe;
