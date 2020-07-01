within AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves;
model IsenthalpicExpansionValve "Model of a simple isenthalpic expansion valve"
  extends BaseClasses.PartialIsenthalpicExpansionValve;

equation
  // Calculation of mass flow and pressure drop
  //
  if (calcProc == Utilities.Types.CalcProc.linear) then
    C = 1  "Linear relationship";
    m_flow = C * AThr * dp
    "Simple linear relationship between mass flow and pressure drop";

  elseif (calcProc == Utilities.Types.CalcProc.nominal) then
    C * dpNom = mFlowNom "Nominal relationship";
    m_flow = C * AThr * dp
    "Simple nominal relationship between mass flow and pressure drop";

  elseif (calcProc == Utilities.Types.CalcProc.flowCoefficient) then
    C = flowCoefficient.C "Flow coefficient model";
    m_flow = homotopy(C * AThr * sqrt(abs(2*dInl*dp)),
                      mFlowNom/dpNom * AThr * dp)
    "Usage of flow coefficient model";

  else
    assert(false, "Invalid choice of calculation procedure");
  end if;

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a model of a simple expansion valve that is used, for
  example, in close-loop systems like heat pumps or chillers. It
  inherits from PartialIsenthalpicExpansionValve which inherits from
  PartialExpansionValve. Therefore, please checkout these sub-models
  for further information of underlying modeling approaches and
  parameterisation:
</p>
<ul>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialIsenthalpicExpansionValve\">
    AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialIsenthalpicExpansionValve</a>.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
    AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>.
  </li>
</ul>
</html>"));
end IsenthalpicExpansionValve;
