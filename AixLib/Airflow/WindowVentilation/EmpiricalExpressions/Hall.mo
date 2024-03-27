within AixLib.Airflow.WindowVentilation.EmpiricalExpressions;
model Hall "Empirical expression developed by Hall (2004)"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialEmpiricalFlowStack(
      final useOpnAreaInput=false,
      final useSpecOpnAreaTyp,
      final opnAreaTyp);
  parameter Modelica.Units.SI.Length winSashD(min=0) = 0 "Window sash depth";
  parameter Modelica.Units.SI.Length winGapW(min=0) = 0.01
    "Gap width in the overlap area between the frame and the sash";
  Modelica.Units.SI.Area winOpnA(min=0)
    "Window opening area, differs from the input port A";
  Modelica.Blocks.Interfaces.RealInput s(quantity="Length", unit="m", min=0)
    "Window sash opening width"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-40,120})));
protected
  Real C_d "Discharge coefficient";
  Real C_NPL "Correction factor of the neutral pressure level";
  Real interimRes1 "Interim result";
equation
  C_d = 0.930*(s^0.2) "Case: without window reveal, without radiator";
  assert(winClrH >= winClrW,
    "The model only applies to windows whose height is not less than the width",
    AssertionLevel.warning);
  C_NPL = sqrt((winClrW - s)/winClrH);
  winOpnA = C_NPL*s*(winClrH*s/(s + winSashD) - winClrH*(1- C_NPL))
    + 2*winClrH*winSashD/(s + winSashD)*winGapW;
  interimRes1 = 2*Modelica.Constants.g_n*winClrH*C_NPL*deltaT/T_i;
  assert(interimRes1 > Modelica.Constants.eps,
    "The polynomial under the square root to calculate V_flow is less than 0, the V_flow will be set to 0",
    AssertionLevel.warning);
  V_flow = if noEvent(interimRes1 > Modelica.Constants.eps)
    then C_d*winOpnA*sqrt(interimRes1) else 0;
end Hall;
