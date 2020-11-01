within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case900
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    ReferenceHeatingLoad(table=[900,1170,2041]),
    ReferenceCoolingLoad(table=[900,-3415,-2132]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case900.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(info="<html><p>
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 600:
</p>
<ul>
  <li>high mass exterior vertical walls and floor
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
end Case900;
