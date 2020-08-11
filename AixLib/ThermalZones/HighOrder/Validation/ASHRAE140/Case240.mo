within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case240
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case220(
    internalGains=200,
    ReferenceHeatingLoad(table=[240,5649,7448]),
    ReferenceCoolingLoad(table=[240,-1246,-415]));
  annotation (Documentation(revisions="<html><ul>
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
  Difference to case 220:
</p>
<ul>
  <li>Internal Gains = 200 W
  </li>
</ul>
</html>"));
end Case240;
