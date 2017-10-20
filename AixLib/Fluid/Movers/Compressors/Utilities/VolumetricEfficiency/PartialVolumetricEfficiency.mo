within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency;
partial model PartialVolumetricEfficiency
  "Based model used by all models describing volumetric efficiencies"
  extends BaseClasses.PartialEfficiency;

  // Definition of outputs
  //
  output Modelica.SIunits.Efficiency lamH(min=0, max=1, nominal= 0.9)
    "Overall volumetric efficiency";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end PartialVolumetricEfficiency;
