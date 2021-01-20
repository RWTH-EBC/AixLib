within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case950
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case650(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    ReferenceHeatingLoadOrTempMax(table=[950,0,0]),
    ReferenceCoolingLoadOrTempMin(table=[950,-921,-387]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case950.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 900:
</p>
<ul>
  <li>From 1800 hours to 0700 hours, vent fan = ON
  </li>
  <li>From 0700 hours to 1800 hours, vent fan = OFF
  </li>
  <li>Heating = always OFF
  </li>
  <li>From 1800 hours to 0700 hours, cool = OFF
  </li>
  <li>From 0700 hours to 1800 hours, cool = ON if temperature &gt; 27
  degC; otherwise, cool = OFF
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
end Case950;
