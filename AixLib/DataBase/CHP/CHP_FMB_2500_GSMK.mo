within AixLib.DataBase.CHP;
record CHP_FMB_2500_GSMK "FMB-2500-GSMK : Cummins"
  extends CHPBaseDataDefinition(
    Vol={91.6e-3},
    data_CHP=[0,0,0,0,0; 50,1000,1250,2760,249.1; 75,1500,1648,3809,343.8; 100,
        2000,2164,4900,422.2],
    MaxTFlow=363.15,
    MaxTReturn=343.15,
    Pipe_D=0.3);

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-2500-GSMK </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
<p>Source:</p>
<p><ul>
<li>Bibtexkey: SchmittEnertec-FMB-2500-GSMK</li>
</ul></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul></p>
</html>"));
end CHP_FMB_2500_GSMK;
