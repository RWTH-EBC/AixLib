within AixLib.Media.Refrigerants.Validation;
package RefrigerantsDerivatives "Package that contains validation models to check refrigerants' derivatives"
  extends Modelica.Icons.ExamplesPackage;

annotation (Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains validation models for each refrigerant model
  implemented in the refrigerant library. Within the validation models,
  the refrigerants' partial derivatives are compared to external media
  models that are validated. Since the refrigerant models all use the
  same approach (i.e. HybridTwoPhase), a validation of the partial
  derivatives is needed just once.
</p>
</html>"));
end RefrigerantsDerivatives;
