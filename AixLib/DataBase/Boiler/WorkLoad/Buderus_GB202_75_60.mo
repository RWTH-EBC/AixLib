within AixLib.DataBase.Boiler.WorkLoad;
record Buderus_GB202_75_60
  "Buderus Logano Plus GB202 - Condensing Boiler - 75/60degC"
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
<p>
  Source:
</p>
<ul>
  <li>Buderus Planungsunterlage Logano plus GB202 p. 20
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
end Buderus_GB202_75_60;
