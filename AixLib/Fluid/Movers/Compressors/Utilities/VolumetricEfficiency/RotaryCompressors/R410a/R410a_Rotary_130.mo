within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.RotaryCompressors.R410a;
model R410a_Rotary_130
  "Polynomial - R410a - Rotary Compressor - 130 cm³"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.Koerner2017,
    final a = {1.108},
    final b = {-0.165});

end R410a_Rotary_130;
