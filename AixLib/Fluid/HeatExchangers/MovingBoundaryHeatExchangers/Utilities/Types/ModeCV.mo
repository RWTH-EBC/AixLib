within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types;
type ModeCV = enumeration(
    SC
    "Supercooled",
    TP
    "Two-phase",
    SH
    "Superheated",
    SCTP
    "Supercooled - Two-phase",
    TPSH
    "Two-phase - Superheated",
    SCTPSH
    "Supercooled - Two-phase - Superheated")
  "Enumeration to define different kinds of control volumes"
  annotation (Evaluate=true);
