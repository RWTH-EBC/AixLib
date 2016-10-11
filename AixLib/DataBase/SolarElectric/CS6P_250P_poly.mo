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
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>single Area=1,608516m2 </p>
<p><br><h4><span style=\"color: #008000\">References</span></h4></p>
<p>Record for record used with AixLib.Fluid.Solar.Electric.PVsystem</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
</ul></p>
</html>"));
end CS6P_250P_poly;
