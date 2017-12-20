within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types;
type CalculationHeatFlow = enumeration(
    Simplified
    "Simplified - Mean temperature differece",
    LMTD
    "LMTD - Logarithmic mean temperature difference",
    E_NTU
    "Epsilon-NTU - Method of number of transfer units",
    E_NTU_Graeber
    "Epsilon-NTU-Gräber - Method of number of transfer units (simplified)")
  "Enumeration to define methods of calculating heat flows"
  annotation (Evaluate=true);
