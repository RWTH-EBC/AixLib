within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea;
function geometricAreaSideHung
  "Calculation of the geometric opening area of side-hung inward or outward windows"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea.partialOpeningArea;
  output Modelica.Units.SI.Angle alpha = 2*asin(s/(2*w)) "Hinged opening angle";
protected
  Modelica.Units.SI.Area A1 "Opening area at side";
  Modelica.Units.SI.Area A2 "Opening area on top or bottom";
algorithm
  assertInput(w, h, s);
  A1 := s*h;
  A2 := 0.5*s*w*cos(alpha/2);
  A := A1 + 2*A2;
end geometricAreaSideHung;
