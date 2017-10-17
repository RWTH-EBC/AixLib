within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient.SimilitudeTheory;
model Poly_R22R407CR410A_EEV_15_22
  "Polynomial   - Similitude for R22, R407C, R410A - EEV - 1.5 mm to 2.2 mm"
  extends PolynomialFlowCoefficient(
    final polyMod=Choices.PolynomialModels.ShanweiEtAl2005,
    final a={-1.615e4,3.328e-4,1.4465e-3,2.9968e-3,-3.3890e2,7.0925e-5},
    final b={1,1,1,1,1,1},
    final dCle=0.02e-3);

end Poly_R22R407CR410A_EEV_15_22;
