within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Tang "Empirical expression developed by Tang et al. (2016)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
    redeclare replaceable model OpeningArea =
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    final varNameIntRes = "V_flow");
  parameter Modelica.Units.SI.TemperatureDifference dTLim(min=0.02)=0.05
    "Limitation of temperature difference: Due to the temperature difference in
    the denominator, this expression is not applicable to low temperature
    difference, output with 0 if the absolute temperature difference is less
    than this limit.";
  Integer errCou_dT(start=0)
    "Warning counter for assertion check of 'dT'";
protected
  Real cofDcg = 0.6 "Discharge coefficient";
  Real cof_dT = 0.02 "Coefficient of temperature difference";
initial equation
  errCou_dT = 0;
equation
  // Assertion of temperature difference check
  when abs(dTRoomAmb) < dTLim then
    errCou_dT = pre(errCou_dT) + 1;
  end when;
  assert(abs(dTRoomAmb) > dTLim or errCou_dT > 1,
    "In " + getInstanceName() + ": The temperature difference between indoor 
    and ambient is equal or less than the limited value (" + String(dTLim) + " 
    K), the term of temperature difference correlation will be set to 0",
    AssertionLevel.warning);
  // Calculate intRes
  intRes = if noEvent(abs(dTRoomAmb) > dTLim)
    then Modelica.Constants.g_n*winClrHeight*abs(dTRoomAmb)/TRoom + cof_dT/
      abs(dTRoomAmb)
    else Modelica.Constants.g_n*winClrHeight*abs(dTRoomAmb)/TRoom + 0;
  // Calculate volume flow
  V_flow = if noEvent(intRes > Modelica.Constants.eps) then
    1/3*cofDcg*openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Tang et al..</p>
<h4>References</h4>
<p>Tang, Y., Li, X., Zhu, W., &amp; Cheng, P. L. (2016). Predicting single-sided airflow rates based on primary school experimental study. Building and Environment, 98, 71&ndash;79. </p>
</html>"));
end Tang;
