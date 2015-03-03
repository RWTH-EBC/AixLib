within AixLib.HVAC.Interfaces;
partial model TwoPort
  "Component with two hydraulic ports and mass flow rate from a to b"
  Modelica.SIunits.PressureDifference dp
    "Pressure drop between the two ports (= port_a.p - port_b.p)";
  Modelica.SIunits.MassFlowRate m_flow "Mass flowing from port a to port b";
  outer BaseParameters baseParameters "System properties";
  Port_a port_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Port_b port_b annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
protected
  parameter Modelica.SIunits.DynamicViscosity mu = baseParameters.mu_Water
    "Dynamic viscosity";
  parameter Modelica.SIunits.Density rho = baseParameters.rho_Water
    "Density of the fluid";
  parameter Modelica.SIunits.SpecificHeatCapacity cp = baseParameters.cp_Water
    "Specific heat capacity";
equation
  dp = port_a.p - port_b.p;
  0 = port_a.m_flow + port_b.m_flow;
  m_flow = port_a.m_flow;
  annotation(Icon(graphics), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(revisions = "<html>
 <p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>
 This component transports fluid between its two ports, without storing mass or energy.
 Energy may be exchanged with the environment though, e.g., in the form of heat transfer.
 <code>TwoPort</code> is intended as base class for devices like pipes, valves and simple fluid machines.
 <p>
 <h4><font color=\"#008000\">Concept</font></h4>
 Three equations need to be added by an extending class using this component:
 </p>
 <ul>
 <li>the momentum balance specifying the relationship between the pressure drop <code>dp</code> and the mass flow rate <code>m_flow</code></li>
 <li><code>port_b.h_outflow</code> for flow in design direction</li>
 <li><code>port_a.h_outflow</code> for flow in reverse direction</li>
 </ul>
 </html>"));
end TwoPort;

