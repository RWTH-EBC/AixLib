within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model GidsPhaff
  "Empirical expression developed by de Gids and Phaff (1982)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      final useOpnAreaInput=true,
      final useSpecOpnAreaTyp=false,
      final opnAreaTyp);
  Modelica.Blocks.Interfaces.RealInput u_10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_1 = 0.001 "Coefficient 1";
  Real C_2 = 0.0035 "Coefficient 2";
  Real C_3 = 0.01 "Coefficient 3";
  Real interimRes1 "Interim result";
equation
  interimRes1 = C_1*(u_10^2) + C_2*winClrH*deltaT + C_3;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(interimRes1 > Modelica.Constants.eps)
    then 1/2*A*sqrt(interimRes1) else 0;
end GidsPhaff;
