within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case430
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case420(
    solar_absorptance_OW=0.6,
    ReferenceCoolingLoad(table=[430,-875,-422]),
    ReferenceHeatingLoad(table=[430,5429,7827]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case430.mos"
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
  Difference to case 420:
</p>
<ul>
  <li>Solar absorptance on exterior surface = 0.6
  </li>
</ul>
</html>
"));
end Case430;
