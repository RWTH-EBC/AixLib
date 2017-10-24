within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.ReciporatingCompressors.R134a;
model R134a_Reciporating_169
  "Reciporating Compressor - R134a - 169 cm³ - Polynomial"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Choices.IsentropicPolynomialModels.DarrAndCrawford1992,
    final a={0.8405,-4.8711*1e-5,-0.1105},
    final b={1,1,1});

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
