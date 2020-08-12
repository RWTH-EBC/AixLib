within AixLib.Media.Refrigerants.Validation.RefrigerantsFittedFormulas;
model RefrigerantsFittedFormulasR410a
  "Model that checks the fitted formulas of R410a"
  extends RefrigerantsFittedFormulasR134a(
    redeclare package MediumInt =
      AixLib.Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner,
    extProp(fileName=Modelica.Utilities.Files.loadResource(
      "modelica://AixLib/Resources/Media/Refrigerants/ValidationFittedFormulasR410a.txt")),
    h_min = 155e3,
    h_max = 600e3,
    s_min = 0.75e3,
    s_max = 2e3,
    d_min = 2.0,
    d_max = 1325,
    p_min = 1e5,
    p_max = 48e5,
    T_min = 233.15,
    T_max = 473.15);

  annotation (experiment(StopTime=6400, Tolerance=1e-006),
Documentation(revisions="<html><ul>
  <li>August 13, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This example models checks the implementation of the <b>refrigerant's
  fitted formulas</b> depending on the independent variables density
  and temperature. Therefore, the user has first to introduce some
  information about the refrigerant and afterwards the fitted formulas
  are calculated. The following <b>refrigerant's information</b> is
  required:
</p>
<ol>
  <li>The <i>refrigerant package</i> that shall be tested.
  </li>
  <li>The <i>refrigerant's fluid limits</i> that are determined by the
  fitting procedure.
  </li>
</ol>
<p>
  The following <b>refrigerant's fitted formulas</b> are calculated and
  checked:
</p>
<ol>
  <li>Calculation of the saturation properties.
  </li>
  <li>Calculation of further state propeties like the density depending
  on pressure and temperature.
  </li>
</ol>
<p>
  Additionally, the fitted formulas are also calculated with an
  external media libary (i.e. <a href=
  \"https://github.com/modelica/ExternalMedia\">ExternalMedia</a>).
</p>
<h4>
  Limitations
</h4>
<p>
  Unfortunately, it is not possible to directly call formulas related
  to the Helmholtz equation of state for the ExternalMedia library.
  Thus, these formulas are set to unity and cannot be validated
  directly in Modelica. Therefore, the parameters are not allowed to
  change (except for the medium package).
</p>
</html>"));
end RefrigerantsFittedFormulasR410a;
