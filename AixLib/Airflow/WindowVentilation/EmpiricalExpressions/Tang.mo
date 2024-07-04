within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Tang "Empirical expression developed by Tang et al. (2016)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple openingArea);
  parameter Modelica.Units.SI.TemperatureDifference dTLim(min=0.02)=0.05
    "Limitation of temperature difference: Due to the temperature difference in
    the denominator, this expression is not applicable to low temperature
    difference, output with 0 if the absolute temperature difference is less
    than this limit.";
protected
  Real cofDcg = 0.6 "Discharge coefficient";
  Real cof_dT = 0.02 "Coefficient of temperature difference";
  Real intRes "Interim result";
equation
  assert(abs(dT_RoomAmb) >= dTLim,
    "The absolute temperature difference is less than the limited value, the term of temperature difference correlation will be set to 0",
    AssertionLevel.warning);
  intRes = if noEvent(abs(dT_RoomAmb) >= dTLim)
    then Modelica.Constants.g_n*winClrHeight*abs(dT_RoomAmb)/TRoom + cof_dT/abs(dT_RoomAmb)
    else Modelica.Constants.g_n*winClrHeight*abs(dT_RoomAmb)/TRoom + 0;
  assert(intRes > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow =if noEvent(intRes > Modelica.Constants.eps) then
    1/3*cofDcg*openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html><ul>
  <li>June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This model contains the empirical expression developed by Tang et
  al..
</p>
<h4>
  References
</h4>
<p>
  Tang, Y., Li, X., Zhu, W., & Cheng, P. L. (2016). Predicting
  single-sided airflow rates based on primary school experimental
  study. Building and Environment, 98, 71–79.
</p>
</html>"));
end Tang;
