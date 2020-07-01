within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case210
  extends Case220(Room(wallTypes(
        roof=DataBase.Walls.ASHRAE140.RO_Case600(eps=0.1),
        OW=DataBase.Walls.ASHRAE140.OW_Case600(eps=0.1),
        groundPlate_upp_half=DataBase.Walls.ASHRAE140.FL_Case600(eps=0.1))));
  annotation (Documentation(info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 220: </p>
<ul>
<li> Infrared emittace of interior surface = 0.1</li>
</ul>
</ul>
</ul>
</html>", revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>"));
end Case210;
