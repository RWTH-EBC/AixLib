within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials;
record PipeMaterialDefinition "Record for definition of pipe material"
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.ThermalConductivity lambda;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Record with definition for a pipe material
</p>
</html>"), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PipeMaterialDefinition;
