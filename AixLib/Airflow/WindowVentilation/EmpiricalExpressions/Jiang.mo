within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Jiang "Empirical expression developed by Jiang et al. (2022)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlow(
      redeclare final model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashWidth (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective));
  Modelica.Blocks.Interfaces.RealInput dp(unit="Pa")
    "Pressure difference between the outside and inside of the facade "
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  Real C_1 = 0.15 "Coefficient 1";
  Real C_2 = 0.33 "Coefficient 2";
  Real interimRes1 "Interim result";
equation
  interimRes1 = C_1*dp + C_2;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(interimRes1 > Modelica.Constants.eps)
    then 1/2*openingArea.A*sqrt(interimRes1) else 0;
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Jiang et al..</p>
<h4>References</h4>
<p>Jiang, J., Yang, J., Rewitz, K., &amp; M&uuml;ller, D. (2022). Experimental Quantification of Air Volume Flow by Natural Ventilation through Window Opening. In American Society of Heating and Air-Conditioning Engineers (Chair), IAQ 2020: Indoor Environmental Quality Performance Approaches, Athens.</p>
</html>"));
end Jiang;
