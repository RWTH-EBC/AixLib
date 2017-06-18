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

end SubstationDirectThrough;
