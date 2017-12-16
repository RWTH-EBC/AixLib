within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
package VoidFractions "Package that contains different void fraction models"
  extends Modelica.Icons.VariantsPackage;


  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 07, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package contains different modellling approaches of the void fraction of
the two-phase regime of a moving boundary heat exchanger. Currently, the
following approaches are implemented within this package:
</p>
<ul>
<li>
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.VoidFractions.Graeber2013\">
Graeber2013:</a> This approach only depends on the saturation pressure and,
thus, allows analytical integration.
</li>
</ul>
</html>"));
end VoidFractions;
