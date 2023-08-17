within AixLib.DataBase.PhotovoltaicThermal;
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
