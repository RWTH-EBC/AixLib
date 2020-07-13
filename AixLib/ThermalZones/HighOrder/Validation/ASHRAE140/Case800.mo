within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case800
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case430(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    ReferenceHeatingLoad(table=[800,4868,7228]),
    ReferenceCoolingLoad(table=[800,-325,-55]));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 430: </p>
<ul>
<li>high mass exterior vertical walls and floor  </li>
</ul>
</ul>
</ul>
</html>
"));
end Case800;
