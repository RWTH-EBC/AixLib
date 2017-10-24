within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ReciporatingCompressors.R134a;
model R134a_Reciporating_170
  "Reciporating Compressor - R134a - 170 cm³ - Polynomial"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.Li2013,
    final rotSpeRef = 2000/60,
    final a = {1.223,-0.206,-0.017},
    final b = {1,1,1},
    final c = {0.779,-0.036,0});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end R134a_Reciporating_170;
