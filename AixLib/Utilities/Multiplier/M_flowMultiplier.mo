within AixLib.Utilities.Multiplier;
model M_flowMultiplier

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
    annotation (choicesAllMatching=true);
  parameter Real f "multiplier: port_a.m_flow=f*port_b.m_flow";

  extends Modelica.Fluid.Interfaces.PartialTwoPort(
    final port_a_exposesState=false,
    final port_b_exposesState=false);

  // Advanced
  parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
    "Guess value of m_flow = port_a.m_flow"
    annotation(Dialog(tab = "Advanced"));
  parameter Medium.MassFlowRate m_flow_small = system.m_flow_small
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));

  // Diagnostics
  parameter Boolean show_T = false
    "= true, if temperatures at port_a and port_b are computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_V_flow = false
    "= true, if volume flow rate at inflowing port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Variables
  Modelica.SIunits.VolumeFlowRate V_flow=
      port_a.m_flow/Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                  Medium.density(state_a),
                  Medium.density(state_b),
                  m_flow_small*f) if show_V_flow
    "Volume flow rate at inflowing port (positive when flow from port_a to port_b)";

  Medium.Temperature port_a_T=
      Modelica.Fluid.Utilities.regStep(port_a.m_flow,
                  Medium.temperature(state_a),
                  Medium.temperature(Medium.setState_phX(port_a.p, port_a.h_outflow, port_a.Xi_outflow)),
                  m_flow_small*f) if show_T
    "Temperature close to port_a, if show_T = true";
  Medium.Temperature port_b_T=
      Modelica.Fluid.Utilities.regStep(port_b.m_flow,
                  Medium.temperature(state_b),
                  Medium.temperature(Medium.setState_phX(port_b.p, port_b.h_outflow, port_b.Xi_outflow)),
                  m_flow_small) if show_T
    "Temperature close to port_b, if show_T = true";
protected
  Medium.ThermodynamicState state_a "state for medium inflowing through port_a";
  Medium.ThermodynamicState state_b "state for medium inflowing through port_b";

equation
  // medium states
  state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
  state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));

  // Pressure drop in design flow direction
  0 = port_a.p - port_b.p;

  // Design direction of mass flow rate
  assert(port_a.m_flow > -m_flow_small or allowFlowReversal, "Reverting flow occurs even though allowFlowReversal is false");

  // Mass balance (no storage)
  port_a.m_flow + f*port_b.m_flow = 0;

  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);

  // Transport of substances
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}), graphics={
      Polygon(points={{-80,60},{80,0},{-80,-60},{-80,60}}, lineColor={0,0,
            255})}),    Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>
The model multiplies the mass flow rate and enthalpy of a medium at constant pressure and temperature.
</p>
<h4><font color=\"#008000\">Example Results</font></h4>
<p><a href=\"BaseLib.Examples.Multiplier_test\">BaseLib.Examples.Multiplier_test </a></p>
</html>",
      revisions="<html>
<ul>
<li><i>April 01, 2014  </i>by Moritz Lauster:<br/>
Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>
Formatted documentation appropriately</li>
<li><i>November, 2011&nbsp;</i> by Peter Matthes:<br/>
Model rewritten to work with MSL 3.2.</li>
<li>by Alexander Hoh:<br/>
Implemented.</li>
</ul>
</html>"));
end M_flowMultiplier;
