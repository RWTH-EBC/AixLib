within AixLib.DataBase.Pipes.Isolation;
record Iso50pc "50% Isolation (thickness isolation = 0.5 x d_o)"

  extends DataBase.Pipes.IsolationBaseDataDefinition(
    factor=0.5,
    d=30,
    lambda=0.04,
    c=1400);
  // Constant chemical Values assumed

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>50&percnt; isolation.  Calculated according to: <i>thickness isolation = 0.5 x d_o</i></p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.Pipes.DynamicPipeEBC1\">HVAC.Components.Pipes.DynamicPipeEBC1</a></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>July 9, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end Iso50pc;
