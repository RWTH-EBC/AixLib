within AixLib.DataBase.WindowsDoors.Simple;
record WindowSimple_EnEV2009 "Window according to EnEV 2009"
  extends OWBaseDataDefinition_Simple(Uw = 1.3, frameFraction = 0.2, g = 0.6);
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
  Window definition according to EnEV 2009 for a simple window.
</p>
<p>
  <b><span style=\"color: #008000\">References</span></b>
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
  <li>For EnEV see Bundesregierung (Veranst.): Verordnung ueber
  energiesparenden Waermeschutz und energiesparende Anlagentechnik bei
  Gebaeuden. Berlin, 2009
  </li>
</ul>
</html>"));
end WindowSimple_EnEV2009;
