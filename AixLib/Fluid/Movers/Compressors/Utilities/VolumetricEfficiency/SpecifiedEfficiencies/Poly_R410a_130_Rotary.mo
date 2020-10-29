within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies;
model Poly_R410a_130_Rotary "Rotary Compressor - R410a - 130 cm³ - Polynomial"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Types.VolumetricPolynomialModels.Koerner2017,
    final a={1.108},
    final b={-0.165});

  annotation (Documentation(revisions="<html><ul>
  <li>October 23, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for the isentropic
  efficiency presented by Körner (2017).<br/>
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
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      Koerner2017
    </td>
    <td>
      <code>η<sub>vol</sub> = a1*π^b1</code>
    </td>
    <td>
      R410a
    </td>
    <td>
      <code>50 - 120</code>
    </td>
    <td>
      <code>1 - 10</code>
    </td>
  </tr>
</table>
<h4>
  References
</h4>
<p>
  D. Körner (2017): Development of dynamic compression heat pump models
  to evaluate promising refrigerants considering legal regulations.
  <i>Master Thesis</i>
</p>
</html>"));
end Poly_R410a_130_Rotary;
