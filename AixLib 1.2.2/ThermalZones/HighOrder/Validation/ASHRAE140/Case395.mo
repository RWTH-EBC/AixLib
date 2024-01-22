within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case395
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case400(
    Win_Area=0.001,
    airExchange=0,
    tableCoolOrTempMin=[395,-18,0],
    tableHeatOrTempMax=[395,4799,5835]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case395.mos"
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
  Input Specifications of <b>Case 395</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 400:
</p>
<ul>
  <li>no window
  </li>
</ul>
<h4>
  Limitations
</h4>
<p>
  The simulated annual heating load of <b>Case 395</b> cannot meet the
  statistical acceptance ranges given by ASHRAE140 (01.01.2021).<br/>
  However, cases that do not perform according to the reference values
  should not be considered erroneous. They shall be used as indication
  for debugging purposes instead.
</p>
</html>"));
end Case395;
