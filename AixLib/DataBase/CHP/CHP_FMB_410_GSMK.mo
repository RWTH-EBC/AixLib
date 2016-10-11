within AixLib.DataBase.CHP;
record CHP_FMB_410_GSMK "FMB-410-GSMK : Schmitt Enertec"
  extends CHPBaseDataDefinition(
    vol={22.6e-3},
    data_CHP=[0,0,0,0,0; 50,167,269,491,49.0; 75,251,376,703,70.2; 100,334,485,
        913,91.1],
    maxVTemp=363.15,
    maxRTemp=343.15,
    pipe_D=0.13);

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-410-GSMK </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
<p>Source: </p>
<p><ul>
<li>Bibtexkey: SchmittEnertec-FMB-410-GSMK</li>
</ul></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul></p>
</html>"));
end CHP_FMB_410_GSMK;
