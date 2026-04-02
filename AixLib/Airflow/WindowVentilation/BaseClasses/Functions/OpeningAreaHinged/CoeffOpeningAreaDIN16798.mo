within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function CoeffOpeningAreaDIN16798
  "Coefficient for hinged opening area according to DIN CEN/TR 16798-8 (DIN SPEC 32739-8)"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Angle ang(min=0, max=Modelica.Constants.pi/2)
    "Window sash opening angle";
  output Real cof "Coefficient";
protected
  Modelica.Units.NonSI.Angle_deg angDeg "Window sash opening angle in deg";
algorithm
  angDeg := Modelica.Units.Conversions.to_deg(ang);
  assert(angDeg <= 90,
    "The model only applies to a maximum tilt angle of 90°",
    AssertionLevel.error);
  cof := 2.6e-7*(angDeg^3) - 1.19e-4*(angDeg^2) + 1.86e-2*angDeg;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This function calculates the coefficient for hinged opening area according to DIN CEN/TR 16798-8 (DIN SPEC 32739-8).</p>
</html>"));
end CoeffOpeningAreaDIN16798;
