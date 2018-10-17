within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient;
model PowerFlowCoefficient
  "Model describing flow coefficient based on power approach"
  extends BaseClasses.PartialFlowCoefficient;

  // Definition of parameters
  //
  parameter Types.PowerModels powMod=Types.PowerModels.ShanweiEtAl2005
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
               enable=if (powMod == Types.PowerModels.ShanweiEtAl2005) then
          true else false));
  parameter Real pDifRat = 0.84
    "Pressure differential ratio factor depending on valve moddeld"
    annotation(Dialog(group="Further geometry data",
               enable=if (powMod == Types.PowerModels.Li2013) then true else
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
  if (powMod == Types.PowerModels.ShanweiEtAl2005) then
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
    P[4] = Medium.bubbleDensity(satInl)/Medium.density(staOut)
      "Density at valve's inlet and at valve's outlet";
    P[5] = (Medium.bubbleDensity(satOut)/Medium.density(staOut)- 1)/
      (Medium.bubbleDensity(satOut)/Medium.dewDensity(satOut) - 1)
      "Vapour quality at valve's outlet";

    corFact = 1
      "No correction factor is needed";

  elseif (powMod == Types.PowerModels.ZhifangAndOu2008) then
    /*Polynomial approach presented by Zhifang and Ou (2008):
      C_D = C * ((pInl-pOut)*sqrt(AVal)/sigma_inlet)^b1 * 
      (dInlPip*sqrt(rho_inlet*pInl)/eta_inlet)^b2
      
      Caution with units - In the following, none S.I units are presented:
        Pressure:        in kPa
    */
    P[1] = (pInl-pOut)*1e-3*sqrt(abs(opening*AVal))/
      max(Medium.surfaceTension(satInl),1e-6)
      "Surface tension at valve's inlet";
    P[2] = dInlPip*sqrt(abs(Medium.density(staInl)*pInl*1e-3))/
      Medium.dynamicViscosity(staInl)
      "Dynamic viscosity at valve's inlet";

    corFact = 1
      "No correction factor is needed";

  elseif (powMod == Types.PowerModels.Li2013) then
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
  C = corFact * a * product(abs(P[i])^b[i] for i in 1:nT)
    "Calculation procedure of generic power approach";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This model contains calculation procedures for flow coefficients (for 
more information, please check out 
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>). 
The calculation procedures based on a power approach and are presented 
below.
</p>
<h4>Implemented approaches</h4>
<p>
Actually, three power approaches are implemented in this package.
To add further calculation procedures, just add its name in
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices</a>
and expand the <code>if-structure</code>.<br />
</p>
<table summary=\"Power approaches\" border=\"1\" cellspacing=\"0\" 
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
<td><code>C = a * a * (A/d<sub>clearance</sub>^2)^b1 * 
((p<sub>inlet</sub>-p<sub>outlet</sub>)/p<sub>crit</sub>)^b2 * 
(T<sub>crit</sub>/T<sub>subcooling</sub>)^b3 * 
(rho<sub>inlet</sub>/rho<sub>outlet</sub>)^b4 * 
(quality)^b5</code></td> 
<td><code>R22, R407C, R410A</code></td> 
<td><code>40 - 50 &deg;C</code></td> 
<td><code>0 - 10 &deg;C</code></td> 
<td><code>1.5 - 10 &deg;C</code></td> 
</tr> 
<tr>
<td>ZhifangAndOu2008</td> 
<td><code>C = a * ((p<sub>inlet</sub>-p<sub>outlet</sub>) * 
sqrt(A)/&sigma;<sub>inlet</sub>)^b1 * 
(d<sub>inlet</sub>*sqrt(&rho;<sub>inlet</sub> * 
p<sub>inlet</sub>)/&mu;<sub>inlet</sub>)^b2</code></td> 
<td><code>R134a</code></td> 
<td><code>31 - 67.17 &deg;C</code></td> 
<td><code>no information</code></td> 
<td><code>0 - 20 &deg;C</code></td> 
</tr> 
<tr>
<td>Li2013</td> 
<td><code>C = a * (opening)^b1 * 
(T<sub>subcooling</sub>/T<sub>crit</sub>)^b2</code></td> 
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
X. Zhifang, S. Lin and O. Hongfei. (2008): 
<a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2007.03.023\">
Refrigerant flow characteristics of electronic expansion
valve based on thermodynamic analysis and experiment</a>. In: 
<i>Applied Thermal Engineering 28(2)</i>, 
S. 2381&ndash;243
</p>
<p>
Li, W. (2013): <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">
Simplified modeling analysis ofmass flow characteristics in electronic expansion 
valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8&ndash;12
</p>
</html>"));
end PowerFlowCoefficient;
