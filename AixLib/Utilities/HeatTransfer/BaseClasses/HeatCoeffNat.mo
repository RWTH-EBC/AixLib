within AixLib.Utilities.HeatTransfer.BaseClasses;
model HeatCoeffNat
  "Calculates the dynamic heat loss coefficient for natural convection"
  extends Modelica.Blocks.Interfaces.MISO(
  final nin=3);

  parameter Modelica.SIunits.ThermodynamicTemperature T_amb_nominal
    "Nominall temperature of ambient";
  parameter Modelica.SIunits.ThermodynamicTemperature TSurf_nominal
    "Nominal temperature of surface";
  parameter Real scalingFactor "Scaling-factor of HP";
  parameter Real wukExp "Exponent for the wük";
protected
  Modelica.SIunits.ThermodynamicTemperature T_amb;
  Modelica.SIunits.ThermodynamicTemperature TSurf;
  Real kA_nominal;

equation
  assert(
    T_amb_nominal == TSurf_nominal,
    "With the given set of nominal Temperatures no heat flow would occur. Disable the HeatLosses model.",
    level=AssertionLevel.error);
  kA_nominal = u[1];
  T_amb = u[2];
  TSurf = u[3];
  y =kA_nominal*(scalingFactor^(3*wukExp + 1))*(((TSurf - T_amb)*T_amb_nominal)
    /(TSurf_nominal - T_amb_nominal)*TSurf_nominal)^wukExp;

end HeatCoeffNat;
