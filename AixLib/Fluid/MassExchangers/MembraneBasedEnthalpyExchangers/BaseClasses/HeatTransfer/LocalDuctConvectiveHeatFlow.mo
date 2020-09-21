within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
model LocalDuctConvectiveHeatFlow
  "heat transfer model for locally resolved rectangular ducts"
  extends PartialDuctHeatTransfer;

  parameter Real nParallel "number of parallel ducts";

equation
  Q_flows={hCons[i]*surfaceAreas[i]*(heatPorts[i].T - Ts[i])*nParallel for i in 1:n};


  annotation (Documentation(info="<html>
<p>This heat transfer model calculates the convective heat flow for local distribution using the function convectiveHeatTransferCoefficient. The heat flow is calculated as follows.</p>
<p align=\"center\"><i>Q̇[i] = &alpha;[i] C<sub>cross</sub>[i] A<sub>surface</sub>[i] ( heatPorts[i].T - T<sub>s</sub>[i] ) n<sub>parallel</sub> </i></p>
</html>", revisions="<html>
<ul>
<li>August 21, 2018, by Martin Kremer:<br/>First implementation.</li>
</ul>
</html>"));
end LocalDuctConvectiveHeatFlow;
