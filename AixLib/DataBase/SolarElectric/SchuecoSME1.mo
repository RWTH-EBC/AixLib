within AixLib.DataBase.SolarElectric;
record SchuecoSME1 "SchuecoSME1"
  //Monocrystalline Solar Module Area_one_panel=1,27664m2
  extends AixLib.DataBase.SolarElectric.PV_data(
    eta0=0.147,
    Temp_coeff=0.0037,
    NOCT_Temp_Cell=45,
    NOCT_Temp=20,
    NOCT_radiation=800,
    Area=1.27664);
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Monocrystalline Solar Module, single Area=1,27664m2 </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record for record used with <a href=\"HVAC.Components.Solar_UC.Electric.PVsystem\">HVAC.Components.Solar_UC.Electric.PVsystem</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end SchuecoSME1;
