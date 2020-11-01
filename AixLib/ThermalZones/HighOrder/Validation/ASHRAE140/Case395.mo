within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case395
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case400(
    Win_Area=0.001,
    airExchange=0,
    ReferenceHeatingLoad( table=[395,4799,5835]),
    ReferenceCoolingLoad(table=[395,-18,0]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case395.mos"
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
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 400:
</p>
<ul>
  <li>no window
  </li>
</ul>
</html>"));
end Case395;
