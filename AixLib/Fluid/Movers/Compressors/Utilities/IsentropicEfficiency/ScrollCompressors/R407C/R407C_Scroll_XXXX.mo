within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.ScrollCompressors.R407C;
model R407C_Scroll_XXXX
  "Scroll Compressor - R407C - Unknown displacement volume - Polynomial"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Types.IsentropicPolynomialModels.Karlsson2007,
    final a={0.926,-0.0823,0.00352,0.00294,-0.000022},
    final b={1,1,1,1,1});

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
