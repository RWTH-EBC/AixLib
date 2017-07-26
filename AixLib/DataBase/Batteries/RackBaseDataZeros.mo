within AixLib.DataBase.Batteries;
record RackBaseDataZeros
  "Battery Rack with 78 Batteries (Lead Batteries) not stacked and standing at one wall"
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
