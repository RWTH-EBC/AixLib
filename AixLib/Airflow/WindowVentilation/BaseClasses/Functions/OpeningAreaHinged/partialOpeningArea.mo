within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
partial function partialOpeningArea
  "Calculation of hinged-opening area by rectangular windows, unspecified types"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Length a(min=0)
    "Length of the hinged axis, the axis should be parallel to a window frame";
  input Modelica.Units.SI.Length b(min=0)
    "Distance from the hinged axis to the frame across the opening area";
  input Modelica.Units.SI.Length s(min=0) "Opening width of window sash";
  output Modelica.Units.SI.Area A(min=0) "Opening area";
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This partial function defines the inputs and output of the function for opening area calculation.</p>
</html>"));
end partialOpeningArea;
