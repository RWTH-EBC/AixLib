within AixLib.DataBase;
package SolarThermal "Properties of different solar thermal collectors"
  extends Modelica.Icons.Package;
  record SolarThermalBaseDataDefinition
    "Base Data Definition for Solar thermal collectors"
    extends Modelica.Icons.Record;

    parameter Real eta_zero "Conversion factor/Efficiency at Q = 0" annotation (Dialog(group="Geometry"));
    parameter Real c1(unit="W/(m.K)") "Loss coefficient c1";
    parameter Real c2(unit="W/(m.m.K)") "Loss coefficient c2";

    annotation (Documentation(revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
<p>April 2014, Mark Wesseling</p>
<p><ul>
<li>corrected Units</li>
</ul></p>
</html>",
        info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This base record defines the values conversion factor and loss coefficients for solar thermal collectors.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
</html>"));
  end SolarThermalBaseDataDefinition;

  record SimpleAbsorber "Properties of a simple absorber"
    extends SolarThermalBaseDataDefinition(
      eta_zero = 0.94,
      c1 = 23,
      c2 = 0);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple Absorber; Values are assumptions; For real values of collectors see <a href=\"http://www.solarenergy.ch/index.php?id=111&no_cache=1\">http://www.solarenergy.ch/index.php?id=111&AMP;no_cache=1</a></p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
</html>",   revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end SimpleAbsorber;

  record AirCollector "Properties of an air collector"
    extends SolarThermalBaseDataDefinition(
      eta_zero = 0.8,
      c1 = 7.5,
      c2 = 0.01);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple Air Collector; Values are assumptions; For real values of collectors see <a href=\"http://www.solarenergy.ch/index.php?id=111&no_cache=1\">http://www.solarenergy.ch/index.php?id=111&AMP;no_cache=1</a></p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
</html>",   revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end AirCollector;

  record FlatCollector "Properties of a flat collector"
    extends SolarThermalBaseDataDefinition(
      eta_zero = 0.8,
      c1 = 5,
      c2 = 0.01);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple Flat collector; Values are assumptions; For real values of collectors see <a href=\"http://www.solarenergy.ch/index.php?id=111&no_cache=1\">http://www.solarenergy.ch/index.php?id=111&AMP;no_cache=1</a></p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
</html>",   revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end FlatCollector;

  record VacuumCollector "Properties of a vacuum collector"
    extends SolarThermalBaseDataDefinition(
      eta_zero = 0.75,
      c1 = 2,
      c2 = 0.005);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple Vacuum Tube Collector; Values are assumptions; For real values of collectors see <a href=\"http://www.solarenergy.ch/index.php?id=111&no_cache=1\">http://www.solarenergy.ch/index.php?id=111&AMP;no_cache=1</a></p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
</html>",   revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end VacuumCollector;

  record ConcentratingCollector "Properties of a CRC collector"
    extends SolarThermalBaseDataDefinition(
      eta_zero = 0.65,
      c1 = 1,
      c2 = 0.004);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple Concentrating Collector; Values are assumptions; For real values of collectors see <a href=\"http://www.solarenergy.ch/index.php?id=111&no_cache=1\">http://www.solarenergy.ch/index.php?id=111&AMP;no_cache=1</a></p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.SolarThermal\">AixLib.HVAC.HeatGeneration.SolarThermal</a>.</p>
</html>",   revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end ConcentratingCollector;
end SolarThermal;
