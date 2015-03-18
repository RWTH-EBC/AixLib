within AixLib.DataBase.WindowsDoors.Simple;


record WindowSimple_WSchV1984 "Window according to WSchV1984"
  extends OWBaseDataDefinition_Simple(Uw = 2.5, g = 0.8, Emissivity = 0.9, frameFraction = 0.2);
  annotation(Documentation(revisions = "<html>
 <p><ul>
 <li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
 <li><i>July 5, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul></p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Window definition according to WSchV 1984 for a simple window. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
 <p>Source:</p>
 <ul>
 <li>For EnEV see W&auml;rmeschutzverordnung 1984. 1984</li>
 </ul>
 </html>"));
end WindowSimple_WSchV1984;
