within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Caciolo "Empirical expression developed by Caciolo et al. (2013)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStackWindIncidence(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
      final varNameIntRes = "V_flow_th");
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
equation
  incAng = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference(
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range180,
    winDir, aziRef);
  // Calculate V_flow_win
  if abs(incAngDeg) <= 90 then
    /*Windward*/
    cofWin = 1.234 - 0.490*winSpeLoc + 0.048*(winSpeLoc^2);
    // If winSpeLoc < winSpeLim, wind-driven airflow is negligible
    V_flow_win = 0.0357*openingArea.A*max(winSpeLoc - winSpeLim, 0);
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
  <li>
    Dec. 18, 2024, by Jun Jiang:<br/>
    Replace the wind speed warning counter with max() function for cases of negligible wind-driven airflow (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1561\">issue 1561</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Caciolo et al..</p>
<h4>References</h4>
<p>Caciolo, M., Cui, S., Stabat, P., &amp; Marchio, D. (2013). Development of a new correlation for single-sided natural ventilation adapted to leeward conditions. Energy and Buildings, 60, 372&ndash;382.</p>
</html>"));
end Caciolo;
