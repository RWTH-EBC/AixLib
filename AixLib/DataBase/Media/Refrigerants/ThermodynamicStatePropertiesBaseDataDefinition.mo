within AixLib.DataBase.Media.Refrigerants;
record ThermodynamicStatePropertiesBaseDataDefinition
  "Base data definition for fitting coefficients of thermodynamic state 
  properties"
  extends Modelica.Icons.Record;

  parameter String name
  "Short description of the record"
  annotation (Dialog(group="General"));

  parameter Integer temperature_ph_nT[:]
  "Polynomial order for p (SC) | Polynomial order for h (SC) | Total number of terms (SC) |
   Polynomial order for p (SH) | Polynomial order for h (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real temperature_ph_sc[:]
  "Coefficients for supercooled regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real temperature_ph_sh[:]
  "Coefficients for superheated regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real temperature_ph_iO[:]
  "Mean SC p | Mean SC h | Std SC p | Std SC h | 
   Mean SH p | Mean SH h | Std SH p | Std SH h"
  annotation (Dialog(group="Temperature_ph"));

  parameter Integer temperature_ps_nT[:]
  "Polynomial order for p (SC) | Polynomial order for s (SC) | Total number of terms (SC) |
   Polynomial order for p (SH) | Polynomial order for s (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real temperature_ps_sc[:]
  "Coefficients for supercooled regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real temperature_ps_sh[:]
  "Coefficients for superheated regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real temperature_ps_iO[:]
  "Mean SC p | Mean SC s | Std SC p | Std SC s | 
   Mean SH p | Mean SH s | Std SH p | Std SH s"
  annotation (Dialog(group="Temperature_ps"));

  parameter Integer density_pT_nT[:]
  "Polynomial order for p (SC) | Polynomial order for T (SC) | Total number of terms (SC) |
   Polynomial order for p (SH) | Polynomial order for T (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Density_pT"));
  parameter Real density_pT_sc[:]
  "Coefficients for supercooled regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real density_pT_sh[:]
  "Coefficients for superheated regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real density_pT_iO[:]
  "Mean SC p | Mean SC T | Std SC p | Std SC T | 
   Mean SH p | Mean SH T | Std SH p | Std SH T"
  annotation (Dialog(group="Density_pT"));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 9, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>This record is a base data definition for fitting coefficients of the thermodynamic state properties depending on two independent state variables. These thermodynamic state properties are given as fitted formulas in order to reduce the overall computing time of the refrigerant model. Therefore, the fitting approach is based on &QUOT;Fast_Propane&QUOT; model developed by Sangi et al..</p>
<p>Sangi et al. used the <b>following fitting approaches</b>, which are also implemented within <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium</a>:<br></p>
<table cellspacing=\"0\" cellpadding=\"3\" border=\"1\" width=\"80%\"><tr>
<td valign=\"middle\" rowspan=\"2\"><p><i>Temperature_ph</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input1.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input2.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p><i>Temperature_ps</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input1.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input2.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p><i>Density_pT</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input1.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input2.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Functional approach</i></p></td>
<td valign=\"middle\" colspan=\"2\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/StateProperties_Approach.png\"/></p></td>
</tr>
</table>
<p><br>As it can be seen, the fitted formulas consist basically of the coefficient c<sub>i</sub> as well as of the parameters Mean<sub>i</sub> and Std<sub>i</sub>. These coefficients are the fitting coefficients and must be obtained during a fitting procedure. While the fitting procedure, the formulas presented above are fitted to external data (e.g. NIST Refprop 9.1) and the fitting coefficients are determined.</p>
<p><b>Assumptions and limitations</b> </p>
<p>The fitting procedure is performed for a<b> predefined range of the external data</b> that is given in terms of, for example, temperature and pressure. As a consequence, the fitting coefficients are also just valid within the predefined range of external data.</p>
<p><b>References</b> </p>
<p>Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita; M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275</p>
</html>"));
end ThermodynamicStatePropertiesBaseDataDefinition;
