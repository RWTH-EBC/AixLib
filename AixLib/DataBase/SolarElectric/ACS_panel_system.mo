within AixLib.DataBase.SolarElectric;
record ACS_panel_system
  extends AixLib.DataBase.SolarElectric.PV_data(
    eta0=0.176,
    Temp_coeff=0.003,
    NOCT_Temp_Cell=45,
    NOCT_Temp=25,
    NOCT_radiation=1000,
    Area=22.63);
  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>ACS panel system </p>
<p><br><h4><span style=\"color: #008000\">References</span></h4></p>
<p>
Record for record used with 
<a href=\"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">
AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
</ul></p>
</html>"));
end ACS_panel_system;
