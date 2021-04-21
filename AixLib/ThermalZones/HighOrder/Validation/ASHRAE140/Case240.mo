within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case240
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case220(
    internalGains=200,
    tableCoolOrTempMin=[240,-1246,-415],
    tableHeatOrTempMax=[240,5649,7448]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case240.mos"
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
  Input Specifications of <b>Case 240</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 220:
</p>
<ul>
  <li>Internal Gains = 200 W
  </li>
</ul>
</html>"));
end Case240;
