within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea;
function geometricOpeningArea
  "Calculation of the geometric opening area"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.partialOpeningArea;
protected
  Modelica.Units.SI.Angle alpha=
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea.s_to_alpha(
    a, b, s) "Hinged opening angle";
  Modelica.Units.SI.Area A1 "Opening area of oppsite side";
  Modelica.Units.SI.Area A2 "Opening area of profile side";
algorithm
  A1 := s*a;
  A2 := 0.5*s*b*cos(alpha/2);
  A := A1 + 2*A2;
end geometricOpeningArea;
