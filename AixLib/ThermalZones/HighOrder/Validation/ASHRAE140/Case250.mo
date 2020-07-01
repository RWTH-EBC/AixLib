within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case250
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case220(
                                       Room(solar_absorptance_OW=0.9));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 220: </p>
<ul>
<li> Solar absorptance on exterior surface = 0.9</li>
</ul>
</ul>
</ul>
</html>"));
end Case250;
