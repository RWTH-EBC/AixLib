within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea;
function crossSectionArea
  "Calculation of the cross-sectional opening area of windows"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea.partialOpeningArea(
      final s=0);
algorithm
  assertInput(w, h, s);
  A := w*h;
end crossSectionArea;
