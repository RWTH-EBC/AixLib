within AixLib.DataBase.SolarElectric;
record solarmodul_aleo_s_24 "solarmodul_aleo_s_24"
  //Area_one_panel=1,33155m2
  extends AixLib.DataBase.SolarElectric.PVBaseRecord(
    Eta0=0.139,
    TempCoeff=0.0034,
    NoctTempCell=47,
    NoctTemp=25,
    NoctRadiation=1000,
    Area=1.33155);
  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>single Areal=1,33155m2 </p>
<p><br><h4><span style=\"color: #008000\">References</span></h4></p>
<p>
Record for record used with 
<a href=\"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">
AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end solarmodul_aleo_s_24;
