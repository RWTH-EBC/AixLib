within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case810
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case900(
    absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01,
    tableCoolOrTempMin=[810,-1711,-1052],
    tableHeatOrTempMax=[810,1839,3004]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case810.mos"
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
  Input Specifications of <b>Case 810</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 900:
</p>
<ul>
  <li>Solar absorptance on interior surface = 0.1
  </li>
</ul>
</html>"));
end Case810;
