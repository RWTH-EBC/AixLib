within AixLib.DataBase.Walls.WSchV1995.IW;
record IWload_WSchV1995_L_half
  "Inner wall load-bearing after WSchV1995, for building of type L (leicht), only half"
  // New Walls for Dymola 2012, the same number of layers as other mass clases
  extends WallBaseDataDefinition(n(min = 1) = 2 "Number of wall layers", d = {0.09, 0.0275}
      "Thickness of wall layers",                                                                                       rho = {93, 1018.2}
      "Density of wall layers",                                                                                                    lambda = {0.78, 0.346}
      "Thermal conductivity of wall layers",                                                                                                    c = {1593, 1000}
      "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
      "Emissivity of inner wall surface");
  /*    n(min=1) = 3 "Number of wall layers",
      d={0.09,0.0125,0.015} "Thickness of wall layers",
      rho={93,800,1200} "Density of wall layers",
      lambda={0.78,0.25,0.51} "Thermal conductivity of wall layers",
      c={1593,1000,1000} "Specific heat capacity of wall layers",
      eps=0.95 "Emissivity of inner wall surface");
  */
  annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>August 15, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to WSchV 1995. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>W&auml;rmeschutzverordnung 1995. 1995</li>
 </ul>
 </html>"));
end IWload_WSchV1995_L_half;
