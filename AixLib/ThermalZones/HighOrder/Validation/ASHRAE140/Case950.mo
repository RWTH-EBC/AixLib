within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case950
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case650(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    tableCoolOrTempMin=[950,-921,-387],
    tableHeatOrTempMax=[950,0,0]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case950.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  Input Specifications of <b>Case 950</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 600:
</p>
<ul>
  <li>Air exchange rate: 10.8
  </li>
  <li>18-7 h: Vent fan = ON
  </li>
  <li>7-18 h: Vent fan = OFF
  </li>
  <li>Heating = always OFF
  </li>
  <li>18-7 h: Cool = OFF
  </li>
  <li>7-18 h: Cool =ON IF Temp &lt; 27°C, otherwise Cool=OFF
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
end Case950;
