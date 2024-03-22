within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea;
function projectiveAreaSideHung
  "Calculation of the projective opening area of side-hung inward or outward windows"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea.partialOpeningArea;
  output Modelica.Units.SI.Angle alpha = 2*asin(s/(2*w)) "Hinged opening angle";
protected
  Modelica.Units.SI.Area A1 "Projective opening area at side";
  Modelica.Units.SI.Area A2 "Projectvie opening area on top or bottom";
algorithm
  assertInput(w, h, s);
  A1 := h*w*(1 - cos(alpha));
  A2 := 0.5*w*sin(alpha)*w*cos(alpha);
  A := A1 + 2*A2;
end projectiveAreaSideHung;
