within AixLib.DataBase.Pipes.DIN_EN_10255;
record DIN_EN_10255_DN10 "DIN-EN-10255: DN 10"

  extends AixLib.DataBase.Pipes.PipeBaseDataDefinition(
    d_i=0.0125,
    d_o=0.0172,
    d=7850,
    lambda=50,
    c=460);
  // Constant chemical Values assumed (See VDI-Waermeatlas, 1988, p. De2)

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Non-alloy steel pipes according to DIN EN 10255, Line M. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.Pipes.DynamicPipeEBC1\">HVAC.Components.Pipes.DynamicPipeEBC1</a></p>
<p>Source:</p>
<p><ul>
<li>DIN EN 10255, p. 14 Table 4 </li>
</ul></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>July 9, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation, reference and formatted appropriately</li>
</ul></p>
</html>"));
end DIN_EN_10255_DN10;
