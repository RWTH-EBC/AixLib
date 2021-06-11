within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials;
record Steel "Pipe Material Steel"
  extends Modelica.Icons.Record;
  extends PipeMaterialDefinition(
    lambda=52);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for pipe material steel
</p>
</html>"),Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Steel;
