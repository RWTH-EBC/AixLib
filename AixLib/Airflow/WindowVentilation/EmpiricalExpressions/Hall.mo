within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Hall "Empirical expression developed by Hall (2004)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare final model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashExpressionHall
        (winSashD=winSashD, winGapW=winGapW));
  parameter Modelica.Units.SI.Length winSashD(min=0) = 0 "Window sash depth";
  parameter Modelica.Units.SI.Length winGapW(min=0) = 0.01
    "Gap width in the overlap area between the frame and the sash";
protected
  Real C_d "Discharge coefficient";
  Real interimRes1 "Interim result";
equation
  C_d = 0.930*(openingArea.opnWidth^0.2) "Case: without window reveal, without radiator";
  interimRes1 = 2*Modelica.Constants.g_n*winClrH*openingArea.C_NPL*deltaT/T_i;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(interimRes1 > Modelica.Constants.eps)
    then C_d*openingArea.A*sqrt(interimRes1) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Hall;
