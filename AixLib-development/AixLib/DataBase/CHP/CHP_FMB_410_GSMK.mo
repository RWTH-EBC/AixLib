within AixLib.DataBase.CHP;
record CHP_FMB_410_GSMK "FMB-410-GSMK : Schmitt Enertec"
  extends CHPBaseDataDefinition(
    vol={22.6e-3},
    data_CHP=[0,0,0,0,0; 50,167,269,491,49.0; 75,251,376,703,70.2; 100,334,485,
        913,91.1],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.13);

  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-410-GSMK </p>
</html>",
        revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
end CHP_FMB_410_GSMK;
