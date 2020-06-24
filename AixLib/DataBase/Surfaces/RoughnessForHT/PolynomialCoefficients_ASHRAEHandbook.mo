within AixLib.DataBase.Surfaces.RoughnessForHT;
record PolynomialCoefficients_ASHRAEHandbook
    extends Modelica.Icons.Record;
  parameter Real D = 11.58;
  parameter Real E = 5.894;
  parameter Real F = 0.0;
  annotation(Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Calculate the heat transfer coeficient alpha at outside surfaces
  depending on wind speed and surface type
</p>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<p>
  Wind direction has no influence
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  alpha = D + E*V + R*V^2
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record to be used in model <a href=
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
    Awarded stars
  </li>
  <li>
    <i>March 21, 2012&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PolynomialCoefficients_ASHRAEHandbook;
