within AixLib.Airflow.Window.BaseClasses.Functions.OpeningArea;
partial function partialOpeningArea
  "Partial function for calculation of opening area"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length w "Width of the window clear opening";
  input Modelica.Units.SI.Length h "Height of the window clear opening";
  input Modelica.Units.SI.Length s "Opening width of window sash";
  output Modelica.Units.SI.Area A "Opening area";
end partialOpeningArea;
