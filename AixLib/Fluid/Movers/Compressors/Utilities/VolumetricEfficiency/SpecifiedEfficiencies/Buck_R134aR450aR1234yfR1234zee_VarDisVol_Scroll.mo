within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies;
model Buck_R134aR450aR1234yfR1234zee_VarDisVol_Scroll
  "Scroll Compressor - R134a, R450a, R1234yf, R1234ze(e) - Similitude - Power"
  extends PowerVolumetricEfficiency(
    final MRef=0.102032,
    final rotSpeRef=9.334,
    final powMod=Types.VolumetricPowerModels.MendozaMirandaEtAl2016,
    final a=1.35,
    final b={-0.2678,-0.0106,0.7195});

  annotation (Documentation(revisions="<html><ul>
  <li>October 23, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for the isentropic
  efficiency presented by Mendoza-Miranda et al. (2016).<br/>
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
      MendozaMirandaEtAl2016
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 * π^b1 *
      (π^1.5*n^3*V<sub>dis</sub>)^b2 * (M<sub>ref</sub>/M)^b3</code>
    </td>
    <td>
      R134a,R450a,R1324yf,R1234ze(E)
    </td>
    <td>
      <code>0 - 50</code>
    </td>
    <td>
      <code>1 - 6</code>
    </td>
  </tr>
</table>
<h4>
  References
</h4>
<p>
  J.M. Mendoza-Miranda, A. Mota-Babiloni, J.J. Ramírez-Minguela, V.D.
  Muñoz-Carpio, M. Carrera-Rodríguez, J. Navarro-Esbrí and C.
  Salazar-Hernández (2016): <a href=
  \"http://www.sciencedirect.com/science/article/pii/S036054421631163X\">Comparative
  evaluation of R1234yf, R1234ze(E) and R450A as alternatives to R134a
  in a variable speed reciprocating compressor</a>. In: <i>Energy
  114</i>, S. 753–766
</p>
</html>"));
end Buck_R134aR450aR1234yfR1234zee_VarDisVol_Scroll;
