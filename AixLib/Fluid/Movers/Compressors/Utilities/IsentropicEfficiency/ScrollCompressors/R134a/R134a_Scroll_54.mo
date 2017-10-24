within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.ScrollCompressors.R134a;
model R134a_Scroll_54
  "Polynomial - R22 - Scroll Compressor - 54.25 cm³"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Choices.IsentropicPolynomialModels.Li2013,
    final rotSpeRef=50,
    final a={1.599,-1.060,0.461},
    final b={1,1,1},
    final c={0.333,1.197,440.393,214,1.047,-0.051,0});

end R134a_Scroll_54;
