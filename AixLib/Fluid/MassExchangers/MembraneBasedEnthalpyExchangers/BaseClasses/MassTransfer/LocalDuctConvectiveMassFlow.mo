within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
model LocalDuctConvectiveMassFlow
  "heat transfer model for locally resolved rectangular ducts"
  extends PartialDuctMassTransfer;

  parameter Real nParallel "number of parallel ducts";

equation
  m_flows={betas[i]*surfaceAreas[i]*(massPorts[i].X - Xs[i])*nParallel for i in 1:n};

  annotation (Documentation(info="<html>
<p>This mass transfer model calculates the convective mass flow for local distribution using the function convectiveMassTransferCoefficient. The mass flow is calculated as follows.</p>
<p align=\"center\"><i>m&#775;[i] = &beta;[i] A<sub>surface</sub>[i] ( flowPorts[i].Xi - Xi<sub>s</sub>[i] ) n<sub>parallel</sub> </i></p>
</html>", revisions="<html>
<ul>
<li>August 21, 2018, by Martin Kremer:<br/>First implementation.</li>
</ul>
</html>"));
end LocalDuctConvectiveMassFlow;
