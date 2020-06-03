within AixLib.DataBase.Walls.WSchV1995.Floor;
record FLpartition_WSchV1995_SM_upHalf
  "Floor partition after WSchV1995, for building of type S (schwer) and M (mittel), upper half"
  extends WallBaseDataDefinition(n(min = 1) = 2 "Number of wall layers", d = {0.02, 0.06}
      "Thickness of wall layers",                                                                                     rho = {120, 2000}
      "Density of wall layers",                                                                                                    lambda = {0.045, 1.4}
      "Thermal conductivity of wall layers",                                                                                                    c = {1030, 1000}
      "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
      "Emissivity of inner wall surface");
  annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>August 15, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to WSchV 1995. For detailed wall type see
  above.
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
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Wärmeschutzverordnung 1995. 1995
  </li>
</ul>
</html>"));
end FLpartition_WSchV1995_SM_upHalf;
