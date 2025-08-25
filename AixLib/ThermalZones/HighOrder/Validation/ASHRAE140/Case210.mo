within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case210
  extends Case220(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.LightMassCases_eps01(),
    tableCoolOrTempMin=[210,-668,-162],
    tableHeatOrTempMax=[210,6456,6967]);

  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case210.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
        Documentation(info="<html><p>
  Input Specifications of <b>Case 210</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 220:
</p>
<ul>
  <li>Infrared emittace of interior surface = 0.1
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
end Case210;
