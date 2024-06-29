within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function ProjectiveOpeningArea
  "Calculation of the projective opening area"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.PartialOpeningArea;
protected
  Modelica.Units.SI.Angle ang=
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.WidthToAngle(
    lenAxs, lenAxsToFrm, width) "Hinged opening angle";
  Modelica.Units.SI.Area A1 "Projective opening of oppsite side";
  Modelica.Units.SI.Area A2 "Projectvie opening of profile side";
algorithm
  A1 := lenAxs*lenAxsToFrm*(1 - cos(ang));
  A2 := 0.5*lenAxsToFrm*sin(ang)*lenAxsToFrm*cos(ang);
  A := A1 + 2*A2;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This function calculates the projective opening area.</p>
</html>"));
end ProjectiveOpeningArea;
