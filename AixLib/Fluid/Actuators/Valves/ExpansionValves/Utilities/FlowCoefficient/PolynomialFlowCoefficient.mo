within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient;
model PolynomialFlowCoefficient
  "Model describing flow coefficient based on polynomial approach"
  extends BaseClasses.PartialFlowCoefficient;

  // Definition of parameters
  //
  parameter Types.PolynomialModels polyMod=Types.PolynomialModels.ShanweiEtAl2005
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
               enable=if (polyMod == Types.PolynomialModels.ShanweiEtAl2005)
           then true else false));
  parameter Real pDifRat = 0.84
    "Pressure differential ratio factor depending on valve moddeld"
    annotation(Dialog(group="Further geometry data",
               enable=if (polyMod == Types.PolynomialModels.Li2013) then true
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
  if (polyMod == Types.PolynomialModels.ShanweiEtAl2005) then
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
    P[2] = Medium.bubbleDensity(satInl)
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

  elseif (polyMod == Types.PolynomialModels.Li2013) then
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

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>
This model contains calculation procedures for flow coefficients (for 
more information, please check out 
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>). 
The calculation procedures based on a polynomial approach and are presented 
below.
</p>
<h4>Implemented approaches</h4>
<p>
Actually, two polynomial approaches are implemented in this package.
To add further calculation procedures, just add its name in
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices</a>
and expand the <code>if-structure</code>.<br />
</p>
<table summary=\"Polynomial approaches\" border=\"1\" cellspacing=\"0\" 
cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Reference</th>
<th>Formula</th> 
<th>Refrigerants</th> 
<th>Validity <code>T<sub>condensing</sub></code></th> 
<th>Validity <code>T<sub>evaporating</sub></code></th> 
<th>Validity <code>T<sub>subcooling</sub></code></th> 
</tr> 
<tr>
<td>ShanweiEtAl2005</td> 
<td><code>C = a1*A + a2*&rho;<sub>inlet</sub> + a3*&rho;<sub>outlet</sub> + 
a4*T<sub>subcooling</sub> + a5*d<sub>clearance</sub> + a6*(p<sub>inlet</sub>-
p<sub>outlet</sub>)</code></td> 
<td><code>R22, R407C, R410A</code></td> 
<td><code>40 - 50 &deg;C</code></td> 
<td><code>0 - 10 &deg;C</code></td> 
<td><code>1.5 - 10 &deg;C</code></td> 
</tr> 
<tr>
<td>Li2013</td> 
<td><code>C = a1 + a2*opening + a3*opening^2 + 
a4*opening*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a5*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a6*(T<sub>subcooling</sub>/T<sub>crit</sub>)^2</code></td> 
<td><code>R22, R407C, R410A</code></td> 
<td><code>30 - 50 &deg;C</code></td> 
<td><code>0 - 30 &deg;C</code></td> 
<td><code>1.5 - 15 &deg;C</code></td> 
</tr> 
</table>
<h4>References</h4>
<p>
M. Shanwei, Z. Chuan, C. Jiangping and C. Zhiujiu. (2005): 
<a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2004.12.005\">
Experimental research on refrigerant mass flow coefficient of electronic 
expansion valve</a>. In: <i>Applied Thermal Engineering 25(14)</i>, 
S. 2351&ndash;2366
</p>
<p>
Li, W. (2013): <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">
Simplified modeling analysis ofmass flow characteristics in electronic expansion 
valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8&ndash;12
</p>
</html>"));
end PolynomialFlowCoefficient;
