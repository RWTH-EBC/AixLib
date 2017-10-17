within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient.SimilitudeTheory;
model Buck_R22R407CR410A_EEV_16_18
  "Buckingham - Similitude for R22, R407C, R410A - EEV - 1.6 mm to 1.8 mm "
  extends PowerFlowCoefficient(
    final powMod=Choices.PowerModels.Li2013,
    final a=1.066,
    final b={0.8006,0.0609},
    final pDifRat=0.84);

end Buck_R22R407CR410A_EEV_16_18;
