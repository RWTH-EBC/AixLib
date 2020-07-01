within AixLib.FastHVAC.Data.Boiler.WorkLoad;
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
  <font color=\"#008000\">Overview</font>
</h4>
<p>
  Free workload range (0-1) with fixed efficiency of 100%
</p>
<h4>
  <font color=\"#008000\">Level of Development</font>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars3.png\" alt=\"\" />
</p>
<h4>
  <font color=\"#008000\">References</font>
</h4>
<p>
  Record is currently not used in any model.
</p>
</html>"));
end ideal;
