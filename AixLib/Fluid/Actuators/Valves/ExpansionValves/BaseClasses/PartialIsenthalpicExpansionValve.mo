within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
partial model PartialIsenthalpicExpansionValve
  "Base model for all isenthalpic expansion valves"
  extends BaseClasses.PartialExpansionValve;

equation
  // Calculation of energy balance
  //
  port_a.h_outflow = inStream(port_b.h_outflow) "Isenthalpic expansion valve";
  port_b.h_outflow = inStream(port_a.h_outflow) "Isenthalpic expansion valve";

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a base model for simple isenthalpic expansion valves that are
  used, for example, in close-loop systems like heat pumps or chillers.
  This model inherits from <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses.PartialExpansionValve</a>
  and, hence, please check out the PartialExpansionValve model if
  detailed information is required about the modelling approach.
</p>
<p>
  Within this base model, the following two equations are implemented:
</p>
<ul>
  <li>
    <code>port_b.h_outflow = inStrem(port_a.h_outflow)</code> for flow
    in design direction.
  </li>
  <li>
    <code>port_a.h_outflow = inStrem(port_b.h_outflow)</code> for flow
    in reverse direction.
  </li>
</ul>
</html>"));
end PartialIsenthalpicExpansionValve;
