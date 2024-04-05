within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Caciolo
  "Empirical expression developed by Caciolo et al. (2013)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStackWindIncidence(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  Modelica.Blocks.Interfaces.RealInput u(unit="m/s", min=0)
    "Local wind speed by window or facade"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_d = 0.60 "Discharge coefficient";
  Real C_T "Coefficient of wind";
  Modelica.Units.SI.Velocity u_lim=1.23
    "Lower bound of wind speed in windward conditions";
  Real interimRes1 "Interim result";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_w "Wind induced volume flow";
equation
  beta = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference(
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180,
    phi,
    aziRef);
  if abs(beta_deg) <= 90 then
    /*Windward*/
    C_T = 1.234 - 0.490*u + 0.048*(u^2);
    assert(u >= u_lim,
      "The wind speed in the windward condition is less than the limitation, the V_flow_w will be set to 0",
      AssertionLevel.warning);
    V_flow_w = if noEvent(u >= u_lim) then 0.0357*openingArea.A*(u - u_lim)
      else 0;
  else
    /*Leeward*/
    C_T = 1.355 - 0.179*u;
    V_flow_w = 0;
  end if;
  interimRes1 = Modelica.Constants.g_n*winClrH*deltaT*C_T/avgT;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow_th is less than 0, the V_flow_th will be set to 0",
    AssertionLevel.warning);
  V_flow_th = if noEvent(interimRes1 > Modelica.Constants.eps)
    then 1/3*openingArea.A*C_d*sqrt(interimRes1) else 0;
  V_flow = V_flow_th + V_flow_w;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Caciolo et al..</p>
<h4>References</h4>
<p>Caciolo, M., Cui, S., Stabat, P., &amp; Marchio, D. (2013). Development of a new correlation for single-sided natural ventilation adapted to leeward conditions. Energy and Buildings, 60, 372&ndash;382.</p>
</html>"));
end Caciolo;
