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

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end PolynomialVolumetricEfficiency;
