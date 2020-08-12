within AixLib.Media.Refrigerants.UsersGuide;
class Composition "Composition of the regrigerant library"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html><p>
  The refrigerants' library consists mainly of five packages.
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Media.Refrigerants.Interfaces\">Interfaces:</a>
    Contains both templates to create new refrigerant models and
    partial models of the modeling approaches implemented in the
    library.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.DataBase.Media.Refrigerants\">DataBases:</a>
    Contains records with fitting coefficients used for, for example,
    different modeling approaches implemented in the library.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Media.Refrigerants.R134a\">Refrigerants:</a>
    Packages of different refrigerants which contain refrigerant models
    ready to use.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Media.Refrigerants.Examples\">Examples:</a>
    Contains example models to show the functionality of the
    refrigerant models.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Media.Refrigerants.Validation\">Validation:</a>
    Contains validation models to validate the modeling approaches
    implemented in the library.
  </li>
</ol>
<p>
  The ready to use models are provided in the following packages:
</p>
<ul>
  <li>
    <a href=\"modelica://AixLib.Media.Refrigerants.R134a\">R134a</a>
  </li>
  <li>
    <a href=\"modelica://AixLib.Media.Refrigerants.R290\">R290</a>
  </li>
  <li>
    <a href=\"modelica://AixLib.Media.Refrigerants.R410a\">R410a</a>
  </li>
</ul>
<ul>
  <li>October 14, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end Composition;
