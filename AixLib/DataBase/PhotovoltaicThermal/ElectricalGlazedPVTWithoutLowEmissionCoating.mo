within AixLib.DataBase.PhotovoltaicThermal;
record ElectricalGlazedPVTWithoutLowEmissionCoating
  "electrical properties of pvt module"
  extends PhotovoltaicThermalBaseDataDefinitionElectrical(eta_zero = 0.8, m=-0.5378);
  annotation(Documentation(info="<html><h4>
  Overview
</h4>
<p>
  Derived from the simulated results of a glazed PVT Collector without
  low-emission coating from this <a href=
  \"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">
  thesis</a> p.43 Figure 3.12.
</p>
<h4>
  References
</h4>
<p>
  Record is used in model <a href=
  \"modelica://AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal\">AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal</a>.
</p>
<p>
  September 2023, Philipp Schmitz, Fabian Wüllhorst
</p>
<ul>
  <li>implemented
  </li>
</ul>
</html>"));
end ElectricalGlazedPVTWithoutLowEmissionCoating;
