within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model GidsPhaff
  "Empirical expression developed by de Gids and Phaff (1982)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  Modelica.Blocks.Interfaces.RealInput u_10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_1 = 0.001 "Coefficient 1";
  Real C_2 = 0.0035 "Coefficient 2";
  Real C_3 = 0.01 "Coefficient 3";
  Real interimRes1 "Interim result";
equation
  interimRes1 = C_1*(u_10^2) + C_2*winClrH*abs(deltaT) + C_3;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow =if noEvent(interimRes1 > Modelica.Constants.eps) then 1/2*
    openingArea_1.A*sqrt(interimRes1) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 3, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by de Gids and Phaff.</p>
<h4>References</h4>
<p>Gids, W. de, &amp; Phaff, H. (1982). Ventilation rates and energy consumption due to open windows: a brief overview of research in the Netherlands. Air Infiltration Review, 4(1), 4&ndash;5.</p>
</html>"));
end GidsPhaff;
