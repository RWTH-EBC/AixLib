within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency;
model PolynomialVolumetricEfficiency
  "Model describing volumetric efficiency based on polynomial approach"
  extends PartialVolumetricEfficiency;

  // Definition of parameters describing polynomial approaches in general
  //
  parameter Types.VolumetricPolynomialModels polyMod=Types.VolumetricPolynomialModels.Karlsson2007
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
  if (polyMod == Types.VolumetricPolynomialModels.DarrAndCrawford1992) then
    /*Polynomial approach presented by Dar and Crawford (1992):
      lamH = a1 + a2*rotSpe - a3*epsRef*(dInlIse/dInl-1) - 
      a4*rotSpe*(dInlIse/dInl-1)
      
      Caution with units - In the following, none S.I units are presented:
      Density:           in lb/ft^3
      Rotational Speed:  in rpm
      Volume flow:       in ft^3/min
    */
    p[1] = 1
      "Dummy value for usage of simple coefficcient";
    p[2] = rotSpe*60
      "Rotational speed";
    p[3] = -(epsRef)*(Medium.density(Medium.setState_psX(s=
      Medium.specificEntropy(staInl),p=Medium.pressure(staOut)))/
      Medium.density(staInl)-1)
      "Effect of clearance";
    p[4] = -rotSpe*60*(Medium.density(Medium.setState_psX(s=
      Medium.specificEntropy(staInl),p=Medium.pressure(staOut)))/
      Medium.density(staInl)-1)
      "Effect of clearance";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.VolumetricPolynomialModels.Karlsson2007) then
    /*Polynomial approach presented by Karlsson (2007):
      lamH = a1*TInl*piPre + a2*piPre + a3 + a4*TInl + a5*rotSpe + a6*rotSpe^2
      
      Caution with units - In the following, none S.I units are presented:
      Temperature:         in °C
    */
    p[1] = (Medium.temperature(staInl)-273.15)*piPre
      "Inlet temperature times pressure ratio";
    p[2] = piPre
      "Pressure ratio";
    p[3] = 1
      "Dummy value for usage of simple coefficcient";
    p[4] = (Medium.temperature(staInl)-273.15)
      "Inlet temperature";
    p[5] = rotSpe
      "Rotational speed";
    p[6] = rotSpe^2
      "Quadratic rotational speed";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.VolumetricPolynomialModels.KinarbEtAl2010) then
    /*Polynomial approach presented by Kinab et al. (2010):
      etaEng = a1 + a2*piPre
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = piPre
      "Pressure ratio";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.VolumetricPolynomialModels.ZhouEtAl2010) then
    /*Polynomial approach presented by Zhou et al. (2010):
    etaEng = 1 + a1 - a2*piPre^(1/kapMean)
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = 1
      "Dummy value for usage of simple coefficient";
    p[3] = -piPre^(2/(Medium.isentropicExponent(staInl)+
      Medium.isentropicExponent(staOut)))
      "Pressure ratio";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.VolumetricPolynomialModels.Li2013) then
    /*Polynomial approach presented by Li (2013):
      lamH = lamHRef * (a1 + a2*(rotSpe/rotSpeRef) + a3*(rotSpe/rotSpeRef)^2)
        with  lamHRef = c1 + c2*((pOut/(pInl*(1-c3))^(1/kapMea))
      
      Caution with units - In the following, none S.I units are presented:
      Pressure:            in kPa
      Temperature:         in °C
      Specific enthalpy:   in kJ/kg
      Rotational speed:    in rpm
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = (rotSpe/rotSpeRef)
      "Rotational speed";
    p[3] = (rotSpe/rotSpeRef)^2
      "Quadratic rotational speed";

    corFac[1] = c[1] + c[2]*((Medium.pressure(staOut)/(Medium.pressure(staInl)*
      (1-c[3]*1e-3)))^(2/(Medium.isentropicExponent(staInl)+
      Medium.isentropicExponent(staOut))))
      "Reference volumetric efficiency";
    corFac[2] = 1
      "No correction factor is needed";

  elseif (polyMod == Types.VolumetricPolynomialModels.HongtaoLaughmannEtAl2017) then
    /*Polynomial approach presented by Hongtao et al. (2013):
      lamH = a1 + a2*omega + a3*omega^2 +
             a4*piPre + a5*omega*piPre + a6*omega^2*piPre + 
             a7*piPre^2 + a8*omega*piPre^2 + a9*omega^2*piPre^2 + 
             a10*pOut + a11*omega*pOut + a12*omega^2*pOut - 
             a13*pInl - a14*omega*pInl - a15*omega^2*pInl + 
             a16*pInl*pOut + a17*omega*pInl*pOut + a18*omega^2*pInl*pOut + 
             a19*omega^3*pInl*pOut + a20*omega^4*pInl*pOut - 
             a21*pInl^2 - a22*omega*pInl^2 - a23*omega^2*pInl^2 - 
             a24*omega^3*pInl^2 - a25*omega^4*pInl^2
  
      with omega = rotSpe/rotSpeRef
    */
    p[1] = 1
      "First coefficient";
    p[2] = (rotSpe/rotSpeRef)
      "Second coefficient";
    p[3] = (rotSpe/rotSpeRef)^2
      "Third coefficient";
    p[4] = piPre
      "Fourth coefficient";
    p[5] = piPre*(rotSpe/rotSpeRef)
      "Fifth coefficient";
    p[6] = piPre*(rotSpe/rotSpeRef)^2
      "Sixth coefficient";
    p[7] = piPre^2
      "Seventh coefficient";
    p[8] = piPre^2*(rotSpe/rotSpeRef)
      "Eighth coefficient";
    p[9] = piPre^2*(rotSpe/rotSpeRef)^2
      "Ninth coefficient";
    p[10] = Medium.pressure(staOut)
      "Tenth coefficient";
    p[11] = Medium.pressure(staOut)*(rotSpe/rotSpeRef)
      "Eleventh coefficient";
    p[12] = Medium.pressure(staOut)*(rotSpe/rotSpeRef)^2
      "Twelfth coefficient";
    p[13] = -Medium.pressure(staInl)
      "Thirteenth coefficient";
    p[14] = -Medium.pressure(staInl)*(rotSpe/rotSpeRef)
      "Fourteenth coefficient";
    p[15] = -Medium.pressure(staInl)*(rotSpe/rotSpeRef)^2
      "Fifteenth coefficient";
    p[16] = Medium.pressure(staInl)*Medium.pressure(staOut)
      "Sixteenth coefficient";
    p[17] = Medium.pressure(staInl)*Medium.pressure(staOut)*(rotSpe/rotSpeRef)
      "Seventeenth coefficient";
    p[18] = Medium.pressure(staInl)*Medium.pressure(staOut)*(rotSpe/rotSpeRef)^2
      "Eighteenth coefficient";
    p[19] = Medium.pressure(staInl)*Medium.pressure(staOut)*(rotSpe/rotSpeRef)^3
      "Nineteenth coefficient";
    p[20] = Medium.pressure(staInl)*Medium.pressure(staOut)*(rotSpe/rotSpeRef)^4
      "Twentieth coefficient";
    p[21] = -Medium.pressure(staInl)^2
      "Twenty-first coefficient";
    p[22] = -Medium.pressure(staInl)^2*(rotSpe/rotSpeRef)^2
      "Twenty-second coefficient";
    p[23] = -Medium.pressure(staInl)^2*(rotSpe/rotSpeRef)^3
      "Twenty-third coefficient";
    p[24] = -Medium.pressure(staInl)^2*(rotSpe/rotSpeRef)^4
      "Twenty-fourth coefficient";
    p[25] = -Medium.pressure(staInl)^2*(rotSpe/rotSpeRef)^5
      "Twenty-fifth coefficient";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.VolumetricPolynomialModels.Koerner2017) then
    /*Polynomial approach presented by Körner et al.(2017):
      lamH = a1*piPre^b1
    */
    p[1] = piPre
      "Pressure ratio";

    corFac = {1,1}
      "No correction factors are needed";

  elseif (polyMod == Types.VolumetricPolynomialModels.Engelpracht2017) then
    /*Polynomial approach presented by Engelpracht (2017):
      lamH = a1 + a2*((piPre-c1)/c2) + a3*((TInl-c3)/c4)*((piPre-c1)/c2) + 
             a4*((TInl-c3)/c4) + a5*((rotSpe-c5)/c6) + a6*((rotSpe-c5)/c6)^2
    */
    p[1] = 1
      "Dummy value for usage of simple coefficient";
    p[2] = ((piPre-c[1])/c[2])
      "Pressure ratio";
    p[3] = ((Medium.temperature(staInl)-c[3])/c[4])*((piPre-c[1])/c[2])
      "Pressure ratio times inlet temperature";
    p[4] = ((Medium.temperature(staInl)-c[3])/c[4])
      "Inlet temperature";
    p[5] = ((rotSpe-c[5])/c[6])
      "Rotational speed";
    p[6] = ((rotSpe-c[5])/c[6])^2
      "Quadratic rotational speed";

    corFac = {1,1}
      "No correction factors are needed";

  else
    assert(false, "Invalid choice of polynomial approach");
  end if;

  // Calculationg of flow coefficient
  //
  lamH = min(1, corFac[1] *
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
  This model contains a calculation procedure for volumetric efficiency
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
  Actually, eigtht polynomial approaches are implemented in this
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
      <code>η<sub>vol</sub> = a1 + a2*n -
      a3*epsRef*(ρ<sub>inlIse</sub>/ρ<sub>inl</sub>-1) -
      a4*n*(ρ<sub>inlIse</sub>/ρ<sub>inl</sub>-1)</code>
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
  <tr>
    <td>
      KinarbEtAl2010
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 + a2*π</code>
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
      ZhouEtAl2010
    </td>
    <td>
      <code>η<sub>vol</sub> = 1 + a1 - a2*π^(1/κ)</code>
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
      Li2013
    </td>
    <td>
      <code>η<sub>vol</sub> = η<sub>volRef</sub> * (a1 +
      a2*(n/n<sub>ref</sub>) + a3*(n/n<sub>ref</sub>)^2)</code>
    </td>
    <td>
      R22,R134a
    </td>
    <td>
      <code>30 - 120</code>
    </td>
    <td>
      <code>4 - 12</code>
    </td>
  </tr>
  <tr>
    <td>
      HongtaoLaughmannEtAl2017
    </td>
    <td>
      <code>η<sub>vol</sub> = a1 + a2*(n/n<sub>ref</sub>) +
      a3*(n/n<sub>ref</sub>)^2 + a4*π + a5*(n/n<sub>ref</sub>)*π +
      a6*(n/n<sub>ref</sub>)^2*π + a7*π^2 + a8*(n/n<sub>ref</sub>)*π^2
      + a9*(n/n<sub>ref</sub>)^2*π^2 + a10*p<sub>out</sub> +
      a11*(n/n<sub>ref</sub>)*p<sub>out</sub> +
      a12*(n/n<sub>ref</sub>)^2*p<sub>out</sub> - a13*p<sub>inl</sub> -
      a14*(n/n<sub>ref</sub>)*p<sub>inl</sub> -
      a15*(n/n<sub>ref</sub>)^2*p<sub>inl</sub> +
      a16*p<sub>inl</sub>*p<sub>out</sub> +
      a17*(n/n<sub>ref</sub>)*p<sub>inl</sub>*p<sub>out</sub> +
      a18*(n/n<sub>ref</sub>)^2*p<sub>inl</sub>*p<sub>out</sub> +
      a19*(n/n<sub>ref</sub>)^3*p<sub>inl</sub>*p<sub>out</sub> +
      a20*(n/n<sub>ref</sub>)^4*p<sub>inl</sub>*p<sub>out</sub> -
      a21*p<sub>inl</sub>^2 - a22*(n/n<sub>ref</sub>)*p<sub>inl</sub>^2
      - a23*(n/n<sub>ref</sub>)^2*p<sub>inl</sub>^2 -
      a24*(n/n<sub>ref</sub>)^3*p<sub>inl</sub>^2 -
      a25*(n/n<sub>ref</sub>)^4*p<sub>inl</sub>^2</code>
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
      Koerner2017
    </td>
    <td>
      <code>η<sub>vol</sub> = a1*π^b1</code>
    </td>
    <td>
      R410a
    </td>
    <td>
      <code>50 - 120</code>
    </td>
    <td>
      <code>1 - 10</code>
    </td>
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
  R. Zhou, T. Zhang, J. Catano, J.T. Wen, G.J. Michna, Y. Peles, and
  M.K. Jensen, M. K. (2010): <a href=
  \"http://www.sciencedirect.com/science/article/pii/S135943111000219X\">The
  steady-state modeling and optimization of a refrigeration system for
  high heat flux removal</a>. In: <i>Applied Thermal Engineering
  30(16)</i>, S. 2347–2356
</p>
<p>
  E. Kinab, D. Marchio, P. Rivière and A. Zoughaib (2010): <a href=
  \"http://www.sciencedirect.com/science/article/pii/S0378778810002239\">Reversible
  heat pump model for seasonal performance optimization</a>. In:
  <i>Energy and Buildings 42(12)</i>, S. 2269–2280
</p>
<p>
  W. Li (2013): <a href=
  \"http://www.merl.com/publications/docs/TR2017-055.pdf\">Simplified
  steady-state modeling for variable speed compressor</a>. In:
  <i>Applied Thermal Engineering 50(1)</i>, S. 318–326
</p>
<p>
  Q. Hongtao, C.R. Laughman, D.J. Burns and S.A. Bortoff, (2017):
  <a href=
  \"http://www.merl.com/publications/docs/TR2017-055.pdf\">Dynamic
  Characteristics of an R-410A Multi-split Variable Refrigerant Flow
  Air-conditioning System</a>. In: <i>IEA Heat Pump Conference 2017</i>
</p>
<p>
  D. Körner (2017): Development of dynamic compression heat pump models
  to evaluate promising refrigerants considering legal regulations.
  <i>Master Thesis</i>
</p>
<p>
  M. Engelpracht (2017): Development of modular and scalable simulation
  models for heat pumps and chillers considering various refrigerants.
  <i>Master Thesis</i>
</p>
</html>"));
end PolynomialVolumetricEfficiency;
