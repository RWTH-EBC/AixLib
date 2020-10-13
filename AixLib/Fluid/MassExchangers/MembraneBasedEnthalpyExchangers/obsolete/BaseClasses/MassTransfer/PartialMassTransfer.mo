within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.MassTransfer;
partial model PartialMassTransfer
  "Common interface for mass transfer models"

  // Parameters
  replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
    annotation(Dialog(tab="Internal Interface",enable=false));
  parameter Integer n=1 "Number of heat transfer segments"
    annotation(Dialog(tab="Internal Interface",enable=false), Evaluate=true);

  // Inputs provided to mass transfer model
  input Medium.ThermodynamicState[n] states
    "Thermodynamic states of flow segments";

  input Modelica.SIunits.Area[n] surfaceAreas "Mass transfer areas";

  // Outputs defined by mass transfer model
  output Modelica.SIunits.MassFlowRate[n] m_flows "Mass flow rates";

  outer Modelica.Fluid.System system "System wide properties";

  // Flow ports
  Interfaces.FlowPort[n] flowPorts annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  //Variables
  input Modelica.SIunits.MassFraction[n] Xis "Mass fraction";

equation
  m_flows =flowPorts.m_flow;
  annotation (Documentation(info="<html><p>
  This component is a common interface for mass transfer models. The
  mass flow rates <code>m_flows[n]</code> through the boundaries of n
  flow segments are obtained as function of the thermodynamic
  <code>states</code> of the flow segments for a given fluid
  <code>Medium</code>, the <code>surfaceAreas[n]</code> and the
  boundary mass fractions <code>flowPorts[n].Xi</code>.
</p>An extending model implementing this interface needs to define one
equation: the relation between the predefined fluid mass fractions
<code>Xis[n]</code>, the boundary mass fractions
<code>flowPorts[n].Xi</code>, and the mass flow rates
<code>m_flows[n]</code>.
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end PartialMassTransfer;
