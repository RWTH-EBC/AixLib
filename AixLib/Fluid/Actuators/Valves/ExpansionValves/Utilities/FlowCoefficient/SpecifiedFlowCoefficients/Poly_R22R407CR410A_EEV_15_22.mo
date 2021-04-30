within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients;
model Poly_R22R407CR410A_EEV_15_22
  "Polynomial   - Similitude for R22, R407C, R410A - EEV - 1.5 mm to 2.2 mm"
  extends PolynomialFlowCoefficient(
    final polyMod=Types.PolynomialModels.ShanweiEtAl2005,
    final a={-1.615e4,3.328e-4,1.4465e-3,2.9968e-3,-3.3890e2,7.0925e-5},
    final b={1,1,1,1,1,1},
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
end Poly_R22R407CR410A_EEV_15_22;
