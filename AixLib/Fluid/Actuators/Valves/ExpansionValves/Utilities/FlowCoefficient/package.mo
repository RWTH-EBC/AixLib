within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities;
package FlowCoefficient "Package that contains models describing different flow coefficients"
  extends Modelica.Icons.Package;





  annotation (Icon(graphics={
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
          textString="C")}), Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains models describing calculations procedures of
  flow coefficients that are based on a literature review. However, in
  this package the flow coefficient is implemented in such a way that
  it fulfills<br/>
  <br/>
  <code>ṁ = C*A<sub>valve</sub>*sqrt(2*ρ<sub>inlet</sub>*dp)</code>
  .<br/>
  <br/>
  For more information, please checkout <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>.
</p>
<h4>
  Commen model variables
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
<p>
  Moreover, two approaches can be identified in general: A polynomial
  and a power approach. The characteristics of these approaches are
  presented below.
</p>
<h4>
  Polynomial approaches
</h4>
<p>
  A generic polynomial approach is presented below:<br/>
  <br/>
  <code>C = corFact * sum(a[i]*P[i]^b[i] for i in 1:nT)</code><br/>
  <br/>
  Actually, two polynomial approaches are implemented in this package.
</p>
<h4>
  Power approaches
</h4>
<p>
  A generic power approach is presented below:<br/>
  <br/>
  <code>C = corFact * a * product(P[i]^b[i] for i in 1:nT)</code><br/>
  <br/>
  Actually, thee power approaches are implemented in this package.
</p>
<h4>
  References
</h4>
<p>
  X. Zhifang, S. Lin and O. Hongfei. (2008): <a href=
  \"http://dx.doi.org/10.1016/j.applthermaleng.2007.03.023\">Refrigerant
  flow characteristics of electronic expansion valve based on
  thermodynamic analysis and experiment</a>. In: <i>Applied Thermal
  Engineering 28(2)</i>, S. 238–243
</p>
<p>
  Q. Ye, J. Chen and Z. Chen. (2007): <a href=
  \"http://dx.doi.org/10.1016/j.enconman.2006.11.011\">Experimental
  investigation of R407c and R410a flow through electronic expansion
  valve</a>. In: <i>Energy Conversion andManagement 48(5)</i>, S.
  1624–1630
</p>
</html>"));
end FlowCoefficient;
