within AixLib.DataBase.Walls.EnEV2009;
package Ceiling
  extends Modelica.Icons.Package;

  record CE_RO_EnEV2009_SM_TBA
    "Ceiling and Roof for a TBA after EnEV 2009, for building of type S (schwer) and M (mittel)"
    extends DataBase.Walls.WallBaseDataDefinition(
      n(min=1) = 7 "Number of wall layers",
      d={0.02,0.08,0.08,0.015,0.22,0.0125,0.015} "Thickness of wall layers",
      rho={120,2300,2300,1200,194,800,1200} "Density of wall layers",
      lambda={0.045,2.3,2.3,0.51,0.045,0.25,0.51} "Thermal conductivity of wall layers",
      c={1030,1000,1000,1000,1301,1000,1000} "Specific heat capacity of wall layers",
      eps=0.95 "Emissivity of inner wall surface");
    annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",   info = "<html>
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
  end CE_RO_EnEV2009_SM_TBA;
end Ceiling;
