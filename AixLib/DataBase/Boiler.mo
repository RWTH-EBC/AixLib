within AixLib.DataBase;
package Boiler "Records describing boiler efficiencies"
  extends Modelica.Icons.Package;
  record BoilerEfficiencyBaseDataDefinition
    "TYPE: Table with boiler efficiency depending on part-load factor"
    extends Modelica.Icons.Record;
    parameter Real[:,2] boilerEfficiency "part-load factor | boiler efficiency";

    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This base record defines the record structure for boiler efficiencies. Boiler efficiency is defined depending on the part-load factor.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>1. Column: part-load factor Q(T)/Q_max</p>
<p>2. Column: boiler efficiency</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"AixLib.HVAC.HeatGeneration.Boiler\">AixLib.HVAC.HeatGeneration.Boiler</a></p>
</html>",
        revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end BoilerEfficiencyBaseDataDefinition;

  record BoilerConst
    "Boiler efficency for a simple boiler with fixed temperature"
    extends BoilerEfficiencyBaseDataDefinition(
  boilerEfficiency=[0.0000, 0.78;
  0.2000, 0.78;
  0.4000, 0.82;
  0.6000, 0.84;
  0.8000, 0.86;
  1.0000, 0.88]);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This record defines the efficiencies of a standard boiler operating at a constant temperature. Boiler efficiency is defined depending on the part-load factor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>1. Column: part-load factor Q(T)/Q_max</p>
<p>2. Column: boiler efficiency</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.Boiler\">AixLib.HVAC.HeatGeneration.Boiler</a></p>
</html>",
        revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end BoilerConst;

  record BoilerLT "Boiler efficency for a low-temperature boiler"
    extends BoilerEfficiencyBaseDataDefinition(
  boilerEfficiency=[0.0000, 1.0;
  0.2000, 1.0;
  0.4000, 0.98;
  0.6000, 0.96;
  0.8000, 0.95;
  1.0000, 0.94]);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This record defines the efficiencies of a low-temperature boiler operating at a variable temperature. Boiler efficiency is defined depending on the part-load factor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>1. Column: part-load factor Q(T)/Q_max</p>
<p>2. Column: boiler efficiency</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.Boiler\">AixLib.HVAC.HeatGeneration.Boiler</a></p>
</html>",
        revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end BoilerLT;

  record BoilerCondensing "Boiler efficency for a condensing boiler"
    extends BoilerEfficiencyBaseDataDefinition(
  boilerEfficiency=[0.0000, 1.05;
  0.2000, 1.05;
  0.4000, 1.02;
  0.6000, 1.0;
  0.8000, 0.98;
  1.0000, 0.96]);
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This record defines the efficiencies of a condensing boiler operating at a variable temperature. Boiler efficiency is defined depending on the part-load factor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>1. Column: part-load factor Q(T)/Q_max</p>
<p>2. Column: boiler efficiency</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.HVAC.HeatGeneration.Boiler\">AixLib.HVAC.HeatGeneration.Boiler</a></p>
</html>",
        revisions="<html>
<p>October 2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end BoilerCondensing;
end Boiler;
