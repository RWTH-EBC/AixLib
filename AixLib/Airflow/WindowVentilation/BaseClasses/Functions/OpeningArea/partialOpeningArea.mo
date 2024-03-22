within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningArea;
partial function partialOpeningArea
  "Calculation of hinged-opening area by rectangular windows"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length a
    "Length of the window clear opening, hinged-side";
  input Modelica.Units.SI.Length b
    "Length of the window clear opening, ";
  input Modelica.Units.SI.Length s "Opening width of window sash";
  output Modelica.Units.SI.Area A "Opening area";
end partialOpeningArea;
