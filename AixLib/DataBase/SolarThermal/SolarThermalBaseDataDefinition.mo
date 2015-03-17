within AixLib.DataBase.SolarThermal;
record SolarThermalBaseDataDefinition
  "Base Data Definition for Solar thermal collectors"
  extends Modelica.Icons.Record;
  parameter Real eta_zero "Conversion factor/Efficiency at Q = 0" annotation(Dialog(group = "Geometry"));
  parameter Real c1(unit = "W/(m.K)") "Loss coefficient c1";
  parameter Real c2(unit = "W/(m.m.K)") "Loss coefficient c2";
  annotation(Documentation(revisions = "<html>
 <p>October 2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 <p>April 2014, Mark Wesseling</p>
 <ul>
 <li>corrected Units</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This base record defines the values conversion factor and loss coefficients for solar thermal collectors.</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
 </html>"));
end SolarThermalBaseDataDefinition;
