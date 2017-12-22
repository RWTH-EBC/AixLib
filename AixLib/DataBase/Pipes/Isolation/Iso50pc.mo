within AixLib.DataBase.Pipes.Isolation;

record Iso50pc "50% Isolation (thickness isolation = 0.5 x d_o)"



  extends DataBase.Pipes.IsolationBaseDataDefinition(

    factor=0.5,

    d=30,

    lambda=0.04,

    c=1400);

  // Constant chemical Values assumed



  annotation (Documentation(info="<html>
<h4>
  <font color=\"#008000\">Overview</font>
</h4>
<p>
  50% isolation. Calculated according to: <i>thickness isolation = 0.5 x d_o</i>
</p>
<h4>
  <font color=\"#008000\">References</font>
</h4>
<p>
  Record is used with <a href=\"HVAC.Components.Pipes.DynamicPipeEBC1\">HVAC.Components.Pipes.DynamicPipeEBC1</a>
</p></html>",revisions="<html>
<ul>
  <li>
    <i>July 9, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>

</html>"));

end Iso50pc;

