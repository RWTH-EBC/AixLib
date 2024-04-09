within AixLib.Airflow.WindowVentilation.BaseClasses.Functions.OpeningAreaHinged;
function coeffOpeningAreaDIN16798
  "Coefficient for hinged opening area according to DIN CEN/TR 16798-8 (DIN SPEC 32739-8)"
  extends Modelica.Icons.Function;
  input Modelica.Units.SI.Angle alpha(min=0, max=Modelica.Constants.pi/2)
    "Window sash opening angle";
  output Real C_w "coefficient";
protected
  Modelica.Units.NonSI.Angle_deg alpha_deg "Window sash opening angle in deg";
algorithm
  alpha_deg := Modelica.Units.Conversions.to_deg(alpha);
  assert(alpha_deg <= 90,
    "The model only applies to a maximum tilt angle of 90°",
    AssertionLevel.warning);
  C_w := 2.6e-7*(alpha_deg^3) - 1.19e-4*(alpha_deg^2) + 1.86e-2*alpha_deg;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 4, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This function calculates the coefficient for hinged opening area according to DIN CEN/TR 16798-8 (DIN SPEC 32739-8).</p>
</html>"));
end coeffOpeningAreaDIN16798;
