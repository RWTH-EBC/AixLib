within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
partial model PartialIsothermalExpansionValve
  "Base model for alls isothermal expansion valves"
  extends BaseClasses.PartialExpansionValve;

equation
  // Calculation of energy balance
  //
  port_a.h_outflow = inStream(port_b.h_outflow) "Isenthalpic expansion valve";
  port_b.h_outflow = inStream(port_a.h_outflow) "Isenthalpic expansion valve";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end PartialIsothermalExpansionValve;
