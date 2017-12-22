within AixLib.DataBase.WindowsDoors.Simple;

record WindowSimple_EnEV2009 "Window according to EnEV 2009"

  extends OWBaseDataDefinition_Simple(Uw = 1.3, g = 0.6, Emissivity = 0.9, frameFraction = 0.2);

  annotation(Documentation(revisions = "<html>
<ul>
  <li>
    <i>September 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
  <li>
    <i>July 5, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul></html>",revisions="<html>
<p>
  <b><font style=\"color:">Overview</font></b>
</p>
<p>
  Window definition according to EnEV 2009 for a simple window.
</p>
<p>
  <img src=\"modelica://AixLib/Resources/Images/Stars/stars5.png\" alt=\"stars:" out="" of="">
</p>
<p>
  <b><font style=\"color:">References</font></b>
</p>
<p>
  <b><font style=\"color:">References</font></b>
</p>
<p>
  Record is used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>For EnEV see Bundesregierung (Veranst.): Verordnung ueber energiesparenden Waermeschutz und energiesparende Anlagentechnik bei Gebaeuden. Berlin, 2009
  </li>
</ul></html>",revisions="<html>

</html>"));

end WindowSimple_EnEV2009;

