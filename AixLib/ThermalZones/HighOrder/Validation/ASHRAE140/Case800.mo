within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case800
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case430(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    tableCoolOrTempMin=[800,-325,-55],
    tableHeatOrTempMax=[800,4868,7228]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case800.mos"
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
  Input Specifications of <b>Case 800</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 430:
</p>
<ul>
  <li>high mass exterior vertical walls and floor
  </li>
</ul>
</html>
"));
end Case800;
