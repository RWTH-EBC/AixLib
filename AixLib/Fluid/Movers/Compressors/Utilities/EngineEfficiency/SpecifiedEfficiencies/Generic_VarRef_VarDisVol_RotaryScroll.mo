within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies;
model Generic_VarRef_VarDisVol_RotaryScroll "Generic overall engine efficiency based on literature review for 
  various compressors"
  extends PolynomialEngineEfficiency(
    final useIseWor=false,
    final polyMod=Types.EnginePolynomialModels.Engelpracht2017,
    final a={0.2199,-0.0193,0.02503,-0.001345,8.817e-5,-0.0003382,1.584e-5,
             -1.083e-6,1.976e-6,-5.321e-8,4.053e-9,-4.329e-9},
    final b={1,1,1,1,1,1,1,1,1,1,1,1});

  annotation (Documentation(revisions="<html><ul>
  <li>October 23, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for the engine efficiency
  presented by Engelpracht (2017). However, this approach is just
  fitted to various experimental data obtained by a literature review
  and, therefore, to use with caution.<br/>
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
      <code>η<sub>eng</sub> = a1 + a2*π + a3*π^2 + a4*n*π + a5*n^2 +
      a6*π^2*n + a7*π*n^2 + a8*n^3 + a9*π^2n^2 + a10*π*π^3 +
      a11*n^4</code>
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
