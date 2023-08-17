within AixLib.DataBase;
package PhotovoltaicThermal
  "Properties for efficiency of photovoltaic thermal modules"
  extends Modelica.Icons.Package;

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
</html>",   info="<html>
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

  record PhotovoltaicThermalBaseDataDefinitionElectrical
    "Base Data Definition for the electrical part of a photovoltaic thermal collector"
    extends Modelica.Icons.Record;
    parameter Modelica.Units.SI.Efficiency eta_zero(max=1)
      "Conversion factor/Efficiency at Q = 0";
    parameter Real m(unit = "W/(m.m.K)") "gradient of linear approximation";

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
</html>",   info="<html>
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
  end PhotovoltaicThermalBaseDataDefinitionElectrical;

  record ThermalGlazedPVTWithLowEmissionCoating
    "thermal properties of pvt module"
    extends SolarThermalBaseDataDefinition(eta_zero = 0.66091, c1 = 3.824, c2 = 0.0211);
    annotation(Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Derived from the simulated results of a glazed PVT Collector with low-emission coating from this <a href=\"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">thesis</a> p.43 Figure 3.12.</p>
<p><b><span style=\"color: #008000;\">References</span> </b></p>
<p>Record is used in model <a href=\"AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>. </p>
</html>"));
  end ThermalGlazedPVTWithLowEmissionCoating;

  record ThermalGlazedPVTWithoutLowEmissionCoating
    "thermal properties of pvt module"
    extends SolarThermalBaseDataDefinition(eta_zero = 0.65458, c1 = 6.6356, c2 = 0.0235);
    annotation(Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Derived from the simulated results of a glazed PVT Collector without low-emission coating from this <a href=\"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">thesis</a> p.43 Figure 3.12.</p>
<p><b><span style=\"color: #008000;\">References</span> </b></p>
<p>Record is used in model <a href=\"AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>. </p>
</html>"));
  end ThermalGlazedPVTWithoutLowEmissionCoating;

  record ElectricalGlazedPVTWithLowEmissionCoating
    "elecrical properties of pvt module"
    extends PhotovoltaicThermalBaseDataDefinitionElectrical(eta_zero = 0.11819, m = -0.5033);
    annotation(Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Derived from the simulated results of a glazed PVT Collector with low-emission coating from this <a href=\"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">thesis</a> p.43 Figure 3.12.</p>
<p><b><span style=\"color: #008000;\">References</span> </b></p>
<p>Record is used in model <a href=\"AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>. </p>
<p>October 2013, Marcus Fuchs </p>
<ul>
<li>implemented </li>
</ul>
</html>"));
  end ElectricalGlazedPVTWithLowEmissionCoating;

  record ElectricalGlazedPVTWithoutLowEmissionCoating
    "electrical properties of pvt module"
    extends PhotovoltaicThermalBaseDataDefinitionElectrical(eta_zero = 0.8, m=-0.5378);
    annotation(Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Derived from the simulated results of a glazed PVT Collector without low-emission coating from this <a href=\"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">thesis</a> p.43 Figure 3.12.</p>
<p><b><span style=\"color: #008000;\">References</span> </b></p>
<p>Record is used in model <a href=\"AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>. </p>
<p>October 2013, Marcus Fuchs </p>
<ul>
<li>implemented </li>
</ul>
</html>"));
  end ElectricalGlazedPVTWithoutLowEmissionCoating;
end PhotovoltaicThermal;
