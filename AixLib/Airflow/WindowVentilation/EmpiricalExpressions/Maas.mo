within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Maas "Empirical expression developed by Maas (1995)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      redeclare final model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashWidth (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective));
  Modelica.Blocks.Interfaces.RealInput u_13(unit="m/s", min=0)
    "Local wind speed at a height of 13 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_1 = 0.0056 "Coefficient 1";
  Real C_2 = 0.0037 "Coefficient 2";
  Real C_3 = 0.012 "Coefficient 3";
  Real interimRes1 "Interim result";
equation
  interimRes1 = C_1*(u_13^2) + C_2*winClrH*deltaT + C_3;
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
<p>This model contains the empirical expression developed by Maas.</p>
<h4>References</h4>
<p>Maas, A. (1995). Experimentelle Quantifizierung des Luftwechsels bei Fensterl&uuml;ftung [Dissertation]. Universit&auml;t Gesamthochschule Kassel, Kassel. </p>
</html>"));
end Maas;
