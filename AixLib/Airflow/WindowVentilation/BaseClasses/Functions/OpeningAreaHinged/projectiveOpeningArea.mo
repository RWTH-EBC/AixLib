within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function projectiveOpeningArea
  "Calculation of the projective opening area"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.partialOpeningArea;
protected
  Modelica.Units.SI.Angle alpha=
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.s_to_alpha(
    a, b, s) "Hinged opening angle";
  Modelica.Units.SI.Area A1 "Projective opening of oppsite side";
  Modelica.Units.SI.Area A2 "Projectvie opening of profile side";
algorithm
  A1 := a*b*(1 - cos(alpha));
  A2 := 0.5*b*sin(alpha)*b*cos(alpha);
  A := A1 + 2*A2;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This function calculates the projective opening area.</p>
</html>"));
end projectiveOpeningArea;
