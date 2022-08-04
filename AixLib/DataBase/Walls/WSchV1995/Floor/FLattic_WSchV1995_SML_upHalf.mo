within AixLib.DataBase.Walls.WSchV1995.Floor;
record FLattic_WSchV1995_SML_upHalf
  "Attic floor after WSchV1995, for building of type S (schwer), M (mittel) and L (leicht), upper half"
  extends WallBaseDataDefinition(
      n(min=1) = 2 "Number of wall layers",
      d={0.08,0.02} "Thickness of wall layers",
      rho={194,600} "Density of wall layers",
      lambda={0.054,0.14} "Thermal conductivity of wall layers",
      c={1301,1700} "Specific heat capacity of wall layers",
      eps=0.95 "Emissivity of inner wall surface");
  annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>", info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Wall definition according to WSchV 1995. For detailed wall type see
  above.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  <b><span style=\"color: #ff0000;\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Waermeschutzverordnung 1995. 1995
  </li>
</ul>
</html>"));
end FLattic_WSchV1995_SML_upHalf;
