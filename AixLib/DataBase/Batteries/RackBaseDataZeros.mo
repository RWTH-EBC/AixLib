within AixLib.DataBase.Batteries;
record RackBaseDataZeros
  "Rack with no batteries inside"
  import AixLib;
  extends AixLib.DataBase.Batteries.RackBaseDataDefinition(
    batType=AixLib.DataBase.Batteries.LeadBattery1(),
    nParallels=0,
    nSeries=0,
    nStacked=0,
    airBetweenStacks=false,
    batArrangement=true,
    areaStandingAtWall=0);

end RackBaseDataZeros;
