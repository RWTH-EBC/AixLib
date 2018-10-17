within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices;
type CalcProc = enumeration(
    linear
    "Usage of linear behaviour: m_flow = A * f(dp)",
    nominal
    "Usage of nominal conditions: m_flow = (m_flow/dp)_nominal * f(dp)",
    flowCoefficient
    "Usage of flow coefficient: m_flow = C * f(dp)")
  "Enumeration to define calculation procedure of mass flow and pressure drop"
  annotation (Evaluate=true);
