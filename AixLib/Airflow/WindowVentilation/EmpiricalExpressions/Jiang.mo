within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Jiang "Empirical expression developed by Jiang et al. (2022)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlow(
    redeclare AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingArea(
      final opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
      final opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective));
  Modelica.Blocks.Interfaces.RealInput dp(unit="Pa")
    "Pressure difference between the outside and inside of the facade "
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  Real cof1 = 0.15 "Coefficient 1";
  Real cof2 = 0.33 "Coefficient 2";
  Real intRes "Interim result";
equation
  intRes = cof1*dp + cof2;
  assert(intRes > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(intRes > Modelica.Constants.eps) then
    1/2*openingArea.A*sqrt(intRes) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Jiang et al..</p>
<h4>References</h4>
<p>Jiang, J., Yang, J., Rewitz, K., &amp; M&uuml;ller, D. (2022). Experimental Quantification of Air Volume Flow by Natural Ventilation through Window Opening. In American Society of Heating and Air-Conditioning Engineers (Chair), IAQ 2020: Indoor Environmental Quality Performance Approaches, Athens.</p>
</html>"));
end Jiang;
