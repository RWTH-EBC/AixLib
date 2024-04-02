within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function effectiveOpeningArea
  "Calculation of the effective opening area"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Area A_clr(min=0) "Window clear opening area";
  input Modelica.Units.SI.Area A_eq(min=0) "Window equivalent opening area";
  input Modelica.Units.SI.Area A_eq90(min=0)
    "Window equivalent opening area by 90° opening";
  output Modelica.Units.SI.Area A(min=0) "Effective opening area";
algorithm
  A := A_eq/A_eq90*A_clr;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end effectiveOpeningArea;
