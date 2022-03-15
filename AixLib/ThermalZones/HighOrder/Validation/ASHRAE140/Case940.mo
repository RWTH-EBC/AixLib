within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case940
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case640(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    tableCoolOrTempMin=[940,-3241,-2079],
    tableHeatOrTempMax=[940,793,1411]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case940.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  Input Specifications of <b>Case 940</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 900:
</p>
<ul>
  <li>23-7 h: Heat = ON IF Temp &lt; 10°C
  </li>
  <li>7-23 h: Heat = ON IF Temp &lt; 20°C
  </li>
  <li>Cool = ON IF Temp &gt; 27°C
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
end Case940;
