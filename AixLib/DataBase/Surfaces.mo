within AixLib.DataBase;
package Surfaces "Outside surfaces of walls"
      extends Modelica.Icons.Package;

  package RoughnessForHT "Roughness coefficents for heat transfer"
        extends Modelica.Icons.Package;

    record PolynomialCoefficients_ASHRAEHandbook
        extends Modelica.Icons.Record;
      parameter Real D = 11.58;
      parameter Real E = 5.894;
      parameter Real F = 0.0;

      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Calculate the heat transfer coeficient alpha at outside surfaces depending on wind speed and surface type </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Wind direction has no influence </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>alpha = D + E*V + R*V^2</p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Base data definition for record to be used in model <a href=\"AixLib.Utilities.HeatTransfer.HeatConv_outside
\">AixLib.Utilities.HeatTransfer.HeatConv_outside</a></p>
<p>Source</p>
<ul>
<li>ASHRAE Handbook of Fundamentals. ASHRAE, 1989</li>
<li>As cited in EnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56</li>
</ul>
</html>",     revisions="<html>
<p><ul>
<li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Awarded stars</li>
<li><i>March 21, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul></p>
</html>"));
    end PolynomialCoefficients_ASHRAEHandbook;

    record Brick_RoughPlaster
      extends PolynomialCoefficients_ASHRAEHandbook(
        D=12.49,
        E=4.065,
        F=0.028);

      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Material: Brick, Rough plaster </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"AixLib.Utilities.HeatTransfer.HeatConv_outside
\">AixLib.Utilities.HeatTransfer.HeatConv_outside</a></p>
<p>Source</p>
<ul>
<li>ASHRAE Handbook of Fundamentals. ASHRAE, 1989</li>
<li>As cited inEnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56</li>
</ul>
</html>",     revisions="<html>
<p><ul>
<li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>March 21, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul></p>
</html>"));
    end Brick_RoughPlaster;
    annotation (Documentation(info="<html>
</html>"));
  end RoughnessForHT;
end Surfaces;
