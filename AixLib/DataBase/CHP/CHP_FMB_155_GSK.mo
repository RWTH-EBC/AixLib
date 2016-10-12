within AixLib.DataBase.CHP;
record CHP_FMB_155_GSK "FMB-155-GSK : Schmitt Enertec"
  extends CHPBaseDataDefinition(
    Vol={11.97e-3},
    data_CHP=[0,0,0,0,0; 50,61,129,213,21.2; 75,92,166,283,28.3; 100,122,196,
        348,34.7],
    MaxTFlow=363.15,
    MaxTReturn=343.15,
    Pipe_D=0.13);

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-155-GSK </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.CHP.CHP\">HVAC.Components.HeatGenerators.CHP.CHP</a></p>
<p>Source:</p>
<p><ul>
<li>Bibtexkey: SchmittEnertec-FMB-155-GSK</li>
</ul></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul></p>
</html>"));
end CHP_FMB_155_GSK;
