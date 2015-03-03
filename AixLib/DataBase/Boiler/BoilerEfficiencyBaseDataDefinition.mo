within AixLib.DataBase.Boiler;
record BoilerEfficiencyBaseDataDefinition
  "TYPE: Table with boiler efficiency depending on part-load factor"
  extends Modelica.Icons.Record;
  parameter Real[:, 2] boilerEfficiency "part-load factor | boiler efficiency";
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This base record defines the record structure for boiler efficiencies. Boiler efficiency is defined depending on the part-load factor.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>1. Column: part-load factor Q(T)/Q_max</p>
 <p>2. Column: boiler efficiency</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.HeatGeneration.Boiler\">AixLib.HVAC.HeatGeneration.Boiler</a></p>
 </html>", revisions = "<html>
 <p>October 2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end BoilerEfficiencyBaseDataDefinition;
