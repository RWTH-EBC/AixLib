within AixLib.Airflow.WindowVentilation.BaseClasses.Functions;
function SmallestAngleDifference
  "Smallest difference between two angles around a point"
  input AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes
    typ=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180;
  input Modelica.Units.SI.Angle ang1 "Input angle";
  input Modelica.Units.SI.Angle ang2=0 "Reference angle";
  output Modelica.Units.SI.Angle angDif "Difference between two angels";
algorithm
  angDif := ang1 - ang2;
  if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180 then
    /*Convert difference to -180°...+180°*/
    while angDif <= -Modelica.Constants.pi loop
      angDif := angDif + 2*Modelica.Constants.pi;
    end while;
    while angDif > Modelica.Constants.pi loop
      angDif := angDif - 2*Modelica.Constants.pi;
    end while;
  elseif typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range360 then
    /*Convert difference to 0...360°*/
    while angDif < 0 loop
      angDif := angDif + 2*Modelica.Constants.pi;
    end while;
    while angDif >= 2*Modelica.Constants.pi loop
      angDif := angDif - 2*Modelica.Constants.pi;
    end while;
  else
    /*Exceptions*/
    angDif := 0;
  end if;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This function finds the smallest difference between two angles around a point.</p>
<p>The difference is calculated as input angle &apos;ang1&apos; to the reference angle &apos;ang2&apos;, positive value shows a clockwise direction from input to reference, i.e. shows a counter-clockwise by measurement.</p>
</html>"));
end SmallestAngleDifference;
