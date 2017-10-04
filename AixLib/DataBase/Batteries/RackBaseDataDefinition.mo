within AixLib.DataBase.Batteries;
record RackBaseDataDefinition
  "Base Data Definition for the different battery rooms"
  import AixLib;
  extends Modelica.Icons.Record;
  inner parameter AixLib.DataBase.Batteries.BatteryBaseDataDefinition batType
    "Battery Type in the Rack"
    annotation (Dialog(tab="Battery Rack Types"), choicesAllMatching);
  parameter Integer nParallels "Number of batteries placed in one Series";
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

end RackBaseDataDefinition;
