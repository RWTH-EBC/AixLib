within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ScrollCompressors.R134a;
model R134a_Scroll_54
  "Scroll Compressor - R134a - 54.24 cm³ - Polynomial "
  extends PolynomialVolumetricEfficiency(
    final polyMod=Types.VolumetricPolynomialModels.Li2013,
    final rotSpeRef=50,
    final a={0.693,0.543,-0.236},
    final b={1,1,1},
    final c={1.047,-0.051,0});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end R134a_Scroll_54;
