within AixLib.Media.Refrigerants.UsersGuide;
class Approaches "Approaches implemented in refrigerant library"
  extends Modelica.Icons.Information;

  class HybridApproach "Hybrid Approach"
    extends Modelica.Icons.Information;

    annotation (Documentation(revisions="<html><ul>
  <li>October 14, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",
        info="<html><p>
  The hybrid approach is developed by Sangi et al. and consists of both
  the Helmholtz equation of state and fitted formula for thermodynamic
  state properties at bubble or dew line (e.g. p<sub>sat</sub> or
  h<sub>l,sat</sub>) and thermodynamic state properties depending on
  two independent state properties (e.g. T_ph or T_ps). In the
  following, the basic formulas of the hybrid approach are given.
</p>
<p>
  <b>The Helmholtz equation of state</b>
</p>
<p>
  The Helmholtz equation of state (EoS) allows the accurate description
  of fluids' thermodynamic behaviour and uses the Helmholtz energy as
  fundamental thermodynamic relation with temperature and density as
  independent variables. Furthermore, the EoS allows determining all
  thermodynamic state properties from its partial derivatives and its
  <b>general formula</b> is given below:
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_EoS.png\"
  alt=\"Calculation procedure of dimensionless Helmholtz energy\">
</p>
<p>
  As it can be seen, the general formula of the EoS can be divided in
  two part: The <b>ideal gas part (left summand)</b> and the
  <b>residual part (right summand)</b>. Both parts' formulas are given
  below:
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_IdealGasPart.png\"
  alt=
  \"Calculation procedure of dimensionless ideal gas Helmholtz energy\">
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_ResidualPart.png\"
  alt=
  \"Calculation procedure of dimensionless residual Helmholtz energy\">
</p>
<p>
  Both, the ideal gas part and the residual part can be divided in
  three subparts (i.e. the summations) that contain different
  coefficients (e.g. nL, l<sub>i</sub>, p<sub>i</sub> or
  e<sub>i</sub>). These coefficients are fitting coefficients and must
  be obtained during a fitting procedure. While the fitting procedure,
  the general formula of the EoS is fitted to external data (e.g.
  obtained from measurements or external media libraries) and the
  fitting coefficients are determined. Finally, the formulas obtained
  during the fitting procedure are implemented in an explicit form.
</p>
<p>
  For further information of <b>the EoS and its partial
  derivatives</b>, please read the paper \" <a href=
  \"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A
  fluid properties library</a>\" by Thorade and Saadat as well as the
  paper \" <a href=
  \"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
  Partial derivatives of thermodynamic state properties for dynamic
  simulation</a>\" by Thorade and Saadat.
</p>
<p>
  <b>Fitted formulas</b>
</p>
<p>
  Fitted formulas allow to reduce the overall computing time of the
  refrigerant model. Therefore, both thermodynamic state properties at
  bubble and dew line and thermodynamic state properties depending on
  two independent state properties are expresses as fitted formulas.
  The fitted formulas' approaches implemented in this package are
  developed by Sangi et al. within their \"Fast_Propane\" model and given
  below:<br/>
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
<table summary=
\"Formulas for calculating thermodynamic properties at superheated and supercooled regime\"
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
        \"Calculation procedure for supercooled and superheated region\">
      </p>
    </td>
  </tr>
</table>
<p>
  As it can be seen, the fitted formulas consist basically of the
  coefficients e<sub>i</sub>, c<sub>i</sub> as well as of the
  parameters Mean<sub>i</sub> and Std<sub>i</sub>. These coefficients
  are the fitting coefficients and must be obtained during a fitting
  procedure. While the fitting procedure, the formulas presented above
  are fitted to external data (e.g. obtained from measurements or
  external media libraries) and the fitting coefficients are
  determined. Finally, the formulas obtained during the fitting
  procedure are implemented in an explicit form.
</p>
<p>
  For further information of <b>the hybrid approach</b>, please read
  the paper \"<a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium
  Model for the Refrigerant Propane for Fast and Accurate Dynamic
  Simulations</a>\" by Sangi et al..
</p>
<p>
  <b>Smooth transition</b>
</p>
<p>
  To ensure a smooth transition between different regions (e.g. from
  supercooled region to two-phase region) and, therefore, to avoid
  discontinuities as far as possible, Sangi et al. implemented
  functions for a smooth transition between the regions. An example
  (i.e. specificEnthalpy_ps) of these functions is given below:<br/>
</p>
<table summary=
\"Calculation procedures to avoid numerical instability at phase change\"
cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\" style=
\"border-collapse:collapse;\">
  <tr>
    <td valign=\"middle\">
      <p>
        <i>From supercooled region to bubble line and vice versa</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SupercooledToTwoPhase.png\"
        alt=
        \"Calculation procedure for change from supercooled to two-phase\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>From dew line to superheated region and vice versa</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/TwoPhaseToSuperheated.png\"
        alt=
        \"Calculation procedure for change from superheated to two-phase\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>From bubble or dew line to two-phase region and vice
        versa</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationToTwoPhase.png\"
        alt=
        \"Calculation procedure for change from saturation to two-phase\">
      </p>
    </td>
  </tr>
</table>
<h4>
  Assumptions and limitations
</h4>
<p>
  Two limitations are known for this package:
</p>
<ol>
  <li>The modelling approach implemented in this package is a hybrid
  approach and, therefore, is based on the Helmholtz equation of state
  as well as on fitted formula. Hence, the refrigerant model is just
  valid within the valid range of the fitted formula.
  </li>
  <li>It may be possible to have discontinuities when moving from one
  region to another (e.g. from supercooled region to two-phase region).
  However, functions are implemented to reach a smooth transition
  between the regions and to avoid these discontinuities as far as
  possible. (Sangi et al., 2014)
  </li>
</ol>
</html>"));
  end HybridApproach;

  annotation (Documentation(revisions="<html><ul>
  <li>October 14, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  Currently, one modeling approach is implemented in the refrigerants'
  library:
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula\">
    Hybrid Approach:</a> The hybrid approach uses the both the
    Helmholtz equation of state (EoS) and polynomial functions. The
    polynomial functions are used to avoid iterations that normally
    occur while using modeling approaches only based on the EoS.
  </li>
</ol>
<h4>
  Assumptions and limitations:
</h4>
<p>
  Up to this point, the modeling approaches implemented in the library
  are only valid for pure and pseudo-pure refrigerants. Consequently,
  calculation procedures of pseudo-pure refrigerants are only roughly
  valid within the two-phase region.
</p>
</html>"));
end Approaches;
