within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ScrollCompressors.R407C;
model R407C_Scroll_XXXX
  "Scroll Compressor - R407C - Unknown displacement volume - Polynomial"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.Karlsson2007,
    final a = {0.0012, -0.088, 1.1262, -0.0045, 0.0039, -0.000025},
    final b = {1,1,1,1,1,1});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end R407C_Scroll_XXXX;
