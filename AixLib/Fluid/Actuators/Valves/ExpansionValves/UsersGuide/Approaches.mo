within AixLib.Fluid.Actuators.Valves.ExpansionValves.UsersGuide;
class Approaches
  "Approaches implemented in the library"
  extends Modelica.Icons.Information;

  class PolynomialApproach "Polynomial Aprroaches"
    extends Modelica.Icons.Information;

    annotation (Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html><p>
A generic polynomial approach is presented below:<br/>
<br/>
<code>C = corFact * sum(a[i]*P[i]^b[i] for i in 1:nT)</code><br/>
<br/>
All flow coefficient models presented in this library are based on a
literature review. Therefore, the variable <code>corFact</code> allows
a correction of the flow coefficient if the general modelling approach
presented in the litarature differs from <code>ṁ =
C*A<sub>valve</sub>*sqrt(2*ρ<sub>inlet</sub>*dp).</code>
<h4>
  Common model variables
</h4>
<p>
  Calculation procedures presented in the litarture have some variables
  in commen and these variables are presented below:<br/>
</p>
<table summary=\"Commen variables\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Variable
    </th>
    <th>
      Comment
    </th>
  </tr>
  <tr>
    <td>
      <code>A</code>
    </td>
    <td>
      Cross-sectional flow area
    </td>
  </tr>
  <tr>
    <td>
      <code>d<sub>inlet</sub></code>
    </td>
    <td>
      Diameter of the pipe at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>p<sub>inlet</sub></code>
    </td>
    <td>
      Pressure at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>p<sub>outlet</sub></code>
    </td>
    <td>
      Pressure at valve's outlet
    </td>
  </tr>
  <tr>
    <td>
      <code>ρ<sub>inlet</sub></code>
    </td>
    <td>
      Density at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>ρ<sub>outlet</sub></code>
    </td>
    <td>
      Density at valve's outlet
    </td>
  </tr>
  <tr>
    <td>
      <code>T<sub>inlet</sub></code>
    </td>
    <td>
      Temperature at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>μ<sub>inlet</sub></code>
    </td>
    <td>
      Dynamic viscosity at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>σ<sub>inlet</sub></code>
    </td>
    <td>
      Surface tension at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>C<sub>outlet</sub></code>
    </td>
    <td>
      Specific heat capacity at valve's outlet
    </td>
  </tr>
  <tr>
    <td>
      <code>h<sub>fg</sub></code>
    </td>
    <td>
      Heat of vaparisation
    </td>
  </tr>
</table>
<h4>
  Polynomial flow coefficient models
</h4>
<p>
  Actually, two polynomial approaches are implemented in this package.
  To add further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.PolynomialFlowCoefficient\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.PolynomialFlowCoefficient</a>.<br/>
</p>
<table summary=\"Polynomial approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>T<sub>condensing</sub></code>
    </th>
    <th>
      Validity <code>T<sub>evaporating</sub></code>
    </th>
    <th>
      Validity <code>T<sub>subcooling</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      ShanweiEtAl2005
    </td>
    <td>
      <code>C = a1*A + a2*ρ<sub>inlet</sub> + a3*ρ<sub>outlet</sub> +
      a4*T<sub>subcooling</sub> + a5*d<sub>clearance</sub> +
      a6*(p<sub>inlet</sub>- p<sub>outlet</sub>)</code>
    </td>
    <td>
      <code>R22, R407C, R410A</code>
    </td>
    <td>
      <code>40 - 50 °C</code>
    </td>
    <td>
      <code>0 - 10 °C</code>
    </td>
    <td>
      <code>1.5 - 10 °C</code>
    </td>
  </tr>
  <tr>
    <td>
      Li2013
    </td>
    <td>
      <code>C = a1 + a2*opening + a3*opening^2 +
      a4*opening*(T<sub>subcooling</sub>/T<sub>crit</sub>) +
      a5*(T<sub>subcooling</sub>/T<sub>crit</sub>) +
      a6*(T<sub>subcooling</sub>/T<sub>crit</sub>)^2</code>
    </td>
    <td>
      <code>R22, R407C, R410A</code>
    </td>
    <td>
      <code>30 - 50 °C</code>
    </td>
    <td>
      <code>0 - 30 °C</code>
    </td>
    <td>
      <code>1.5 - 15 °C</code>
    </td>
  </tr>
</table>
</html>"));
  end PolynomialApproach;

  class PowerApproach "Power Aprroaches"
    extends Modelica.Icons.Information;

    annotation (Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html><p>
A generic power approach is presented below:<br/>
<br/>
<code>C = corFact * a * product(P[i]^b[i] for i in 1:nT)</code><br/>
<br/>
All flow coefficient models presented in this library are based on a
literature review. Therefore, the variable <code>corFact</code> allows
a correction of the flow coefficient if the general modelling approach
presented in the litarature differs from <code>ṁ =
C*A<sub>valve</sub>*sqrt(2*ρ<sub>inlet</sub>*dp).</code>
<h4>
  Common model variables
</h4>
<p>
  Calculation procedures presented in the litarture have some variables
  in commen and these variables are presented below:<br/>
</p>
<table summary=\"Commen variables\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Variable
    </th>
    <th>
      Comment
    </th>
  </tr>
  <tr>
    <td>
      <code>A</code>
    </td>
    <td>
      Cross-sectional flow area
    </td>
  </tr>
  <tr>
    <td>
      <code>d<sub>inlet</sub></code>
    </td>
    <td>
      Diameter of the pipe at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>p<sub>inlet</sub></code>
    </td>
    <td>
      Pressure at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>p<sub>outlet</sub></code>
    </td>
    <td>
      Pressure at valve's outlet
    </td>
  </tr>
  <tr>
    <td>
      <code>ρ<sub>inlet</sub></code>
    </td>
    <td>
      Density at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>ρ<sub>outlet</sub></code>
    </td>
    <td>
      Density at valve's outlet
    </td>
  </tr>
  <tr>
    <td>
      <code>T<sub>inlet</sub></code>
    </td>
    <td>
      Temperature at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>μ<sub>inlet</sub></code>
    </td>
    <td>
      Dynamic viscosity at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>σ<sub>inlet</sub></code>
    </td>
    <td>
      Surface tension at valve's inlet
    </td>
  </tr>
  <tr>
    <td>
      <code>C<sub>outlet</sub></code>
    </td>
    <td>
      Specific heat capacity at valve's outlet
    </td>
  </tr>
  <tr>
    <td>
      <code>h<sub>fg</sub></code>
    </td>
    <td>
      Heat of vaparisation
    </td>
  </tr>
</table>
<h4>
  Power flow coefficient models
</h4>
<p>
  Actually, three power approaches are implemented in this package. To
  add further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices</a>
  and expand the <code>if-structure</code> defined in <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.PolynomialFlowCoefficient\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.PolynomialFlowCoefficient</a>.<br/>
</p>
<table summary=\"Power approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Reference
    </th>
    <th>
      Formula
    </th>
    <th>
      Refrigerants
    </th>
    <th>
      Validity <code>T<sub>condensing</sub></code>
    </th>
    <th>
      Validity <code>T<sub>evaporating</sub></code>
    </th>
    <th>
      Validity <code>T<sub>subcooling</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      ShanweiEtAl2005
    </td>
    <td>
      <code>C = a * a * (A/d<sub>clearance</sub>^2)^b1 *
      ((p<sub>inlet</sub>-p<sub>outlet</sub>)/p<sub>crit</sub>)^b2 *
      (T<sub>crit</sub>/T<sub>subcooling</sub>)^b3 *
      (rho<sub>inlet</sub>/rho<sub>outlet</sub>)^b4 *
      (quality)^b5</code>
    </td>
    <td>
      <code>R22, R407C, R410A</code>
    </td>
    <td>
      <code>40 - 50 °C</code>
    </td>
    <td>
      <code>0 - 10 °C</code>
    </td>
    <td>
      <code>1.5 - 10 °C</code>
    </td>
  </tr>
  <tr>
    <td>
      ZhifangAndOu2008
    </td>
    <td>
      <code>C = a * ((p<sub>inlet</sub>-p<sub>outlet</sub>) *
      sqrt(A)/σ<sub>inlet</sub>)^b1 *
      (d<sub>inlet</sub>*sqrt(ρ<sub>inlet</sub> *
      p<sub>inlet</sub>)/μ<sub>inlet</sub>)^b2</code>
    </td>
    <td>
      <code>R134a</code>
    </td>
    <td>
      <code>31 - 67.17 °C</code>
    </td>
    <td>
      <code>no information</code>
    </td>
    <td>
      <code>0 - 20 °C</code>
    </td>
  </tr>
  <tr>
    <td>
      Li2013
    </td>
    <td>
      <code>C = a * (opening)^b1 *
      (T<sub>subcooling</sub>/T<sub>crit</sub>)^b2</code>
    </td>
    <td>
      <code>R22, R407C, R410A</code>
    </td>
    <td>
      <code>30 - 50 °C</code>
    </td>
    <td>
      <code>0 - 30 °C</code>
    </td>
    <td>
      <code>1.5 - 15 °C</code>
    </td>
  </tr>
</table>
</html>"));
  end PowerApproach;

  annotation (Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  Expansion valve models implemented in this library use a flow
  coefficient model by default to calculate the relationship between
  mass flow rate and pressure drop. In the following, all flow
  coefficient models implemented in this library are shortly
  summarised. Furthermore, all expansion valve models have a parameter
  to calculate transient behaviour of opening and closing the valves.
  This approach is also summarised in this information section.
</p>
<h4>
  Modeling approaches
</h4>
<p>
  Actually, three different modelling approaches are suggested and
  saved as enumeration in <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices.CalcProc\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices.CalcProc</a>.
  In the following, these modeling approaches are characterised
  shortly:<br/>
</p>
<table summary=\"Modelling approaches\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Approach
    </th>
    <th>
      Formula
    </th>
    <th>
      Comment
    </th>
  </tr>
  <tr>
    <td>
      <b>Linear</b>
    </td>
    <td>
      <code>ṁ = C*A<sub>valve</sub>*dp</code>
    </td>
    <td>
      Used for testing or initialisation
    </td>
  </tr>
  <tr>
    <td>
      <b>Nominal</b>
    </td>
    <td>
      <code>ṁ = ṁ<sub>nominal</sub>/dp<sub>nominal</sub> *
      A<sub>valve</sub>*dp</code>
    </td>
    <td>
      Used mainly for initialisation
    </td>
  </tr>
  <tr>
    <td>
      <b>Flow coefficient</b>
    </td>
    <td>
      <code>ṁ =
      C*A<sub>valve</sub>*sqrt(2*ρ<sub>inlet</sub>*dp)</code>
    </td>
    <td>
      Chosen by default and follows from Bernoulli's law
    </td>
  </tr>
</table>
<p>
  For the third approach (i.e. flow coefficient), different calculation
  models are stored in <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices.FlowCoefficient</a>.
  Therefore, the calculation procedure of the flow coefficient C is
  introduced as replaceable model and must by defined by the User.
  Further information is given in the following sections:
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.UsersGuide.Approaches.PolynomialApproach\">
    Polynomial approaches</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.UsersGuide.Approaches.PowerApproach\">
    Power approaches</a>
  </li>
</ol>
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
<h4>
  Transient behaviour
</h4>
<p>
  All expansion valve models have a parameter <code>useInpFil</code>
  that is used to model the valve's transient behaviour while opening
  or closing. Generally, this approach uses the same modeling attempt
  as the stat-up and shut-down transients introtuced for flow machines
  (see <a href=
  \"modelica://AixLib.Fluid.Movers.UsersGuide\">AixLib.Fluid.Movers.UsersGuide</a>).
  Therefore, just the parameter's affections are presented here:
</p>
<ol>
  <li>If <code>useInpFil=false</code>, then the input signal
  <code>opeSet.y</code> is equal to the valve's opening degree. Thus, a
  step change in the input signal causes a step change in the opening
  degree.
  </li>
  <li>If <code>useInpFil=true</code>, which is the default, then the
  opening degree is equal to the output of a filter. This filter is
  implemented as a 2nd order differential equation. Thus, a step change
  in the fan input signal will cause a gradual change in the opening
  degree. The filter has a parameter <code>risTim</code>, which by
  default is set to <i>1</i> second. The rise time is the time required
  to reach <i>99.6%</i> of the full opening degree, or,if the ventil is
  closed, to reach a opening degree of <i>0.4%</i>.
  </li>
</ol>
</html>"));
end Approaches;
