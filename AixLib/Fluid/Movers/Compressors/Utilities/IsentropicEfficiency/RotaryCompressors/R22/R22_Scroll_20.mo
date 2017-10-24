within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.RotaryCompressors.R22;
model R22_Scroll_20
  "Polynomial - R22 - Rotary Compressor - 20.7 cm³"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Choices.IsentropicPolynomialModels.Li2013,
    final rotSpeRef=60,
    final a={1.870,-1.418,0.548},
    final b={1,1,1},
    final c={0.527,0.852,19.146,115,1.083,-0.077,0});

end R22_Scroll_20;
