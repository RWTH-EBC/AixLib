within AixLib.Media.Refrigerants;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  class Composition "Composition of the regrigerant library"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
The refrigerants' library consists mainly of five packages.
</p>
<ol>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces\">Interfaces:</a> 
Contains both templates to create new refrigerant models and partial models 
of the modeling approaches implemented in the library.</li>
<li>
<a href=\"modelica://AixLib.DataBase.Media.Refrigerants\">DataBases:</a> 
Contains records with fitting coefficients used for, for example, different 
modeling approaches implemented in the library.</li>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.R134a\">Refrigerants:</a> 
Packages of different refrigerants which contain refrigerant models ready 
to use.</li>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.Examples\">Examples:</a> 
Contains example models to show the functionality of the 
refrigerant models.</li>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.Validation\">Validation:</a> 
Contains validation models to validate the modeling approaches 
implemented in the library.</li>
</ol>
<p>
The ready to use models are provided in the following packages:
</p>
<ul>
<li><a href=\"modelica://AixLib.Media.Refrigerants.R134a\">R134a</a></li>
<li><a href=\"modelica://AixLib.Media.Refrigerants.R290\">R290</a></li>
<li><a href=\"modelica://AixLib.Media.Refrigerants.R410a\">R410a</a></li>
</ul>
</html>",   revisions="<html>
<ul>
  <li>
  October 14, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end Composition;

  class Approaches "Approaches implemented in refrigerant library"
    extends Modelica.Icons.Information;

    class HybridApproach "Hybrid Approach"
      extends Modelica.Icons.Information;

      annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 14, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
The hybrid approach is developed by Sangi et al. and consists of both 
the Helmholtz equation of state and fitted formula for thermodynamic 
state properties at bubble or dew line (e.g. p<sub>sat</sub> or 
h<sub>l,sat</sub>) and thermodynamic state properties depending on two
independent state properties (e.g. T_ph or T_ps). In the following, the basic
formulas of the hybrid approach are given.
</p>
<p>
<h4>The Helmholtz equation of state</h4>
</p>
<p>
The Helmholtz equation of state (EoS) allows the accurate description of
fluids&apos; thermodynamic behaviour and uses the Helmholtz energy as
fundamental thermodynamic relation with temperature and density as independent
variables. Furthermore, the EoS allows determining all thermodynamic state
properties from its partial derivatives and its<b> general formula</b> is
given below:
</p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_EoS.png\"
alt=\"Calculation procedure of dimensionless Helmholtz energy\"/></p>
<p>
As it can be seen, the general formula of the EoS can be divided in two part:
The <b>ideal gas part (left summand) </b>and the <b>residual part (right
summand)</b>. Both parts&apos; formulas are given below:</p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_IdealGasPart.png\"
alt=\"Calculation procedure of dimensionless ideal gas Helmholtz energy\"/></p>
<p align=\"center\">
<img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_ResidualPart.png\"
alt=\"Calculation procedure of dimensionless residual Helmholtz energy\"/></p>
<p>
Both, the ideal gas part and the residual part can be divided in three
subparts (i.e. the summations) that contain different coefficients (e.g. nL,
l<sub>i</sub>, p<sub>i</sub> or e<sub>i</sub>). These coefficients are
fitting coefficients and must be obtained during a fitting procedure. While
the fitting procedure, the general formula of the EoS is fitted to external
data (e.g. obtained from measurements or external media libraries) and the
fitting coefficients are determined. Finally, the formulas obtained during
the fitting procedure are implemented in an explicit form.
</p>
<p>
For further information of <b>the EoS and its partial derivatives</b>, please
read the paper &quot;
<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia -
A fluid properties library</a>&quot; by Thorade and Saadat as well as the
paper &quot;
<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
Partial derivatives of thermodynamic state properties for dynamic
simulation</a>&quot; by Thorade and Saadat.
</p>
<p>
<h4>Fitted formulas</h4>
</p>
<p>
Fitted formulas allow to reduce the overall computing time of the refrigerant
model. Therefore, both thermodynamic state properties at bubble and dew line
and thermodynamic state properties depending on two independent state
properties are expresses as fitted formulas. The fitted formulas&apos;
approaches implemented in this package are developed by Sangi et al. within
their &quot;Fast_Propane&quot; model and given below:<br />
</p>
<table summary=\"Formulas for calculating saturation properties\"
cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\"
style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\"><p>
  <i>Saturation pressure</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationPressure.png\"
  alt=\"Formula to calculate saturation pressure\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Saturation temperature</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationTemperature.png\"
  alt=\"Formula to calculate saturation temperature\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Bubble density</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleDensity.png\"
  alt=\"Formula to calculate bubble density\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Dew density</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewDensity.png\"
  alt=\"Formula to calculate dew density\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Bubble Enthalpy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEnthalpy.png\"
  alt=\"Formula to calculate bubble enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Dew Enthalpy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEnthalpy.png\"
  alt=\"Formula to calculate dew enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Bubble Entropy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEntropy.png\"
  alt=\"Formula to calculate bubble entropy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Dew Entropy</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEntropy.png\"
  alt=\"Formula to calculate dew entropy\"/>
</p></td>
</tr>
</table>
<table summary=\"Formulas for calculating thermodynamic properties at
superheated and supercooled regime\" cellspacing=\"0\" cellpadding=\"3\"
border=\"1\" width=\"80%\" style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\" rowspan=\"2\"><p>
  <i>Temperature_ph</i>
</p></td>
<td valign=\"middle\"><p>
  First Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input1.png\"
  alt=\"First input required to calculate temperature by pressure and specific
  enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  Second Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input2.png\"
  alt=\"Second input required to calculate temperature by pressure and
  specific enthalpy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p>
  <i>Temperature_ps</i>
</p></td>
<td valign=\"middle\"><p>
  First Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input1.png\"
  alt=\"First input required to calculate temperature by pressure and
  specific entropy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  Second Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input2.png\"
  alt=\"Second input required to calculate temperature by pressure and
  specific entropy\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p>
  <i>Density_pT</i>
</p></td>
<td valign=\"middle\"><p>
  First Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input1.png\"
  alt=\"First input required to calculate density by pressure and temperature\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  Second Input
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input2.png\"
  alt=\"Second input required to calculate density by pressure and
  temperature\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>Functional approach
</i></p></td>
<td valign=\"middle\" colspan=\"2\"><p>
  <img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/StateProperties_Approach.png\"
  alt=\"Calculation procedure for supercooled and superheated region\"/>
</p></td>
</tr>
</table>
<p>
As it can be seen, the fitted formulas consist basically of the coefficients
e<sub>i</sub>, c<sub>i</sub> as well as of the parameters Mean<sub>i</sub>
and Std<sub>i</sub>. These coefficients are the fitting coefficients and must
be obtained during a fitting procedure. While the fitting procedure, the
formulas presented above are fitted to external data (e.g. obtained from
measurements or external media libraries) and the fitting coefficients are
determined. Finally, the formulas obtained during the fitting procedure are
implemented in an explicit form.
</p>
<p>
For further information of <b>the hybrid approach</b>, please read the paper
&quot;<a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the
Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>&quot;
by Sangi et al..
</p>
<p>
<h4>Smooth transition</h4>
</p>
<p>
To ensure a smooth transition between different regions (e.g. from supercooled
region to two-phase region) and, therefore, to avoid discontinuities as far as
possible, Sangi et al. implemented functions for a smooth transition between
the regions. An example (i.e. specificEnthalpy_ps) of these functions is
given below:<br />
</p>
<table summary=\"Calculation procedures to avoid numerical instability at
phase change\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\"
style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\"><p>
  <i>From supercooled region to bubble line and vice versa</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SupercooledToTwoPhase.png\"
  alt=\"Calculation procedure for change from supercooled to two-phase\"/>
</p></td>
<tr>
<td valign=\"middle\"><p>
  <i>From dew line to superheated region and vice versa</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/TwoPhaseToSuperheated.png\"
  alt=\"Calculation procedure for change from superheated to two-phase\"/>
</p></td>
</tr>
<tr>
<td valign=\"middle\"><p>
  <i>From bubble or dew line to two-phase region and vice versa</i>
</p></td>
<td valign=\"middle\"><p>
  <img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationToTwoPhase.png\"
  alt=\"Calculation procedure for change from saturation to two-phase\"/>
</p></td>
</tr>
</table>
<h4>Assumptions and limitations</h4>
<p>
Two limitations are known for this package:
</p>
<ol>
<li>The modelling approach implemented in this package is a hybrid approach
and, therefore, is based on the Helmholtz equation of state as well as on
fitted formula. Hence, the refrigerant model is just valid within the valid
range of the fitted formula.</li>
<li>It may be possible to have discontinuities when moving from one region
to another (e.g. from supercooled region to two-phase region). However,
functions are implemented to reach a smooth transition between the regions
and to avoid these discontinuities as far as possible.
(Sangi et al., 2014)</li>
</ol>
</html>"));
    end HybridApproach;

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 14, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",   info="<html>
<p>
Currently, one modeling approach is implemented in the refrigerants&apos; 
library:
</p>
<ol>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula\">
Hybrid Approach:</a> The hybrid approach uses the both the Helmholtz equation 
of state (EoS) and polynomial functions. The polynomial functions are used to 
avoid iterations that normally occur while using modeling approaches only 
based on the EoS.</li>
</ol>
<h4>Assumptions and limitations:</h4>
<p>
Up to this point, the modeling approaches implemented in the library are only 
valid for pure and pseudo-pure refrigerants. Consequently, calculation 
procedures of pseudo-pure refrigerants are only roughly valid within the 
two-phase region.
</p>
</html>"));
  end Approaches;

  class Naming "Naming and abbreviations"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
In general, both the naming and the abbreviations follow the guidelines 
presented in the media package of the Modelica standard library. However, 
adaptions are made for functions and variables related to the Helmholtz 
equation of state. These adaptions are presented below.
</p>
<h4>Naming of refrigerant models</h4>
<p>
The naming of the models follows the guideline presented below:
</p>
<p style=\"margin-left: 30px;\">
<i>Refrigerant</i> _ <i>Reference Point</i> _ 
<i>Range of validity for pressure</i> _ 
<i>Range of validity for temperature</i> _ 
<i>Approach of calculating fitted formulas</i>
</p>
<p>
<ol>
<li><u>Refrigerant:</u> Name of the refrigerant, 
e.g. R134a or R410a.</li>
<li><u>Reference Point:</u> Reference point chosen for the model, 
e.g. IIR (h = 200 kJ/lkg and s = 1 kJ/kg/K at 273.15 K at 
saturated liquid line).</li>
<li><u>Validity pressure:</u> Range of validity for pressure given in bar. 
Caution: 0.5 bar is written as 05 or 39.5 bar is written as 395.</li>
<li><u>Validity temperature:</u> Range of validity for temperature in K. 
Caution: No digits are presented.</li>
<li><u>Approach:</u> Approach of calculating fitted formulas. 
Currently, three different calculating rules are implemented.</li>
</ol>
</p>
<p>
<ul>
<li><i>Record:</i> The fitting coefficients used for the fitted formulas 
are stored in records.</li>
<li><i>Formula:</i> Fitted formulas are hard-coded in the refrigerant model 
due to simulation speed and, therefore, all fitting coefficients are 
directly stored in the models.</li>
<li><i>Horner:</i> Fitted formulas are hard-coded in the refrigerant model 
using the Horner pattern due to simulation speed and, therefore, all fitting 
coefficients are directly stored in the models.</li>
</ul>
</p>
<h4>Abbreviations of parameters, constants, variables and functions</h4>
<p>
Some special abbreviations are introduced for functions and variables related 
to the Helmholtz energy equation of state. Some examples are given below:
</p>
<table summary=\"Abbreviations for EoS\" cecellpadding=\"2\" border=\"1\" 
width=\"80%\" style=\"border-collapse:collapse;\">
<tr>
  <td><b>Expression</b></td>
  <td><b>Abbreviation</b></td>
  <td><b>Comment</b></td>
</tr>
<tr>
  <td><p>alpha_0</p></td>
  <td><p>f_Idg</p></td>
  <td><p>Helmholtz energy of ideal gas</p></td>
</tr>
<tr>
  <td><p>alpha_r</p></td>
  <td><p>f_Res</p></td>
  <td><p>Helmholtz energy of residual gas</p></td>
</tr>
<tr>
  <td><p>tau * d(alpha_0)/(dtau)_delta=const.</p></td>
  <td><p>t_fIdg_t</p></td>
  <td><p>Partial derivative of f_Idg with respect to tau</p></td>
</tr>
<tr>
  <td><p>tau*tau * dd(alpha_0)/(dtau*dtau)_delta=const.</p></td>
  <td><p>tt_fIdg_tt</p></td>
  <td><p>Partial derivative of f_Idg with respect to tau*tau</p></td>
</tr>
<tr>
  <td><p>tau*delta * dd(alpha_r)/(dtau*ddelta)</p></td>
  <td><p>td_fRes_td</p></td>
  <td><p>Partial derivative of f_Res with respect to tau*delta </p></td>
</tr>
</table>
<p>
Some special abbreviations are introduced for partial derivatives. 
Some examples are given below:
</p>
<table summary=\"Abbreviations for partial derivatives\"  cellspacing=\"0\" 
cellpadding=\"2\" border=\"1\" width=\"80%\" 
style=\"border-collapse:collapse;\">
<tr>
  <td><b>Expression</b></td>
  <td><b>Abbreviation</b></td>
  <td><b>Comment</b></td>
</tr>
<tr>
  <td><p>d(d)/(dp)_h=const.</p></td>
  <td><p>ddph</p></td>
  <td><p>Partial derivative of density with respect to pressure 
  at constant specific enthalpy</p></td>
</tr>
<tr>
  <td><p>d(T)/(ds)_p=const.</p></td>
  <td><p>dTsp</p></td>
  <td><p>Partial derivative of temperature with respect to specific 
  entropy and constant pressure</p></td>
</tr>
<tr>
  <td><p>d(Tsat)/(dp)</p></td>
  <td><p>dTp</p></td>
  <td><p>Partial derivative of saturation temperature with 
  respect to pressure</p></td>
</tr>
<tr>
  <td><p>d(dl)/(dp)</p></td>
  <td><p>ddldp</p></td>
  <td><p>Partial derivative of bubble density with respect 
  to pressure</p></td>
</tr>
<tr>
  <td><p>d(dv)/(dp)</p></td>
  <td><p>ddvdp</p></td>
  <td><p>Partial derivative of dew density with respect to pressure</p></td>
</tr>
</table>
</html>"));
  end Naming;

  class References "References"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<p>
In the following, the literature used for the media library is summarised.
</p>
<h4>References regarding the Helmholtz equation of state:</h4>
<p>
R. Span (2000):
<a href=\"http://dx.doi.org/10.1007/978-3-662-04092-8\">
Multiparameter Equations of State: An Accurate Source of Thermodynamic 
Property Data</a>. <i>Springer, Berlin und Heidelberg</i>
</p>
<p>
Thorade, Matthis; Saadat, Ali (2012):
<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia -
A fluid properties library</a>. In: <i>Proceedings of the 9th International
Modelica Conference</i>; September 3-5; 2012; Munich; Germany.
Link&ouml;ping University Electronic Press, S. 63&ndash;70.
</p>
<p>
Thorade, Matthis; Saadat, Ali (2013):
<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
Partial derivatives of thermodynamic state properties for dynamic
simulation</a>. In:<i> Environmental earth sciences 70 (8)</i>,
S. 3497&ndash;3503.
</p>
<h4>References regarding the hybrid approach:</h4>
<p>
Klasing,Freerk: A New Design for Direct Exchange Geothermal Heat Pumps -
Modeling, Simulation and Exergy Analysis. <i>Master thesis</i>
</p>
<p>
Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">
A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic
Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund,
Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press
(Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275
</p>
<h4>References regarding refrigerant R134a:</h4>
<p>
Tillner-Roth, R.; Baehr, H. D. (1994): 
<a href=\"http://dx.doi.org/10.1063/1.555958\">
An International Standard Formulation for the thermodynamic Properties of 
1,1,1,2|Tetrafluoroethane (HFC|134a) for Temperatures from 170 K to 455 K 
and Pressures up to 70 MPa</a>. In: <i>Journal of physical and chemical 
reference data (23)</i>, S. 657–729.
</p>
<p>
Perkins, R. A.; Laesecke, A.; Howley, J.; Ramires, M. L. V.; Gurova, A. N.;
Cusco, L. (2000): 
<a href=\"http://ws680.nist.gov/publication/get_pdf.cfm?pub_id=831676\">
Experimental thermal conductivity values for the IUPAC round-robin sample 
of 1,1,1,2-tetrafluoroethane (R134a)</a>. Gaithersburg, MD:
<i>National Institute of Standards and Technology.</i>
</p>
<p>
Huber, Marcia L.; Laesecke, Arno; Perkins, Richard A. (2003): 
<a href=\"http://dx.doi.org/10.1021/ie0300880\">
Model for the Viscosity and Thermal Conductivity of Refrigerants, Including 
a New Correlation for the Viscosity of R134a </a>. In: <i>Ind. Eng. Chem. 
Res. 42 (13)</i>, S. 3163–3178.
</p>
<p>
Mulero, A.; Cachadiña, I.; Parra, M. I. (2012): 
<a href=\"http://dx.doi.org/10.1063/1.4768782\">
Recommended Correlations for the Surface Tension of Common Fluids</a>. 
In: <i>Journal of physical and chemical reference data 41 (4)</i>, 
S. 43105.
</p>
<h4>References regarding refrigerant R290:</h4>
<p>
Klasing,Freerk: A New Design for Direct Exchange Geothermal Heat Pumps -
Modeling, Simulation and Exergy Analysis. <i>Master thesis</i>
</p>
<p>
Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
M&uuml;ller, Dirk (2014): 
<a href=\"http://dx.doi.org/10.3384/ecp14096\">
A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic
Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund,
Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press
(Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275
</p>
<p>
Scalabrin, G.; Marchi, P.; Span, R. (2006): 
<a href=\"http://dx.doi.org/10.1063/1.2213629\">
A Reference Multiparameter Viscosity Equation for Propane with an 
Optimized Functional Form</a>. In: <i>J.Phys. Chem. Ref. Data, 
Vol. 35, No. 3</i>, S. 1415-1442
</p>
<h4>References regarding refrigerant R410a:</h4>
<p>
Nabizadeh, H.; Mayinger, F. (1999): 
<a href=\"http://dx.doi.org/10.1007/978-1-4615-4777-8_1\">
Viscosity of Gaseous R404A, R407C, R410A, and R507</a>. 
In: <i>International Journal of Thermophysics 20 (3)</i>, S.
777–790.
</p>
<p>
Geller, V. Z.; Bivens, D.; Yokozeki, A. (2000): 
<a href=\"http://docs.lib.purdue.edu/iracc/508\">
Viscosity of Mixed Refrigerants, R404A, R407C, R410A, and R507C. 
In: <i>International refrigeration and air conditioning conference</i>. 
USA, S. 399–406.
</p>
<p>
Geller, V. Z.; Nemzer, B. V.; Cheremnykh, U. V. (2001): 
<a href=\"http://dx.doi.org/10.1023/A:1010691504352\">
Thermal Conductivity of the Refrigerant Mixtures R404A, R407C, 
R410A, and R507A</a>. In:<i>International Journal of Thermophysics 
22 (4)</i>, 1035–1043.
</p>
<p>
Fröba, A. P.; Leipertz, A. (2003): 
<a href=\"http://dx.doi.org/10.1023/A:1026152331710\">
Thermophysical Properties of the Refrigerant Mixtures R410A and 
R407C from Dynamic Light Scattering (DLS)</a>. In: <i>International 
Journal ofThermophysics 24 (5)</i>, S. 1185–1206.
</p>
<p>
Lemmon, E. W. (2003): 
<a href=\"http://dx.doi.org/10.1023/A:1025048800563\">
Pseudo-Pure Fluid Equations of State for the Refrigerant Blends R-410A,
 R-404A, R-507A, and R-407C</a>. In: <i>International Journal of
Thermophysics 24 (4)</i>, S. 991–1006.
</p>
</html>",
  revisions="<html>
<ul>
  <li>
  October 14, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end References;

  annotation(DocumentationClass = true, Documentation(info="<html>
<p>
This library provides different refrigerant models that are used, for
example, in heat pumps or chillers. The objectives of these refrigerant 
models are both to provide an accurate description of thermodynamic 
properties and to provide fast models to speed up the overall simulation 
time of complex simulation models.
</p>
<p>
In the following User's Guide, a short summary of the refrigerants'
library is given to allow the user an easy use of the refrigerant
models.
</p>
<ol>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.UsersGuide.Composition\">
Composition of the library</a></li>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.UsersGuide.Approaches\">
Approaches implemented</a></li>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.UsersGuide.Naming\">
Naming and abbreviations</a></li>
<li>
<a href=\"modelica://AixLib.Media.Refrigerants.UsersGuide.References\">
References</a></li>
</ol>
<p>
Additionally, descriptions of all models are provided in each models
information section.
</p>
</html>", revisions="<html>
<ul>
  <li>
  October 14, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end UsersGuide;
