within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case900FF
  extends Case600FF(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    ReferenceTempMax(table=[900,41.8,44.8]),
    ReferenceTempMin(table=[900,-6.4,-1.6]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case900FF.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 900:
</p>
<ul>
  <li>no cooling or heating equipment
  </li>
</ul>
<ul>
  <li>July 1, 2020, by Konstantina Xanthopoulou:<br/>
    updated
  </li>
  <li>
    <i>March 9, 2015</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>"));
end Case900FF;
