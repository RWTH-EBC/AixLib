within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case950FF
  extends Case650FF(
    wallTypes=AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases(),
    ReferenceTempMax(table=[900,35.5,38.5]),
    ReferenceTempMin(table=[900,-20.2,-18.6]),
    checkResultsAccordingToASHRAEHeating(endTime=21135600));
  annotation (Documentation(info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 950: </p>
<ul>
  <li>no cooling or heating equipment
  </li>
</ul>
</html>", revisions="<html>
 <ul>
<li>
  July 1, 2020, by Konstantina Xanthopoulou:<br/>
  updated
  </li>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>"));
end Case950FF;
