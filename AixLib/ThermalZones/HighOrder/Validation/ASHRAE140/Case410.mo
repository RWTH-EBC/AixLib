within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case410
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case400(
                                      AirExchangeRate(k=0.41));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 400: </p>
<ul>
<li> Air Exchange Rate = 0.41</li>
</ul>
</ul>
</ul>
</html>"));
end Case410;
