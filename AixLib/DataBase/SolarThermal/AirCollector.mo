within AixLib.DataBase.SolarThermal;
record AirCollector "Properties of an air collector"
  extends SolarThermalBaseDataDefinition(eta_zero = 0.8, c1 = 7.5, c2 = 0.01);
  annotation(Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple Air Collector; Values are assumptions; For real values of
  collectors see <a href=
  \"http://www.solarenergy.ch/index.php?id=111&amp;no_cache=1\">http://www.solarenergy.ch/index.php?id=111&amp;no_cache=1</a>
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>.
</p>
<p>
  October 2013, Marcus Fuchs
</p>
<ul>
  <li>implemented
  </li>
</ul>
</html>"));
end AirCollector;
