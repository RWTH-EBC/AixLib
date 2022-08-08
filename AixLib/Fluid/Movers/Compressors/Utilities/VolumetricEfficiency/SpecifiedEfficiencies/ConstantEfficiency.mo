within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies;
model ConstantEfficiency
  "General model that describes a constant overall volumetric efficiency"
  extends PartialVolumetricEfficiency;

  // Definition of parameters
  //
  parameter Modelica.Units.SI.Efficiency lamHCon=0.9
    "Constant overall volumetric efficiency";

equation
  // Calculate overall volumetric efficiency
  //
  lamH = lamHCon "Allocation of constant overall volumetric efficiency";

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a simple calculation procedure for volumetric
  efficiency models (for more information, please check out <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>).
  The model provides a constant overall volumetric efficiency and is
  the most basic engine efficiency model.
</p>
</html>"));
end ConstantEfficiency;
