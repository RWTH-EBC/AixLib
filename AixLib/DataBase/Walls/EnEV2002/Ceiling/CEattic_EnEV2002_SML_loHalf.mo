within AixLib.DataBase.Walls.EnEV2002.Ceiling;
record CEattic_EnEV2002_SML_loHalf
  "Ceiling towards attic after EnEV 2002, for building of type S (schwer), M (mittel) and L (leicht), lower half"
  extends WallBaseDataDefinition(n(min = 1) = 3 "Number of wall layers", d = {0.08, 0.0125, 0.015}
      "Thickness of wall layers",                                                                                              rho = {160, 800, 1200}
      "Density of wall layers",                                                                                                    lambda = {0.058, 0.25, 0.51}
      "Thermal conductivity of wall layers",                                                                                                    c = {1358, 1000, 1000}
      "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
      "Emissivity of inner wall surface");
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
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2002. For detailed wall type see
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
  <li>Energieeinsparverordnung 2002. 2002
  </li>
</ul>
</html>"));
end CEattic_EnEV2002_SML_loHalf;
