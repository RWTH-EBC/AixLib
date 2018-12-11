within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
partial model PartialMetaIsenthalpicExpansionValve
  "Base model for all isenthalpic expansion valves"

   extends BaseClasses.PartialMetaExpansionValve;

equation
  // Calculation of energy balance
  //
  port_a.h_outflow = inStream(port_b.h_outflow) "Isenthalpic expansion valve";
  port_b.h_outflow = inStream(port_a.h_outflow) "Isenthalpic expansion valve";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialMetaIsenthalpicExpansionValve;
