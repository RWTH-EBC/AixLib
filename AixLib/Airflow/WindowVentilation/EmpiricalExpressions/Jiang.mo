within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Jiang "Empirical expression developed by Jiang et al. (2022)"
  extends AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlow(
      final useOpnAreaInput=true,
      final useSpecOpnAreaTyp=true,
      final opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective);
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
    then 1/2*A_eff*sqrt(interimRes1) else 0;
end Jiang;
