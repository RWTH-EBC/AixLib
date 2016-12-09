within AixLib.DataBase.Boiler.WorkLoad;
record Buderus_GB202_40_30
  "Buderus Logano Plus GB202 - Condensing Boiler - 40/30degC"
  extends WorkLoadBaseDataDefinition(
eta=[0.2,1.107; 0.4,1.102; 0.6,1.090; 0.8,1.080; 1,1.070],
operatingRange={0.2,1});
  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Record for Buderus Logano Plus GB202 condensing boiler. Temperature range:
40/30&deg;C </p>
<p>Source:</p>
<p><ul>
<li>Buderus &QUOT;Planungsunterlage Logano plus GB202&QUOT; p. 20</li>
</ul></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>June 27, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and
formatted appropriately, reference added</li>
</ul></p>
</html>"));
end Buderus_GB202_40_30;
