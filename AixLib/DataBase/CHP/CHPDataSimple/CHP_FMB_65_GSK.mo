within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_FMB_65_GSK "FMB-65-GSK : Schmitt Enertec"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={4.5e-3},
    data_CHP=[0,0,0,0,0; 50,25,52,88,8.8; 75,38,75,128,12.8; 100,50,82,150,15.0],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.08);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Natural Gas CHP: Schmitt Enertec GmbH FMB-65-GSK
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>July 4, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
</ul>
</html>"));
end CHP_FMB_65_GSK;
