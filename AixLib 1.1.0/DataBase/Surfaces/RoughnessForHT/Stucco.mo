within AixLib.DataBase.Surfaces.RoughnessForHT;
record Stucco
  extends DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook(
    D=11.58,
    E=5.894,
    F=0.0);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Material: Stucco
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"AixLib.Utilities.HeatTransfer.HeatConv_outside\">AixLib.Utilities.HeatTransfer.HeatConv_outside</a>
</p>
<p>
  Source
</p>
<ul>
  <li>ASHRAE Handbook of Fundamentals. ASHRAE, 1989
  </li>
  <li>As cited inEnergyPlus Engineering Reference. : EnergyPlus
  Engineering Reference, 2011 p.56
  </li>
</ul>
<ul>
  <li>
    <i>August 30, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>March 21, 2012&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Stucco;
