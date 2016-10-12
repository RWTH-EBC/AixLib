within AixLib.DataBase.CHP;
record CHP_FMB_1500_GSMK "FMB-1500-GSMK : Guascor"
  extends CHPBaseDataDefinition(
    Vol={56.0e-3},
    data_CHP=[0,0,0,0,0; 50,600,777,1599,159.5; 75,900,1046,2252,224.4; 100,
        1200,1315,2916,290.9],
    MaxTFlow=363.15,
    MaxTReturn=343.15,
    Pipe_D=0.2);

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-1500-GSMK </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
<p>Source:</p>
<p><ul>
<li>Bibtexkey: SchmittEnertec-FMB-1500-GSMK</li>
</ul></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul></p>
</html>"));
end CHP_FMB_1500_GSMK;
