within AixLib.DataBase.SolarThermal;
record SolarThermalBaseDataDefinition
  "Base Data Definition for Solar thermal collectors"
  extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.Efficiency eta_zero(max=1)
    "Conversion factor/Efficiency at Q = 0";
  parameter Real c1(unit = "W/(m.m.K)") "Loss coefficient c1";
  parameter Real c2(unit = "W/(m.m.K.K)") "Loss coefficient c2";
  annotation(Documentation(revisions="<html><ul>
  <li>
    <i>October 25, 2016</i> by Philipp Mehrfeld:<br/>
    correct units
  </li>
  <li>
    <i>April 2014</i>, Mark Wesseling:<br/>
    corrected Units
  </li>
  <li>
    <i>October 2013</i>, Marcus Fuchs:<br/>
    implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This base record defines the values conversion factor and loss
  coefficients for solar thermal collectors.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record to be used in model <a href=
  \"AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>.
</p>
</html>"));
end SolarThermalBaseDataDefinition;
