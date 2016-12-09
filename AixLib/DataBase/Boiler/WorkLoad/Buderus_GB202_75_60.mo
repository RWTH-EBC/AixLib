within AixLib.DataBase.Boiler.WorkLoad;
record Buderus_GB202_75_60
  "Buderus Logano Plus GB202 - Condensing Boiler - 75/60degC"
  extends WorkLoadBaseDataDefinition(
eta=[0.2,1.097; 0.4,1.070; 0.6,1.036; 0.8,1.003; 1,0.970],
operatingRange={0.2,1});
  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Record for Buderus Logano Plus GB202 condensing boiler. Temperature range:
75/60&deg;C </p>
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
end Buderus_GB202_75_60;
