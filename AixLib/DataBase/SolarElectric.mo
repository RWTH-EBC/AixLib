within AixLib.DataBase;
package SolarElectric "Modelica.Icons.Package"
    extends Modelica.Icons.Package;

  record PV_data
      extends Modelica.Icons.Record;
    parameter Real eta0( min=0, max=1) "maximum efficiency [WK-1m-2]";
    parameter Real Temp_coeff( min=0, max=1) "temperature coeffient in /°C";
    parameter Real NOCT_Temp_Cell "meassured cell temperature in °C";
    parameter Real NOCT_Temp "defined temperature in °C (mostly 25°C)";
    parameter Real NOCT_radiation "defined radiation in W/m2 (1000 W/m2)";
    parameter Real Area "Area of one Panel in m2";

    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base data definition for photovoltaics
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record used with <a href=\"HVAC.Components.Solar_UC.Electric.PVsystem\">HVAC.Components.Solar_UC.Electric.PVsystem</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
  end PV_data;

  record SE6M181_14_panels "SE6M181_14_panels"
  //Polycrystalline Solar Module; single Area= 1,44 m2
    extends PV_data(
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

  record ACS_panel_system
    extends PV_data(
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

  record SchuecoSME1 "SchuecoSME1"
    //Monocrystalline Solar Module Area_one_panel=1,27664m2
    extends PV_data(
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

  record solarmodul_aleo_s_24 "solarmodul_aleo_s_24"
    //Area_one_panel=1,33155m2
    extends PV_data(
      eta0=0.139,
      Temp_coeff=0.0034,
      NOCT_Temp_Cell=47,
      NOCT_Temp=25,
      NOCT_radiation=1000,
      Area=1.33155);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>single Areal=1,33155m2 </p>
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
  end solarmodul_aleo_s_24;

  record CS6P_250P_poly "CS6P_250P_poly"
    //Area_one_panel=1,608516m2
    extends PV_data(
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
end SolarElectric;
