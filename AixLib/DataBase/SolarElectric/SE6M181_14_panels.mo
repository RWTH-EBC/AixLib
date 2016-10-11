within AixLib.DataBase.SolarElectric;
record SE6M181_14_panels "SE6M181_14_panels"
//Polycrystalline Solar Module; single Area= 1,44 m2
  extends AixLib.DataBase.SolarElectric.PV_data(
    eta0=0.126,
    Temp_coeff=0.0043,
    NOCT_Temp_Cell=46,
    NOCT_Temp=25,
    NOCT_radiation=1000,
    Area=1.44);
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Polycrystalline Solar Module, single Area=1,44 m2 </p>
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
end SE6M181_14_panels;
