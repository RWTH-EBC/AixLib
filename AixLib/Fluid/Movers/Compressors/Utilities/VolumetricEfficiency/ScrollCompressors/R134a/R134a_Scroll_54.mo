within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ScrollCompressors.R134a;
model R134a_Scroll_54
  "Polynomial - R134a - Scroll Compressor - 54.24 cm³"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.Li2013,
    final rotSpeRef = 50,
    final a = {0.693,0.543,-0.236},
    final b = {1,1,1},
    final c = {1.047,-0.051,0});

end R134a_Scroll_54;
