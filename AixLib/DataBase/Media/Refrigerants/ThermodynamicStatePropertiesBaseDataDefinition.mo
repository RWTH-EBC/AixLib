within AixLib.DataBase.Media.Refrigerants;
record ThermodynamicStatePropertiesBaseDataDefinition
  "Base data definition for fitting coefficients of thermodynamic state
  properties"
  extends Modelica.Icons.Record;

  parameter String name
  "Short description of the record"
  annotation (Dialog(group="General"));

  parameter Integer T_phNt[:]
  "Polynomial order for p (SC) | Polynomial order for h (SC) |
   Total number of terms (SC) | Polynomial order for p (SH) |
   Polynomial order for h (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tl_phA[:]
  "Coefficients a for supercooled regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tl_phB[:]
  "Coefficients b for supercooled regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tl_phC[:]
  "Coefficients c for supercooled regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tl_phD[:]
  "Coefficient d for supercooled regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tv_phA[:]
  "Coefficients a for superheated regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tv_phB[:]
  "Coefficients b for superheated regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tv_phC[:]
  "Coefficients c for superheated regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real Tv_phD[:]
  "Coefficient d for superheated regime"
  annotation (Dialog(group="Temperature_ph"));
  parameter Real T_phIO[:]
  "Mean SC p | Std SC p | Mean SC h | Std SC h | Mean SC T | Std SC T |
   Mean SH p | Std SH p | Mean SH h | Std SH h | Mean SH T | Std SH T"
  annotation (Dialog(group="Temperature_ph"));

  parameter Integer T_psNt[:]
  "Polynomial order for p (SC) | Polynomial order for s (SC) |
   Total number of terms (SC) | Polynomial order for p (SH) |
   Polynomial order for s (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tl_psA[:]
  "Coefficients a for supercooled regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tl_psB[:]
  "Coefficients b for supercooled regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tl_psC[:]
  "Coefficients c for supercooled regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tl_psD[:]
  "Coefficient d for supercooled regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tv_psA[:]
  "Coefficients a for superheated regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tv_psB[:]
  "Coefficients b for superheated regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tv_psC[:]
  "Coefficients c for superheated regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real Tv_psD[:]
  "Coefficient d for superheated regime"
  annotation (Dialog(group="Temperature_ps"));
  parameter Real T_psIO[:]
  "Mean SC p | Std SC p | Mean SC s | Std SC s | Mean SC T | Std SC T |
   Mean SH p | Std SH p | Mean SH s | Std SH s | Mean SH T | Std SH T"
  annotation (Dialog(group="Temperature_ps"));

  parameter Integer d_pTNt[:]
  "Polynomial order for p (SC) | Polynomial order for T (SC) |
   Total number of terms (SC) | Polynomial order for p (SH) |
   Polynomial order for T (SH) | Total number of terms (SH)"
  annotation (Dialog(group="Density_pT"));
  parameter Real dl_pTA[:]
  "Coefficients a for supercooled regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real dl_pTB[:]
  "Coefficients b for supercooled regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real dl_pTC[:]
  "Coefficients c for supercooled regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real dl_pTD[:]
  "Coefficient d for supercooled regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real dv_pTA[:]
  "Coefficients a for superheated regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real dv_pTB[:]
  "Coefficients b for superheated regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real dv_pTC[:]
  "Coefficients c for superheated regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real dv_pTD[:]
  "Coefficient d for superheated regime"
  annotation (Dialog(group="Density_pT"));
  parameter Real d_pTIO[:]
  "Mean SC p | Std SC p | Mean SC T | Std SC T | Mean SC d | Std SC d |
   Mean SH p | Std SH p | Mean SH T | Std SH T | Mean SH d | Std SH d"
  annotation (Dialog(group="Density_pT"));

  annotation (Documentation(revisions="<html><ul>
  <li>June 9, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",     info="<html>
<p>
  This record is a base data definition for fitting coefficients of the
  thermodynamic state properties depending on two independent state
  variables. These thermodynamic state properties are given as fitted
  formulas in order to reduce the overall computing time of the
  refrigerant model. Therefore, the fitting approach is based on
  \"Fast_Propane\" model developed by Sangi et al..
</p>
<p>
  Sangi et al. used the <b>following fitting approaches</b>, which are
  also implemented within <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>:<br/>
</p>
<table summary=\"Formulas for calculating thermodynamic properties\"
cellspacing=\"0\" cellpadding=\"3\" border=\"1\" width=\"80%\" style=
\"border-collapse:collapse;\">
  <tr>
    <td valign=\"middle\" rowspan=\"2\">
      <p>
        <i>Temperature_ph</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        First Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input1.png\"
        alt=
        \"First input required to calculate temperature by pressure and specific enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        Second Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input2.png\"
        alt=
        \"Second input required to calculate temperature by pressure and specific enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\" rowspan=\"2\">
      <p>
        <i>Temperature_ps</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        First Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input1.png\"
        alt=
        \"First input required to calculate temperature by pressure and specific entropy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        Second Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input2.png\"
        alt=
        \"Second input required to calculate temperature by pressure and specific entropy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\" rowspan=\"2\">
      <p>
        <i>Density_pT</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        First Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input1.png\"
        alt=
        \"First input required to calculate density by pressure and temperature\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        Second Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input2.png\"
        alt=
        \"Second input required to calculate density by pressure and temperature\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Functional approach</i>
      </p>
    </td>
    <td valign=\"middle\" colspan=\"2\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/StateProperties_Approach.png\"
        alt=
        \"Functional approach of calculating supercooled and superheated region\">
      </p>
    </td>
  </tr>
</table>
<p>
  As it can be seen, the fitted formulas consist basically of the
  coefficient c<sub>i</sub> as well as of the parameters
  Mean<sub>i</sub> and Std<sub>i</sub>. These coefficients are the
  fitting coefficients and must be obtained during a fitting procedure.
  While the fitting procedure, the formulas presented above are fitted
  to external data (e.g. obtained from measurements or external media
  libraries) and the fitting coefficients are determined.
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  The fitting procedure is performed for a <b>predefined range of the
  external data</b> that is given in terms of, for example, temperature
  and pressure. As a consequence, the fitting coefficients are also
  just valid within the predefined range of external data.
</p>
<h4>
  References
</h4>
<p>
  Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
  Müller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A
  Medium Model for the Refrigerant Propane for Fast and Accurate
  Dynamic Simulations</a>. In: <i>The 10th International Modelica
  Conference</i>. Lund, Sweden, March 10-12, 2014: Linköping University
  Electronic Press (Linköping Electronic Conference Proceedings), S.
  1271–1275
</p>
</html>"));
end ThermodynamicStatePropertiesBaseDataDefinition;
