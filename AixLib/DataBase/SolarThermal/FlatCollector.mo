within AixLib.DataBase.SolarThermal;
record FlatCollector "Properties of a flat collector"
  extends SolarThermalBaseDataDefinition(eta_zero = 0.8, c1 = 5, c2 = 0.01);
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple Flat collector; Values are assumptions; For real values of collectors see <a href=\"http://www.solarenergy.ch/index.php?id=111&no_cache=1\">http://www.solarenergy.ch/index.php?id=111&AMP;no_cache=1</a></p>
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
end FlatCollector;

