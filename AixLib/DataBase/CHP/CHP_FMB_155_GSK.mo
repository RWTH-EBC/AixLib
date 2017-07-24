within AixLib.DataBase.CHP;
record CHP_FMB_155_GSK "FMB-155-GSK : Schmitt Enertec"
  extends CHPBaseDataDefinition(
    vol={11.97e-3},
    data_CHP=[0,0,0,0,0; 50,61,129,213,21.2; 75,92,166,283,28.3; 100,122,196,
        348,34.7],
    maxTFlow=363.15,
    maxTReturn=343.15,
    DPipe=0.13);

  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-155-GSK </p>
</html>",
        revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
end CHP_FMB_155_GSK;
