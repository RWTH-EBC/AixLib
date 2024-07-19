within AixLib.ThermalZones.HighOrder.Components.Types;
type CalcMethodConvectiveHeatTransferInsideSurface = enumeration(
    EN_ISO_6946_Appendix_A
        "EN ISO 6946 Appendix A >>Flat Surfaces<<",
    Bernd_Glueck
        "By Bernd Glueck",
    Custom_hCon
        "Custom hCon (constant)",
    ASHRAE140_2017
        "ASHRAE140-2017")
  "Calculation method for convective heat transfer coefficient at inside surface";
