within AixLib.DataBase.Boiler;


record BoilerCondensing "Boiler efficency for a condensing boiler"
  extends BoilerEfficiencyBaseDataDefinition(boilerEfficiency = [0.0000, 1.05; 0.2000, 1.05; 0.4000, 1.02; 0.6000, 1.0; 0.8000, 0.98; 1.0000, 0.96]);
  annotation(Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This record defines the efficiencies of a condensing boiler operating at a variable temperature. Boiler efficiency is defined depending on the part-load factor.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>1. Column: part-load factor Q(T)/Q_max</p>
 <p>2. Column: boiler efficiency</p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.Boiler\">AixLib.HVAC.HeatGeneration.Boiler</a></p>
 </html>", revisions = "<html>
 <p>October 2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end BoilerCondensing;
