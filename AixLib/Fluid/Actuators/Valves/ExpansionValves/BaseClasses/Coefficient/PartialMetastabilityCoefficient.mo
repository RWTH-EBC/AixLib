within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.Coefficient;
partial model PartialMetastabilityCoefficient
  "Partial model describing base metastability Parameter"

  // Definition of inputs
  //
  replaceable package Medium = Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Definition of two-phase medium";

  input Real opening(unit="1") "Current valve's opening";
  input Modelica.SIunits.Area AVal
    "Cross-sectional area of the expansion valve";
  input Modelica.SIunits.Diameter dInlPip
    "Diameter of the pipe at valve's inlet";
  //  input Modelica.SIunits.Area AThr     "Area of Valve";

  input Medium.ThermodynamicState staInl
    "Thermodynamic state at valve's inlet conditions";
  input Medium.ThermodynamicState staOut
    "Thermodynamic state at valve's outlet conditions";
  input Modelica.SIunits.AbsolutePressure pInl
    "Pressure at valves's inlet conditions";
  input Modelica.SIunits.AbsolutePressure pOut
    "Pressure at valves's outlet conditions";
  // Modelica.SIunits.Diameter dThr "Diameter at the throat";
  // input Real kappa   "Isentropic Exponent "

  // Definition of base variables
  //
  Real C_meta(
    unit="1",
    min=0,
    max=100,
    nominal=25) "Metastability Parameter used for expansion valves";
  Modelica.SIunits.AbsolutePressure p_th "Pressure at the throat";

 //Modelica.SIunits.MassFlowRate m_flow_HHMFFM;

equation

  //AVal*opening = Modelica.Constants.pi*dThr^2/4;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-58,-4},{56,-88}},
          lineColor={28,108,200},
          textString="M
"),
  Ellipse(extent={{-110,118},{80,-88}}, lineColor={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialMetastabilityCoefficient;
