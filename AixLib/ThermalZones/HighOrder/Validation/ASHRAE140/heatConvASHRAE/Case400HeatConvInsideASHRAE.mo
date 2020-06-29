within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case400HeatConvInsideASHRAE
  extends Case600HeatConvInsideASHRAE(
                 Room(
      solar_absorptance_OW=0.1,
    outerWall_South( windowSimple(redeclare model correctionSolarGain =
            Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoTransmittance),
      use_shortWaveRadIn=false,
      use_shortWaveRadOut=false,
      solar_absorptance=0.1),
    ceiling(use_shortWaveRadIn=false, solar_absorptance=0.1),
    outerWall_West(use_shortWaveRadIn=false, solar_absorptance=0.1),
    outerWall_North(use_shortWaveRadIn=false, solar_absorptance=0.1),
    outerWall_East(use_shortWaveRadIn=false, solar_absorptance=0.1),
    floor(use_shortWaveRadIn=false)),
    TransmittedRad(y=0),
    Source_InternalGains(k=0),
    AirExchangeRate(k=0));
end Case400HeatConvInsideASHRAE;
