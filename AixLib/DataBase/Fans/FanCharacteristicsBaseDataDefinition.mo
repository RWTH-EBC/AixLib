within AixLib.DataBase.Fans;
record FanCharacteristicsBaseDataDefinition
  "Characteristics for simple fan model"
  extends Modelica.Icons.Record;
  parameter Real[:, :] dp "V_flow | dp | eta ";
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br/>1. Column: Volume Flow in m^3 / h</p>
 <p>2. Column: Pressure Increase in Pa</p>
 <p>3. Column: efficiency of Fan</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.Fan.FanSimple\">AixLib.HVAC.Fan.FanSimple</a></p>
 </html>", revisions = "<html>
 <p>30.12.2013, by <i>Mark Wesseling</i>: implemented</p>
 </html>"));
end FanCharacteristicsBaseDataDefinition;
