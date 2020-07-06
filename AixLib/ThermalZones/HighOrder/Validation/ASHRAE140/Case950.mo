within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case950
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case650(
                                      Room(wallTypes(OW=
            AixLib.DataBase.Walls.ASHRAE140.OW_Case900(), groundPlate_upp_half=
            AixLib.DataBase.Walls.ASHRAE140.FL_Case900())),
      ReferenceCoolingLoad(table=[950,-921,-387]));
  annotation (Documentation(info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 900:</p>
<ul>
<li>From 1800 hours to 0700 hours, vent fan = ON</li>
<li>From 0700 hours to 1800 hours, vent fan = OFF</li>
<li>Heating = always OFF</li>
<li>From 1800 hours to 0700 hours, cool = OFF</li>
<li>From 0700 hours to 1800 hours, cool = ON if temperature &gt; 27 degC; otherwise, cool = OFF</li>
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
end Case950;
