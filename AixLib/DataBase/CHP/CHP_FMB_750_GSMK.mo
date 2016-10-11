within AixLib.DataBase.CHP;
record CHP_FMB_750_GSMK "FMB-750-GSMK : Guascor"
  extends CHPBaseDataDefinition(
    Vol={36.0e-3},
    data_CHP=[0,0,0,0,0; 50,305,408,860,85.8; 75,457,583,1196,119.3; 100,609,
        731,1559,155.6],
    MaxTFlow=363.15,
    MaxTReturn=343.15,
    Pipe_D=0.16);

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-750-GSMK </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
<p>Source:</p>
<p><ul>
<li>Bibtexkey: SchmittEnertec-FMB-750-GSMK</li>
</ul></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul></p>
</html>"));
end CHP_FMB_750_GSMK;
