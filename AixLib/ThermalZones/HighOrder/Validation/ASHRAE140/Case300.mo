within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case300
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case620(
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_ASHRAE140,
    absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs09,
    internalGains=0,
    TsetHeater=19.9,
    TsetCooler=20,
    airExchange=0,
    tableCoolOrTempMin=[300,-7100,-4302],
    tableHeatOrTempMax=[300,4761,5964]);

  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case300.mos"
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
  Input Specifications of <b>Case 300</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 270:
</p>
<ul>
  <li>no windows on south side. two windows, one facing east, one
  facing west, each with a surface of 6m2.
  </li>
</ul>
</html>"));
end Case300;
