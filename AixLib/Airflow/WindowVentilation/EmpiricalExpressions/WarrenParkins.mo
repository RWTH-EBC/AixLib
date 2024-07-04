within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model WarrenParkins "Empirical expression developed by Warren and Parkins (1984)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple openingArea);
  Modelica.Blocks.Interfaces.RealInput winSpe10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cofDcg = 0.61 "Discharge coefficient";
  Real intRes "Interim result";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_win "Wind induced volume flow";
equation
  intRes = Modelica.Constants.g_n*winClrHeight*dT_RoomAmb/TAvg;
  assert(intRes > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow_th is less than 0, the V_flow_th will be set to 0",
    AssertionLevel.warning);
  V_flow_th = if noEvent(intRes > Modelica.Constants.eps) then
    1/3*cofDcg*openingArea.A*sqrt(intRes) else 0;
  V_flow_win = 0.025*openingArea.A*winSpe10;
  V_flow = max(V_flow_th, V_flow_win);
  annotation (Documentation(revisions="<html><ul>
  <li>June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This model contains the empirical expression developed by Warren and
  Parkins.
</p>
<h4>
  References
</h4>
<p>
  Warren, P. R., & Parkins, L. M. (1984). Single-sided ventilation
  through open windows. In Air infiltration and Ventilation Centre
  (Chair), Windows in building design and maintenance, Goteborg.
</p>
</html>"));
end WarrenParkins;
