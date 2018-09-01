within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
partial model PartialFlowIsenthalpicValve

    extends PartialFlowValve;

equation

  port_a.h_outflow = inStream(port_b.h_outflow)
                                               "Isenthalpic expansion valve";
  port_b.h_outflow = inStream(port_a.h_outflow)
                                               "Isenthalpic expansion valve";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialFlowIsenthalpicValve;
