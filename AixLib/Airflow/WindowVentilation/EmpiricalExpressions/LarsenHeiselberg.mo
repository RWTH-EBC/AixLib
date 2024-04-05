within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model LarsenHeiselberg
  "Empirical expression developed by Larsen and Heiselberg (2008)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStackWindIncidence(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple);
  parameter Modelica.Units.SI.Velocity windSpeLim(min=0.25)=1
    "Limitation of wind speed";
  //Due to the wind speed in the denominator, this expression is not applicable
  //to low wind speeds, output with 0 if the wind speed is less than this limit.
  Modelica.Blocks.Interfaces.RealInput u_10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real C_beta_p "Coefficient of C_beta*sqrt(abs(C_p))";
  Real deltaC_p "Coefficient of deltaC_p";
  Real C_1, C_2, C_3 "Other coefficients";
  Real interimRes1 "Interim result1";
equation
  beta = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference(
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range360,
    phi,
    aziRef);
  (C_beta_p,)  = Modelica.Math.Vectors.interpolate(
    {0, 45, 90, 135, 180, 225, 270, 315, 360},
    {0.2, 0.53, 0.56, 0.28, 0.09, 0.28, 0.56, 0.53, 0.2},
    beta_deg);
  deltaC_p = 9.1897e-9*(beta_deg^3) - 2.626e-6*(beta_deg^2) - 2.354e-4*beta + 0.113;
  if beta_deg>=285 or beta_deg<=75 then
    C_1 = 0.0015;
    C_2 = 0.0009;
    C_3 = -0.0005;
  elseif beta_deg>=105 and beta_deg<=255 then
    C_1 = 0.0050;
    C_2 = 0.0009;
    C_3 = 0.0160;
  else
    C_1 = 0.0010;
    C_2 = 0.0005;
    C_3 = 0.0111;
  end if;
  assert(u_10 >= windSpeLim,
    "The wind speed is less than the limited value, the term of wind correlation will be set to 0",
    AssertionLevel.warning);
  interimRes1 = if noEvent(u_10 >= windSpeLim)
    then C_1*(C_beta_p^2)*(u_10^2) + C_2*deltaT*winClrH + C_3*deltaC_p*deltaT/(u_10^2)
    else C_1*(C_beta_p^2)*(u_10^2) + C_2*deltaT*winClrH + 0;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(interimRes1 > Modelica.Constants.eps)
    then openingArea.A*sqrt(interimRes1) else 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Larsen and Heiselberg.</p>
<h4>References</h4>
<p>Larsen, T. S., &amp; Heiselberg, P. (2008). Single-sided natural ventilation driven by wind pressure and temperature difference. Energy and Buildings, 40(6), 1031&ndash;1040.</p>
</html>"));
end LarsenHeiselberg;
