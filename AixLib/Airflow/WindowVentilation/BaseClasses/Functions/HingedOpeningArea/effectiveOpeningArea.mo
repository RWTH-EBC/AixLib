within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea;
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
end effectiveOpeningArea;
