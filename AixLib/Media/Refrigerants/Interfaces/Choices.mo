within AixLib.Media.Refrigerants.Interfaces;
package Choices
  "Types, constants to define menu choices"
  extends Modelica.Media.Interfaces.Choices;

  type InputChoice = enumeration(
      pT "(p,T) as inputs",
      dT "(d,T) as inputs",
      ph "(p,h) as inputs",
      ps "(p,s) as inputs")
     "Enumeration to define input choice of calculating thermodynamic state"
      annotation (Evaluate=true);
  annotation (Documentation(revisions="<html><ul>
  <li>October 7, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains types and constants to define menue choices.
</p>
</html>"));
end Choices;
