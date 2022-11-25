within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case920
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case620(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    tableCoolOrTempMin=[920,-3092,-1840],
    tableHeatOrTempMax=[920,3313,4300]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case920.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  Input Specifications of <b>Case 920</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 900:
</p>
<ul>
  <li>no windows on south side. two windows, one facing east, one
  facing west, each with a surface of 6m2.
  </li>
</ul>
</html>", revisions="<html><ul>
<ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    Implemented
  </li>
</ul>
</html>"));
end Case920;
