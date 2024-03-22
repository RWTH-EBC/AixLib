within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea;
partial function partialOpeningArea
  "Calculation of hinged-opening area by rectangular windows"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length a(min=0)
    "Length of the window clear opening, hinged-side";
  input Modelica.Units.SI.Length b(min=0)
    "Length of the window clear opening, vertical to hinged-side";
  input Modelica.Units.SI.Length s(min=0) "Opening width of window sash";
  output Modelica.Units.SI.Area A(min=0) "Opening area";
end partialOpeningArea;
