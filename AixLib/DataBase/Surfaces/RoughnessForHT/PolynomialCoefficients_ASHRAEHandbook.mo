within AixLib.DataBase.Surfaces.RoughnessForHT;
record PolynomialCoefficients_ASHRAEHandbook
    extends Modelica.Icons.Record;
  parameter Real D = 11.58;
  parameter Real E = 5.894;
  parameter Real F = 0.0;

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Calculate the heat transfer coeficient alpha at outside surfaces depending on wind speed and surface type </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">Assumptions</font></h4></p>
<p>Wind direction has no influence </p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>alpha = D + E*V + R*V^2</p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record to be used in model <a href=\"BaseLib.HeatTransfer.HeatTransfer_Outside\">BaseLib.HeatTransfer.HeatTransfer_Outside</a></p>
<p>Source</p>
<p><ul>
<li>Bibtexkey: ASHRAEHandbook1989</li>
<li>As cited in EnergyPlusRef2011 p.56</li>
</ul></p>
</html>", revisions="<html>
<p><ul>
<li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Awarded stars</li>
<li><i>March 21, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul></p>
</html>"));
end PolynomialCoefficients_ASHRAEHandbook;
