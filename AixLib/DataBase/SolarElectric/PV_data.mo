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
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition for photovoltaics </p>
<p><br><h4><span style=\"color: #008000\">References</span></h4></p>
<p>Base data definition for record used with AixLib.Fluid.Solar.Electric.PVsystem</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>September 01, 2014&nbsp;</i> by Xian Wu:<br/>Added documentation and formatted appropriately</li>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
</ul></p>
</html>"));
end PV_data;
