within AixLib.DataBase.CHP;
record CHP_FMB_31_GSK "FMB-31-GSK : Schmitt Enertec"
  extends CHPBaseDataDefinition(
    Vol={3e-3},
    data_CHP=[0,0,0,0,0; 50,13,25,44,4.4; 75,20,35,62,6.2; 100,26,46,81,8.1],
    MaxTFlow=363.15,
    MaxTReturn=343.15,
    Pipe_D=0.08);

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-31-GSK </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
<p>Source: </p>
<p><ul>
<li>Bibtexkey: SchmittEnertec-FMB-31-GSK</li>
</ul></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul></p>
</html>"));
end CHP_FMB_31_GSK;
