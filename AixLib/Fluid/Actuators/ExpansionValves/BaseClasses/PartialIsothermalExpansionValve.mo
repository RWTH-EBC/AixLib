within AixLib.Fluid.Actuators.ExpansionValves.BaseClasses;
partial model PartialIsothermalExpansionValve
  "Base model for alls isothermal expansion valves"
  extends BaseClasses.PartialExpansionValve;

equation
  // Calculation of energy balance
  //
  port_a.h_outflow = inStream(port_b.h_outflow) "Isenthalpic expansion valve";
  port_b.h_outflow = inStream(port_a.h_outflow) "Isenthalpic expansion valve";

end PartialIsothermalExpansionValve;
