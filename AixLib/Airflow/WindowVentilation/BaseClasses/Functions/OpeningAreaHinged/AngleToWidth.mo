within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function AngleToWidth
  "Conversion from the hinged opening angle to hinged opening width"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length lenAxs(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  input Modelica.Units.SI.Length lenAxsToFrm(min=0)
    "Distance from the hinged axis to the frame across the opening area";
  input Modelica.Units.SI.Angle ang(min=0, max=Modelica.Constants.pi/2)
    "Opening angle of window sash";
  output Modelica.Units.SI.Length width(min=0) "Opening width of window sash";
algorithm
  width := 2*lenAxsToFrm*sin(ang/2);
  annotation (Documentation(revisions="<html><ul>
  <li>June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This function converts the hinged opening angle to hinged opening
  width.
</p>
</html>"));
end AngleToWidth;
