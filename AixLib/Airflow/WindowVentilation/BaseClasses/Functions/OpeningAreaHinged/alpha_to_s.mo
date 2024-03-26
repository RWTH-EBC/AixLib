within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function alpha_to_s
  "Conversion from the hinged opening angle to hinged opening width"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length a(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  input Modelica.Units.SI.Length b(min=0)
    "Distance from the hinged axis to the frame across the opening area";
  input Modelica.Units.SI.Angle alpha(min=0, max=Modelica.Constants.pi/2)
    "Opening angle of window sash";
  output Modelica.Units.SI.Length s(min=0) "Opening width of window sash";
algorithm
  s := 2*b*sin(alpha/2);
end alpha_to_s;
