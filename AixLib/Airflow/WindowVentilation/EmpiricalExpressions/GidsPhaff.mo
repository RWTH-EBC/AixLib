within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model GidsPhaff "Empirical expression developed by de Gids and Phaff (1982)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  Modelica.Blocks.Interfaces.RealInput winSpe10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cof1 = 0.001 "Coefficient 1";
  Real cof2 = 0.0035 "Coefficient 2";
  Real cof3 = 0.01 "Coefficient 3";
  Real intRes "Interim result";
equation
  intRes = cof1*(winSpe10^2) + cof2*winClrHeight*abs(dTRoomAmb) + cof3;
  assert(intRes > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(intRes > Modelica.Constants.eps) then
    1/2*openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by de Gids and Phaff.</p>
<h4>References</h4>
<p>Gids, W. de, &amp; Phaff, H. (1982). Ventilation rates and energy consumption due to open windows: a brief overview of research in the Netherlands. Air Infiltration Review, 4(1), 4&ndash;5.</p>
</html>"));
end GidsPhaff;
