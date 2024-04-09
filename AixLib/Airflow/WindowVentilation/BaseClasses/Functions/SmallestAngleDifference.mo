within AixLib.Airflow.WindowVentilation.BaseClasses.Functions;
function SmallestAngleDifference
  "Smallest difference between two angles around a point"
  input AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes
    typ=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180;
  input Modelica.Units.SI.Angle phi1 "Input angle";
  input Modelica.Units.SI.Angle phi2=0 "Reference angle";
  output Modelica.Units.SI.Angle beta "Difference between two angels";
algorithm
  beta := phi1 - phi2;
  if typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180 then
    /*Convert difference to -180°...+180°*/
    while beta <= -Modelica.Constants.pi loop
      beta := beta + 2*Modelica.Constants.pi;
    end while;
    while beta > Modelica.Constants.pi loop
      beta := beta - 2*Modelica.Constants.pi;
    end while;
  elseif typ == AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range360 then
    /*Convert difference to 0...360°*/
    while beta < 0 loop
      beta := beta + 2*Modelica.Constants.pi;
    end while;
    while beta >= 2*Modelica.Constants.pi loop
      beta := beta - 2*Modelica.Constants.pi;
    end while;
  else
    /*Exceptions*/
    beta := 0;
  end if;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This function finds the smallest difference between two angles around a point.</p>
<p>The difference is calculated as input angle &apos;phi1&apos; to the reference angle &apos;phi2&apos;, positive value shows a clockwise direction from input to reference, i.e. shows a counter-clockwise by measurement.</p>
</html>"));
end SmallestAngleDifference;
