within AixLib.DataBase.Media.Refrigerants;
record HelmholtzEquationOfStateBaseDateDefinition
  "Base data definition for fitting coefficients of the Helmholtz EoS"
  extends Modelica.Icons.Record;

  parameter String name
  "Short description of the record"
  annotation (Dialog(group="General"));

  parameter Integer f_IdgNl
  "Number of terms of the equation's (alpha_0) first part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real f_IdgL1[:]
  "First coefficient of the equation's (alpha_0) first part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real f_IdgL2[:]
  "Second coefficient of the equation's (alpha_0) first part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Integer f_IdgNp
  "Number of terms of the equation's (alpha_0) second part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real f_IdgP1[:]
  "First coefficient of the equation's (alpha_0) second part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real f_IdgP2[:]
  "Second coefficient of the equation's (alpha_0) second part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Integer f_IdgNe
  "Number of terms of the equation's (alpha_0) third part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real f_IdgE1[:]
  "First coefficient of the equation's (alpha_0) third part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real f_IdgE2[:]
  "Second coefficient of the equation's (alpha_0) third part"
  annotation (Dialog(group="Ideal gas part"));

  parameter Integer f_ResNp
  "Number of terms of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResP1[:]
  "First coefficient of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResP2[:]
  "Second coefficient of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResP3[:]
  "Third coefficient of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Integer f_ResNb
  "Number of terms of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResB1[:]
  "First coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResB2[:]
  "Second coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResB3[:]
  "Third coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResB4[:]
  "Fourth coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Integer f_ResNG
  "Number of terms of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResG1[:]
  "First coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResG2[:]
  "Second coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResG3[:]
  "Third coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResG4[:]
  "Fourth coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResG5[:]
  "Fifth coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResG6[:]
  "Sixth coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real f_ResG7[:]
  "Seventh coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));

  annotation (Documentation(revisions="<html><ul>
  <li>June 9, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This record is a base data definition for fitting coefficients of the
  <b>Helmholtz equation of state (EoS)</b>. The EoS allows the accurate
  description of fluids' thermodynamic behaviour and uses the Helmholtz
  energy as fundamental thermodynamic relation with temperature and
  density as independent variables. The <b>general formula</b> of the
  EoS as it is implemented within <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>
  is given below:
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Helmholtz_EoS.png\"
  alt=\"Calculation procedure of dimensionless Helmholtz energy\">
</p>
<p>
  As it can be seen, the general formula of the EoS can be divided in
  two part: The <b>ideal gas part</b> and the <b>residual part</b>.
  Both parts' formulas are given below:
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Helmholtz_IdealGasPart.png\"
  alt=
  \"Calculation procedure of dimensionless ideal gas Helmholtz energy\">
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Helmholtz_ResidualPart.png\"
  alt=
  \"Calculation procedure of dimensionless residual Helmholtz energy\">
</p>
<p>
  Both, the ideal gas part and the residual part can be divided in
  three subparts (i.e. the summations) that contain different
  coefficients (e.g. nL, l<sub>i</sub>, p<sub>i</sub> or
  e<sub>i</sub>). These coefficients are the fitting coefficients and
  must be obtained during a fitting procedure. While the fitting
  procedure, the general formula of the EoS is fitted to external data
  (e.g. obtained from measurements or external media libraries) and the
  fitting coefficients are determined.
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  The fitting procedure is performed for a <b>predefined range of the
  external data</b> that is given in terms of, for example, temperature
  and pressure. Therefore, all other thermodynamic state properties are
  also just defined within a certain predefined range and, as a
  consequence, the fitting coefficients are also just valid within the
  predefined range of Helmholtz energy.
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
  Thorade, Matthis; Saadat, Ali (2013): <a href=
  \"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
  Partial derivatives of thermodynamic state properties for dynamic
  simulation</a>. In: <i>Environmental earth sciences 70 (8)</i>, S.
  3497–3503.
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
end HelmholtzEquationOfStateBaseDateDefinition;
