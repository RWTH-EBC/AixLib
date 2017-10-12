within AixLib.DataBase.Batteries;
record RackBaseDataDefinition
  "Base data definition for the different battery racks"
  import AixLib;
  extends Modelica.Icons.Record;
  parameter AixLib.DataBase.Batteries.BatteryBaseDataDefinition batType
    "Battery type in the rack"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  parameter Integer nParallel "Number of batteries placed in one series";
  parameter Integer nSeries "Number of battery series";
  parameter Integer nStacked "Number of batteries stacked on another";
  parameter Boolean airBetweenStacks
    "Is there a gap between the stacks (nStacked>1)?"
    annotation (Dialog(descriptionLabel=true), choices(
      choice=true "Yes",
      choice=false "No",
      radioButtons=true));
  parameter Boolean batArrangement
    "How are the batteries touching each other?"
    annotation (Dialog(descriptionLabel=true), choices(
      choice=true "Longer sides touch each other in one row",
      choice=false "Shorter sides touch each other in one row",
      radioButtons=true));
  parameter Modelica.SIunits.Area areaStandingAtWall
    "default=0, area of the rack, which is placed at the wall, so there 
    is no vertical heat convection.";

annotation (
    Documentation(info="<html>
    <p><b><font style=\"color: #008000; \">Overview</font></b> </p>
    <p>This record is the base data definition for the parameters of
    a battery rack. </p>
    <p><b><font style=\"color: #008000; \">References</font></b> </p>
    <p><a href=\"AixLib.DataBase.Batteries.BatteryBaseDataDefinition\">
    AixLib.DataBase.Batteries.BatteryBaseDataDefinition</a></p>
    </html>",  revisions="<html>
    <ul>
    <li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
    </ul>
    </html>"));
end RackBaseDataDefinition;
