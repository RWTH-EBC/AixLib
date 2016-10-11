within AixLib.DataBase.SolarElectric;
record CS6P_250P_poly "CS6P_250P_poly"
  //Area_one_panel=1,608516m2
  extends AixLib.DataBase.SolarElectric.PV_data(
    eta0=0.1554,
    Temp_coeff=0.0034,
    NOCT_Temp_Cell=45,
    NOCT_Temp=20,
    NOCT_radiation=800,
    Area=1.608516);
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>single Area=1,608516m2 </p>
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
end CS6P_250P_poly;
