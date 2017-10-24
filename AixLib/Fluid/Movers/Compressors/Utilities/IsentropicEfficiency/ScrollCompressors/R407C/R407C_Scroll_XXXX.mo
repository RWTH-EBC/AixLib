within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.ScrollCompressors.R407C;
model R407C_Scroll_XXXX
  "Polynomial - R407C - Scroll Compressor - Unknown displacement volume"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Choices.IsentropicPolynomialModels.Karlsson2007,
    final a={0.926,-0.0823,0.00352,0.00924,-0.000022},
    final b={1,1,1,1,1});

end R407C_Scroll_XXXX;
