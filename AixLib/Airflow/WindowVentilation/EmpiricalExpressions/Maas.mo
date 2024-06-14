within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Maas "Empirical expression developed by Maas (1995)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
    redeclare AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingArea(
      final opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
      final opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective));
  Modelica.Blocks.Interfaces.RealInput winSpe13(unit="m/s", min=0)
    "Local wind speed at a height of 13 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cof1 = 0.0056 "Coefficient 1";
  Real cof2 = 0.0037 "Coefficient 2";
  Real cof3 = 0.012 "Coefficient 3";
  Real intRes "Interim result";
equation
  intRes = cof1*(winSpe13^2) + cof2*winClrHeight*dT_RoomAmb + cof3;
  assert(intRes > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow =if noEvent(intRes > Modelica.Constants.eps) then
    1/2*openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Maas.</p>
<h4>References</h4>
<p>Maas, A. (1995). Experimentelle Quantifizierung des Luftwechsels bei Fensterl&uuml;ftung [Dissertation]. Universit&auml;t Gesamthochschule Kassel, Kassel. </p>
</html>"));
end Maas;
