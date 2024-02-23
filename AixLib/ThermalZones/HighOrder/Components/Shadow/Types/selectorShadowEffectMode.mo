within AixLib.ThermalZones.HighOrder.Components.Shadow.Types;
type selectorShadowEffectMode = enumeration(
    constRedDiffAllDir
    "Constant reduce factor for diffuse radiation, considering all direction (infinite shield width)",
    constRedDiffPerpDir
    "Constant reduce factor for diffuse radiation, only considering perpendicular direction as overall factor",
    varRedDiffAsDirRad
    "Variable reduce factor for diffuse radiation, same factor as direct radiation (no diffuse radiation when the shadow is not present)")
  "Enumeration of calculation modes by calculation the shadow effect";
