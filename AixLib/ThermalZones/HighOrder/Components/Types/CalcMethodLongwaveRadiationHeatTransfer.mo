within AixLib.ThermalZones.HighOrder.Components.Types;
type CalcMethodLongwaveRadiationHeatTransfer = enumeration(
    No_Approx
        "No approx",
    Linear_Wall
        "Linear approx at wall temp",
    Linear_Rad
        "Linear approx at rad temp",
    Linear_Constant_Tref
        "Linear approx at constant T_ref")
  "Calculation method for longwave radiation heat transfer";
