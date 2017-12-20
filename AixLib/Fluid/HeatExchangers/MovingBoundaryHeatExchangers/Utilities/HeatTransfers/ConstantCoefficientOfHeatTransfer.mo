within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.HeatTransfers;
model ConstantCoefficientOfHeatTransfer
  "General model describing a constant coefficient of heat transfer"
  extends BaseClasses.PartialCoefficientOfHeatTransfer;

  // Definition of parameters
  //
  parameter Modelica.SIunits.CoefficientOfHeatTransfer AlpCon = 2000
    "Constant coefficient of heat transfer";


equation
  // Calculationf of coefficient of heat transfer
  //
  Alp = AlpCon "Allocation of constant coefficient of heat transfer";

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
This model provides a constant coefficient of heat transfer
and is the most basic coefficient of heat transfer.
</p>
</html>"));
end ConstantCoefficientOfHeatTransfer;
