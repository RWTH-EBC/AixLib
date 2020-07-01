within AixLib.DataBase.Pipes.Insulation;
record Iso25pc "25% Insulation (thickness insulation = 0.25 x d_o)"
  extends InsulationBaseDataDefinition(
    factor=0.25,
    d=30,
    lambda=0.04,
    c=1400);
  // Constant chemical Values assumed

  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  25 % insulation. Calculated according to: <i>thickness insulation = 1
  x d_o</i>
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record is used with <a href=
  \"AixLib.Fluid.FixedResistances.Pipe\">AixLib.Fluid.FixedResistances.Pipe</a>
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>April 25, 2017</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>July 9, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end Iso25pc;
