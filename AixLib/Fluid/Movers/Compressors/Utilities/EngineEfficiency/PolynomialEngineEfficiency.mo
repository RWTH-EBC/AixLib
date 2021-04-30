within AixLib.Fluid.Movers.Compressors.Utilities.EngineEfficiency;
model PolynomialEngineEfficiency
  "Model describing engine efficiency based on polynomial approach"
  extends PartialEngineEfficiency;

  // Definition of parameters describing polynomial approaches in general
  //
  parameter Types.EnginePolynomialModels polyMod=Types.EnginePolynomialModels.DurprezEtAl2007
    "Chose predefined polynomial model for flow coefficient"
    annotation (Dialog(group="Modelling approach"));
  parameter Real a[:]
    "Multiplication factors for each summand"
    annotation(Dialog(group="Modelling approach"));
  parameter Real b[:]
    "Exponents for each summand"
    annotation(Dialog(group="Modelling approach"));
  parameter Integer nT = size(a,1)
    "Number of terms used for the calculation procedure"
    annotation(Dialog(group="Modelling approach",
                      enable=false));

  // Definition of coefficients
  //
  Real p[nT]
    "Array that contains all coefficients used for the calculation procedure";
  Real corFac[2]
    "Array of correction factors used if efficiency model proposed in literature
    differs from efficiency model defined in PartialCompressor model";

equation
  // Calculation of coefficients
  //
  if (polyMod == Types.EnginePolynomialModels.JahningEtAl2000) then
    /*Polynomial approach presented by Jahning et al. (2000):
      etaEng = a1 + a2*exp(pInl)^b2
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = exp(Medium.pressure(staInl))
      "Inlet pressure";

  elseif (polyMod == Types.EnginePolynomialModels.DurprezEtAl2007) then
    /*Polynomial approach presented by Durprez et al. (2007):
      etaEng = a1 + a2*piPre + a3*piPre^2 + a4*piPre^3 + a5*piPre^4 + 
               a6*piPre^5 + a7*piPre^6
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = piPre
      "Pressure ratio";
    p[3] = piPre^2
      "Quadratic pressure ratio";
    p[4] = piPre^3
      "Cubic pressure ratio";
    p[5] = piPre^4
      "Biquadratic pressure ratio";
    p[6] = piPre^5
      "Quintic pressure ratio";
    p[7] = piPre^6
      "Bicubic pressure ratio";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.EnginePolynomialModels.KinarbEtAl2010) then
    /*Polynomial approach presented by Kinab et al. (2010):
      etaEng = a1 + a2*piPre + a3*piPre^2
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = piPre
      "Pressure ratio";
    p[3] = piPre^3
      "Quadratic pressure ratio";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.EnginePolynomialModels.Engelpracht2017) then
    /*Polynomial approach presented by Engelpracht (2017):
      etaEng = a1 + a2*piPre + a3*rotSpe + a4*piPre^2 + 
               a5*rotSpe*piPre + a6*rotSpe^2 + a7*piPre^2*rotSpe + 
               a8*piPre*rotSpe^2 + a9*rotSpe^3 + a10*rotSpe^2*piPre^2 + 
               a11*rotSpe^3*piPre + a12*rotSpe^4
    */
    p[1] = 1
      "First coefficient";
    p[2] = piPre
      "Second coefficient";
    p[3] = rotSpe
      "Third coefficient";
    p[4] = piPre^2
      "Fourth coefficient";
    p[5] = rotSpe*piPre
      "Fifth coefficient";
    p[6] = rotSpe^2
      "Sixth coefficient";
    p[7] = piPre^2*rotSpe
      "Seventh coefficient";
    p[8] = piPre*rotSpe^2
      "Eighth coefficient";
    p[9] = rotSpe^3
      "Ninth coefficient";
    p[10] = rotSpe^2*piPre^2
      "Tenth coefficient";
    p[11] = rotSpe^3*piPre
      "Eleventh coefficient";
    p[12] = rotSpe^4
      "Twelfth coefficient";

    corFac = {1,1}
      "No correction factors are needed";

  else
    assert(false, "Invalid choice of polynomial approach");
  end if;

  // Calculationg of flow coefficient
  //
  etaEng = min(1, corFac[1] *
    sum(a[i]*p[i]^b[i] for i in 1:nT)^corFac[2])
    "Calculation procedure of generic polynomial";

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for engine efficiency
  models (for more information, please check out <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>).
  The calculation procedures based on a polynomial approach are
  presented below.
</p>
<h4>
  Implemented approaches
</h4>
<p>
  Actually, four polynomial approaches are implemented in this package.
  To add further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code>.<br/>
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
      JahningEtAl2000
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 + a2*exp(p<sub>Inl</sub>)^b2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      DurprezEtAl2007
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 + a2*π + a3*π^2 + a4*π^3 + a5*π^4 +
      a6*π^5 + a7*π^6</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
  </tr>
  <tr>
    <td>
      KinarbEtAl2010
    </td>
    <td>
      <code>η<sub>eng</sub> = a1 + a2*π + a3*π^2</code>
    </td>
    <td>
      Generic model
    </td>
    <td>
      <code>Generic model</code>
    </td>
    <td>
      <code>Generic model</code>
    </td>
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
  I.D. Jähnig, D. Reindl and S.A. Klein, S. A. (2000): <a href=
  \"https://www.researchgate.net/publication/288676460_Semi-empirical_method_for_representing_domestic_refrigeratorfreezer_compressor_calorimeter_test_data\">
  Semi-empirical method for representing domestic refrigerator/freezer
  compressor calorimeter test data</a>.
</p>
<p>
  M.-E Duprez, E. Dumont and M. Frère (2007): <a href=
  \"http://www.sciencedirect.com/science/article/pii/S0140700706002477\">Modelling
  of reciprocating and scroll compressors</a>. In: <i>International
  Journal of Refrigeration 30(5)</i>, S. 873–886
</p>
<p>
  E. Kinab, D. Marchio, P. Rivière and A. Zoughaib (2010): <a href=
  \"http://www.sciencedirect.com/science/article/pii/S0378778810002239\">Reversible
  heat pump model for seasonal performance optimization</a>. In:
  <i>Energy and Buildings 42(12)</i>, S. 2269–2280
</p>
<p>
  M. Engelpracht (2017): Development of modular and scalable simulation
  models for heat pumps and chillers considering various refrigerants.
  <i>Master Thesis</i>
</p>
</html>"));
end PolynomialEngineEfficiency;
