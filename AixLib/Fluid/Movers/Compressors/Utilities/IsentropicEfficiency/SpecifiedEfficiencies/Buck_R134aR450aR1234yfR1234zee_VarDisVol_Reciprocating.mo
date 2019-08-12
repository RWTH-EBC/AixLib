within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies;
model Buck_R134aR450aR1234yfR1234zee_VarDisVol_Reciprocating
  "Reciporating Compressor - R134a, R450a, R1234yf, R1234ze(e) - Similitude - Power"
  extends PowerIsentropicEfficiency(
    final MRef=0.102032,
    final rotSpeRef=9.334,
    final powMod=Types.IsentropicPowerModels.MendozaMirandaEtAl2016,
    final a=1,
    final b={0.0753,0.2183,0.0015,0.0972});

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
This model contains a calculation procedure for the isentropic 
efficiency presented by Mendoza-Miranda et al. (2016).<br />
</p>
<table summary=\"Power approaches\" border=\"1\" cellspacing=\"0\" 
cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Reference</th>
<th>Formula</th> 
<th>Refrigerants</th> 
<th>Validity <code>n<sub>compressor</sub></code></th> 
<th>Validity <code>&Pi;<sub>pressure</sub></code></th> 
</tr> 
<tr>
<td>MendozaMirandaEtAl2016</td> 
<td><code>&eta;<sub>ise</sub> = a1 * &pi;^b1 * 
(n<sub>ref</sub>/n)^b2 * 
(n^3*V<sub>dis</sub>/dh<sub>ise</sub>^1.5)^b3 * 
(1/((T<sub>inl</sub>+T<sub>outIse</sub>)/2-T<sub>out</sub>))^b4
</code></td> 
<td>R134a,R450a,R1324yf,R1234ze(E)</td> 
<td><code>0 - 50</code></td> 
<td><code>1 - 6</code></td> 
</tr> 
</table>
<h4>References</h4>
<p>
J.M. Mendoza-Miranda, A. Mota-Babiloni, J.J. Ram&iacute;rez-Minguela, 
V.D. Mu&ntilde;oz-Carpio, M. Carrera-Rodr&iacute;guez, 
J. Navarro-Esbr&iacute; and C. Salazar-Hern&aacute;ndez (2016): 
<a href=\"http://www.sciencedirect.com/science/article/pii/S036054421631163X\">
Comparative evaluation of R1234yf, R1234ze(E) and R450A as 
alternatives to R134a in a variable speed reciprocating 
compressor</a>. In: <i>Energy 114</i>, S. 753&ndash;766
</p>
</html>"));
end Buck_R134aR450aR1234yfR1234zee_VarDisVol_Reciprocating;
