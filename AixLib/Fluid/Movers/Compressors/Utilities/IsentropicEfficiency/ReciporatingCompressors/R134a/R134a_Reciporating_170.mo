within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.ReciporatingCompressors.R134a;
model R134a_Reciporating_170
  "Polynomial - R134a - Reciporating Compressor - 170 cm³"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Choices.IsentropicPolynomialModels.Li2013,
    final rotSpeRef=2000/60,
    final a={0.507,0.606,-0.113},
    final b={1,1,1},
    final c={1.140,0.295,447.050,350,0.779,-0.036,0});

end R134a_Reciporating_170;
