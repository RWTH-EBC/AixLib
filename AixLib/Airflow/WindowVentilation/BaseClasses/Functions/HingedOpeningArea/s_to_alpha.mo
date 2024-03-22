within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea;
function s_to_alpha
  "Conversion from the hinged opening width to hinged opening angle"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length a(min=0)
    "Length of the window clear opening, hinged-side";
  input Modelica.Units.SI.Length b(min=0)
    "Length of the window clear opening, vertical to hinged-side";
  input Modelica.Units.SI.Length s(min=0) "Opening width of window sash";
  output Modelica.Units.SI.Angle alpha(min=0, max=Modelica.Constants.pi/2)
    "Opening angle of window sash";
algorithm
  alpha := 2*asin(s/(2*b));
end s_to_alpha;
