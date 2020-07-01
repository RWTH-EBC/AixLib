within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case900
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
                                      Room(wallTypes(OW=
            AixLib.DataBase.Walls.ASHRAE140.OW_Case900(), groundPlate_upp_half=
            AixLib.DataBase.Walls.ASHRAE140.FL_Case900())));
  annotation (Documentation(info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 600: </p>
<ul>
<li>high mass exterior vertical walls and floor  </li>
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
end Case900;
