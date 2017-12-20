within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
package HeatTransfers "Package that contains different heat transfer correlations"
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
This package contains different modellling approaches of the coefficient of
heat transfer. Currently, the following approaches are implemented within 
this package:
</p>
</p>
<ul>
<li>
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.HeatTransfers.ConstantCoefficientOfHeatTransfer\">
ConstantCoefficientOfHeatTransfer:</a> This model provides a constant
coefficient of heat transfer. Thus, it is the most basic model.
</li>
</ul>
</html>"));
end HeatTransfers;
