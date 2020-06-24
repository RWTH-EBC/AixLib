within AixLib.DataBase.Boiler.WorkLoad;
record WorkLoadBaseDataDefinition "Efficiency depending on workload"
  extends Modelica.Icons.Record;
//refering to lower heating value
  parameter Real[:,2] eta "Efficiency";
  parameter Real[2] operatingRange "Operating range";
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Base data definition for efficiency based on the current work load. </p>
</html>", revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with AixLib</li>
<li><i>June 27, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and
formatted appropriately</li>
</ul>
</html>"));
end WorkLoadBaseDataDefinition;
