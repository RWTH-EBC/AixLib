within AixLib.DataBase.SolarElectric;
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
