within AixLib.DataBase.PhotovoltaicThermal;
record PhotovoltaicThermalBaseDataDefinitionElectrical
  "Base Data Definition for the electrical part of a photovoltaic thermal collector"
  extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.Efficiency eta_zero(max=1)
    "Conversion factor/Efficiency at Q = 0";
  parameter Real m(unit = "W/(m.m.K)") "gradient of linear approximation";

  annotation(Documentation(revisions="<html><ul>
  <p>
    September 2023, Philipp Schmitz, Fabian Wüllhorst
  </p>
  <ul>
    <li>implemented
    </li>
  </ul>
</ul>
</html>", info="<html><h4>
  Overview
</h4>
<p>
  This base record defines the values conversion factor and loss
  coefficients for solar thermal collectors.
</p>
<h4>
  References
</h4>
<p>
  Base data definition for record to be used in model <a href=
  \"modelica://AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal\">AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal</a>.
</p>
</html>"));
end PhotovoltaicThermalBaseDataDefinitionElectrical;
