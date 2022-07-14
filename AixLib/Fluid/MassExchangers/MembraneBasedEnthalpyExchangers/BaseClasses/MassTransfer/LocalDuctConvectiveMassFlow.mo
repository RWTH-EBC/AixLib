within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
model LocalDuctConvectiveMassFlow
  "mass transfer model for locally resolved rectangular ducts in quasi-counter 
  flow arrangement"
  extends PartialDuctMassTransfer;

  parameter Real nParallel "number of parallel ducts";

  input Real[n] coeCroCous
    "coefficient for mass transfer reduction due to cross-flow portion";

equation
  m_flows={kCons[i]*coeCroCous[i]*surfaceAreas[i]*(massPorts[i].p - ps[i])
    *nParallel for i in 1:n};

  annotation (Documentation(info="<html><p>
  This mass transfer model calculates the convective mass flow for
  local distribution using the function
  convectiveMassTransferCoefficient. The mass flow is calculated as
  follows.
</p>
<p style=\"text-align:center;\">
  <i>ṁ[i] = β[i] A<sub>surface</sub>[i] ( flowPorts[i].Xi -
  Xi<sub>s</sub>[i] ) n<sub>parallel</sub></i>
</p>
</html>", revisions="<html>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end LocalDuctConvectiveMassFlow;
