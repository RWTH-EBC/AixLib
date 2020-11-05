within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_FMB_31_GSK "FMB-31-GSK : Schmitt Enertec"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={3e-3},
    data_CHP=[0,0,0,0,0; 50,13,25,44,4.4; 75,20,35,62,6.2; 100,26,46,81,8.1],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.08);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Natural Gas CHP: Schmitt Enertec GmbH FMB-31-GSK
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>July 4, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
</ul>
</html>"));
end CHP_FMB_31_GSK;
