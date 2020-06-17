within AixLib.DataBase.Pipes.Insulation;
record Iso0pc "No insulation"
  extends InsulationBaseDataDefinition(
    factor=0.001,
    d=1000,
    lambda=100,
    c=1);
  // Constant chemical Values assumed
  // neglectable heat capacity and resistance

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>0 % insulation. </p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>Record is used with <a href=\"AixLib.Fluid.FixedResistances.Pipe\">AixLib.Fluid.FixedResistances.Pipe</a></p>
</html>",
      revisions="<html>
<ul>
<li><i>April 25, 2017 </i>by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>July 9, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>"));
end Iso0pc;
