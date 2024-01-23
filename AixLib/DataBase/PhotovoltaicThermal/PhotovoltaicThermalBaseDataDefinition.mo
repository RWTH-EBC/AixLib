within AixLib.DataBase.PhotovoltaicThermal;
record PhotovoltaicThermalBaseDataDefinition
  "Base Data Definition for photovoltaic thermal collectors"
  extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.Efficiency etaThe_zero(max=1)
    "Conversion factor/Efficiency at Q = 0 for thermal efficiency";
  parameter Real c1The(unit = "W/(m.m.K)")
    "Loss coefficient c1 for thermal efficiency";
  parameter Real c2The(unit = "W/(m.m.K.K)")
    "Loss coefficient c2 for thermal efficiency";
  parameter Modelica.Units.SI.Efficiency etaEle_zero(max=1)
    "Conversion factor/Efficiency at Q = 0 for electrical efficiency";
  parameter Real mEle(unit = "W/(m.m.K)")
    "Gradient of electrical efficiency linear approximation";
  annotation(Documentation(revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>", info="<html>
<h4>
  Overview
</h4>
<p>
  This record extends the solar thermal collectors records and
  adds efficieny curves for the electrical part to enable a 
  model of a photovoltaic thermal collector
</p>
<h4>
  References
</h4>
<p>
  Record is used in model <a href=
  \"modelica://AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal\">AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal</a>.
</p>
</html>"));
end PhotovoltaicThermalBaseDataDefinition;
