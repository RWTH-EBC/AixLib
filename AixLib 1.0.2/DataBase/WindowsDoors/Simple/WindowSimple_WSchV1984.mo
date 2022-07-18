within AixLib.DataBase.WindowsDoors.Simple;
record WindowSimple_WSchV1984 "Window according to WSchV1984"
  extends OWBaseDataDefinition_Simple(Uw = 2.5, frameFraction = 0.2, g = 0.8);
  annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
  <li>
    <i>July 5, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>", info="<html>
<p>
  <b><span style=\"color: #008000\">Overview</span></b>
</p>
<p>
  Window definition according to WSchV 1984 for a simple window.
</p>
<p>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  Record is used in model <a href=
  \"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>For EnEV see Waermeschutzverordnung 1984. 1984
  </li>
</ul>
</html>"));
end WindowSimple_WSchV1984;
