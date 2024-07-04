within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
partial function PartialOpeningArea
  "Calculation of hinged-opening area by rectangular windows, unspecified types"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length lenAxs(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  input Modelica.Units.SI.Length lenAxsToFrm(min=0)
    "Distance from the hinged axis to the frame across the opening area";
  input Modelica.Units.SI.Length width(min=0) "Opening width of window sash";
  output Modelica.Units.SI.Area A(min=0) "Opening area";
  annotation (Documentation(revisions="<html><ul>
  <li>June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This partial function defines the inputs and output of the function
  for opening area calculation.
</p>
</html>"));
end PartialOpeningArea;
