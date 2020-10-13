within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.MassTransfer;
model LocalDuctConvectiveMassFlow
  "Convective mass transfer through duct locally resolved"
  extends PartialDuctMassTransfer;

  parameter Real nParallel "number of parallel ducts";

equation

  m_flows={betas[i]*surfaceAreas[i]*(flowPorts[i].Xi - Xis[i])*nParallel for i in 1:n};

  annotation (Documentation(revisions="<html><ul>
  <li>April 23, 2019, by Martin Kremer:<br/>
    Changes extends due to changes on calculation of mass transfer
    coefficient.
  </li>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This mass transfer model calculates the convective mass flow using
  the function convectiveMassTransferCoefficient. The mass flow is
  calculated as follows.
</p>
<p style=\"text-align:center;\">
  <i>ṁ = 2 β C<sub>cross</sub> A<sub>surface</sub> ( flowPort.Xi -
  Xi<sub>s</sub> ) n<sub>parallel</sub></i>
</p>
</html>"));
end LocalDuctConvectiveMassFlow;
