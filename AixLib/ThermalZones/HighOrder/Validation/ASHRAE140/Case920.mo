within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case920
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case620(
                                      Room(wallTypes=
          AixLib.DataBase.Walls.Collections.ASHRAE140.HighMassCases()),
    ReferenceHeatingLoad(table=[920,3313,4300]),
    ReferenceCoolingLoad(table=[900,-3092,-1840]));
  annotation (Documentation(info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 900: </p>
<ul>
<li>no windows on south side. two windows, one facing east, one facing west, each with a surface of 6m2.</li>
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
end Case920;
