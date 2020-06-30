within AixLib.DataBase.Walls.EnEV2009.OW;
record OW_EnEV2009_L
  "outer wall after EnEV 2009, for building of type L (leicht)"
  extends WallBaseDataDefinition(n(min = 1) = 4 "Number of wall layers", d = {0.03, 0.02, 0.18, 0.0275}
      "Thickness of wall layers",                                                                                                   rho = {1800, 300, 172, 1018.2}
      "Density of wall layers",                                                                                                    lambda = {1, 0.1, 0.056, 0.346}
      "Thermal conductivity of wall layers",                                                                                                    c = {1000, 1700, 1337, 1000}
      "Specific heat capacity of wall layers",                                                                                                    eps = 0.95
      "Emissivity of inner wall surface");
  // New Walls for Dymola 2012, the same number of layers as other mass clases
  // n(min=1) = 5 "Number of wall layers",
  // d={0.03,0.02,0.18,0.0125,0.015} "Thickness of wall layers",
  // rho={1800,300,172,800,1200} "Density of wall layers",
  // lambda={1,0.1,0.056,0.25,0.51} "Thermal conductivity of wall layers",
  // c={1000,1700,1337,1000,1000} "Specific heat capacity of wall layers",
  annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));
end OW_EnEV2009_L;
