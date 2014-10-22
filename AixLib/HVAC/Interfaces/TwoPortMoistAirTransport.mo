within AixLib.HVAC.Interfaces;
partial model TwoPortMoistAirTransport
  "Base class for moist air transport models without influence on fluid"
  extends TwoPortMoistAir;

equation
    // Mass Equation
  0 = portMoistAir_a.m_flow + portMoistAir_b.m_flow;

    // Enthalpy Equations
  inStream(portMoistAir_a.h_outflow) = portMoistAir_b.h_outflow;
  inStream(portMoistAir_b.h_outflow) = portMoistAir_a.h_outflow;

    // Water Equations
  inStream(portMoistAir_b.X_outflow) = portMoistAir_a.X_outflow;
  inStream(portMoistAir_a.X_outflow) = portMoistAir_b.X_outflow;

  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Two Port Model for Moist Air with transport equations, no influence of fluid</p>
</html>",
    revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),            graphics));
end TwoPortMoistAirTransport;
