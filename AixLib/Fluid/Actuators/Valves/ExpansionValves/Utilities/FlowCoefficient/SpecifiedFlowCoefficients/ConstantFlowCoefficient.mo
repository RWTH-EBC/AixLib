within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients;
model ConstantFlowCoefficient
  "General model that describes a constant flow coefficient"
  extends BaseClasses.PartialFlowCoefficient;

  // Definition of parameters
  //
  parameter Real C_const(unit="1", min = 0, max = 100, nominal = 25) = 15
    "Constant flow coefficient";

equation
  // Calculate flow coefficient
  //
  C = C_const "Allocation of constant flow coefficient";

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a simple calculation procedure for flow
  coefficients (for more information, please check out <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>).
  The model provides a constant flow coefficient and is the most basic
  flow coefficient model.
</p>
</html>"));
end ConstantFlowCoefficient;
