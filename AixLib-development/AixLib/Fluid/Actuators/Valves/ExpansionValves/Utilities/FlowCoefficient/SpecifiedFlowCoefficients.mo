within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient;
package SpecifiedFlowCoefficients
  "Package that cointains flow coefficients that are specified"
  extends Modelica.Icons.VariantsPackage;

  model ConstantFlowCoefficient
    "General model that describes a constant flow coefficient"
    extends BaseClasses.PartialFlowCoefficient;

    // Definition of parameters
    //
    parameter Real C_const(unit="1", min = 0, max = 100, nominal = 25) = 15
      "Constant flow coefficient";

  equation
    // Calculate flow coefficient
    //
    C = C_const "Allocation of constant flow coefficient";

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a simple calculation procedure for flow coefficients (for 
more information, please check out 
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>). 
The model provides a constant flow coefficient and is the most basic flow 
coefficient model.
</p>
</html>"));
  end ConstantFlowCoefficient;

  model Buck_R22R407CR410A_EEV_16_18
    "Buckingham - Similitude for R22, R407C, R410A - EEV - 1.6 mm to 1.8 mm "
    extends PowerFlowCoefficient(
      final powMod=Types.PowerModels.Li2013,
      final a=1.066,
      final b={0.8006,0.0609},
      final pDifRat=0.84);

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a calculation procedure for flow coefficients presented by 
Li (2013).<br />
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
Li, W. (2013): <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">
Simplified modeling analysis ofmass flow characteristics in electronic expansion 
valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8&ndash;12
</p>
</html>"));
  end Buck_R22R407CR410A_EEV_16_18;

  model Buck_R22R407CR410A_EEV_15_22
    "Buckingham - Similitude for R22, R407C, R410A - EEV - 1.5 mm to 2.2 mm "
    extends PowerFlowCoefficient(
      final powMod=Types.PowerModels.ShanweiEtAl2005,
      final a=0.2343,
      final b={0.0281,0.0260,-0.0477,-0.1420,-0.1291},
      final dCle=0.02e-3);

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a calculation procedure for flow coefficients presented by 
Shanwei et al. (2005).<br />
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
</table>
<h4>References</h4>
<p>
M. Shanwei, Z. Chuan, C. Jiangping and C. Zhiujiu. (2005): 
<a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2004.12.005\">
Experimental research on refrigerant mass flow coefficient of electronic 
expansion valve</a>. In: <i>Applied Thermal Engineering 25(14)</i>, 
S. 2351&ndash;2366
</p>
</html>"));
  end Buck_R22R407CR410A_EEV_15_22;

  model Power_R134a_EEV_15 "Power - R134a - EEV - 1.5 mm"
    extends PowerFlowCoefficient(
      final powMod=Types.PowerModels.ZhifangAndOu2008,
      final a=1.1868e-13,
      final b={-1.4347,3.6426});

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a calculation procedure for flow coefficients presented by 
Zhifang et al. (2008).<br />
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
</table>
<h4>References</h4>
<p>
X. Zhifang, S. Lin and O. Hongfei. (2008): 
<a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2007.03.023\">
Refrigerant flow characteristics of electronic expansion
valve based on thermodynamic analysis and experiment</a>. In: 
<i>Applied Thermal Engineering 28(2)</i>, 
S. 2381&ndash;243
</p>
</html>"));
  end Power_R134a_EEV_15;

  model Poly_R22R407CR410A_EEV_15_22
    "Polynomial   - Similitude for R22, R407C, R410A - EEV - 1.5 mm to 2.2 mm"
    extends PolynomialFlowCoefficient(
      final polyMod=Types.PolynomialModels.ShanweiEtAl2005,
      final a={-1.615e4,3.328e-4,1.4465e-3,2.9968e-3,-3.3890e2,7.0925e-5},
      final b={1,1,1,1,1,1},
      final dCle=0.02e-3);

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a calculation procedure for flow coefficients presented by 
Shanwei et al. (2005).<br />
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
<td><code>C = a1*A + a2*&rho;<sub>inlet</sub> + a3*&rho;<sub>outlet</sub> + 
a4*T<sub>subcooling</sub> + a5*d<sub>clearance</sub> + a6*(p<sub>inlet</sub>-
p<sub>outlet</sub>)</code></td> 
<td><code>R22, R407C, R410A</code></td> 
<td><code>40 - 50 &deg;C</code></td> 
<td><code>0 - 10 &deg;C</code></td> 
<td><code>1.5 - 10 &deg;C</code></td> 
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
</html>"));
  end Poly_R22R407CR410A_EEV_15_22;

  model Poly_R22_EEV_16 "Polynomial - R22 - EEV - 1.6 mm"
    extends PolynomialFlowCoefficient(
      final polyMod=Types.PolynomialModels.Li2013,
      final a={-0.03469,1.64866,-0.84227,1.19513,0,0},
      final b={1,1,1,1,1,1},
      final pDifRat=0.84);

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a calculation procedure for flow coefficients presented by 
Li (2013).<br />
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
<td>Li2013</td> 
<td><code>C = a1 + a2*opening + a3*opening^2 + 
a4*opening*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a5*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a6*(T<sub>subcooling</sub>/T<sub>crit</sub>)^2</code></td> 
<td><code>R22</code></td> 
<td><code>30 - 50 &deg;C</code></td> 
<td><code>0 - 30 &deg;C</code></td> 
<td><code>1.5 - 15 &deg;C</code></td> 
</tr> 
</table>
<h4>References</h4>
<p>
Li, W. (2013): <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">
Simplified modeling analysis ofmass flow characteristics in electronic expansion 
valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8&ndash;12
</p>
</html>"));
  end Poly_R22_EEV_16;

  model Poly_R407c_EEV_18 "Polynomial - R407c - EEV - 1.8 mm"
    extends PolynomialFlowCoefficient(
      final polyMod=Types.PolynomialModels.Li2013,
      final a={-0.07154,1.67713,-0.79141,1.09516,0,0},
      final b={1,1,1,1,1,1},
      final pDifRat=0.84);

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a calculation procedure for flow coefficients presented by 
Li (2013).<br />
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
<td>Li2013</td> 
<td><code>C = a1 + a2*opening + a3*opening^2 + 
a4*opening*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a5*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a6*(T<sub>subcooling</sub>/T<sub>crit</sub>)^2</code></td> 
<td><code>R407C</code></td> 
<td><code>30 - 50 &deg;C</code></td> 
<td><code>0 - 30 &deg;C</code></td> 
<td><code>1.5 - 15 &deg;C</code></td> 
</tr> 
</table>
<h4>References</h4>
<p>
Li, W. (2013): <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">
Simplified modeling analysis ofmass flow characteristics in electronic expansion 
valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8&ndash;12
</p>
</html>"));
  end Poly_R407c_EEV_18;

  model Poly_R410a_EEV_18 "Polynomial - R410a - EEV - 1.8 mm"
    extends PolynomialFlowCoefficient(
      final polyMod=Types.PolynomialModels.Li2013,
      final a={-0.07374,1.5461,-0.73679,1.09651,0,0},
      final b={1,1,1,1,1,1},
      final pDifRat=0.84);

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
This model contains a calculation procedure for flow coefficients presented by 
Li (2013).<br />
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
<td>Li2013</td> 
<td><code>C = a1 + a2*opening + a3*opening^2 + 
a4*opening*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a5*(T<sub>subcooling</sub>/T<sub>crit</sub>) + 
a6*(T<sub>subcooling</sub>/T<sub>crit</sub>)^2</code></td> 
<td><code>R410A</code></td> 
<td><code>30 - 50 &deg;C</code></td> 
<td><code>0 - 30 &deg;C</code></td> 
<td><code>1.5 - 15 &deg;C</code></td> 
</tr> 
</table>
<h4>References</h4>
<p>
Li, W. (2013): <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">
Simplified modeling analysis ofmass flow characteristics in electronic expansion 
valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8&ndash;12
</p>
</html>"));
  end Poly_R410a_EEV_18;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 06, 2017, by Mirko Engelpracht:<br />
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package cointains flow coefficients that are already specified.
This means that the calculation approaches of the flow coeffiencient
presented before are adapted for a specific expansion valve type and
a specific refrigerant.
</p>
<h4>Naming and abbreviations</h4>
<p>
In the following, a guideline of naming flow coefficient models is
summarised:
</p>
<p style=\"margin-left: 30px;\">
<i>Approach of calculating flow coefficient</i> _ 
<i>Valid refrigerants</i> _
<i>Type of expansion valve</i> _
<i>Diameter of cross-sectional area of expansion valve</i>
</p>
<ol>
<li><u>Approach:</u> Approach of calculating flow coefficient,
e.g. polynomial or power.</li>
<li><u>Refrigerant:</u> Refrigerants the flow coefficent model is
valid for, e.g. R134a or R410a.</li>
<li><u>Type:</u> Type of expansion valve,
e.g. electric expansion valve (EEV).</li>
<li><u>Diameter:</u> Diameter of the cross-sectional area
of expansion valves if it is fully opened,
e.g. 1.6 mm.</li>
</ol>
</html>"));
end SpecifiedFlowCoefficients;
