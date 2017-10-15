within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient;
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

end ConstantFlowCoefficient;
