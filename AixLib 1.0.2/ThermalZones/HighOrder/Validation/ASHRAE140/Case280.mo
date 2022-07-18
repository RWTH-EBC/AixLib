within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case280
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case270(
    absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01,
    tableCoolOrTempMin=[280,-7114,-4873],
    tableHeatOrTempMax=[280,4675,6148]);

  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case280.mos"
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
  Input Specifications of <b>Case 280</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 270:
</p>
<ul>
  <li>Solar absorptance on interior surface = 0.1
  </li>
</ul>
</html>"));
end Case280;
