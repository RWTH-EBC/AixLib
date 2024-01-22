within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_FMB_2500_GSMK "FMB-2500-GSMK : Cummins"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={91.6e-3},
    data_CHP=[0,0,0,0,0; 50,1000,1250,2760,249.1; 75,1500,1648,3809,343.8; 100,
        2000,2164,4900,422.2],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.3);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Natural Gas CHP: Schmitt Enertec GmbH FMB-2500-GSMK
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>July 4, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
</ul>
</html>"));
end CHP_FMB_2500_GSMK;
