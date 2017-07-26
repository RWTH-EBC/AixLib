within AixLib.DataBase.Batteries.BatteryRacks;
record Lead1_Rack74
  "Battery Rack with 74 Batteries (Lead Batteries) not stacked and standing at one wall"
  extends BatteryTypes.RackBaseDataZeros(
    BatType = AixLib.DataBase.Batteries.BatteryTypes.LeadBattery1(),
    nParallels = 37,
    nSeries = 2,
    nStacked = 1,
    AirBetweenStacks = false,
    BatArrangement = true,
    AreaStandingAtWall = 2*BatType.width*BatType.height)
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example Building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Cities.TypeBuilding\">Cities.TypeBuilding</a> and <a href=\"Cities.HouseMultizone\">Cities.HouseMultizone</a></p>
<p>Source: </p>
<ul>
<li>Project &QUOT;EnEff:Campus&QUOT;, 2014</li>
</ul>
</html>"));

end Lead1_Rack74;
