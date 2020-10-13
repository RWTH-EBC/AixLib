within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses.HeatTransfer;
model LocalDuctConvectiveHeatFlow
  "convective heat transfer locally resolved"
  extends PartialDuctHeatTransfer;

  parameter Real nParallel "number of parallel ducts";

equation

  Q_flows={alphas[i]*surfaceAreas[i]*(heatPorts[i].T - Ts[i])*nParallel for i in 1:n};

  annotation (Documentation(revisions="<html><ul>
  <li>April 23, 2019, by Martin Kremer:<br/>
    Changes extends due to changes in calculation of heat transfer
    coefficient.
  </li>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This heat transfer model calculates the convective heat flow for
  local distribution using the function
  convectiveHeatTransferCoefficient. The heat flow is calculated as
  follows.
</p>
<p style=\"text-align:center;\">
  <i>Q̇ = 2 α C<sub>cross</sub> A<sub>surface</sub> ( heatPorts.T -
  T<sub>s</sub> ) n<sub>parallel</sub></i>
</p>
</html>"));
end LocalDuctConvectiveHeatFlow;
