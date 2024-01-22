within AixLib.DataBase.Walls.EnEV2002.Floor;
record FLattic_EnEV2002_SML_upHalf
  "Attic floor after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht), upper half"
  extends WallBaseDataDefinition(
      n(min=1) = 2 "Number of wall layers",
      d={0.08,0.02} "Thickness of wall layers",
      rho={160,300} "Density of wall layers",
      lambda={0.058,0.1} "Thermal conductivity of wall layers",
      c={1358,1700} "Specific heat capacity of wall layers",
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
  Wall definition according to EnEV 2002. For detailed wall type see
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
  <li>Energieeinsparverordnung 2002. 2002
  </li>
</ul>
</html>"));
end FLattic_EnEV2002_SML_upHalf;
