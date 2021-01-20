within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case940
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case640(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    ReferenceHeatingLoadOrTempMax(table=[940,793,1411]),
    ReferenceCoolingLoadOrTempMin(table=[940,-3241,-2079]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case940.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 900:
</p>
<ul>
  <li>From 2300 hours to 0700 hours, heat = ON if temperature &lt; 10
  degC
  </li>
  <li>From 0700 hours to 2300 hours, heat = ON if temperature &lt; 20
  degC
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
end Case940;
