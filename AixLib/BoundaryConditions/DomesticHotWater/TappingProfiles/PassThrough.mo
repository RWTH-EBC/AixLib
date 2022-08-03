within AixLib.BoundaryConditions.DomesticHotWater.TappingProfiles;
model PassThrough "Just extract the water from the DHW tank"
  extends BaseClasses.PartialDHW;
equation
  connect(m_flow_in, m_flow_out) annotation (Line(points={{-120,60},{-6,60},{
          -6,0},{110,0}}, color={0,0,127}));
end PassThrough;
