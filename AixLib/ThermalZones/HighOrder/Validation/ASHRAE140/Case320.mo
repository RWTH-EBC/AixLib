within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case320
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case270(
    TsetHeater=20,
    TsetCooler=27,
    ReferenceHeatingLoad(table=[320,3859,5141]),
    ReferenceCoolingLoad(table=[320,-7304,-5061]));
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
  Difference to case 270:
</p>
<ul>
  <li>Heat = ON if temperature &lt; 20 degC
  </li>
  <li>Cool = ON if temperature &lt; 27 degC
  </li>
</ul>
</html>"));
end Case320;
