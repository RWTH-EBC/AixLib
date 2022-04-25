within AixLib.DataBase.Pumps;
record MinMaxCharacteristicsBaseDataDefinition
  "TYPE: Table with Head = f(V_flow) min amd max characteristics for the pump"
  extends Modelica.Icons.Record;
  parameter Real[:, :] minMaxHead "V_flow | min Head | max Head";
  annotation(Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Record contains the mininmal and maximal characteristics of a pump.
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
  Base data definition for record to be used in model <a href=
  \"AixLib.Fluid.Movers.Pump\">AixLib.Fluid.Movers.Pump</a>
</p>
<p>
  01.11.2013, by <i>Ana Constantin</i>: implemented
</p>
</html>"));
end MinMaxCharacteristicsBaseDataDefinition;
