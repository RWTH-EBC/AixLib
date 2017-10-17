within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient.SimilitudeTheory;
model Buck_R22R407CR410A_EEV_15_22
  "Buckingham - Similitude for R22, R407C, R410A - EEV - 1.5 mm to 2.2 mm "
  extends PowerFlowCoefficient(
    final powMod=Choices.PowerModels.ShanweiEtAl2005,
    final a=0.2343,
    final b={0.0281,0.0260,-0.0477,-0.1420,-0.1291},
    final dCle=0.02e-3);

end Buck_R22R407CR410A_EEV_15_22;
