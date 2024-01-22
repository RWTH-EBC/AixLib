within AixLib.DataBase.Media.Refrigerants;
package R134a "Package provides records for R134a"
  extends Modelica.Icons.VariantsPackage;





annotation (Documentation(revisions="<html><ul>
  <li>June 10, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides records with fitting coefficients for the
  refrigerant R134a. The records are inherited from the base data
  definitions provided in AixLib.DataBase.Media.Refrigerants and the
  fitting coefficients are used for the refrigerant model provided in
  AixLib.Media.Refrigerants.
</p>
<p>
  For detailed information of the <b>base data definitions</b>, please
  checkout the following records:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">
    AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a>
  </li>
</ul>
<p>
  For detailed information of the <b>refrigerant models using the
  fitting coefficients</b>, please checkout the following packages:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
    AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">
    AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord</a>
  </li>
</ul>
</html>"));
end R134a;
