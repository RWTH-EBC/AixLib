within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient;
package SpecifiedFlowCoefficients "Package that cointains flow coefficients that are specified"
  extends Modelica.Icons.VariantsPackage;








  annotation (Documentation(revisions="<html><ul>
  <li>December 06, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package cointains flow coefficients that are already specified.
  This means that the calculation approaches of the flow coeffiencient
  presented before are adapted for a specific expansion valve type and
  a specific refrigerant.
</p>
<h4>
  Naming and abbreviations
</h4>
<p>
  In the following, a guideline of naming flow coefficient models is
  summarised:
</p>
<p style=\"margin-left: 30px;\">
  <i>Approach of calculating flow coefficient</i> _ <i>Valid
  refrigerants</i> _ <i>Type of expansion valve</i> _ <i>Diameter of
  cross-sectional area of expansion valve</i>
</p>
<ol>
  <li>
    <u>Approach:</u> Approach of calculating flow coefficient, e.g.
    polynomial or power.
  </li>
  <li>
    <u>Refrigerant:</u> Refrigerants the flow coefficent model is valid
    for, e.g. R134a or R410a.
  </li>
  <li>
    <u>Type:</u> Type of expansion valve, e.g. electric expansion valve
    (EEV).
  </li>
  <li>
    <u>Diameter:</u> Diameter of the cross-sectional area of expansion
    valves if it is fully opened, e.g. 1.6 mm.
  </li>
</ol>
</html>"));
end SpecifiedFlowCoefficients;
