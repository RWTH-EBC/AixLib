within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case950FF
  extends Case650FF(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    checkTimeHeatOrTempMax=21135600,
    tableCoolOrTempMin=[950,-20.2,-18.6],
    tableHeatOrTempMax=[950,35.5,38.5]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case950FF.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  Input Specifications of <b>Case 950FF</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 950:
</p>
<ul>
  <li>no cooling or heating equipment
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
end Case950FF;
