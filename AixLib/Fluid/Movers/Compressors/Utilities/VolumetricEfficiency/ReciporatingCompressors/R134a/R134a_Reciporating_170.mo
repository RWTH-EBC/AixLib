within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.ReciporatingCompressors.R134a;
model R134a_Reciporating_170
  "Polynomial - R134a - Reciporating Compressor - 170 cm³"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Choices.VolumetricPolynomialModels.Li2013,
    final rotSpeRef = 2000/60,
    final a = {1.223,-0.206,-0.017},
    final b = {1,1,1},
    final c = {0.779,-0.036,0});

end R134a_Reciporating_170;
