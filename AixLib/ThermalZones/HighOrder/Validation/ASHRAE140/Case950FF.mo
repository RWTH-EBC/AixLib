within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case950FF
  extends Case650FF(Room(wallTypes(OW=
            AixLib.DataBase.Walls.ASHRAE140.OW_Case900(), groundPlate_upp_half=
            AixLib.DataBase.Walls.ASHRAE140.FL_Case900())));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 950: </p>
<ul>
<li>no cooling or heating equipment</li>
</ul>
</html>"));
end Case950FF;
