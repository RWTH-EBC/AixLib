within AixLib.DataBase.Surfaces.RoughnessForHT;
record SmoothPlaster
  extends
    DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook(
    D=10.22,
    E=3.1,
    F=0.0);

  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Material: Smooth plaster </p>
<h4><font color=\"#008000\">References</font></h4>
<p>Record is used in model <a href=\"AixLib.Utilities.HeatTransfer.HeatConv_outside\">AixLib.Utilities.HeatTransfer.HeatConv_outside</a></p>
 <p>Source</p>
 <ul>
 <li>ASHRAE Handbook of Fundamentals. ASHRAE, 1989</li>
 <li>As cited inEnergyPlus Engineering Reference. : EnergyPlus Engineering Reference, 2011 p.56</li>
 </ul>
</html>", revisions="<html>
<ul>
<li><i>August 30, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
<li><i>March 21, 2012&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul>
</html>"));
end SmoothPlaster;
