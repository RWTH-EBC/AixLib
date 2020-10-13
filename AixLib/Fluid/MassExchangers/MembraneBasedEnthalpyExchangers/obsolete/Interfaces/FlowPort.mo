within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.Interfaces;
connector FlowPort "Connector flow port"

  flow Modelica.SIunits.MassFlowRate m_flow;
  Modelica.SIunits.MassFraction Xi;
  Modelica.SIunits.Pressure p;

annotation (Documentation(info="<html><p>
  Basic definition of the connector.
</p>
<p>
  <b>Variables:</b>
</p>
<ul>
  <li>Pressure p
  </li>
  <li>flow MassFlowRate m_flow
  </li>
  <li>MassFraction Xi
  </li>
</ul>
<p>
  If ports with different media are connected, the simulation is
  asserted due to the check of parameter.
</p>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end FlowPort;
