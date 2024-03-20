within AixLib.Airflow.Window.BaseClasses.Functions.OpeningArea;
function geometricAreaTopBottomHung
  "Calculation of the geometric opening area of top- or bottom-hung windows"
  extends partialOpeningArea;
  output Modelica.Units.SI.Angle alpha = 2*asin(s/(2*h)) "Hinged opening angle";
protected
  Modelica.Units.SI.Area A1 "Opening area at top/bottom";
  Modelica.Units.SI.Area A2 "Opening area on both sides";
algorithm
  assertInput(w, h, s);
  A1 := s*w;
  A2 := 0.5*s*h*cos(alpha/2);
  A := A1 + 2*A2;
end geometricAreaTopBottomHung;
