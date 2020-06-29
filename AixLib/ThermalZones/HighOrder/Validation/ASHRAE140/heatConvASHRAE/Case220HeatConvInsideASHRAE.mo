within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case220HeatConvInsideASHRAE
  extends Case600HeatConvInsideASHRAE(
    AirExchangeRate(k=0),
    Source_InternalGains(k=0),
    Room(redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 Type_Win,
    outerWall_South(windowSimple(redeclare model correctionSolarGain =
            Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoTransmittance)),
        solar_absorptance_OW=0.1),
    Tset_Cooler(k=20.0001),
    TSet_Heater(k=19.9999));
end Case220HeatConvInsideASHRAE;
