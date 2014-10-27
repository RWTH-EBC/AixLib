within AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment;

record Bathroom "ThermX2, Profil V (Kermi) Power=603W, L=700, H=300, Typ=22, {75,65,24}"
  extends RadiatiorBaseDataDefinition(NominalPower = 603, T_flow_nom = 75, T_return_nom = 65, T_room_nom = 24, Exponent = 1.2776, VolumeWater = 3.6, MassSteel = 17.01, RadPercent = 0.3, length = 0.7, height = 0.3);
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Kermi radiator: Flachheizkoerper ThermX2, Profil V</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The record contains information about the:</p>
 <ul>
 <li>Nominal&nbsp;power&nbsp;of&nbsp;radiator&nbsp;at&nbsp;nominal&nbsp;temperatures&nbsp;in&nbsp;W</li>
 <li>Nominal&nbsp;temperatures&nbsp;T_flow&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
 <li>Nominal&nbsp;temperatures&nbsp;T_return&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
 <li>Nominal&nbsp;temperatures&nbsp;T_room&nbsp;according&nbsp;to&nbsp;DIN-EN&nbsp;442 in degC</li>
 <li>Exponent</li>
 <li>Water&nbsp;volume&nbsp;inside&nbsp;radiator&nbsp;in&nbsp;l</li>
 <li>Material&nbsp;mass&nbsp;of&nbsp;radiator&nbsp;in&nbsp;kg</li>
 <li>Percent&nbsp;of&nbsp;radiative&nbsp;heat from total produced heat</li>
 <li>Length of radiator in m</li>
 <li>Height of radiator in m</li>
 </ul>
 <p><br>Not all this information is used in the model, just the power, the temperatures, the exponent, the percentage and the volume.</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"AixLib.HVAC.Radiators.Radiator\">AixLib.HVAC.Radiators.Radiator</a></p>
 <p>Source:</p>
 <ul>
 <li>Manufacturer: Kermi</li>
 <li>Product: Flachheizkoerper ThermX2 Profil V</li>
 <li>Booklet: Flachheizkoerper, I/2010, Pages 44-52.</li>
 </ul>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>November 15, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul></p>
 </html>"));
end Bathroom;