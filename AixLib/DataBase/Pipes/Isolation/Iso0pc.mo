within AixLib.DataBase.Pipes.Isolation;

record Iso0pc "Coating, no insulation"



  extends DataBase.Pipes.IsolationBaseDataDefinition(

    factor=0.04,

    d=1000,

    lambda=0.5,

    c=1600);

  // Constant chemical Values assumed

  // would yield ~1mm coating for a DN25 pipe



  annotation (Documentation(info="<html>
<h4>
  <font color=\"#008000\">Overview</font>
</h4>
<p>
  0% isolation.
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

end Iso0pc;

