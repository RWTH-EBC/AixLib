within AixLib.ThermalZones.HighOrder.Components.Types;
type CalcMethodRadiativeHeatTransfer = enumeration(
    No_approx
        "No approx",
    Linear_wall_temp
        "Linear approx at wall temp",
    Linear_rad_temp
        "Linear approx at rad temp",
    Linear_constant_T_ref
        "Linear approx at constant T_ref")
  "Calculation method for radiation heat transfer";
