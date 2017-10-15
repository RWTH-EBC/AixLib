within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient.R134a;
model R134a_EEV_15
  "Polynomial - R134a - EEV - 1.5 mm"
  extends PowerFlowCoefficient(
    final powMod=Choices.PowerModels.ZhifangAndOu2008,
    final a = 1.1868e-13,
    final b = {-1.4347, 3.6426});

end R134a_EEV_15;
