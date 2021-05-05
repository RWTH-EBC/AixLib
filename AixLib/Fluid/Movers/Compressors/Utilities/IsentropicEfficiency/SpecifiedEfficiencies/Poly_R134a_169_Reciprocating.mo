within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies;
model Poly_R134a_169_Reciprocating
  "Reciporating Compressor - R134a - 169 cm³ - Polynomial"
  extends PolynomialIsentropicEfficiency(
    final polyMod=Types.IsentropicPolynomialModels.DarrAndCrawford1992,
    final a={0.8405,-4.8711*1e-5,-0.1105},
    final b={1,1,1});

  annotation (Documentation(revisions="<html><ul>
  <li>October 23, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for the isentropic
  efficiency presented by Darr and Crawford (1992).<br/>
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
      DarrAndCrawford1992
    </td>
    <td>
      <code>η<sub>ise</sub> = a1 + a2*n + a3/ρ<sub>inlet</sub></code>
    </td>
    <td>
      R134a
    </td>
    <td>
      <code>40 - 75</code>
    </td>
    <td>
      <code>3 - 10</code>
    </td>
  </tr>
</table>
<h4>
  References
</h4>
<p>
  J.H. Darr and R.R. Crawford (1992): <a href=
  \"https://www.researchgate.net/publication/288676460_Semi-empirical_method_for_representing_domestic_refrigeratorfreezer_compressor_calorimeter_test_data\">
  Modeling of an Automotive Air Conditioning Compressor Based on
  Experimental Data: ACRC Technical Report 14</a>. Publisher: <i>Air
  Conditioning and Refrigeration Center. College of Engineering.
  University of Illinois at Urbana-Champaign.</i>
</p>
</html>"));
end Poly_R134a_169_Reciprocating;
