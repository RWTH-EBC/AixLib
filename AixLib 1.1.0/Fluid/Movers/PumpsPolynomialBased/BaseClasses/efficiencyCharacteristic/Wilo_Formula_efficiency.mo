within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic;
function Wilo_Formula_efficiency "Wilo-formula"
  extends baseEfficiency(
    Q(min=0, max=4.3),
    H(min=0, max=20),
    P(min=0, max=500));
algorithm
  eta := 9.81*Q*H*rho/(P*3600);
  annotation(preferredView="text");
end Wilo_Formula_efficiency;
