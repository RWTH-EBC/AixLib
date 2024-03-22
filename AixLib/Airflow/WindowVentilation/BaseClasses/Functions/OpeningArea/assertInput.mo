within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea;
function assertInput
  "Assertation condition to check the input"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea.partialOpeningArea;
algorithm
  assert(w>0, "Window width is less than or equal to 0.");
  assert(h>0, "Window height is less than or equal to 0.");
  assert(s>-Modelica.Constants.eps, "Opening width input is less than 0.");
end assertInput;
