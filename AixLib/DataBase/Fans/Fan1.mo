within AixLib.DataBase.Fans;


record Fan1 "Fan with Diameter of 250mm"
  extends FanCharacteristicsBaseDataDefinition(dp = [0, 1100, 0.3; 900, 1050, 0.4; 1500, 1000, 0.6; 2000, 800, 0.7; 2500, 500, 0.5; 2600, 400, 0.4; 2700, 0, 0.3]);
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <p>Example for a small fan with a diameter of 250mm. Maximum volume flow of 2700 m^3/h and maximum pressure increase of 1100 Pa. </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"AixLib.HVAC.Fan.FanSimple\">AixLib.HVAC.Fan.FanSimple</a></p>
 </html>", revisions = "<html>
 <p>30.12.2013, by <i>Mark Wesseling</i>: implemented</p>
 </html>"));
end Fan1;
