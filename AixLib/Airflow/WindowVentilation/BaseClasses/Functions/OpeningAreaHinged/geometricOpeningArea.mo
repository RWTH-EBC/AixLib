within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function geometricOpeningArea
  "Calculation of the geometric opening area"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.partialOpeningArea;
protected
  Modelica.Units.SI.Angle alpha=
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged.s_to_alpha(
    a, b, s) "Hinged opening angle";
  Modelica.Units.SI.Area A1 "Opening area of oppsite side";
  Modelica.Units.SI.Area A2 "Opening area of profile side";
algorithm
  A1 := s*a;
  A2 := 0.5*s*b*cos(alpha/2);
  A := A1 + 2*A2;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This function calculates the geometric opening area.</p>
</html>"));
end geometricOpeningArea;
