within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ScrollCompressors.R407C;
model R407C_Scroll_XXXX
  "Polynomial - R407C - Scroll Compressor - Unknown displacement volume"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.Karlsson2007,
    final a = {0.0012, -0.088, 1.1262, -0.0045, 0.0039, -0.000025},
    final b = {1,1,1,1,1,1});

end R407C_Scroll_XXXX;
