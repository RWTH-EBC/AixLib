within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types;
type TypeHX = enumeration(
    DirectCurrent
    "Direct-current heat exchanger",
    CounterCurrent
    "Counter-current heat exchanger")
  "Enumeration to define types of heat exchangers"
  annotation (Evaluate=true);
