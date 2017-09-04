within AixLib.DataBase.CHP;
record CHP_FMB_2500_GSMK "FMB-2500-GSMK : Cummins"
  extends CHPBaseDataDefinition(
    vol={91.6e-3},
    data_CHP=[0,0,0,0,0; 50,1000,1250,2760,249.1; 75,1500,1648,3809,343.8; 100,
        2000,2164,4900,422.2],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.3);

  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-2500-GSMK </p>
</html>",
        revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
end CHP_FMB_2500_GSMK;
