within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ReciporatingCompressors.R134a;
model R134a_Reciporating_169
  "Polynomial - R134a - Reciporating Compressor - 169 cm³"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.DarrAndCrawford1992,
    final a = {0.8889,-1.0025*1e-4,-0.8889,1.0025*1e-4},
    final b = {1,1,1,1});

end R134a_Reciporating_169;
