within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Caciolo "Empirical expression developed by Caciolo et al. (2013)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStackWindIncidence(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
      final varNameIntRes = "V_flow_th");
    Integer errCouWinSpeLoc(start=0)
      "Warning counter for assertion check of 'winSpeLoc'";
  Modelica.Blocks.Interfaces.RealInput winSpeLoc(unit="m/s", min=0)
    "Local wind speed by window or facade"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cofDcg = 0.60 "Discharge coefficient";
  Real cofWin "Coefficient of wind";
  Modelica.Units.SI.Velocity winSpeLim = 1.23
    "Lower bound of wind speed in windward conditions";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_win "Wind induced volume flow";
initial equation
  errCouWinSpeLoc = 0;
equation
  incAng = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference(
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180,
    winDir, aziRef);
  // Assertion of wind speed
  when (winSpeLoc < winSpeLim) and abs(incAngDeg) <= 90 then
    errCouWinSpeLoc = pre(errCouWinSpeLoc) + 1;
  end when;
  assert(winSpeLoc > winSpeLim or errCouWinSpeLoc > 1,
    "In " + getInstanceName() + ": The wind speed in the windward condition 
    is equal or less than the limitation (" + String(winSpeLim) + " m/s), the 
    'V_flow_win' will be set to 0",
    AssertionLevel.warning);
  // Calculate V_flow_win
  if abs(incAngDeg) <= 90 then
    /*Windward*/
    cofWin = 1.234 - 0.490*winSpeLoc + 0.048*(winSpeLoc^2);
    V_flow_win =if noEvent(winSpeLoc > winSpeLim) then
      0.0357*openingArea.A*(winSpeLoc - winSpeLim) else 0;
  else
    /*Leeward*/
    cofWin = 1.355 - 0.179*winSpeLoc;
    V_flow_win = 0;
  end if;
  intRes = Modelica.Constants.g_n*winClrHeight*dTRoomAmb*cofWin/TAvg;
  V_flow_th = if noEvent(intRes > Modelica.Constants.eps) then
    1/3*openingArea.A*cofDcg*sqrt(intRes) else 0;
  V_flow = V_flow_th + V_flow_win;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Caciolo et al..</p>
<h4>References</h4>
<p>Caciolo, M., Cui, S., Stabat, P., &amp; Marchio, D. (2013). Development of a new correlation for single-sided natural ventilation adapted to leeward conditions. Energy and Buildings, 60, 372&ndash;382.</p>
</html>"));
end Caciolo;
