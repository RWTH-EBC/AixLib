within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case270
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case220(
    redeclare model CorrSolarGainWin = Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_ASHRAE140,
    absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs09,
    ReferenceHeatingLoad(table=[270,4510,5920]),
    ReferenceCoolingLoad(table=[270,-10350,-7528]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case270.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(revisions="<html><ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 220:
</p>
<ul>
  <li>Window according to ASHRAE
  </li>
  <li>Solar absorptance on exterior surface = 0.1
  </li>
  <li>Solar absorptance on exterior surface = 0.9
  </li>
</ul>
</html>"));
end Case270;
