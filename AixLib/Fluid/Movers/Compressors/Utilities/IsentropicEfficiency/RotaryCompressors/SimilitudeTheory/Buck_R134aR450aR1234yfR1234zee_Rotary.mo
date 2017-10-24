within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.RotaryCompressors.SimilitudeTheory;
model Buck_R134aR450aR1234yfR1234zee_Rotary
  "Power - Similutude for R134a, R450a, R1234yf, R1234ze(e) - Rotary"
  extends PowerIsentropicEfficiency(
    final MRef=0.102032,
    final rotSpeRef=9.334,
    final powMod=Choices.IsentropicPowerModels.MendozaMirandaEtAl2016,
    final a=0.85,
    final b={0.0753,0.2183,0.0015,0.0972});

end Buck_R134aR450aR1234yfR1234zee_Rotary;
