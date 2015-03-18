within AixLib.DataBase.SolarThermal;


record ConcentratingCollector "Properties of a CRC collector"
  extends SolarThermalBaseDataDefinition(eta_zero = 0.65, c1 = 1, c2 = 0.004);
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple Concentrating Collector; Values are assumptions; For real values of collectors see <a href=\"http://www.solarenergy.ch/index.php?id=111&no_cache=1\">http://www.solarenergy.ch/index.php?id=111&AMP;no_cache=1</a></p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
 </html>", revisions = "<html>
 <p>October 2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"));
end ConcentratingCollector;
