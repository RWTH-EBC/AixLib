within AixLib.DataBase.Boiler;
record BoilerConst
  "Boiler efficency for a simple boiler with fixed temperature"
  extends BoilerEfficiencyBaseDataDefinition(boilerEfficiency = [0.0000, 0.78; 0.2000, 0.78; 0.4000, 0.82; 0.6000, 0.84; 0.8000, 0.86; 1.0000, 0.88]);
  annotation(Documentation(info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This record defines the efficiencies of a standard boiler operating at a constant temperature. Boiler efficiency is defined depending on the part-load factor.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>1. Column: part-load factor Q(T)/Q_max</p>
 <p>2. Column: boiler efficiency</p>
 </html>", revisions = "<html>
 <p>October 2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end BoilerConst;
