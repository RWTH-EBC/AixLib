within AixLib.DataBase.WindowsDoors.Simple;
record WindowSimple_EnEV2002 "Window according to EnEv 2002"
  extends OWBaseDataDefinition_Simple(Uw = 1.7, frameFraction = 0.2, g = 0.6);
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
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Window definition according to EnEV 2002 for a simple window.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>For EnEV see Energieeinsparverordnung 2002. 2002
  </li>
</ul>
</html>"));
end WindowSimple_EnEV2002;
