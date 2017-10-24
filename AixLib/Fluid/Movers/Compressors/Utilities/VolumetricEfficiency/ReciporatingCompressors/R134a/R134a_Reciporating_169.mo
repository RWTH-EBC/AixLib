within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ReciporatingCompressors.R134a;
model R134a_Reciporating_169
  "Reciporating Compressor - R134a - 169 cm³ - Polynomial"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.DarrAndCrawford1992,
    final a = {0.8889,-1.0025*1e-4,0.8889,-1.0025*1e-4},
    final b = {1,1,1,1});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end R134a_Reciporating_169;
