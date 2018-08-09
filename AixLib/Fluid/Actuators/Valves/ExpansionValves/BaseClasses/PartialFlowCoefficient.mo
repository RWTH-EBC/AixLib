within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
partial model PartialFlowCoefficient
  "Partial model describing base flow coefficient"

  // Definition of inputs
  //
  replaceable package Medium =
    Modelica.Media.R134a.R134a_ph
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Definition of two-phase medium";

  input Real opening(unit="1")
    "Current valve's opening";
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
        Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This is a base model for flow coefficient models that are required for 
expansion valves. It defines some basic inputs and outputs that are
commonly used by flow coefficient models presented in
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient</a>.
These inputs and outputs are summarised below:<br />
</p>
<table summary=\"Inputs and outputs\" border=\"1\" cellspacing=\"0\" 
cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Type</th>
<th>Name</th> 
<th>Comment</th> 
</tr> 
<tr>
<td><b>input</b></td> 
<td><code>AVal</code></td> 
<td>Cross-sectional area of the expansion valve</td> 
</tr> 
<tr>
<td><b>input</b></td> 
<td><code>dInlPip</code></td> 
<td>Diameter of the pipe at valve's inlet</td> 
</tr> 
<tr>
<td><b>input</b></td> 
<td><code>opening</code></td> 
<td>Valve's degree of opening</td> 
</tr> 
<tr>
<td><b>input</b></td> 
<td><code>staInl</code></td> 
<td>Thermodynamic state at valve's inlet conditions</td> 
</tr> 
<tr>
<td><b>input</b></td> 
<td><code>staOut</code></td> 
<td>Thermodynamic state at valve's out conditions</td> 
</tr> 
<tr>
<td><b>input</b></td> 
<td><code>pInl</code></td> 
<td>Pressure at valve's inlet</td> 
</tr> 
<tr>
<td><b>input</b></td> 
<td><code>pOut</code></td> 
<td>Pressure at valve's outlet</td> 
</tr> 
<tr>
<td><b>output</b></td> 
<td><code>C</code></td> 
<td>Flow coefficient</td> 
</tr> 
</table>
</html>"));
end PartialFlowCoefficient;
