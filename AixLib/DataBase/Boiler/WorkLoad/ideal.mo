within AixLib.DataBase.Boiler.WorkLoad;
record ideal "Free workload range and fixed efficiency"
  extends WorkLoadBaseDataDefinition(
     eta=[0,1; 1,1], operatingRange={0,1});
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>June 27, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and
formatted appropriately</li>
</ul></p>
</html>",
      info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Free workload range (0-1) with fixed efficiency of 100&percnt; </p>
</html>"));
end ideal;
