within AixLib.Fluid.HeatPumps.BaseClasses;
model HeatCoeffForc
  "Calculates the dynamic heat loss coefficient for forced convection"
  extends Modelica.Blocks.Interfaces.MISO(
  final nin=2);
  parameter Modelica.SIunits.MassFlowRate mFlow_nominal
    "Nominal mass flow rate";
  parameter Real scalingFactor "Scaling-factor of HP";
  parameter Real wukExp "Exponent for the wük";
protected
  Real kA_nominal;
  Modelica.SIunits.MassFlowRate mFlow "Mass flow rate";


equation
  kA_nominal = u[1];
  mFlow = u[2];
  y =kA_nominal*(mFlow/mFlow_nominal)^wukExp;

end HeatCoeffForc;
