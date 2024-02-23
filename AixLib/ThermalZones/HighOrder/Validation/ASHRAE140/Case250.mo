within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case250
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case220(
    solar_absorptance_OW=0.9,
    tableCoolOrTempMin=[250,-3380,-2177],
    tableHeatOrTempMax=[250,4751,7024]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case250.mos"
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
  Input Specifications of <b>Case 250</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 220:
</p>
<ul>
  <li>Solar absorptance on exterior surface = 0.9
  </li>
</ul>
<h4>
  Limitations
</h4>
<p>
  The simulated annual cooling load of <b>Case 250</b> cannot meet the
  statistical acceptance ranges given by ASHRAE140 (01.01.2021).<br/>
  However, cases that do not perform according to the reference values
  should not be considered erroneous. They shall be used as indication
  for debugging purposes instead.
</p>
</html>"));
end Case250;
