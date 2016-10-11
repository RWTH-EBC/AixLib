within DataBase.Solar.Electric;
record ACS_panel_system
  extends DataBase.Solar.Electric.PV_data(
    eta0=0.176,
    Temp_coeff=0.003,
    NOCT_Temp_Cell=45,
    NOCT_Temp=25,
    NOCT_radiation=1000,
    Area=22.63);
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>ACS panel system </p>
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
end ACS_panel_system;
