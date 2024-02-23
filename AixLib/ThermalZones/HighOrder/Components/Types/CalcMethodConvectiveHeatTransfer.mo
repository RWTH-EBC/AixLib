within AixLib.ThermalZones.HighOrder.Components.Types;
type CalcMethodConvectiveHeatTransfer = enumeration(
    DIN_6946
        "DIN 6946",
    ASHRAE_Fundamentals
        "ASHRAE Fundamentals",
    Custom_hCon
        "Custom hCon (constant)")
  "Calculation method for convective heat transfer coefficient at outside surface";
