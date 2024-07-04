within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model DIN4108 "Empirical expression according to DIN/TS 4108-8 (2022)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN4108 openingArea);
  Modelica.Blocks.Interfaces.RealInput winSpeLoc(unit="m/s", min=0)
    "Local wind speed by window or facade"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cofDcg = 0.61 "Discharge coefficient";
  Real cofWin = 0.05 "Coefficient of wind speed";
  Real intRes "Interim result";
  Modelica.Units.SI.VolumeFlowRate V_flow_th "Thermal induced volume flow";
  Modelica.Units.SI.VolumeFlowRate V_flow_win "Wind induced volume flow";
equation
  intRes = Modelica.Constants.g_n*winClrHeight*dT_RoomAmb/TAmb;
  assert(intRes > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow_th is less than 0, the V_flow_th will be set to 0",
    AssertionLevel.warning);
  V_flow_th =if noEvent(intRes > Modelica.Constants.eps) then
    1/3*cofDcg*openingArea.A*sqrt(intRes) else 0;
  V_flow_win =cofWin*openingArea.A*winSpeLoc;
  V_flow = sqrt(V_flow_th^2 + V_flow_win^2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=
    \"//&quot;https://github.com/RWTH-EBC/AixLib/issues/1492//&quot;\">issue
    1492</a>)
  </li>
</ul>
</html>", info="<html><p>
  This model contains the empirical expression according to DIN/TS
  4108-8:2022-09.
</p>
<h4>
  References
</h4>
<p>
  DIN Deutsches Institut für Normung e. V. (2022.09). Wärmeschutz und
  Energie-Einsparung in Gebäuden – Teil 8: Vermeidung von
  Schimmelwachstum in Wohngebäuden: Vornorm (DIN/TS 4108-8). Beuth
  Verlag GmbH.
</p>
</html>"));
end DIN4108;
