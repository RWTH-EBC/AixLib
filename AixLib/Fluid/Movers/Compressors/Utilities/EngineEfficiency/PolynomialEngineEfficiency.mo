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
      etaEng = a1 + a2*piPre + a3*piPre^2 + a4*piPre^3 + 
               a5*rotSpe + a6*rotSpe^2 + a7*rotSpe^3 + a8*rotSpe^4 + a9*rotSpe^5 + 
               a10*rotSpe*piPre + a11*rotSpe*piPre^2 + a12*rotSpe*piPre^3 + 
               a13*rotSpe^2*piPre + a14*rotSpe^2*piPre^2 + a15*rotSpe^2*piPre^3 + 
               a16*rotSpe^3*piPre + a17*rotSpe^3*piPre^2 + 
               a18*rotSpe^4*piPre
    */
    p[1] = 1
      "First coefficient";
    p[2] = piPre
      "Second coefficient";
    p[3] = piPre^2
      "Third coefficient";
    p[4] = piPre^3
      "Fourth coefficient";
    p[5] = rotSpe
      "Fifth coefficient";
    p[6] = rotSpe^2
      "Sixth coefficient";
    p[7] = rotSpe^3
      "Seventh coefficient";
    p[8] = rotSpe^4
      "Eighth coefficient";
    p[9] = rotSpe^5
      "Ninth coefficient";
    p[10] = rotSpe*piPre
      "Tenth coefficient";
    p[11] = rotSpe*piPre^2
      "Eleventh coefficient";
    p[12] = rotSpe*piPre^3
      "Twelfth coefficient";
    p[13] = rotSpe^2*piPre
      "Thirteenth coefficient";
    p[14] = rotSpe^2*piPre^2
      "Fourteenth coefficient";
    p[15] = rotSpe^2*piPre^3
      "Fifteenth coefficient";
    p[16] = rotSpe^3*piPre
      "Sixteenth coefficient";
    p[17] = rotSpe^3*piPre^2
      "Seventeenth coefficient";
    p[18] = rotSpe^4*piPre
      "Eighteenth coefficient";

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

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end PolynomialEngineEfficiency;
