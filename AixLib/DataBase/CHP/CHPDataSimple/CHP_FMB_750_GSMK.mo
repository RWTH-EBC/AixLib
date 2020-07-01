within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_FMB_750_GSMK "FMB-750-GSMK : Guascor"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={36.0e-3},
    data_CHP=[0,0,0,0,0; 50,305,408,860,85.8; 75,457,583,1196,119.3; 100,609,
        731,1559,155.6],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.16);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Natural Gas CHP: Schmitt Enertec GmbH FMB-750-GSMK
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>July 4, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
</ul>
</html>"));
end CHP_FMB_750_GSMK;
