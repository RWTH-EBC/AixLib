within AixLib.Media.Refrigerants;
package R134a "Package with models for refrigerant R134a"
  extends Modelica.Icons.VariantsPackage;


  annotation (Documentation(info="<html><p>
  This package contains different refrigerant models for the
  refrigerant R134a. The medium models are developed using the
  approaches provided in <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces\">AixLib.Media.Refrigerants.Interfaces</a>.
</p>
<p>
  The <b>naming of the models</b> follows the guidline presented below:
</p>
<p style=\"margin-left: 30px;\">
  <i>Refrigerant</i> _ <i>Reference Point</i> _ <i>Range of validity
  for pressure</i> _ <i>Range of validity for temperature</i> _
  <i>Approach of calculating fitted formulas</i>
</p>
</html>",
        revisions="<html><ul>
  <li>June 11, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end R134a;
