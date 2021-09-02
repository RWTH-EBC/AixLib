within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials;
record PBpipe "Pipe Material PB"
  extends Modelica.Icons.Record;
  extends PipeMaterialDefinition(
    lambda=0.22);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Record for pipe material polybutene
</p>
</html>"), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PBpipe;
