within AixLib.Fluid.Actuators.ExpansionValves.SimpleExpansionValves;
model IsothermalLinearExpansionValve
  "Model of a simple isothermal linear expansion valve"
  extends BaseClasses.PartialIsothermalExpansionValve(final calcProc=Utilities.Choices.CalcProc.linear);

equation
  // Calculation of mass flow and pressure drop
  //
  if (calcProc == Utilities.Choices.CalcProc.linear) then
    C = 1  "Linear relationship";
    m_flow = C * AThr * dp
    "Simple linear relationship between mass flow and pressure drop";

  elseif (calcProc == Utilities.Choices.CalcProc.nominal) then
    C * dpNom = mFlowNom "Nominal relationship";
    m_flow = C * AThr * dp
    "Simple nominal relationship between mass flow and pressure drop";

  elseif (calcProc == Utilities.Choices.CalcProc.flowCoefficient) then
    C = flowCoefficient.C "Flow coefficient model";
    m_flow = homotopy(C * AThr * sqrt(2*dInl*dp),
                      mFlowNom/dpNom * AThr * dp)
    "Usage of flow coefficient model";

  else
    assert(false, "Invalid choice of calculation procedure");
  end if;

end IsothermalLinearExpansionValve;
