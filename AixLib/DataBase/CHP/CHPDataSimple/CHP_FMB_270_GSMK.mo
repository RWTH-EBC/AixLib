within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_FMB_270_GSMK "FMB-270-GSMK : Schmitt Enertec"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={15.08e-3},
    data_CHP=[0,0,0,0,0; 50,110,173,323,32.2; 75,165,247,460,45.9; 100,220,307,
        590,58.9],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.13);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Natural Gas CHP: Schmitt Enertec GmbH FMB-270-GSMK
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>July 4, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
</ul>
</html>"));
end CHP_FMB_270_GSMK;
