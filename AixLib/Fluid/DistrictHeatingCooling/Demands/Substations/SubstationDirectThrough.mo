within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations;
model SubstationDirectThrough
  "Ideal substation with no effect on fluid, only direct throughflow"
  extends BaseClasses.Demands.Substations.PartialSubstation(
  final use_Q_in=false,
  final use_m_flow_in=false,
  final prescribedQ=0,
  final prescribed_m_flow=0,
  redeclare AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.FlowControl.NoFlowControl flowControl(prescribed_m_flow=prescribed_m_flow),
  redeclare AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.HeatTransfer.NoHeatTransfer heatTransfer(prescribedQ=prescribedQ));

  annotation (Documentation(revisions="<html><ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a basic placeholder. Instead of flow control behavior, this
  model does not affect the fluid.
</p>
</html>"), Icon(graphics={Line(points={{-90,0},{90,0}}, color={28,108,200})}));
end SubstationDirectThrough;
