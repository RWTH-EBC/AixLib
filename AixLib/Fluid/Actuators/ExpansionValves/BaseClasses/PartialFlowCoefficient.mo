within AixLib.Fluid.Actuators.ExpansionValves.BaseClasses;
partial model PartialFlowCoefficient
  "Partial model describing base flow coefficient"

  // Definition of inputs
  //
  replaceable package Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Definition of two-phase medium";

  input Real opening(unit="1")
    "Actual valve's opening";
  input Modelica.SIunits.Area AVal
    "Cross-sectional area of the expansion valve";
  input Modelica.SIunits.Diameter dInlPip
    "Diameter of the pipe at valve's inlet";

  input Medium.ThermodynamicState staInl
    "Thermodynamic state at valve's inlet conditions";
  input Medium.ThermodynamicState staOut
    "Thermodynamic state at valve's outlet conditions";
  input Modelica.SIunits.AbsolutePressure pInl
    "Pressure at valves's inlet conditions";
  input Modelica.SIunits.AbsolutePressure pOut
    "Pressure at valves's outlet conditions";

  // Definition of base variables
  //
  Real C(unit="1", min = 0, max = 100, nominal = 25)
    "Mass flow coefficient used for expansion valves";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Ellipse(
          extent={{-90,-90},{90,90}},
          lineThickness=0.25,
          pattern=LinePattern.None,
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,127},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="C")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
end PartialFlowCoefficient;
