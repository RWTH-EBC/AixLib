within AixLib.Airflow.Window.BaseClasses.Functions.OpeningArea;
function projectiveAreaTopBottomHung
  "Calculation of the projective opening area of top- or bottom-hung windows"
  extends
    AixLib.Airflow.Window.BaseClasses.Functions.OpeningArea.partialOpeningArea;
  output Modelica.Units.SI.Angle alpha = 2*asin(s/(2*h)) "Hinged opening angle";
protected
  Modelica.Units.SI.Area A1 "Projective opening area at top/bottom";
  Modelica.Units.SI.Area A2 "Projectvie opening area on both sides";
algorithm
  assertInput(w, h, s);
  A1 := w*h*(1 - cos(alpha));
  A2 := 0.5*h*sin(alpha)*h*cos(alpha);
  A := A1 + 2*A2;
end projectiveAreaTopBottomHung;
