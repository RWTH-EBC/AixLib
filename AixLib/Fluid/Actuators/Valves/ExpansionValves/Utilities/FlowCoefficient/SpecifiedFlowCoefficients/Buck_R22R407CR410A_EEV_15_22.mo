within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients;
model Buck_R22R407CR410A_EEV_15_22
  "Buckingham - Similitude for R22, R407C, R410A - EEV - 1.5 mm to 2.2 mm "
  extends PowerFlowCoefficient(
    final powMod=Types.PowerModels.ShanweiEtAl2005,
    final a=0.2343,
    final b={0.0281,0.0260,-0.0477,-0.1420,-0.1291},
    final dCle=0.02e-3);

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for flow coefficients
  presented by Shanwei et al. (2005).<br/>
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
</table>
<h4>
  References
</h4>
<p>
  M. Shanwei, Z. Chuan, C. Jiangping and C. Zhiujiu. (2005): <a href=
  \"http://dx.doi.org/10.1016/j.applthermaleng.2004.12.005\">Experimental
  research on refrigerant mass flow coefficient of electronic expansion
  valve</a>. In: <i>Applied Thermal Engineering 25(14)</i>, S.
  2351–2366
</p>
</html>"));
end Buck_R22R407CR410A_EEV_15_22;
