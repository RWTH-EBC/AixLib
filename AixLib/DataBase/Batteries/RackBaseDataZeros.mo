within AixLib.DataBase.Batteries;
record RackBaseDataZeros
  "Rack with no batteries inside"
  import AixLib;
  extends AixLib.DataBase.Batteries.RackBaseDataDefinition(
    batType=AixLib.DataBase.Batteries.LeadBattery1(),
    nParallel=0,
    nSeries=0,
    nStacked=0,
    airBetweenStacks=false,
    batArrangement=true,
    areaStandingAtWall=0);
annotation (
    Documentation(info="<html>
    <p><b><font style=\"color: #008000; \">Overview</font></b> </p>
    <p>This record is an example for the RackBaseDataDefinition. It is meant
    to be put in the battery rack as a base case for the different battery 
    parameters.</p>
    <p><b><font style=\"color: #008000; \">References</font></b> </p>
    <p><a href=\"AixLib.DataBase.Batteries.RackBaseDataDefinition\">
    AixLib.DataBase.Batteries.RackBaseDataDefinition</a></p>
    </html>",  revisions="<html>
    <ul>
    <li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
    </ul>
    </html>"));
end RackBaseDataZeros;
