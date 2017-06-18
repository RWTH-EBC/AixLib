within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.FlowControl;
model NoFlowControl
  "Ideal container with direct throughflow instead of flow control component in DHC substations"
  extends BaseClasses.Demands.Substations.FlowControl.PartialFlowControl(
  use_m_flow_in=false,
  prescribed_m_flow=0);
equation
  connect(port_a, port_b)
    annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
end NoFlowControl;
