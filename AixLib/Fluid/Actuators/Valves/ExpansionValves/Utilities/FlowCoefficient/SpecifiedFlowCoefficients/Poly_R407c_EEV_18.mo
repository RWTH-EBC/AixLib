within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients;
model Poly_R407c_EEV_18 "Polynomial - R407c - EEV - 1.8 mm"
  extends PolynomialFlowCoefficient(
    final polyMod=Types.PolynomialModels.Li2013,
    final a={-0.07154,1.67713,-0.79141,1.09516,0,0},
    final b={1,1,1,1,1,1},
    final pDifRat=0.84);

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for flow coefficients
  presented by Li (2013).<br/>
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
      Li2013
    </td>
    <td>
      <code>C = a1 + a2*opening + a3*opening^2 +
      a4*opening*(T<sub>subcooling</sub>/T<sub>crit</sub>) +
      a5*(T<sub>subcooling</sub>/T<sub>crit</sub>) +
      a6*(T<sub>subcooling</sub>/T<sub>crit</sub>)^2</code>
    </td>
    <td>
      <code>R407C</code>
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
<h4>
  References
</h4>
<p>
  Li, W. (2013): <a href=
  \"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">Simplified
  modeling analysis ofmass flow characteristics in electronic expansion
  valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8–12
</p>
</html>"));
end Poly_R407c_EEV_18;
