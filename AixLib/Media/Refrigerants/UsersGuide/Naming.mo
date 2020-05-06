within AixLib.Media.Refrigerants.UsersGuide;
class Naming "Naming and abbreviations"
  extends Modelica.Icons.Information;


  annotation (Documentation(info="<html><p>
  In general, both the naming and the abbreviations follow the
  guidelines presented in the media package of the Modelica standard
  library. However, adaptions are made for functions and variables
  related to the Helmholtz equation of state. These adaptions are
  presented below.
</p>
<h4>
  Naming of refrigerant models
</h4>
<p>
  The naming of the models follows the guideline presented below:
</p>
<p style=\"margin-left: 30px;\">
  <i>Refrigerant</i> _ <i>Reference Point</i> _ <i>Range of validity
  for pressure</i> _ <i>Range of validity for temperature</i> _
  <i>Approach of calculating fitted formulas</i>
</p>
<ol>
  <li>
    <u>Refrigerant:</u> Name of the refrigerant, e.g. R134a or R410a.
  </li>
  <li>
    <u>Reference Point:</u> Reference point chosen for the model, e.g.
    IIR (h = 200 kJ/kg and s = 1 kJ/kg/K at 273.15 K at saturated
    liquid line).
  </li>
  <li>
    <u>Validity pressure:</u> Range of validity for pressure given in
    bar. Caution: 0.5 bar is written as 05 or 39.5 bar is written as
    395.
  </li>
  <li>
    <u>Validity temperature:</u> Range of validity for temperature in
    K. Caution: No digits are presented.
  </li>
  <li>
    <u>Approach:</u> Approach of calculating fitted formulas.
    Currently, three different calculating rules are implemented.
  </li>
</ol>
<ul>
  <li>
    <i>Record:</i> The fitting coefficients used for the fitted
    formulas are stored in records.
  </li>
  <li>
    <i>Formula:</i> Fitted formulas are hard-coded in the refrigerant
    model due to simulation speed and, therefore, all fitting
    coefficients are directly stored in the models.
  </li>
  <li>
    <i>Horner:</i> Fitted formulas are hard-coded in the refrigerant
    model using the Horner pattern due to simulation speed and,
    therefore, all fitting coefficients are directly stored in the
    models.
  </li>
</ul>
<h4>
  Abbreviations of parameters, constants, variables and functions
</h4>
<p>
  Some special abbreviations are introduced for functions and variables
  related to the Helmholtz energy equation of state. Some examples are
  given below:
</p>
<table summary=\"Abbreviations for EoS\" cellpadding=\"2\" border=\"1\"
width=\"80%\" style=\"border-collapse:collapse;\">
  <tr>
    <td>
      <p>
        <b>Expression</b>
      </p>
    </td>
    <td>
      <p>
        <b>Abbreviation</b>
      </p>
    </td>
    <td>
      <p>
        <b>Comment</b>
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        alpha_0
      </p>
    </td>
    <td>
      <p>
        f_Idg
      </p>
    </td>
    <td>
      <p>
        Helmholtz energy of ideal gas
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        alpha_r
      </p>
    </td>
    <td>
      <p>
        f_Res
      </p>
    </td>
    <td>
      <p>
        Helmholtz energy of residual gas
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        tau * d(alpha_0)/(dtau)_delta=const.
      </p>
    </td>
    <td>
      <p>
        t_fIdg_t
      </p>
    </td>
    <td>
      <p>
        Partial derivative of f_Idg with respect to tau
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        tau*tau * dd(alpha_0)/(dtau*dtau)_delta=const.
      </p>
    </td>
    <td>
      <p>
        tt_fIdg_tt
      </p>
    </td>
    <td>
      <p>
        Partial derivative of f_Idg with respect to tau*tau
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        tau*delta * dd(alpha_r)/(dtau*ddelta)
      </p>
    </td>
    <td>
      <p>
        td_fRes_td
      </p>
    </td>
    <td>
      <p>
        Partial derivative of f_Res with respect to tau*delta
      </p>
    </td>
  </tr>
</table>
<p>
  Some special abbreviations are introduced for partial derivatives.
  Some examples are given below:
</p>
<table summary=\"Abbreviations for partial derivatives\" cellspacing=\"0\"
cellpadding=\"2\" border=\"1\" width=\"80%\" style=
\"border-collapse:collapse;\">
  <tr>
    <td>
      <p>
        <b>Expression</b>
      </p>
    </td>
    <td>
      <p>
        <b>Abbreviation</b>
      </p>
    </td>
    <td>
      <p>
        <b>Comment</b>
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        d(d)/(dp)_h=const.
      </p>
    </td>
    <td>
      <p>
        ddph
      </p>
    </td>
    <td>
      <p>
        Partial derivative of density with respect to pressure at
        constant specific enthalpy
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        d(T)/(ds)_p=const.
      </p>
    </td>
    <td>
      <p>
        dTsp
      </p>
    </td>
    <td>
      <p>
        Partial derivative of temperature with respect to specific
        entropy and constant pressure
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        d(Tsat)/(dp)
      </p>
    </td>
    <td>
      <p>
        dTp
      </p>
    </td>
    <td>
      <p>
        Partial derivative of saturation temperature with respect to
        pressure
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        d(dl)/(dp)
      </p>
    </td>
    <td>
      <p>
        ddldp
      </p>
    </td>
    <td>
      <p>
        Partial derivative of bubble density with respect to pressure
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        d(dv)/(dp)
      </p>
    </td>
    <td>
      <p>
        ddvdp
      </p>
    </td>
    <td>
      <p>
        Partial derivative of dew density with respect to pressure
      </p>
    </td>
  </tr>
</table>
</html>"));
end Naming;
