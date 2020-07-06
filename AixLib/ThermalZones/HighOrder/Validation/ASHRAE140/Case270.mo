within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case270
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case220(
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
      floor(use_shortWaveRadIn=true)),
    ReferenceHeatingLoad(table=[270,4510,5920]),
    ReferenceCoolingLoad(table=[270,-10350,-7528]));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 220: </p>
<ul>
<li> Window according to ASHRAE</li>
<li> Solar absorptance on exterior surface = 0.1</li>
<li> Solar absorptance on exterior surface = 0.9</li>
</ul>
</ul>
</ul>
</html>"));
end Case270;
