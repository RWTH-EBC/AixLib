within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Tang "Empirical expression developed by Tang et al. (2016)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  parameter Modelica.Units.SI.TemperatureDifference absDeltaTempLim(min=0.02)=0.05
    "Limitation of temperature difference";
  //Due to the temperature difference in the denominator, this expression is not
  //applicable to low temperature difference, output with 0 if the absolute
  //temperature difference is less than this limit.
protected
  Real C_d = 0.6 "Discharge coefficient";
  Real C = 0.02 "Coefficient";
  Real interimRes1 "Interim result";
equation
  assert(abs(deltaT) >= absDeltaTempLim,
    "The temperature difference is less than the limited value, the term of temperature difference correlation will be set to 0",
    AssertionLevel.warning);
  interimRes1 = if noEvent(abs(deltaT) >= absDeltaTempLim)
    then Modelica.Constants.g_n*winClrH*abs(deltaT)/T_i + C/abs(deltaT)
    else Modelica.Constants.g_n*winClrH*abs(deltaT)/T_i + 0;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow =if noEvent(interimRes1 > Modelica.Constants.eps) then 1/3*C_d*
    openingArea_1.A*sqrt(interimRes1) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Tang et al..</p>
<h4>References</h4>
<p>Tang, Y., Li, X., Zhu, W., &amp; Cheng, P. L. (2016). Predicting single-sided airflow rates based on primary school experimental study. Building and Environment, 98, 71&ndash;79. </p>
</html>"));
end Tang;
