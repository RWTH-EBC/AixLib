within AixLib.DataBase.Boiler.WorkLoad;
record ideal "Free workload range and fixed efficiency"
  extends WorkLoadBaseDataDefinition(
     eta=[0,1; 1,1], operatingRange={0,1});
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>June 27, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>",
      info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Free workload range (0-1) with fixed efficiency of 100%
</p>
</html>"));
end ideal;
