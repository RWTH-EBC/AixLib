within AixLib.Media.Refrigerants.Validation.RefrigerantsDerivatives;
model RefrigerantsDerivativesR290
  "Model that checks the implementation of derivatives for R134a"
  extends RefrigerantsDerivativesR134a(
    redeclare package MediumInt =
      AixLib.Media.Refrigerants.R290.R290_IIR_P05_30_T263_343_Horner,
    extProp(fileName=Modelica.Utilities.Files.loadResource(
      "modelica://AixLib/Resources/Media/Refrigerants/ValidationDerivativesR290.txt")),
    convT=70);

  annotation (Documentation(info="<html><p>
  This example model checks the implementation of the <b>refrigerant's
  partial derivatives</b>. Therefore, the user has first to introduce
  some information about the refrigerant and afterwards the partial
  derivatives are calculated. The following <b>refrigerant's
  information</b> is required:
</p>
<ol>
  <li>The <i>refrigerant package</i> that shall be tested.
  </li>
  <li>The <i>independent variables</i> i.e. independents variables'
  alteration with time.
  </li>
</ol>
<p>
  The following <b>refrigerant's partial derivatives</b> are calculated
  and checked:
</p>
<ol>
  <li>Thermodynamic properties calculated by partial derivatives of the
  Helmholtz equation of state (e.g. specific heat capacity at constant
  pressure).
  </li>
  <li>Partial derivatives that only depend on partial derivatives of
  the Helmholtz equation of state (i.e. derivatives wrt. density and
  temperature).
  </li>
  <li>Partial derivatives that do not directly depend on partial
  derivatives of the Helmholtz equation of state (i.e. derivatives not
  wrt. density and temperature).
  </li>
  <li>Partial derivatives at bubble and dew line.
  </li>
</ol>
<p>
  Furthermore, the derivatives are compared with the associated
  derivatives calculated by an external medium model (i.e. <a href=
  \"https://github.com/thorade/HelmholtzMedia\">HelmholtzMedia</a>)
  Therefore, the parameters are not allowed to change (except for the
  medium package).
</p>
<ul>
  <li>August 13, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"),
experiment(StopTime=1, Tolerance=1e-006));
end RefrigerantsDerivativesR290;
