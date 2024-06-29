within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function EquivalentOpeningArea
  "Calculation of the equivalent opening area"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Area AClr(min=0) "Window clear opening area";
  input Modelica.Units.SI.Area AGeo(min=0) "Window geometric opening area";
  output Modelica.Units.SI.Area AEqv(min=0) "Equivalent opening area";
algorithm
  if (AClr<Modelica.Constants.eps) or (AGeo<Modelica.Constants.eps) then
    AEqv := 0;
  else
    AEqv := (AClr^(-2) + AGeo^(-2))^(-0.5);
  end if;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This function calculates the equivalent opening area.</p>
</html>"));
end EquivalentOpeningArea;
