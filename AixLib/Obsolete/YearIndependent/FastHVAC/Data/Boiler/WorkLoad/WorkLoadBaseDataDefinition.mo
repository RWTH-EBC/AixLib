within AixLib.Obsolete.YearIndependent.FastHVAC.Data.Boiler.WorkLoad;
record WorkLoadBaseDataDefinition "Efficiency depending on workload"
  extends Modelica.Icons.Record;
//refering to lower heating value
  parameter Real[:,2] eta "Efficiency";
  parameter Real[2] operatingRange "Operating range";
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base data definition for efficiency based on the current work load.
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars3.png\" alt=\"\">
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record which at this time is not used in any
  model
</p>
<ul>
  <li>
    <i>June 27, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end WorkLoadBaseDataDefinition;
