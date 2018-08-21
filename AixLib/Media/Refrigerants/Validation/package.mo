within AixLib.Media.Refrigerants;
package Validation "Package that contains different models for validating
  the refrigerant models"
  extends Modelica.Icons.ExamplesPackage;


  annotation (Documentation(info="<html>
<p>
This package contains models that validate the implementation of refrigerant
routines for the evaluation of thermodynamic properties.
</p>
<p>
These model outputs are stored as reference data to
allow continuous validation whenever models in the library change.
</p>
</html>",   revisions="<html>
  <ul>
    <li>
    June 12, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation
    (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
    </li>
  </ul>
  </html>"));
end Validation;
