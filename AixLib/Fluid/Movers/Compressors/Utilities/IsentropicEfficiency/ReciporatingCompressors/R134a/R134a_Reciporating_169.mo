within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.ReciporatingCompressors.R134a;
model R134a_Reciporating_169
  "Polynomial - R134a - Reciporating Compressor - 169 cm³"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Choices.IsentropicPolynomialModels.DarrAndCrawford1992,
    final a={0.8405,-4.8711*1e-5,-0.1105},
    final b={1,1,1});

end R134a_Reciporating_169;
