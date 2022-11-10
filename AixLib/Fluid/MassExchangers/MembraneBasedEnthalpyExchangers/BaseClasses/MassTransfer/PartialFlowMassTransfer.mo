within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
partial model PartialFlowMassTransfer
  "base class for any flow mass transfer correlation"
  extends PartialMassTransfer;

  // Additional inputs provided to flow heat transfer model
  input Modelica.Units.SI.Velocity[n] vs
    "Mean velocities of fluid flow in segments";

  input Modelica.Units.SI.Length[n] lengths "Lengths along flow path";

  annotation (Documentation(info="<html><p>
  Base class for mass transfer models of flow devices.
</p>
<p>
  The geometry is specified in the interface with the
  <code>lengths[n]</code> along the flow path. Moreover the fluid flow
  is characterized for different types of devices by the average
  velocities <code>vs[n+1]</code> of fluid flow.
</p>
</html>", revisions="<html>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end PartialFlowMassTransfer;
