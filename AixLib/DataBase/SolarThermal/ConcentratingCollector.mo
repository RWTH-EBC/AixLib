within AixLib.DataBase.SolarThermal;
record ConcentratingCollector "Properties of a CRC collector"
  extends SolarThermalBaseDataDefinition(eta_zero = 0.65, c1 = 1, c2 = 0.004);
  annotation(Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple Concentrating Collector; Values are assumptions; For real
  values of collectors see <a href=
  \"http://www.solarenergy.ch/index.php?id=111&amp;no_cache=1\">http://www.solarenergy.ch/index.php?id=111&amp;no_cache=1</a>
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"AixLib.Fluid.Solar.Thermal.SolarThermal\">AAixLib.Fluid.Solar.Thermal.SolarThermal</a>.
</p>
<p>
  October 2013, Marcus Fuchs
</p>
<ul>
  <li>implemented
  </li>
</ul>
</html>"));
end ConcentratingCollector;
