within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials;
record SheathingMaterialDefinition "Record for definition of sheathing material"
  extends Modelica.Icons.Record;

 parameter Modelica.SIunits.ThermalConductivity lambda;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record with definition for a sheathing material
</p>
</html>"),Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SheathingMaterialDefinition;
