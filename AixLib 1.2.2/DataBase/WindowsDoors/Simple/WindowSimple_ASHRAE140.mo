within AixLib.DataBase.WindowsDoors.Simple;
record WindowSimple_ASHRAE140 "Window according to ASHRAE 140"

extends AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple(
    Uw=3,
    frameFraction=0.00001,
    g=0.789);
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>September 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
  <li>
    <i>July 5, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",
        info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Window definition according to standard ASHARE 140 for a simple
  window.
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
  <li>Standard ASHRAE 140 (BibTextkey: ASHRAE-140-2007)
  </li>
</ul>
</html>"));
end WindowSimple_ASHRAE140;
