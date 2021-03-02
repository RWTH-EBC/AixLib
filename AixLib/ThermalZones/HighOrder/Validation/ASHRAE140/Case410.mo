within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case410
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case400(
    airExchange=0.41,
    tableCoolOrTempMin=[410,-84,0],
    tableHeatOrTempMax=[410,8596,10506]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case410.mos"
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
  Input Specifications of <b>Case 410</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 400:
</p>
<ul>
  <li>Air Exchange Rate = 0.41
  </li>
</ul>
</html>"));
end Case410;
