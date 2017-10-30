within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency.Generic;
model Poly_GeneralLiterature
  "Generic overall engine efficiency based on literature review for 
  various compressors"
  extends PolynomialEngineEfficiency(
    final useIseWor=false,
    final polyMod=Types.EnginePolynomialModels.Engelpracht2017,
    final a={0.0957214408265998,-0.0237502431235701,-0.000612850128091508,-8.25590145280732e-05,
        0.0336042594518318,-0.000551123582212516,4.49402507385231e-06,-1.86028373775212e-08,
        3.13293379590205e-11,0.000124051213495265,2.73040051562071e-05,
        1.04245115131576e-06,-2.83805388964573e-06,-3.08242161042959e-07,-3.71221991776753e-09,
        2.97156718978992e-08,1.05181138122206e-09,-9.91053456387955e-11},
    final b={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 23, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This model contains a calculation procedure for the engine efficiency
presented by Engelpracht (2017). However, this approach is just fitted
to various experimental data obtained by a literature review and, 
therefore, to use with caution.<br />
</p>
<table summary=\"Polynomial approaches\" border=\"1\" cellspacing=\"0\" 
cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Reference</th>
<th>Formula</th> 
<th>Refrigerants</th> 
<th>Validity <code>n<sub>compressor</sub></code></th> 
<th>Validity <code>&Pi;<sub>pressure</sub></code></th> 
</tr> 
<tr>
<td>Engelpracht2017</td> 
<td><code>&eta;<sub>eng</sub> = a1 + a2*&pi; + a3*&pi;^2 + a4*&pi;^3 + 
a5*n + a6*n^2 + a7*n^3 + a8*n^4 + a9*n^5 + a10*n*&pi; + a11*n*&pi;^2 + 
a12*n*&pi;^3 + a13*n^2*&pi; + a14*n^2*&pi;^2 + a15*n^2*&pi;^3 + 
a16*n^3*&pi; + a17*n^3*&pi;^2 + a18*n^4*&pi;</code></td> 
<td>Generic model</td> 
<td><code>0 - 120</code></td> 
<td><code>1 - 10</code></td> 
</tr> 
</table>
<h4>References</h4>
<p>
Engelpracht, Mirko (2017): Development of modular and scalable simulation
models for heat pumps and chillers considering various refrigerants.
<i>Master Thesis</i>
</p>
</html>"));
end Poly_GeneralLiterature;
