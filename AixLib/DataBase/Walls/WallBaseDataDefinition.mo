within AixLib.DataBase.Walls;
record WallBaseDataDefinition "Wall base data definition"
  extends Modelica.Icons.Record;

  parameter Integer n(min = 1)
    "Number of wall layers"
    annotation(Dialog(tab = "Wall", group = "Wall parameters"));
  parameter Modelica.Units.SI.Length d[n] "Thickness of wall layers"
    annotation (Dialog(tab="Wall", group="Layer parameters"));
  parameter Modelica.Units.SI.Density rho[n] "Density of wall layers"
    annotation (Dialog(tab="Wall", group="Layer parameters"));
  parameter Modelica.Units.SI.ThermalConductivity lambda[n]
    "Thermal conductivity of wall layers"
    annotation (Dialog(tab="Wall", group="Wall parameters"));
  parameter Modelica.Units.SI.SpecificHeatCapacity c[n]
    "Specific heat capacity of wall layers"
    annotation (Dialog(tab="Wall", group="Wall parameters"));
  parameter Modelica.Units.SI.Emissivity eps=0.95
    "Emissivity of inner wall surface"
    annotation (Dialog(tab="Wall", group="Wall parameters"));
  annotation (
    defaultComponentPrefixes="parameter",
    Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall BaseDataDefinition actually doesn't need predefined values and
  that is desirable to get errors thrown when using an unparameterised
  wall in a model.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record to be used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<ul>
  <li>
    <i>September 3, 2013</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>April 15, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>
    Define n as length of vectors
  </li>
</ul>
</html>"));
end WallBaseDataDefinition;
