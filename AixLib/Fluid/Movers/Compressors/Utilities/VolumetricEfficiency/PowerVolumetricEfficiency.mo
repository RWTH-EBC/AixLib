within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency;
model PowerVolumetricEfficiency
  "Model describing flow volumetric efficiency on power approach"
  extends PartialVolumetricEfficiency;

  // Definition of parameters
  //
  parameter Types.VolumetricPowerModels powMod=Types.VolumetricPowerModels.MendozaMirandaEtAl2016
    "Chose predefined power model for flow coefficient"
    annotation (Dialog(group="Modelling approach"));
  parameter Real a
    "Multiplication factor for generic power approach"
    annotation(Dialog(group="Modelling approach"));
  parameter Real b[:]
    "Exponents for each multiplier"
    annotation(Dialog(group="Modelling approach"));
  parameter Integer nT = size(b,1)
    "Number of terms used for the calculation procedure"
    annotation(Dialog(group="Modelling approach",
                      enable=false));

  // Definition of further parameters required for special approaches
  //
  parameter Modelica.SIunits.MolarMass MRef=0.1
    "Reference molar wheight"
    annotation(Dialog(group="Reference properties"));
  parameter Modelica.SIunits.Frequency rotSpeRef = 9.334
    "Reference rotational speed"
    annotation(Dialog(group="Reference properties"));

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
  if (powMod == Types.VolumetricPowerModels.MendozaMirandaEtAl2016) then
    /*Power approach presented by Mendoza et al. (2005):
      lamH = piPre^b1 * (piPre^1.5*rotSpe^3*VDis)^b2 * (MRef/M)^b3     
    */
    p[1] = piPre
      "Pressure ratio";
    p[2] = piPre^1.5*rotSpe^3*VDis
      "Rotational Speed";
    p[3] = MRef/Medium.fluidConstants[1].molarMass
      "Molar Mass";

    corFac = {1,1}
      "No correction factors are needed";

  else
    assert(false, "Invalid choice of power approach");
  end if;

  // Calculationg of flow coefficient
  //
  lamH = min(1, corFac[1] * a *
    product(abs(p[i])^b[i] for i in 1:nT)^corFac[2])
    "Calculation procedure of generic power approach";

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for volumetric efficiency
  models (for more information, please check out <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>).
  The calculation procedures based on a power approach are presented
  below.
</p>
<h4>
  Implemented approaches
</h4>
<p>
  Actually, one power approache is implemented in this package. To add
  further calculation procedures, just add its name in <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.Utilities.Types\">AixLib.Fluid.Movers.Compressors.Utilities.Types</a>
  and expand the <code>if-structure</code>.<br/>
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
end PowerVolumetricEfficiency;
