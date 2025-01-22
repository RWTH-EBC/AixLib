within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case230
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case220(
    airExchange=0.822,
    tableCoolOrTempMin=[230,-1139,-454],
    tableHeatOrTempMax=[230,10376,12243]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case230.mos"
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
  Input Specifications of <b>Case 230</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 220:
</p>
<ul>
  <li>Air Exchange Rate = 0.822
  </li>
</ul>
</html>"));
end Case230;
