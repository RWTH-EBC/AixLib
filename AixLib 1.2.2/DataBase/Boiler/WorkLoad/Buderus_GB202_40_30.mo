within AixLib.DataBase.Boiler.WorkLoad;
record Buderus_GB202_40_30
  "Buderus Logano Plus GB202 - Condensing Boiler - 40/30degC"
  extends WorkLoadBaseDataDefinition(
eta=[0.2,1.107; 0.4,1.102; 0.6,1.090; 0.8,1.080; 1,1.070],
operatingRange={0.2,1});
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Record for Buderus Logano Plus GB202 condensing boiler. Temperature
  range: 40/30°C
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
end Buderus_GB202_40_30;
