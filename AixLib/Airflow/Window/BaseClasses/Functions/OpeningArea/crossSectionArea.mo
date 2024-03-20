within AixLib.Airflow.Window.BaseClasses.Functions.OpeningArea;
function crossSectionArea
  "Calculation of the cross-sectional opening area of windows"
  extends partialOpeningArea(final s=0);
algorithm
  assertInput(w, h, s);
  A := w*h;
end crossSectionArea;
