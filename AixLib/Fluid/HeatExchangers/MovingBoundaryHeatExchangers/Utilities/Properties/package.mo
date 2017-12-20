within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
package Properties "Package that contains records of properties used throughout the library"
  extends Modelica.Icons.VariantsPackage;

annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 08, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package contains different records that summarise geometric properties 
and material properties. These properties are used throughout the library in
various models. Currently, the following records are implemented:
</p>
<ol>
<li>
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Properties.GeometryHX\">
GeometryHX:</a> 
Contains parameters of the cross-sectional geometry of the heat heat
exchanger.</li>
<li>
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Properties.MaterialHX\">
MaterialHX:</a> 
Contains parameters of material properties of the heat exchanger.</li>
</ol>
</html>"));
end Properties;
