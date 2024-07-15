within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Hall "Empirical expression developed by Hall (2004)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashHall (
        final sWinSas=sWinSas, final widthWinGap=widthWinGap),
      varName="V_flow");
  parameter Modelica.Units.SI.Thickness sWinSas(min=0) = 0
    "Window sash thickness (depth)";
  parameter Modelica.Units.SI.Length widthWinGap(min=0) = 0.01
    "Gap width in the overlap area between the frame and the sash";
protected
  Real cofDcg = 0.930*(openingArea.opnWidth_internal^0.2)
    "Discharge coefficient, case: without window reveal, without radiator";
  Real intRes "Interim result";
equation
  intRes = 2*Modelica.Constants.g_n*winClrHeight*openingArea.corNPL*dTRoomAmb/
    TRoom;
  V_flow = if noEvent(intRes > Modelica.Constants.eps) then
    cofDcg*openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Hall.</p>
<h4>References</h4>
<p>Hall, M. (2004). Untersuchungen zum thermisch induzierten Luftwechselpotential von Kippfenstern [Dissertation]. Universit&auml;t Kassel, Kassel. </p>
</html>"));
end Hall;
