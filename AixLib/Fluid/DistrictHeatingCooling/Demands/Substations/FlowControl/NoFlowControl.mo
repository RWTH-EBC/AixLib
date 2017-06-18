within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.FlowControl;
model NoFlowControl
  "Ideal container with direct throughflow instead of flow control component in DHC substations"
  extends BaseClasses.Demands.Substations.FlowControl.PartialFlowControl(
  use_m_flow_in=false,
  prescribed_m_flow=0);
equation
  connect(port_a, port_b)
    annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(points={{-90,0},{90,0}}, color={
              28,108,200})}));
end NoFlowControl;
