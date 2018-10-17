within AixLib.DataBase.CHP;
record CHP_FMB_1500_GSMK "FMB-1500-GSMK : Guascor"
  extends CHPBaseDataDefinition(
    vol={56.0e-3},
    data_CHP=[0,0,0,0,0; 50,600,777,1599,159.5; 75,900,1046,2252,224.4; 100,
        1200,1315,2916,290.9],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.2);

  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-1500-GSMK </p>
</html>",
        revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
end CHP_FMB_1500_GSMK;
