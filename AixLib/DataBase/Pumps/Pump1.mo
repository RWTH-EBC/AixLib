within AixLib.DataBase.Pumps;
record Pump1 "Pump with maximum head of 5 m"
  extends MinMaxCharacteristicsBaseDataDefinition(minMaxHead = [0.0000, 0.6, 5.0; 0.5000, 0.4, 4.5; 0.7500, 0.3, 4.0; 1.3000, 0.0, 3.0; 1.5000, 0.0, 2.5; 2.5000, 0.0, 1.5; 3.0000, 0.0, 1.0; 3.5000, 0.0, 0.5; 4.0000, 0.0, 0.0; 4.5000, 0.0, 0.0]);
  annotation(Documentation(revisions = "<html><p>
  01.11.2013, by <i>Ana Constantin</i>: implemented
</p>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Record for a pump with a maximum head of 5 m and a maximum volume
  flow of 4 m3/h.
</p>
<p>
  Values are assumptions.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The record contains just one table.
</p>
<p>
  Table structure:
</p>
<p>
  1. Column: Volume flow in m3/h
</p>
<p>
  2. Column: Head by maximal rotational speed in m
</p>
<p>
  3. Column: Head by maximall rotational speed in m
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"AixLib.Fluid.Movers.Pump\">AixLib.Fluid.Movers.Pump</a>
</p>
</html>"));
end Pump1;
