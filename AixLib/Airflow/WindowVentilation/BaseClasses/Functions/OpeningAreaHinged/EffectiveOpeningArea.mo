within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function EffectiveOpeningArea
  "Calculation of the effective opening area"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Area AClr(min=0) "Window clear opening area";
  input Modelica.Units.SI.Area AEqv(min=0) "Window equivalent opening area";
  input Modelica.Units.SI.Area AEqv90(min=0)
    "Window equivalent opening area by 90° opening";
  output Modelica.Units.SI.Area AEff(min=0) "Effective opening area";
algorithm
  AEff := AEqv/AEqv90*AClr;
  annotation (Documentation(revisions="<html><ul>
  <li>June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This function calculates the effective opening area.
</p>
</html>"));
end EffectiveOpeningArea;
