within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies;
model Generic_VarRef_VarDisVol_RotaryScroll
  "Generic overall volumetric efficiency based on literature review for various compressors"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Types.VolumetricPolynomialModels.Engelpracht2017,
    final a={0.801790164842882, -0.0521044823322188, 3.216164809959999e-04,
             -0.00493895583430215, 0.049805496348618, -0.021900176265525},
    final b={1,1,1,1,1,1},
    final c={4.54069854496490, 1.63495326341915, 263.864279610770,
             8.43796869242862, 64.4107142857143, 20.8137823859887});

  annotation (Documentation(revisions="<html><ul>
  <li>October 23, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for the isentropic
  efficiency presented by Engelpracht (2017). However, this approach is
  just fitted to various experimental data obtained by a literature
  review and, therefore, to use with caution.<br/>
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
      Validity <code>n<sub>compressor</sub></code>
    </th>
    <th>
      Validity <code>Π<sub>pressure</sub></code>
    </th>
  </tr>
  <tr>
    <td>
      Engelpracht2017
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 + a2*((π-c1)/c2) +
      a3*((T<sub>inl</sub>-c3)/c4)*((π-c1)/c2) +
      a4*((T<sub>inl</sub>-c3)/c4) + a5*((n-c5)/c6) +
      a6*((n-c5)/c6)^2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>0 - 120</code>
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
  Engelpracht, Mirko (2017): Development of modular and scalable
  simulation models for heat pumps and chillers considering various
  refrigerants. <i>Master Thesis</i>
</p>
</html>"));
end Generic_VarRef_VarDisVol_RotaryScroll;
