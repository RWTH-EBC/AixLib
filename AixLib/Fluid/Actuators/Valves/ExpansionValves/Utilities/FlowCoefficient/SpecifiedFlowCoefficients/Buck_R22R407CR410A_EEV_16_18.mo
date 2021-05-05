within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients;
model Buck_R22R407CR410A_EEV_16_18
  "Buckingham - Similitude for R22, R407C, R410A - EEV - 1.6 mm to 1.8 mm "
  extends PowerFlowCoefficient(
    final powMod=Types.PowerModels.Li2013,
    final a=1.066,
    final b={0.8006,0.0609},
    final pDifRat=0.84);

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
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
end Buck_R22R407CR410A_EEV_16_18;
