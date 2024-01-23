within AixLib.DataBase.PhotovoltaicThermal;
record ThermalGlazedWithLowEmissionCoating
  "Glazed PVT Collector with low emission coating"
  extends PhotovoltaicThermalBaseDataDefinition(
    etaEle_zero=0.11819,
    mEle=0.5033,
    etaThe_zero=0.66091,
    c1The=3.824,
    c2The=0.0211);
  annotation(Documentation(info="<html><h4>
  Overview
</h4>
<p>
  Derived from the simulated results of a glazed PVT Collector with
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
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>"));
end ThermalGlazedWithLowEmissionCoating;
