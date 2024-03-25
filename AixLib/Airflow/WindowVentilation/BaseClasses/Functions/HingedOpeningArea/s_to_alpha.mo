within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.HingedOpeningArea;
function s_to_alpha
  "Conversion from the hinged opening width to hinged opening angle"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length a(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  input Modelica.Units.SI.Length b(min=0)
    "Distance from the hinged axis to the frame across the opening area";
  input Modelica.Units.SI.Length s(min=0) "Opening width of window sash";
  output Modelica.Units.SI.Angle alpha(min=0, max=Modelica.Constants.pi/2)
    "Opening angle of window sash";
algorithm
  assert(s <= sqrt(2)*b,
    "The opening angle should be less or equal than 90°",
    AssertionLevel.error);
  alpha := 2*asin(s/(2*b));
end s_to_alpha;
