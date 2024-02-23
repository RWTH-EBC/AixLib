within AixLib.Obsolete.YearIndependent.FastHVAC.Data.Boiler.WorkLoad;
record BuderusGB202_75_60
  "Buderus Logano Plus GB202 - Condensing Boiler - 75/60°C"
  extends WorkLoadBaseDataDefinition(
eta=[0.2,1.097; 0.4,1.070; 0.6,1.036; 0.8,1.003; 1,0.970],
operatingRange={0.2,1});
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Record for Buderus Logano Plus GB202 condensing boiler. Temperature
  range: 75/60°C
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars5.png\" alt=\"\">
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is not currently used in any model.
</p>
<p>
  Source:
</p>
<ul>
  <li>Buderus \"Planungsunterlage Logano plus GB202\" p. 20
  </li>
  <li>BibTexKey: BuderusLoganoPlusGB202
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>
    <i>June 27, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately, reference added
  </li>
</ul>
</html>"));
end BuderusGB202_75_60;
