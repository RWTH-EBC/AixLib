within AixLib.Fluid.Movers.Compressors.Utilities.IsentropicEfficiency;
model PolynomialIsentropicEfficiency
  "Model describing isentropic efficiency based on polynomial approach"
  extends PartialIsentropicEfficiency;

  // Definition of parameters describing polynomial approaches in general
  //
  parameter Types.IsentropicPolynomialModels polyMod=Types.IsentropicPolynomialModels.Karlsson2007
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

  // Definition of parameters describing specific approaches
  //
  parameter Real c[:] = {1}
    "Coefficients used for correction factors if needed"
    annotation(Dialog(group="Modelling approach"));
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
  if (polyMod == Types.IsentropicPolynomialModels.DarrAndCrawford1992) then
    /*Polynomial approach presented by Dar and Crawford (1992):
      etaIse = a1 + a2*rotSpe +a3/dInl
      
      Caution with units - In the following, none S.I units are presented:
      Density:           in lb/ft^3
      Rotational Speed:  in rpm
      Volume flow:       in ft^3/min
    */
    p[1] = 1
      "Dummy value for usage of simple coefficcient";
    p[2] = rotSpe*60
      "Rotational speed";
    p[3] = 1/(Medium.density(staInl)*0.3048^3/0.453592)
      "Effect of clearance";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.IsentropicPolynomialModels.Karlsson2007) then
    /*Polynomial approach presented by Karlsson (2007):
      etaIse = a1 + a2*piPre + a3*piPre^2 + a4*rotSpe + a5*rotSpe^2
      
      Caution with units - In the following, none S.I units are presented:
      Pressure:            in bar
    */
    p[1] = 1
      "Usage of dummy value for simple coefficient";
    p[2] = piPre
      "Pressure ratio";
    p[3] = piPre^2
      "Quadratic pressure ratio";
    p[4] = rotSpe
      "Rotational speed";
    p[5] = rotSpe^2
      "Quadratic rotational speed";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.IsentropicPolynomialModels.Engelpracht2017) then
    /*Polynomial approach presented by Engelpracht (2017):
      etaIse = a1 + a2*rotSpe + a3*rotSpe^3 + piPre*y^2 
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = rotSpe
      "Rotational speed";
    p[3] = rotSpe^3
      "Cubic rotational speed";
    p[4] = piPre^2
      "Quadratic pressure ratio";

    corFac = {1,1}
      "No correction factors are needed";

  else
    assert(false, "Invalid choice of polynomial approach");
  end if;

  // Calculationg of flow coefficient
  //
  etaIse = min(1, corFac[1] *
    sum(a[i]*p[i]^b[i] for i in 1:nT)^corFac[2])
    "Calculation procedure of general polynomial";

  annotation (Documentation(revisions="<html><ul>
  <li>October 20, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model contains a calculation procedure for isentropic efficiency
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
  Actually, three polynomial approaches are implemented in this
  package. To add further calculation procedures, just add its name in
  <a href=
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
  <tr>
    <td>
      Karlsson2007
    </td>
    <td>
      <code>η<sub>ise</sub> = a1 + a2*π + a3*π^2 + a4*n + a5*n^2</code>
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
  <tr>
    <td>
      Engelpracht2017
    </td>
    <td>
      <code>η<sub>ise</sub> = a1 + a2*n + a3*n^3 + a5*π^2</code>
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
  J.H. Darr and R.R. Crawford (1992): <a href=
  \"https://www.researchgate.net/publication/288676460_Semi-empirical_method_for_representing_domestic_refrigeratorfreezer_compressor_calorimeter_test_data\">
  Modeling of an Automotive Air Conditioning Compressor Based on
  Experimental Data: ACRC Technical Report 14</a>. Publisher: <i>Air
  Conditioning and Refrigeration Center. College of Engineering.
  University of Illinois at Urbana-Champaign.</i>
</p>
<p>
  F. Karlsson (2007): <a href=
  \"https://www.sp.se/sv/units/risebuilt/energy/Documents/ETk/Karlsson_Capacity_control_residential_HP_heating_systems.pdf\">
  Capacity Control of Residential Heat Pump Heating Systems</a>. In:
  <i>PhD thesis</i>
</p>
<p>
  M. Engelpracht (2017): Development of modular and scalable simulation
  models for heat pumps and chillers considering various refrigerants.
  <i>Master Thesis</i>
</p>
</html>"));
end PolynomialIsentropicEfficiency;
