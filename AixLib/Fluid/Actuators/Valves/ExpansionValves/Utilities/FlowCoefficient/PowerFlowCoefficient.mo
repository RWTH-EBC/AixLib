within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient;
model PowerFlowCoefficient
  "Model describing flow coefficient based on power approach"
  extends BaseClasses.PartialFlowCoefficient;

  // Definition of parameters
  //
  parameter Choices.PowerModels powMod=Choices.PowerModels.ShanweiEtAl2005
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

  parameter Modelica.SIunits.Diameter dCle = 0.02e-3
    "Clearance diameter dCle = d_inner - d_needle"
    annotation(Dialog(group="Further geometry data",
               enable=if (powMod == Choices.PowerModels.ShanweiEtAl2005) then
          true else false));
  parameter Real pDifRat = 0.84
    "Pressure differential ratio factor depending on valve moddeld"
    annotation(Dialog(group="Further geometry data",
               enable=if (powMod == Choices.PowerModels.Li2013) then true else
          false));

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
  if (powMod == Choices.PowerModels.ShanweiEtAl2005) then
    /*Polynomial approach presented by Shanwei et al. (2005):
      C_D = C * (AVal/dCle^2)^b1 * ((pInl-pOut)/p_crit)^b2 *
      (T_crit/T_supercooled)^b3 * (rho_inlet/rho_outlet)^b4 *
      (quality)^b5
      
      Caution with units - In the following, none S.I units are presented:
        Pressure:       in kPa
        Temperature:    in °C
        Heat capacity:  in kJ/(kg*K)
        Heat of vap.:   in kJ/kg
    */
    P[1] = opening*AVal/(dCle^2)
      "Actual coss-sectional flow area";
    P[2] = (pInl-pOut)/Medium.fluidConstants[1].criticalPressure
      "Pressure difference";
    P[3] = (Medium.fluidConstants[1].criticalTemperature-273.15)/
      max((satInl.Tsat - Medium.temperature(staInl)),0.01)
      "Degree of subooling";
    P[4] = Medium.density(staInl)/Medium.density(staOut)
      "Density at valve's inlet and at valve's outlet";
    P[5] = (Medium.bubbleDensity(satOut)/Medium.density(staOut)- 1)/
      (Medium.bubbleDensity(satOut)/Medium.dewDensity(satOut) - 1)
      "Vapour quality at valve's outlet";

    corFact = 1
      "No correction factor is needed";

  elseif (powMod == Choices.PowerModels.ZhifangAndOu2008) then
    /*Polynomial approach presented by Zhifang and Ou (2008):
      C_D = C * ((pInl-pOut)*sqrt(AVal)/sigma_inlet)^b1 * 
      (dInlPip*sqrt(rho_inlet*pInl)/eta_inlet)^b2
      
      Caution with units - In the following, none S.I units are presented:
        Pressure:        in kPa
    */
    P[1] = (pInl-pOut)*1e-3*sqrt(abs(opening*AVal))/
      Medium.surfaceTension(satInl)
      "Surface tension at valve's inlet";
    P[2] = dInlPip*sqrt(abs(Medium.density(staInl)*pInl*1e-3))/
      Medium.dynamicViscosity(staInl)
      "Dynamic viscosity at valve's inlet";

    corFact = 1
      "No correction factor is needed";

  elseif (powMod == Choices.PowerModels.Li2013) then
    /*Polynomial approach presented by Li (2013):
      C_D = C * (opening)^b1 * (T_supercooled/T_crit)^b2
      
      Caution with units - In the following, none S.I units are presented:
        Pressure:       in kPa
        Temperature:    in °C
    */
    P[1] = opening
      "Degree of valve's opening";
    P[2] = (satInl.Tsat - Medium.temperature(staInl))/
      (Medium.fluidConstants[1].criticalTemperature-273.15)
      "Degree of subcooling";

    corFact = 1 - ((1-pOut/pInl)/
      (3*(Medium.isentropicExponent(staOut)/1.4)*pDifRat))
      "Correction factor taking partial vaporisation into account";

    /*The correction factos takes into accout that a partial vaporisation 
      takes place while throttling process. It is a function of the pressure 
      difference between inlet and outlet, the isentropic exponent and the 
      pressure differential ratio factor depending on the valve moddeld.
    */

  else
    assert(false, "Invalid choice of power approach");
  end if;

  // Calculationg of flow coefficient
  //
  C = corFact * a * product(P[i]^b[i] for i in 1:nT)
    "Calculation procedure of generic power approach";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end PowerFlowCoefficient;
