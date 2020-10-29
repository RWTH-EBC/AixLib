within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients;
model Power_R134a_EEV_15 "Power - R134a - EEV - 1.5 mm"
  extends PowerFlowCoefficient(
    final powMod=Types.PowerModels.ZhifangAndOu2008,
    final a=1.1868e-13,
    final b={-1.4347,3.6426});

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for flow coefficients
  presented by Zhifang et al. (2008).<br/>
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
</table>
<h4>
  References
</h4>
<p>
  X. Zhifang, S. Lin and O. Hongfei. (2008): <a href=
  \"http://dx.doi.org/10.1016/j.applthermaleng.2007.03.023\">Refrigerant
  flow characteristics of electronic expansion valve based on
  thermodynamic analysis and experiment</a>. In: <i>Applied Thermal
  Engineering 28(2)</i>, S. 2381–243
</p>
</html>"));
end Power_R134a_EEV_15;
