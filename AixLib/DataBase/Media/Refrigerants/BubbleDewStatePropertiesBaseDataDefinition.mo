within AixLib.DataBase.Media.Refrigerants;
record BubbleDewStatePropertiesBaseDataDefinition
  "Base data definition for fitting coefficients of thermodynamic state
  properties at bubble and dew line"
  extends Modelica.Icons.Record;

  parameter String name
  "Short description of the record"
  annotation (Dialog(group="General"));

  parameter Integer psat_Nt
  "Number of terms for saturation pressure"
  annotation (Dialog(group="Saturation pressure"));
  parameter Real psat_N[:]
  "First coefficient for saturation pressure"
  annotation (Dialog(group="Saturation pressure"));
  parameter Real psat_E[:]
  "Second coefficient for saturation pressure"
  annotation (Dialog(group="Saturation pressure"));

  parameter Integer Tsat_Nt
  "Number of terms for saturation temperature"
  annotation (Dialog(group="Saturation temperature"));
  parameter Real Tsat_N[:]
  "Fitting coefficients for saturation temperature"
  annotation (Dialog(group="Saturation temperature"));
  parameter Real Tsat_IO[:]
  "Mean input (p) | Std input (p) | Mean output (T) | Std output (T)"
  annotation (Dialog(group="Saturation temperature"));

  parameter Integer dl_Nt
  "Number of terms for bubble density"
  annotation (Dialog(group="Bubble density"));
  parameter Real dl_N[:]
  "Fitting coefficients for bubble density"
  annotation (Dialog(group="Bubble density"));
  parameter Real dl_IO[:]
  "Mean input (T) | Std input (T) | Mean output (dl) | Std output (dl)"
  annotation (Dialog(group="Bubble density"));

  parameter Integer dv_Nt
  "Number of terms for dew density"
  annotation (Dialog(group="Dew density"));
  parameter Real dv_N[:]
  "Fitting coefficients for dew density"
  annotation (Dialog(group="Dew density"));
  parameter Real dv_IO[:]
  "Mean input (T) | Std input (T) | Mean output (dv) | Std output (dv)"
  annotation (Dialog(group="Dew density"));

  parameter Integer hl_Nt
  "Number of terms for bubble enthalpy"
  annotation (Dialog(group="Bubble Enthalpy"));
  parameter Real hl_N[:]
  "Fitting coefficients for bubble enthalpy"
  annotation (Dialog(group="Bubble Enthalpy"));
  parameter Real hl_IO[:]
  "Mean input (p) | Std input (p) | Mean output (hl) | Std output (hl)"
  annotation (Dialog(group="Bubble Enthalpy"));

  parameter Integer hv_Nt
  "Number of terms for dew enthalpy"
  annotation (Dialog(group="Dew Enthalpy"));
  parameter Real hv_N[:]
  "Fitting coefficients for dew enthalpy"
  annotation (Dialog(group="Dew Enthalpy"));
  parameter Real hv_IO[:]
  "Mean input (p) | Std input (p) | Mean output (hv) | Std output (hv)"
  annotation (Dialog(group="Dew Enthalpy"));

  parameter Integer sl_Nt
  "Number of terms for bubble entropy"
  annotation (Dialog(group="Bubble Entropy"));
  parameter Real sl_N[:]
  "Fitting coefficients for bubble entropy"
  annotation (Dialog(group="Bubble Entropy"));
  parameter Real sl_IO[:]
  "Mean input (p) | Std input (p) | Mean output (sl) | Std output (sl)"
  annotation (Dialog(group="Bubble Entropy"));

  parameter Integer sv_Nt
  "Number of terms for dew entropy"
  annotation (Dialog(group="Dew Entropy"));
  parameter Real sv_N[:]
  "Fitting coefficients for dew entropy"
  annotation (Dialog(group="Dew Entropy"));
  parameter Real sv_IO[:]
  "Mean input (p) | Std input (p) | Mean output (sv) | Std output (sv)"
  annotation (Dialog(group="Dew Entropy"));

  annotation (Documentation(revisions="<html><ul>
  <li>June 9, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This record is a base data definition for fitting coefficients of the
  thermodynamic state properties at bubble and dew line. If these state
  properties are not expressed as fitted formula, the state properties
  at vapour-liquid equilibrium will be identified iteratively and, as a
  consequence, the computing time will rise (Thorade and Matthias,
  2012). In order to reduce the computing time, the thermodynamic state
  properties are expressed as fitted formula based on the approach
  presented by Sangi et al. within their \" Fast_Propane\" model.
</p>
<p>
  Sangi et al. used the <b>following fitting approaches</b>, which are
  also implemented within <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>:<br/>
</p>
<table summary=\"Formulas for calculating saturation properties\"
cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\" style=
\"border-collapse:collapse;\">
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Saturation pressure</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationPressure.png\"
        alt=\"Formula to calculate saturation pressure\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Saturation temperature</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationTemperature.png\"
        alt=\"Formula to calculate saturation temperature\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Bubble density</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleDensity.png\"
        alt=\"Formula to calculate bubble density\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Dew density</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewDensity.png\"
        alt=\"Formula to calculate dew density\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Bubble Enthalpy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEnthalpy.png\"
        alt=\"Formula to calculate bubble enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Dew Enthalpy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEnthalpy.png\"
        alt=\"Formula to calculate dew enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Bubble Entropy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEntropy.png\"
        alt=\"Formula to calculate bubble entropy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Dew Entropy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEntropy.png\"
        alt=\"Formula to calculate dew entropy\">
      </p>
    </td>
  </tr>
</table>
<p>
  As it can be seen, the fitted formulas consist basically of the
  coefficient e<sub>i</sub> as well as of the parameters
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
  Thorade, Matthis; Saadat, Ali (2012): <a href=
  \"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A
  fluid properties library</a>. In: <i>Proceedings of the 9th
  International Modelica Conference</i>; September 3-5; 2012; Munich;
  Germany. Linköping University Electronic Press, S. 63–70.
</p>
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
end BubbleDewStatePropertiesBaseDataDefinition;
