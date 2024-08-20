within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model LarsenHeiselberg "Empirical expression developed by Larsen and Heiselberg (2008)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStackWindIncidence(
      redeclare replaceable model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
      final varNameIntRes = "V_flow");
  parameter Modelica.Units.SI.Velocity winSpeLim(min=0.25)=1
    "Limitation of wind speed: Due to the wind speed in the denominator, this
    expression is not applicable to low wind speeds, output with 0 if the wind
    speed is less than this limit.";
  Integer errCouWinSpe10(start=0)
    "Warning counter for assertion check of 'winSpe10'";
  Modelica.Blocks.Interfaces.RealInput winSpe10(unit="m/s", min=0)
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
protected
  Real cofWinInc
    "Coefficient of wind incidence, equivalent to C_beta*sqrt(abs(C_p)) in the equation";
  Real dCofWinInc
    "Correlation of coefficient of wind incidence, equivalent to deltaC_p";
  Real cof1, cof2, cof3 "Other coefficients";
initial equation
  errCouWinSpe10 = 0;
equation
  incAng = AixLib.Airflow.WindowVentilation.BaseClasses.Functions.SmallestAngleDifference(
    AixLib.Airflow.WindowVentilation.BaseClasses.Types.SmallestAngleDifferenceTypes.Range360,
    winDir, aziRef);
  (cofWinInc,)  = Modelica.Math.Vectors.interpolate(
    {0, 45, 90, 135, 180, 225, 270, 315, 360},
    {0.2, 0.53, 0.56, 0.28, 0.09, 0.28, 0.56, 0.53, 0.2},
    incAngDeg);
  dCofWinInc = 9.1894e-9*(incAngDeg^3) - 2.626e-6*(incAngDeg^2) - 2.354e-4*incAngDeg + 0.113;
  if incAngDeg>=285 or incAngDeg<=75 then
    cof1 = 0.0015;
    cof2 = 0.0009;
    cof3 = -0.0005;
  elseif incAngDeg>=105 and incAngDeg<=255 then
    cof1 = 0.0050;
    cof2 = 0.0009;
    cof3 = 0.0160;
  else
    cof1 = 0.0010;
    cof2 = 0.0005;
    cof3 = 0.0111;
  end if;
  // Assertion of wind speed check
  when winSpe10 < winSpeLim then
    errCouWinSpe10 = pre(errCouWinSpe10) + 1;
  end when;
  assert(winSpe10 > winSpeLim or errCouWinSpe10 > 1,
    "In " + getInstanceName() + ": The wind speed is equal or less than the
    limited value (" + String(winSpeLim) + " m/s), the term of wind correlation 
    will be set to 0",
    AssertionLevel.warning);
  // Calculate intRes
  intRes =if noEvent(winSpe10 > winSpeLim)
    then cof1*(cofWinInc^2)*(winSpe10^2) + cof2*dTRoomAmb*winClrHeight
      + cof3*dCofWinInc*dTRoomAmb/(winSpe10^2)
    else cof1*(cofWinInc^2)*(winSpe10^2) + cof2*dTRoomAmb*winClrHeight + 0;
  // Calculate volume flow
  V_flow = if noEvent(intRes > Modelica.Constants.eps) then
    openingArea.A*sqrt(intRes) else 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model contains the empirical expression developed by Larsen and Heiselberg.</p>
<h4>References</h4>
<p>Larsen, T. S., &amp; Heiselberg, P. (2008). Single-sided natural ventilation driven by wind pressure and temperature difference. Energy and Buildings, 40(6), 1031&ndash;1040.</p>
</html>"));
end LarsenHeiselberg;
