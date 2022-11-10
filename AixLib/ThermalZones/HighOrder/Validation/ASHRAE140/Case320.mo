within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case320
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case270(
    TsetHeater=20,
    TsetCooler=27,
    tableCoolOrTempMin=[320,-7304,-5061],
    tableHeatOrTempMax=[320,3859,5141]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case320.mos"
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
  Input Specifications of <b>Case 320</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 270:
</p>
<ul>
  <li>Heat = ON if temperature &lt; 20°C
  </li>
  <li>Cool = ON if temperature &lt; 27°C
  </li>
</ul>
</html>"));
end Case320;
