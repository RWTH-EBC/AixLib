within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case420
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case410(
                                      Source_InternalGains(k=200));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 410: </p>
<ul>
<li> Internal Gains = 200 W</li>
</ul>
</ul>
</ul>
</html>"));
end Case420;
