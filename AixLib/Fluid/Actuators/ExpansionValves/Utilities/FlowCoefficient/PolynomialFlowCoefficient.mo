within AixLib.Fluid.Actuators.ExpansionValves.Utilities.FlowCoefficient;
model PolynomialFlowCoefficient
  "Model describing flow coefficient based on polynomial approach"
  extends BaseClasses.PartialFlowCoefficient;

  // Definition of parameters
  //
  parameter Choices.PolynomialModels polyMod=Choices.PolynomialModels.ShanweiEtAl2005
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

  parameter Modelica.SIunits.Diameter dCle = 0.02e-3
    "Clearance diameter dCle = d_inner - d_needle"
    annotation(Dialog(group="Further geometry data",
               enable=if (polyMod == Choices.PolynomialModels.ShanweiEtAl2005)
           then true else false));
  parameter Real pDifRat = 0.84
    "Pressure differential ratio factor depending on valve moddeld"
    annotation(Dialog(group="Further geometry data",
               enable=if (polyMod == Choices.PolynomialModels.Li2013) then true
           else false));

  // Definition of coefficients
  //
  Real P[nT]
    "Array that contains all coefficients used for the calculation procedure";
  Real corFact
    "Corraction factor used to correct flow coefficient";

  /*The correction factor is used to correct the flow coefficient if the 
    formula presented by the author is not equal to 
    m_flow = C_D*A*sqrt(2*rho_inlet*(pInl-pOut))
  */

protected
  Medium.SaturationProperties satInl
    "Saturation properties at valve's inlet conditions";
  Medium.SaturationProperties satOut
    "Saturation properties at valve's outlet conditions";

equation
  // Calculation of protected variables
  //
  satInl = Medium.setSat_p(pInl)
    "Saturation properties at valve's inlet conditions";
  satOut = Medium.setSat_p(pOut)
    "Saturation properties at valve's outlet conditions";

  // Calculation of coefficients
  //
  if (polyMod == Choices.PolynomialModels.ShanweiEtAl2005) then
    /*Polynomial approach presented by Shanwei et al. (2005):
      C_D = a1*AVal + a2*rho_inlet + a3*rho_outlet + a4*T_subcooling +
      a5*dCle + a6*(pInl-pOut)
      
      Caution with units - In the following, none S.I units are presented:
        Pressure:       in kPa
        Temperature:    in °C
        Heat capacity:  in kJ/(kg*K)
        Heat of vap.:   in kJ/kg
    */
    P[1] = opening*AVal
      "Actual coss-sectional flow area";
    P[2] = Medium.density(staInl)
      "Density at valve's inlet";
    P[3] = Medium.density(staOut)
      "Density at valve's outlet";
    P[4] = satInl.Tsat - Medium.temperature(staInl)
      "Degree of subcooling";
    P[5] = dCle
      "Radial clearance";
    P[6] = (pInl-pOut)*1e-3
      "Pressure difference between inlet and outlet";

    corFact = 1
      "No correction factor is needed";

  elseif (polyMod == Choices.PolynomialModels.Li2013) then
    /*Polynomial approach presented by Li (2013):
      C_D = a1 + a2*opening + a3*opening^2 + a4*opening*(T_subcooling/T_crit) +
      a5*(T_subcooling/T_crit) + a6*(T_subcooling/T_crit)^2
      
      Caution with units - In the following, none S.I units are presented:
        Pressure:       in kPa
        Temperature:    in °C
    */
    P[1] = 1
      "Dummy coefficient since no coefficient is needed";
    P[2] = opening
      "Degree of valve's opening";
    P[3] = opening^2
      "Quadratic degree of valve's opening";
    P[4] = opening*(satInl.Tsat - Medium.temperature(staInl))/
      (Medium.fluidConstants[1].criticalTemperature-273.15)
      "Degree of valve's opening times degree of subcooling";
    P[5] = (satInl.Tsat - Medium.temperature(staInl))/
     (Medium.fluidConstants[1].criticalTemperature-273.15)
      "Degree of subcooling";
    P[6] = ((satInl.Tsat - Medium.temperature(staInl))/
      (Medium.fluidConstants[1].criticalTemperature-273.15))^2
      "Quadratic degree of subcooling";

    corFact = 1 - ((1-pOut/pInl)/
      (3*(Medium.isentropicExponent(staOut)/1.4)*pDifRat))
      "Correction factor taking partial vaporisation into account";

      /*The correction factos takes into accout that a partial vaporisation 
        takes place while throttling process. It is a function of the pressure 
        difference between inlet and outlet, the isentropic exponent and the 
        pressure differential ratio factor depending on the valve moddeld.
      */

  else
    assert(false, "Invalid choice of polynomial approach");
  end if;

  // Calculationg of flow coefficient
  //
  C = corFact * sum(a[i]*P[i]^b[i] for i in 1:nT)
    "Calculation procedure of general polynomial";

end PolynomialFlowCoefficient;
