within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_GG_50 "GG 50 : Sokratherm"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={3e-3},
    data_CHP=[0,0,0,0,0; 50,24,54,91,9.1; 75,37,68,118,11.8; 100,50,82,146,14.6],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.08);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Sokratherm BHKW GG 50
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>August 13, 2013&#160;</i> by Ole Odendahl:<br/>
    Added reference
  </li>
</ul>
</html>"));
end CHP_GG_50;
