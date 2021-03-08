within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case420
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case410(
    internalGains=200,
    tableCoolOrTempMin=[420,-189,-11],
    tableHeatOrTempMax=[420,7298,9151]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case420.mos"
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
  Input Specifications of <b>Case 420</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 410:
</p>
<ul>
  <li>Internal Gains = 200 W
  </li>
</ul>
</html>"));
end Case420;
