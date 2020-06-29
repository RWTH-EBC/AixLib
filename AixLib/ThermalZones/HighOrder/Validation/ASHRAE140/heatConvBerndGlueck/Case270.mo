within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvBerndGlueck;
model Case270
  extends heatConvBerndGlueck.Case220(
                  Room(outerWall_South(
        use_shortWaveRadIn=true,
        use_shortWaveRadOut=true,
      calcMethodIn=2,
                    heatTransfer_Outside(calcMethod=2), windowSimple(redeclare
            model correctionSolarGain =
            Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_ASHRAE140),
      Wall(
        surfaceOrientation=1,
        calcMethod=2,
           heatConv(calcMethod=2, surfaceOrientation=1))),
      absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs09,
      ceiling(use_shortWaveRadIn=true),
      outerWall_West(use_shortWaveRadIn=true),
      outerWall_North(use_shortWaveRadIn=true),
      outerWall_East(use_shortWaveRadIn=true),
      floor(use_shortWaveRadIn=true)));

end Case270;
