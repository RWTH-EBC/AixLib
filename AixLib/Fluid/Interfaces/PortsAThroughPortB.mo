within AixLib.Fluid.Interfaces;
model PortsAThroughPortB
  "Model to conenct fluid port bus ports_a to single port port_b"

  // Definition of parameters describing the modular approach in general
  //
  parameter Integer nVal = 1
    "Number of valves - each valve will be connected to an individual port_b"
    annotation(Dialog(tab="General",group="Modular approach"));

  // Extends base port model and set base parameters
  //
  extends WorkingVersion.Fluid.Interfaces.PartialModularPort_a(
    final nPorts=nVal,
    final allowFlowReversal=true,
    final dp_start,
    final m_flow_start,
    final dp_nominal,
    final m_flow_nominal,
    final m_flow_small);

equation
  // Connect port_a with inlet ports of expansion valves
  //
  for i in 1:nVal loop
    connect(ports_a[i],port_b);
  end for;

  annotation (Icon(graphics={
        Polygon(
          points={{-110,40},{0,40},{100,10},{110,10},{110,-10},{100,-10},{0,-40},
              {-110,-40},{-110,40}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.CrossDiag,
          fillColor={34,141,255}),
        Line(
          points={{-100,26},{100,0}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-100,-26},{100,0}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-100,0},{100,0}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-90,40},{0,40},{100,10},{110,10},{110,-10},{100,-10},{0,-40},
              {-110,-40},{-110,40},{-90,40}},
          color={0,0,0},
          thickness=1)}));
end PortsAThroughPortB;
