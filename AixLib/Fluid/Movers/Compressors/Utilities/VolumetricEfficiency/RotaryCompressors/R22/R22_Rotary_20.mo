within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.RotaryCompressors.R22;
model R22_Rotary_20
  "Polynomial - R22 - Rotary Compressor - 20.7 cm³"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.Li2013,
    final rotSpeRef = 60,
    final a = {0.709,0.416,-0.125},
    final b = {1,1,1},
    final c = {1.083,-0.077,0});

end R22_Rotary_20;
