within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies;
model Poly_R407C_Unknown_Scroll
  "Scroll Compressor - R407C - Unknown displacement volume - Polynomial"
  extends PolynomialVolumetricEfficiency(
    final polyMod=Types.VolumetricPolynomialModels.Karlsson2007,
    final a={0.0012,-0.088,1.1262,-0.0045,0.0039,-0.000025},
    final b={1,1,1,1,1,1});

  annotation (Documentation(revisions="<html><ul>
  <li>October 23, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for the isentropic
  efficiency presented by Karlsson (2017).<br/>
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
      Karlsson2007
    </td>
    <td>
      <code>η<sub>vol</sub> = a1*T<sub>inl</sub>*π + a2*π + a3 +
      a4*T<sub>inl</sub> + a5*n + a6*n^2</code>
    </td>
    <td>
      R407c
    </td>
    <td>
      <code>No information</code>
    </td>
    <td>
      <code>No information</code>
    </td>
  </tr>
</table>
<h4>
  References
</h4>
<p>
  F. Karlsson (2007): <a href=
  \"https://www.sp.se/sv/units/risebuilt/energy/Documents/ETk/Karlsson_Capacity_control_residential_HP_heating_systems.pdf\">
  Capacity Control of Residential Heat Pump Heating Systems</a>. In:
  <i>PhD thesis</i>
</p>
</html>"));
end Poly_R407C_Unknown_Scroll;
