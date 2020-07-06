within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case395
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case400(
    ReferenceHeatingLoad(
      table=[395,4799,5835]),
    Room(outerWall_South(withWindow=false)),
    ReferenceCoolingLoad(table=[395,-16,0]));
  parameter Real coeff=Room.outerWall_South.solar_absorptance
    "Weight coefficient";
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 400: </p>
<ul>
<li> no window</li>
</ul>
</ul>
</ul>
</html>"));
end Case395;
